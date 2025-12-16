<%-- /WEB-INF/views/layout/header.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>머니트래커</title>

<%-- 
    Tailwind CSS 빌드 결과물 연결
    - resources/css/output.css 파일이 웹 애플리케이션 루트에 있어야 합니다.
    npx @tailwindcss/cli -i ./src/main/webapp/resources/css/input.css -o ./src/main/webapp/resources/css/output.css --watch
--%>

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/image/favicon.ico" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/favicon.ico" type="image/x-icon">
<link href="${pageContext.request.contextPath}/resources/css/output.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />


<header class="top-0 sticky z-100 bg-white shadow-md">
    <div class="container mx-auto px-4 py-4 flex justify-between items-center">
        <a href="${path}/" class="flex-shrink-0 flex items-center">
				    <img class="w-[32px] h-[32px] flex-shrink-0 object-cover" 
				    	style="width: 32px !important; height: 32px !important;"
				         src="${path}/resources/image/logo.png" 
				         alt="머니트래커 로고"> 
				    <span class="ml-2 text-xl font-bold text-blue-600">머니트래커</span>
				</a>
        <nav class="space-x-4 flex items-center">
            <%-- 로그인 상태에 따라 다른 메뉴 표시 --%>
            <c:choose>
                <c:when test="${not empty sessionScope.memberId}">
		            <a href="${path}/stock" class="text-gray-600 hover:text-blue-600 font-medium btn-loading">주식 시장</a>
		            <a href="${path}/bank" class="text-gray-600 hover:text-blue-600 font-medium btn-loading">은행 상품</a>
		            <a href="${path}/holdings" class="text-gray-600 hover:text-blue-600 font-medium btn-loading">보유 자산</a>
		            <a href="${path}/history" class="text-gray-600 hover:text-blue-600 font-medium btn-loading">자산 기록</a>
		            <div class="relative group">
                        
                        <button class="flex items-center justify-center w-10 h-10 bg-gray-200 rounded-full hover:bg-gray-300 transition-colors focus:outline-none" 
                                aria-expanded="false" aria-haspopup="true">
                            <i class="fas fa-user text-gray-700"></i>
                        </button>

                        <div class="absolute right-0 top-full pt-1 w-48 bg-white rounded-md shadow-lg py-1 
                                    ring-1 ring-black ring-opacity-5 
                                    opacity-0 invisible group-hover:opacity-100 group-hover:visible 
                                    transition-opacity duration-200 z-50">
                            
                            <a href="${path}/auth/mypage" 
                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                <i class="fas fa-cog mr-2"></i> 마이페이지
                            </a>
                            
                            <a href="${path}/auth/logout" 
                               class="block px-4 py-2 text-sm text-red-500 hover:bg-red-50 hover:text-red-700">
                                <i class="fas fa-sign-out-alt mr-2"></i> 로그아웃
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/auth/login" class="text-blue-600 hover:text-blue-700 font-medium">로그인</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>