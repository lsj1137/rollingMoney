package service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import api.KisApiManager;
import dao.StockDAO;
import dto.HoldingDTO;
import dto.StockDTO;

public class StockService {
	private final KisApiManager kisApiManager = new KisApiManager();
	private final StockDAO stockDAO = new StockDAO();
	
	// 스레드 풀 생성 (CPU 코어 수의 2배 정도가 적절하며, 여기서는 네트워크 대기시간을 고려하여 넉넉히 10개로 설정)
    private final ExecutorService executorService = Executors.newFixedThreadPool(10);
	
	// KIS API를 통해 현재가를 조회하고, DB에 저장(혹은 갱신)하는 메서드
    public StockDTO registerStockWithKis(String ticker, String stockName) {
    	StockDTO updatedStock = null;
        try {
            // API(한국투자증권)로 현재가 가져오기
            BigDecimal currentPrice = kisApiManager.getStockPrice(ticker);

            // 가격을 못 가져왔으면(0원 or null) 중단
            if (currentPrice == null || currentPrice.compareTo(BigDecimal.ZERO) <= 0) {
                System.out.println("⚠️ [" + stockName + "] 시세 조회 실패 (장 종료 혹은 에러)");
                return updatedStock;
            }

            // API에서는 약어명, 영문명을 안 주므로 일단 한글명, null로 채움
            StockDTO stockDTO = new StockDTO(stockName, ticker, currentPrice, stockName, null);

            // DAO 내부에서 (있으면 UPDATE, 없으면 INSERT) 로직이 돕니다.
            stockDAO.saveOrUpdate(stockDTO);
            updatedStock = stockDTO;
            
        } catch (Exception e) {
            System.err.println("❌ [" + stockName + "] 서비스 처리 중 에러: " + e.getMessage());
            e.printStackTrace();
        }
        return updatedStock;
    }

	public List<StockDTO> getKorStocks() {
		return stockDAO.getKorStocks();
	}

	public List<StockDTO> getUSStocks() {
		return stockDAO.getUSStocks();
	}
	
	public StockDTO findById(long id) {
		StockDTO stockDTO = stockDAO.findById(id);
		StockDTO updatedStock = registerStockWithKis(stockDTO.getTicker(), stockDTO.getProductName());
		if (updatedStock != null) {
			stockDTO.setCurPrice(updatedStock.getCurPrice());
		}
		return stockDTO;
	}

	public List<StockDTO> findByName(String name) {
		List<StockDTO> stockList = stockDAO.findByName(name);
		System.out.println("총 "+stockList.size()+"건이 조회되었습니다. 가격 정보를 업데이트 합니다.");
		List<StockDTO> updatedList = updateCurPrice(stockList);
		return updatedList;
	}

	public List<StockDTO> findByTicker(String ticker) {
		List<StockDTO> stockList = stockDAO.findByTicker(ticker);
		System.out.println("총 "+stockList.size()+"건이 조회되었습니다. 가격 정보를 업데이트 합니다.");
		List<StockDTO> updatedList = updateCurPrice(stockList);
		return updatedList;
	}

	public List<StockDTO> getPersonalStocks(List<HoldingDTO> holdingStockList) {
		List<StockDTO> stocks = new ArrayList<StockDTO>();
		for (HoldingDTO holding: holdingStockList) {
			stocks.add(stockDAO.findById(holding.getProductId()));
		}
		return stocks;
	}
	
	public List<StockDTO> updateCurPrice(List<StockDTO> stockList) {
		List<Callable<StockDTO>> tasks = new ArrayList<>();
		List<StockDTO> updatedList = new ArrayList<StockDTO>();
		for (StockDTO stock: stockList) {
			tasks.add(() -> { 
				StockDTO updatedStock = registerStockWithKis(stock.getTicker(), stock.getProductName());
				if (updatedStock != null) {
					stock.setCurPrice(updatedStock.getCurPrice());
				}
				return stock;
			});
		}
		try {
			List<Future<StockDTO>> futures = executorService.invokeAll(tasks);
			for (Future<StockDTO> future : futures) {
				updatedList.add(future.get()); 
			}
		} catch (Exception e) {
			System.err.println("❌ 병렬 처리 중 에러 발생: " + e.getMessage());
		}
		return updatedList;
	}
	
	public void shutdownExecutor() {
        executorService.shutdown();
    }
}
