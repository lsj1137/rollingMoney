package util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CsvHelper {

    // 파일 읽어서 데이터 리스트로 반환 (헤더 포함)
    public static List<Map<String, String>> readCsv(File file, String encoding) {
        List<Map<String, String>> result = new ArrayList<>();
        
        try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), encoding))) {
            String line;
            String[] headers = null;

            while ((line = br.readLine()) != null) {
                // 쉼표로 쪼개기 (따옴표 안의 쉼표는 무시하는 정규식)
                // 데이터가 복잡하면 전문 라이브러리를 써야 하지만, 주식 데이터 수준에선 이걸로 충분
                String[] values = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1);

                // 따옴표 제거 작업 ("문자열" -> 문자열)
                for(int i=0; i<values.length; i++) {
                    values[i] = values[i].trim().replaceAll("^\"|\"$", "");
                }

                // 첫 줄은 헤더로 저장
                if (headers == null) {
                	// 맨 앞 글자에 BOM(\uFEFF)이 붙어있으면 제거
                    if (values.length > 0 && values[0].startsWith("\uFEFF")) {
                        values[0] = values[0].substring(1);
                    }
                    headers = values;
                } else {
                    // 데이터 줄: 헤더와 매핑해서 Map으로 저장
                    Map<String, String> row = new HashMap<>();
                    for (int i = 0; i < headers.length && i < values.length; i++) {
                        row.put(headers[i], values[i]);
                    }
                    result.add(row);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}