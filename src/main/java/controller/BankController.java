package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/bank")
public class BankController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
        String contentPage = "/WEB-INF/views/bank/list.jsp";
        

		if (pathInfo == null || pathInfo.equals("/list") || pathInfo.equals("/list/kor")) {
			contentPage = "/WEB-INF/views/bank/list.jsp";
        } 
        request.setAttribute("contentPage", contentPage);
        request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
	}
	

}
