package service;

import dao.StockDAO;
import dto.StockDTO;
import util.CsvHelper;

import java.io.File;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public class DataInitService {

    private StockDAO stockDAO = new StockDAO();

    // 1. 국내 주식 로딩 (코스피, 코스닥)
    public void loadKoreanStocks(String filePath) {
        System.out.println("📂 국내 주식 로딩 시작: " + filePath);
        // 인코딩 주의: 한글이 깨지면 "EUC-KR"로 변경하세요.
        List<Map<String, String>> rows = CsvHelper.readCsv(new File(filePath), "UTF-8");

        int successCount = 0;
        for (Map<String, String> row : rows) {
            try {
                // CSV 헤더명에 맞춰서 데이터 꺼내기
                String ticker = row.get("단축코드");
                String name = row.get("한글종목명"); // 코스닥은 '한글종목명', 코스피는 '한글명'일 수 있음 체크 필요!
                if(name == null) name = row.get("한글명");
                
                String priceStr = row.get("주식 기준가"); // 코스닥
                if(priceStr == null) priceStr = row.get("기준가"); // 코스피

                // 유효성 검사 (비어있으면 스킵)
                if (ticker == null || name == null || priceStr == null || priceStr.isEmpty()) continue;

                // DTO 생성 (약어명, 영문명은 없으면 이름으로 대체하거나 빈칸)
                BigDecimal price = new BigDecimal(priceStr);
                StockDTO dto = new StockDTO(name, ticker, price, name, null, "kor");

                // 저장 (기존에 있으면 가격 업데이트, 없으면 생성)
                stockDAO.saveOrUpdate(dto);
                successCount++;

            } catch (Exception e) {
                // 숫자 변환 에러 등은 무시하고 진행
                // System.err.println("스킵된 행: " + row);
            }
        }
        System.out.println("✅ " + successCount + "개 종목 로딩 완료!");
    }

    // 2. 해외 주식 로딩 (나스닥, 뉴욕)
    public void loadGlobalStocks(String filePath) {
        System.out.println("📂 해외 주식 로딩 시작: " + filePath);
        List<Map<String, String>> rows = CsvHelper.readCsv(new File(filePath), "UTF-8");

        int successCount = 0;
        for (Map<String, String> row : rows) {
            try {
                // 해외 파일 헤더 매핑
                String ticker = row.get("Symbol");
                String name = row.get("Korea name"); // 한글명
                String engName = row.get("English name");
                String priceStr = row.get("base price");

                if (ticker == null || name == null || priceStr == null || priceStr.isEmpty()) continue;

                BigDecimal price = new BigDecimal(priceStr);
                // 해외주식은 영문명도 같이 저장
                StockDTO dto = new StockDTO(name, ticker, price, name, engName, "us");

                stockDAO.saveOrUpdate(dto);
                successCount++;

            } catch (Exception e) {
                // e.printStackTrace();
            }
        }
        System.out.println("✅ " + successCount + "개 종목 로딩 완료!");
    }
}