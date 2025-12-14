package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.HoldingDTO;
import dto.MemberDTO;
import service.HoldingService;

@WebServlet("/holdings")
public class HoldingsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HoldingService holdingService = new HoldingService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String contentPage = "/WEB-INF/views/holdings/holdings.jsp";
    	MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
    	
    	if (member==null) {
        	request.setAttribute("alertMsg", "해당 메뉴는 회원만 이용 가능합니다. 로그인 후 이용하세요.");
            contentPage = "/WEB-INF/views/auth/login.jsp";
    	} else {
    		List<HoldingDTO> holdingList = holdingService.getAllHoldings(member.getMemberId());
    		request.setAttribute("holdingList", holdingList);
    	}
    	
        request.setAttribute("contentPage", contentPage);
        request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
	}

}
