<%-- /WEB-INF/views/layout/footer.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="bg-gray-800 text-white mt-auto">
    <div class="container mx-auto px-4 py-6 text-center text-sm">
        &copy; <%= new java.util.Date().getYear() + 1900 %> Rolling Money Project. All rights reserved.
    </div>
    
    <%-- 모든 페이지에 공통적으로 필요한 스크립트 추가 --%>
    <%-- <script src="${pageContext.request.contextPath}/resources/js/common.js"></script> --%>
</footer>