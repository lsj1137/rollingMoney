package controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.HoldingDTO;
import dto.MemberDTO;
import dto.PaginationVO;
import dto.StockDTO;
import service.HistoryService;
import service.HoldingService;
import service.StockService;


@WebServlet("/stock/*")
public class StockController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	StockService stockService = new StockService();
	HoldingService holdingService = new HoldingService();
	HistoryService historyService = new HistoryService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		String contentPage = "";
		
		if (pathInfo == null || pathInfo.equals("/list") || pathInfo.equals("/list/kor")) {
			List<StockDTO> stockList = getStockList("kor", request);
			request.setAttribute("stocklist", stockList);
			request.setAttribute("category", "kor");
            contentPage = "/WEB-INF/views/stock/list.jsp";
            
        } else if (pathInfo.equals("/list/us")) {
			List<StockDTO> stockList = getStockList("us", request);
			request.setAttribute("stocklist", stockList);
			request.setAttribute("category", "us");
            contentPage = "/WEB-INF/views/stock/list.jsp";
            
        } else if (pathInfo.equals("/search")) {
            contentPage = "/WEB-INF/views/stock/search.jsp";
    	    String query = request.getParameter("query");
    	    String criteria = request.getParameter("criteria");
    	    List<StockDTO> stockList = getSearchResult(criteria, query);
    	    if (stockList!=null) {
    	    	request.setAttribute("searchResults", stockList);
    	    }
        } else if (pathInfo.equals("/trade")) {
        	// 세션 확인: 로그인 여부 확인
        	MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
            if (member==null) {
            	request.setAttribute("alertMsg", "해당 메뉴는 회원만 이용 가능합니다. 로그인 후 이용하세요.");
            } else {
        	    String idStr = request.getParameter("id");
        	    StockDTO stockDTO = getDetail(idStr);
        	    if (stockDTO==null) {
        	    	request.setAttribute("alertMsg", "조회된 종목이 없습니다.");
        	    	contentPage = "/WEB-INF/views/stock/list.jsp";
        	    } else {
        	    	HoldingDTO holdingDTO = holdingService.getHoldingByPid(stockDTO.getProductId());
            	    request.setAttribute("member", member);
            	    request.setAttribute("stock", stockDTO);
            	    request.getSession().setAttribute("stock", stockDTO);
            	    request.setAttribute("holding", holdingDTO);
            	    request.getSession().setAttribute("holding", holdingDTO);
                    contentPage = "/WEB-INF/views/stock/trade.jsp";
        	    }
            }
            
        } else if (pathInfo.equals("/detail")) {
    	    String idStr = request.getParameter("id");
    	    StockDTO stockDTO = getDetail(idStr);
    	    request.setAttribute("stock", stockDTO);
            contentPage = "/WEB-INF/views/stock/detail.jsp";
        } else {
            // 정의되지 않은 하위 도메인은 404 처리 (Controller에서 직접 처리하거나 web.xml에 위임)
            response.sendError(HttpServletResponse.SC_NOT_FOUND); 
            return;
        }

        // 메인 레이아웃에 최종 뷰를 포워딩
        request.setAttribute("contentPage", contentPage);
        request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
		String pathInfo = request.getPathInfo();
		String contentPage = "";
		System.out.println(pathInfo);
    	MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
    	StockDTO stock = (StockDTO) request.getSession().getAttribute("stock");
		
		if (pathInfo.equals("/buy")) {
			String quantity = request.getParameter("quantity");
			String result = buyStock(member, stock, Integer.parseInt(quantity));
			request.setAttribute("alertMsg", result);
    	    request.getSession().setAttribute("stock", null);
    	    request.getSession().setAttribute("holding", null);
			contentPage = "/WEB-INF/views/holdings/holdings.jsp";
		} else if (pathInfo.equals("/sell")) {
	    	HoldingDTO holding = (HoldingDTO) request.getSession().getAttribute("holding");
			String quantity = request.getParameter("quantity");
			String result = sellStock(member, stock, holding, Integer.parseInt(quantity));
			request.setAttribute("alertMsg", result);
    	    request.getSession().setAttribute("stock", null);
    	    request.getSession().setAttribute("holding", null);
			contentPage = "/WEB-INF/views/holdings/holdings.jsp";
		}
		
        request.setAttribute("contentPage", contentPage);
        request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
	}

	// 한국/미국 주식 전체 조회
	protected List<StockDTO> getStockList(String subCategory, HttpServletRequest request) {
		// 페이지네이션 변수 처리
	    int currentPage = 1; // 현재 페이지 번호
	    final int pageSize = 15; // 한 페이지당 아이템 수
	    
	    String pageParam = request.getParameter("page");
	    if (pageParam != null) {
	        try {
	            currentPage = Integer.parseInt(pageParam);
	            if (currentPage < 1) currentPage = 1;
	        } catch (NumberFormatException e) {
	        	e.printStackTrace();
	        }
	    }
	    List<StockDTO> stockList = stockService.getStockListWithPaging(subCategory, currentPage, pageSize);
	    int totalCount = stockService.getTotalStockCount(subCategory);
	    PaginationVO pagination = new PaginationVO(currentPage, pageSize, totalCount); 
	    request.setAttribute("pagination", pagination);
		return stockList;
	}
	
	// 검색 결과
	protected List<StockDTO> getSearchResult(String criteria, String query) {
		List<StockDTO> stockList = null;
		if (query==null || query.trim().isEmpty()) return null;
		if (criteria.equals("name")) {
			stockList = stockService.findByName(query);
		} else {
			stockList = stockService.findByTicker(query);
		}
		return stockList;
		
	}

	// 상세 조회
	protected StockDTO getDetail(String idStr) {
		if (idStr==null || idStr.trim().isEmpty()) return null;
		StockDTO stockDTO = stockService.findById(Long.parseLong(idStr));
		return stockDTO;
	}
	
	// 주식 매수
	protected String buyStock(MemberDTO member, StockDTO stock, int quantity) {
		int result = holdingService.buyStock(member, stock, quantity);
		String message = "알 수 없는 에러가 발생했습니다.";
		if (result>0) {
			message = "✅ 매수 체결되었습니다.";
			historyService.insertHistory(member, "buy", stock.getProductName());
		} else if (result==-1) {
			message = "❌ 잔고가 부족합니다.";
		} else if (result==-2) {
			message = "❌ 매수에 실패했습니다";
		}
		return message;
	}
	
	// 주식 매도
	protected String sellStock(MemberDTO member, StockDTO stock, HoldingDTO holding, int quantity) {
		int result = holdingService.sellStock(member, stock, holding, quantity);
		String message = "알 수 없는 에러가 발생했습니다.";
		if (result>0) {
			message = "✅ 매도 체결되었습니다.";
			historyService.insertHistory(member, "sell", stock.getProductName());
		} else {
			message = "❌ 매도에 실패했습니다";
		}
		return message;
	}
}
