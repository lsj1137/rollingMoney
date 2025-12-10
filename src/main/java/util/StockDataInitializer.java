package util;

import service.DataInitService;

public class StockDataInitializer {
	public static void init() {
	    DataInitService loader = new DataInitService();

	    // 파일 경로 (본인 경로에 맞게 수정)
	    String path = "C:\\Users\\fzaca\\Desktop\\dev\\종목정보\\"; 

	    // 1. 코스피 로딩
	    loader.loadKoreanStocks(path + "kospi_code.csv");

	    // 2. 코스닥 로딩
	    loader.loadKoreanStocks(path + "kosdaq_code.csv");

	    // 3. 나스닥 로딩
	    loader.loadGlobalStocks(path + "nas_code.csv");

	    // 4. 뉴욕 로딩
	    loader.loadGlobalStocks(path + "nys_code.csv");
	}
}
