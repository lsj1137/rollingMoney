<%-- /WEB-INF/views/member/login.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="flex items-center justify-center min-h-screen">
    <div class="w-full max-w-md p-8 space-y-6 bg-white rounded-xl shadow-lg">
        <h2 class="text-3xl font-bold text-center text-gray-900">로그인</h2>

        <form action="${pageContext.request.contextPath}/auth?action=login" method="POST" class="space-y-6">
            <input type="hidden" name="action" value="login">
            
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">이메일</label>
                <input type="email" id="email" name="email" required 
                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
            </div>
            
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">비밀번호</label>
                <input type="password" id="password" name="password" required 
                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
            </div>
	        <%-- 오류 메시지 출력 (서블릿에서 전달받을 경우) --%>
	        <c:if test="${not empty errorMsg}">
	            <p class="text-red-500 text-sm text-center">${errorMsg}</p>
	        </c:if>
            
            <button type="submit" class="w-full py-2 text-white bg-blue-600 rounded-md hover:bg-blue-700 font-semibold">
                로그인
            </button>
        </form>

        <p class="text-center text-sm text-gray-600">
            계정이 없으신가요? 
            <a href="${pageContext.request.contextPath}/auth?action=showRegister" class="font-medium text-blue-600 hover:text-blue-500">회원가입</a>
        </p>
    </div>
</div>