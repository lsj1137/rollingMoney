package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.MemberDTO;

/**
 * Servlet implementation class MemberServlet
 */
@WebServlet("/MemberServlet")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String path = "";
        
        if (action == null || action.equals("showLogin")) {
            // 기본 또는 showLogin 요청 시 로그인 페이지로 이동
            path = "/WEB-INF/views/member/login.jsp";
        } else if (action.equals("showRegister")) {
            // 회원가입 페이지 요청 시
            path = "/WEB-INF/views/member/register.jsp";
        }

        request.getRequestDispatcher(path).forward(request, response);
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action.equals("login")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            MemberDTO member = null;
            // 1. Service를 통해 DB에서 회원 정보 확인
            // member = memberService.login(email, password);
            
            if (member != null/* member가 null이 아닌 경우 */) {
                // 2. 로그인 성공: 세션에 사용자 정보 저장
                // request.getSession().setAttribute("memberId", member.getMemberId());
                response.sendRedirect(request.getContextPath() + "/main"); // 메인 화면으로 리다이렉트
            } else {
                // 3. 로그인 실패: 에러 메시지를 JSP로 전달
                request.setAttribute("errorMsg", "이메일 또는 비밀번호가 올바르지 않습니다.");
                request.getRequestDispatcher("/WEB-INF/views/member/login.jsp").forward(request, response);
            }
            
        } else if (action.equals("register")) {
            // 회원가입 처리 로직 (파라미터 받고 Service.register 호출)
            
            // 4. 가입 성공 후: 로그인 화면으로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/member?action=showLogin");
        }
    }

}
