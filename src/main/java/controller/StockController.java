package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PaginationVO;
import dto.StockDTO;
import service.StockService;

/**
 * Servlet implementation class StockController
 */
@WebServlet("/stock/*")
public class StockController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		String contentPage = "";
		
		if (pathInfo == null || pathInfo.equals("/list") || pathInfo.equals("/list/kor")) {
			List<StockDTO> stockList = getStockList("kor", request);
			request.setAttribute("stocklist", stockList);
			request.setAttribute("category", "kor");
            contentPage = "/WEB-INF/views/stock/list.jsp";
            
        } else if (pathInfo.equals("/list/us")) {
    	    String pageParam = request.getParameter("page");
			request.setAttribute("stocklist", new StockService().getUSStocks());
			request.setAttribute("category", "us");
            contentPage = "/WEB-INF/views/stock/list.jsp";
            
        } else if (pathInfo.equals("/buy")) {
            // GET /stock/buy 요청 처리 (매수 폼 보여주기)
            contentPage = "/WEB-INF/views/stock/buy.jsp";
            
        } else if (pathInfo.equals("/detail")) {
            // GET /stock/detail?ticker=XXX 요청 처리
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	
	protected List<StockDTO> getStockList(String subCategory, HttpServletRequest request) {
		StockService stockService = new StockService();
		// 페이지네이션 변수 처리
	    int currentPage = 1; // 현재 페이지 번호
	    final int pageSize = 9; // 한 페이지당 아이템 수 (카드 9개)
	    
	    String pageParam = request.getParameter("page");
	    
	    if (pageParam != null) {
	        try {
	            currentPage = Integer.parseInt(pageParam);
	            if (currentPage < 1) currentPage = 1;
	        } catch (NumberFormatException e) {
	            // 잘못된 입력 시 기본값 유지
	        }
	    }
	    List<StockDTO> stockList = stockService.getStockListWithPaging(subCategory, currentPage, pageSize);
	    int totalCount = stockService.getTotalStockCount(subCategory);
	    PaginationVO pagination = new PaginationVO(currentPage, pageSize, totalCount); 
	    request.setAttribute("pagination", pagination);
		return stockList;
	}
}
