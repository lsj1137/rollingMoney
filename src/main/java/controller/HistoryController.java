package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.HistoryDTO;
import dto.MemberDTO;
import service.HistoryService;

/**
 * Servlet implementation class HistoryController
 */
@WebServlet("/history")
public class HistoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HistoryService historyService = new HistoryService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String pathInfo = request.getPathInfo();
        String contentPage = "/WEB-INF/views/history/history.jsp";
    	MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
    	Gson gson = new Gson();
		String historyListJson;
    	
    	if (member==null) {
        	request.setAttribute("alertMsg", "해당 메뉴는 회원만 이용 가능합니다. 로그인 후 이용하세요.");
            contentPage = "/WEB-INF/views/auth/login.jsp";
    	} else {
            List<HistoryDTO> historyList = historyService.loadHistory(member);
            historyList.sort((HistoryDTO a, HistoryDTO b)->a.getRecordDate().compareTo(b.getRecordDate()));
            try {
                // Timestamp가 포함되어 있으므로 날짜 포맷팅 관련 처리가 필요할 수 있습니다.
                // 일단 기본 설정으로 변환합니다.
                historyListJson = gson.toJson(historyList);
            } catch (Exception e) {
                historyListJson = "[]"; 
                e.printStackTrace();
            }
            request.setAttribute("historyList", historyList);
            request.setAttribute("historyListJson", historyListJson); // 차트용
    	}
    	
        
        request.setAttribute("contentPage", contentPage);
        request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
	}


}
