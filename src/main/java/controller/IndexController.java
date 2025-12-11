package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//com.yourproject.controller.IndexController.java
@WebServlet("")
public class IndexController extends HttpServlet {
 
 // http://localhost:8080/rollingMoney/ 요청 처리
 protected void doGet(HttpServletRequest request, HttpServletResponse response) 
         throws ServletException, IOException {
     
     // 세션 확인: 로그인 여부 확인
     Object memberId = request.getSession().getAttribute("memberId");
     
     String contentPath = "";
     
     if (memberId != null) {
         // 로그인 상태: 메인 대시보드 또는 주식 시장 목록으로 이동
         contentPath = "/WEB-INF/views/auth/login.jsp";
         
     } else {
         // 비로그인 상태: 로그인 화면으로 이동
          contentPath = "/WEB-INF/views/auth/login.jsp"; 
     }

     // 최종적으로 메인 레이아웃에 끼워 넣기
     request.setAttribute("contentPage", contentPath);
     request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
 }
}