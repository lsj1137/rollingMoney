package api;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import config.ConfigLoader;
import dao.TokenDAO;

import lombok.Getter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;

@Getter
public class KisApiManager {

    // 모의투자용 도메인 (실전투자는 https://openapi.koreainvestment.com:9443)
    private static final String BASE_URL = "https://openapivts.koreainvestment.com:29443";
    private static String APP_KEY;
    private static String APP_SECRET;

    private String accessToken = null;
    private TokenDAO tokenDAO = new TokenDAO(); 
    
	static {
        // 파일에서 값 꺼내기
		APP_KEY = ConfigLoader.getKisAppKey();
		APP_SECRET = ConfigLoader.getKisAppSecret();

		if (APP_KEY == null || APP_SECRET == null) {
		    System.err.println("⚠️ config.properties 파일에 키 정보가 없습니다!");
		}
    }
	
	public String getAccessToken() {
        // 메모리에 있으면 그거 씀
        if (this.accessToken != null) {
            return this.accessToken;
        }

        // 메모리에 없으면 DB 확인
        String dbToken = tokenDAO.getToken();
        Timestamp lastUpdate = tokenDAO.getLastUpdatedAt();

        // DB 토큰이 유효한지 검사 (23시간 지났는지 체크)
        if (dbToken != null && lastUpdate != null) {
            long diff = System.currentTimeMillis() - lastUpdate.getTime();
            long hours = diff / (1000 * 60 * 60);

            if (hours < 23) { // 23시간 이내라면 재사용 (안전하게 1시간 여유)
//                System.out.println("✅ DB에 저장된 토큰을 재사용합니다.");
                this.accessToken = dbToken;
                return dbToken;
            }
        }

        // 없거나 만료됐으면 새로 발급
//        System.out.println("🔄 토큰이 만료되어 새로 발급받습니다...");
        issueNewToken();
        return this.accessToken;
    }

    // 접근 토큰 발급 받기 (1일 1회 필요)
    public void issueNewToken() {
        try {
            String apiPath = "/oauth2/tokenP"; // 접근토큰발급 (P는 기간계=모의투자용 접미어일 수 있음, 문서 확인 필요)
            // 보통 모의투자는 /oauth2/tokenP, 실전은 /oauth2/token 입니다.
            
            URL url = new URL(BASE_URL + apiPath);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // 요청 Body (JSON 만들기)
            String jsonBody = String.format(
                "{\"grant_type\":\"client_credentials\",\"appkey\":\"%s\",\"appsecret\":\"%s\"}", 
                APP_KEY, APP_SECRET
            );

            try(OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonBody.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // 응답 받기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            StringBuilder response = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }

            // 토큰 파싱 (Gson 사용)
            JsonObject jsonObject = JsonParser.parseString(response.toString()).getAsJsonObject();
            String newToken = jsonObject.get("access_token").getAsString();
            this.accessToken = newToken;
            tokenDAO.saveToken(newToken);
            
            
//            System.out.println("✅ KIS 접근 토큰 발급 완료!");

        } catch (Exception e) {
            System.err.println("❌ 토큰 발급 실패: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // 주식 현재가 조회 (국내주식)
    public BigDecimal getStockPrice(String token, String ticker) {
    	if (token == null) return BigDecimal.ZERO;

        try {
            String apiPath = "/uapi/domestic-stock/v1/quotations/inquire-price";
            String query = String.format("?FID_COND_MRKT_DIV_CODE=J&FID_INPUT_ISCD=%s", ticker);
            URL url = new URL(BASE_URL + apiPath + query);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            
            conn.setRequestProperty("Content-Type", "application/json; charset=utf-8");
            conn.setRequestProperty("authorization", "Bearer " + this.accessToken);
            conn.setRequestProperty("appkey", APP_KEY);
            conn.setRequestProperty("appsecret", APP_SECRET);
            conn.setRequestProperty("tr_id", "FHKST01010100"); // 주식현재가 시세 TR ID (중요!)

            // 응답 받기
            int status = conn.getResponseCode();
            BufferedReader br;
            if(status >= 200 && status < 300) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
            }

            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }

            // JSON 파싱
            JsonObject json = JsonParser.parseString(response.toString()).getAsJsonObject();
            JsonObject output = json.getAsJsonObject("output");
            
            // "stck_prpr" 필드가 현재가입니다.
            String priceStr = output.get("stck_prpr").getAsString();
            
            return new BigDecimal(priceStr);

        } catch (Exception e) {
//            System.err.println("❌ 시세 조회 실패 (" + ticker + "): " + e.getMessage());
            return BigDecimal.ZERO;
        }
    }
}