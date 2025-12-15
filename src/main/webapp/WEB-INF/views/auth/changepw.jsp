<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-6 pb-2">마이페이지</h1>

    <div class="flex flex-col md:flex-row gap-8">
        
        <div class="w-full md:w-1/4 bg-white rounded-lg shadow-md p-4 h-fit">
            <nav class="space-y-2">
                <a href="${path}/auth/mypage" 
                   class="flex items-center p-2 text-gray-600 hover:text-blue-600 hover:bg-gray-50 rounded-md transition-colors">
                    <i class="fas fa-user-circle mr-2"></i> 내 정보
                </a>
                <a href="${path}/auth/mypage/security" 
                   class="flex items-center p-2 text-blue-600 bg-blue-50 rounded-md font-semibold hover:bg-blue-100 transition-colors">
                    <i class="fas fa-lock mr-2"></i> 비밀번호 변경
                </a>
            </nav>
        </div>

        <div class="w-full md:w-3/4 bg-white rounded-lg shadow-md p-6">
            <h2 class="text-2xl font-semibold text-gray-700 mb-4 pb-2">비밀번호 변경</h2>
            
            <form action="${path}/auth/mypage/security" method="POST" class="space-y-6">
                
                <div>
                    <label for="currentPassword" class="block text-sm font-medium text-gray-700 mb-1">현재 비밀번호</label>
                    <input type="password" id="currentPassword" name="currentPassword" required
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                           placeholder="현재 비밀번호를 입력하세요">
                </div>

                <div>
                    <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-1">새 비밀번호</label>
                    <input type="password" id="newPassword" name="newPassword" required
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                           placeholder="8자 이상, 문자/숫자/특수문자 포함"
                           title="비밀번호는 8자 이상이며, 문자, 숫자, 특수문자를 포함해야 합니다.">
                </div>

                <div>
                    <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">새 비밀번호 확인</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                           placeholder="새 비밀번호를 다시 입력하세요">
                </div>

                <div class="pt-4">
                    <button type="submit" 
                            class="w-full px-4 py-2 bg-blue-600 text-white font-semibold rounded-lg shadow-md hover:bg-blue-700 transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                        비밀번호 변경
                    </button>
                </div>
            </form>
            
        </div>
    </div>
</div>