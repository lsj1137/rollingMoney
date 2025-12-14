<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="min-h-screen flex items-center justify-center p-4">
    
    <div class="max-w-md w-full bg-white rounded-xl shadow-2xl p-8 text-center border-t-8 border-yellow-500">
        
        <i class="fa-solid fa-tools text-yellow-500 text-6xl mb-6 animate-pulse"></i>
        
        <h1 class="text-3xl font-bold text-gray-800 mb-3">
            죄송합니다!
        </h1>
        
        <h2 class="text-2xl font-semibold text-yellow-600 mb-4">
            은행 상품 조회 기능은 현재 공사 중입니다.
        </h2>
        
        <p class="text-gray-600 mb-8">
            더 나은 서비스 제공을 위해 작업하고 있습니다. <br>
            빠른 시일 내에 뱅킹 상품을 제공하겠습니다.
        </p>
        
        <a href="${path}/" 
           class="inline-flex items-center justify-center px-6 py-3 bg-blue-500 text-white font-bold rounded-lg shadow-md hover:bg-indigo-700 transition-colors duration-300 transform hover:-translate-y-0.5">
            <i class="fa-solid fa-home mr-2"></i> 홈으로 돌아가기
        </a>
    </div>
</div>