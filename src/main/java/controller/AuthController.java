package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.MemberDTO;
import service.MemberService;

/**
 * Servlet implementation class MemberServlet
 */
@WebServlet("/auth")
public class AuthController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
    	MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
        String contentPath = "";
        
        if (action == null || action.equals("showLogin")) {
        	if (member == null) {
                // 기본 또는 showLogin 요청 시 로그인 페이지로 이동
            	contentPath = "/WEB-INF/views/auth/login.jsp";
        	} else {
        		contentPath = "/WEB-INF/views/index.jsp";
        	}
        } else if (action.equals("showRegister")) {
            // 회원가입 페이지 요청 시
        	contentPath = "/WEB-INF/views/auth/register.jsp";
        } else if (action.equals("logout")) {
            request.getSession().setAttribute("member", null);
        	contentPath = "/WEB-INF/views/index.jsp";
        }

        request.setAttribute("contentPage", contentPath);
        request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
        
        String action = request.getParameter("action");
        String contentPath = "";
        
        
        if (action.equals("login")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            MemberDTO member = null;
            member = new MemberService().login(email, password);
            
            if (member != null/* member가 null이 아닌 경우 */) {
                // 로그인 성공: 세션에 사용자 정보 저장
                 request.getSession().setAttribute("member", member);
                 contentPath = "/WEB-INF/views/index.jsp"; 
            } else {
                // 로그인 실패: 에러 메시지를 JSP로 전달
                request.setAttribute("errorMsg", "이메일 또는 비밀번호가 올바르지 않습니다.");
                contentPath = "/WEB-INF/views/auth/login.jsp"; 
            }
            request.setAttribute("contentPage", contentPath);
            request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
            
        } else if (action.equals("register")) {
            // 회원가입 처리 로직
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            System.out.println(name+ email+ password);
            Long result = new MemberService().register(name, email, password);
            String errorMsg = null;
        	contentPath = "/WEB-INF/views/auth/register.jsp";
            if (result==-1) {
            	errorMsg =  "이름은 필수 입력값입니다!";
                request.setAttribute("errorMsg", errorMsg);
            } else if (result==-2) {
            	errorMsg =  "이메일은 필수 입력값입니다!";
                request.setAttribute("errorMsg", errorMsg);
            } else if (result==-3) {
            	errorMsg =  "비밀번호은 필수 입력값입니다!";
                request.setAttribute("errorMsg", errorMsg);
            } else {
                request.setAttribute("alertMsg", "회원가입이 완료되었습니다! 로그인하고 이용하세요.");
            	contentPath = "/WEB-INF/views/auth/login.jsp";
            }
            request.setAttribute("contentPage", contentPath);
            request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
        }
    }

}
