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
     
     
     String contentPath = "";       

     contentPath = "/WEB-INF/views/index.jsp"; 
     
     // 최종적으로 메인 레이아웃에 끼워 넣기
     request.setAttribute("contentPage", contentPath);
     request.getRequestDispatcher("/WEB-INF/views/layout/main_layout.jsp").forward(request, response);
 }
}