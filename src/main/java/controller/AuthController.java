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
@WebServlet("/auth/*")
public class AuthController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

		String pathInfo = request.getPathInfo();
    	Long memberId = (Long) request.getSession().getAttribute("memberId");
        String contentPage = "";
        
        if (pathInfo == null || pathInfo.equals("/login")) {
        	if (memberId == null) {
            	contentPage = "/WEB-INF/views/auth/login.jsp";
        	} else {
        		contentPage = "/WEB-INF/views/index.jsp";
        	}
        } else if (pathInfo.equals("/register")) {
            // 회원가입 페이지 요청 시
        	contentPage = "/WEB-INF/views/auth/register.jsp";
        } else if (pathInfo.equals("/logout")) {
            request.getSession().removeAttribute("memberId");
        	response.sendRedirect("/rollingMoney");
        	return;
        } else if (pathInfo.equals("/mypage")) {
        	if (memberId == null) {
            	contentPage = "/WEB-INF/views/auth/login.jsp";
        	} else {
                String alertMsg = (String) request.getSession().getAttribute("alertMsg");
                if (alertMsg != null) {
                	request.setAttribute("alertMsg", alertMsg);
                	request.getSession().removeAttribute("alertMsg");
                }
        		MemberDTO memberInfo = new MemberService().refresh(memberId);
                request.setAttribute("memberInfo", memberInfo);
            	contentPage = "/WEB-INF/views/auth/mypage.jsp";
        	}
        } else if (pathInfo.equals("/mypage/security")) {
        	if (memberId == null) {
            	contentPage = "/WEB-INF/views/auth/login.jsp";
        	} else {
        		MemberDTO memberInfo = new MemberService().refresh(memberId);
                request.setAttribute("memberInfo", memberInfo);
            	contentPage = "/WEB-INF/views/auth/changepw.jsp";
        	}
        }
        
        request.setAttribute("contentPage", contentPage);
        request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");

		String pathInfo = request.getPathInfo();
        String contentPage = "";
        
        
        if (pathInfo.equals("/login")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            MemberDTO member = null;
            member = new MemberService().login(email, password);
            
            if (member != null/* member가 null이 아닌 경우 */) {
                // 로그인 성공: 세션에 사용자 정보 저장
                 request.getSession().setAttribute("memberId", member.getMemberId());
                 contentPage = "/WEB-INF/views/index.jsp"; 
            } else {
                // 로그인 실패: 에러 메시지를 JSP로 전달
                request.setAttribute("errorMsg", "이메일 또는 비밀번호가 올바르지 않습니다.");
                contentPage = "/WEB-INF/views/auth/login.jsp"; 
            }
            
        } else if (pathInfo.equals("/register")) {
            // 회원가입 처리 로직
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            System.out.println(name+ email+ password);
            Long result = new MemberService().register(name, email, password);
            String errorMsg = null;
        	contentPage = "/WEB-INF/views/auth/register.jsp";
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
            	contentPage = "/WEB-INF/views/auth/login.jsp";
            }
        } else if (pathInfo.equals("/mypage/security")) {
            Long memberId = (Long) request.getSession().getAttribute("memberId");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            Long result = new MemberService().changePw(memberId, currentPassword, newPassword);
            if (result<0) {
            	String errorMsg =  "비밀번호 변경에 실패했습니다.";
                request.setAttribute("errorMsg", errorMsg);
            } else {
                request.getSession().setAttribute("alertMsg", "비밀번호 변경이 완료되었습니다!");
                response.sendRedirect("/rollingMoney/auth/mypage");
                return;
            }
        }
        
        
        request.setAttribute("contentPage", contentPage);
        request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
    }

}
