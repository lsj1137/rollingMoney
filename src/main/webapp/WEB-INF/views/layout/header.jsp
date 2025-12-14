<%-- /WEB-INF/views/layout/header.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <a href="${path}/rollingMoney" class="flex-shrink-0 flex items-center">
				    <img class="w-[32px] h-[32px] flex-shrink-0 object-cover" 
				    	style="width: 32px !important; height: 32px !important;"
				         src="${path}/rollingMoney/resources/image/logo.png" 
				         alt="머니트래커 로고"> 
				    <span class="ml-2 text-xl font-bold text-blue-600">머니트래커</span>
				</a>
        <nav class="space-x-4">
            <%-- 로그인 상태에 따라 다른 메뉴 표시 --%>
            <c:choose>
                <c:when test="${not empty sessionScope.member}">
		            <a href="${pageContext.request.contextPath}/stock" class="text-gray-600 hover:text-blue-600 font-medium">주식 시장</a>
		            <a href="${pageContext.request.contextPath}/bank" class="text-gray-600 hover:text-blue-600 font-medium">은행 상품</a>
		            <a href="${pageContext.request.contextPath}/holdings" class="text-gray-600 hover:text-blue-600 font-medium">보유 자산</a>
		            <a href="${pageContext.request.contextPath}/history" class="text-gray-600 hover:text-blue-600 font-medium">자산 기록</a>
                    <a href="${pageContext.request.contextPath}/auth?action=logout" class="text-red-500 hover:text-red-700 font-medium">로그아웃</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/auth" class="text-blue-600 hover:text-blue-700 font-medium">로그인</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>