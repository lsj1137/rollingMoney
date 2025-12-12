package controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PaginationVO;
import dto.StockDTO;
import service.StockService;


@WebServlet("/stock/*")
public class StockController extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
        } else if (pathInfo.equals("/buy")) {
            contentPage = "/WEB-INF/views/stock/buy.jsp";
            
        } else if (pathInfo.equals("/detail")) {
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	
	protected List<StockDTO> getStockList(String subCategory, HttpServletRequest request) {
		StockService stockService = new StockService();
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
	    System.out.println("START SQL>> "+LocalDateTime.now());
	    List<StockDTO> stockList = stockService.getStockListWithPaging(subCategory, currentPage, pageSize);
	    System.out.println("END list SQL>> "+LocalDateTime.now());
	    int totalCount = stockService.getTotalStockCount(subCategory);
	    System.out.println("END count SQL>> "+LocalDateTime.now());
	    PaginationVO pagination = new PaginationVO(currentPage, pageSize, totalCount); 
	    System.out.println(subCategory+" total: "+totalCount+" / currentPage: "+currentPage);
	    request.setAttribute("pagination", pagination);
		return stockList;
	}
	
	protected List<StockDTO> getSearchResult(String criteria, String query) {
		StockService stockService = new StockService();
		List<StockDTO> stockList = null;
		if (query==null || query.trim().isEmpty()) return null;
		if (criteria.equals("name")) {
			stockList = stockService.findByName(query);
		} else {
			stockList = stockService.findByTicker(query);
		}
		return stockList;
		
	}
}
