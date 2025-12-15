<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="memberInfo" value="${requestScope.memberInfo}" />

<div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-6  pb-2">마이페이지</h1>

    <div class="flex flex-col md:flex-row gap-8">
        
        <div class="w-full md:w-1/4 bg-white rounded-lg shadow-md p-4 h-fit">
            <nav class="space-y-2">
                <a href="${pageContext.request.contextPath}/auth/mypage" 
                   class="flex items-center p-2 text-blue-600 bg-blue-50 rounded-md font-semibold hover:bg-blue-100 transition-colors">
                    <i class="fas fa-user-circle mr-2"></i> 내 정보
                </a>
                <a href="${pageContext.request.contextPath}/auth/mypage/security" 
                   class="flex items-center p-2 text-gray-600 hover:text-blue-600 hover:bg-gray-50 rounded-md transition-colors">
                    <i class="fas fa-lock mr-2"></i> 비밀번호 변경
                </a>
            </nav>
        </div>

        <div class="w-full md:w-3/4 bg-white rounded-lg shadow-md p-6">
            <h2 class="text-2xl font-semibold text-gray-700 mb-4">계정 정보</h2>
            
            <div class="space-y-4">
                
                <div class="flex items-center border-b border-gray-300 pb-2">
                    <p class="w-1/4 text-gray-500 font-medium">이름</p>
                    <p class="w-3/4 text-gray-800 font-bold">${memberInfo.name}</p>
                </div>
                
                <div class="flex items-center border-b border-gray-300 pb-2">
                    <p class="w-1/4 text-gray-500 font-medium">이메일(ID)</p>
                    <p class="w-3/4 text-gray-800">${memberInfo.email}</p>
                </div>
                
                <div class="flex items-center border-b border-gray-300 pb-2">
                    <p class="w-1/4 text-gray-500 font-medium">보유 현금</p>
                    <p class="w-3/4 text-gray-800 text-xl font-bold text-green-600">
                        <fmt:formatNumber value="${memberInfo.cash}" pattern="#,###원" />
                    </p>
                </div>

            </div>
            
        </div>
    </div>
</div>