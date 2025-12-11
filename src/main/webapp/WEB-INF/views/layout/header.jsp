<%-- /WEB-INF/views/layout/header.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>돈굴러가유</title>

<%-- 
    Tailwind CSS 빌드 결과물 연결
    - resources/css/output.css 파일이 웹 애플리케이션 루트에 있어야 합니다.
    npx @tailwindcss/cli -i ./src/main/webapp/resources/css/input.css -o ./src/main/webapp/resources/css/output.css --watch
--%>

<link href="${pageContext.request.contextPath}/resources/css/output.css" rel="stylesheet">

<header class="bg-white shadow-md">
    <div class="container mx-auto px-4 py-4 flex justify-between items-center">
        <a href="${pageContext.request.contextPath}/" class="text-xl font-bold text-gray-800">
            💰 돈굴러가유
        </a>
        <nav class="space-x-4">
            <%-- 로그인 상태에 따라 다른 메뉴 표시 --%>
            <c:choose>
                <c:when test="${not empty sessionScope.memberId}">
		            <a href="${pageContext.request.contextPath}/stock" class="text-gray-600 hover:text-blue-600 font-medium">주식 시장</a>
		            <a href="${pageContext.request.contextPath}/bank" class="text-gray-600 hover:text-blue-600 font-medium">은행 상품</a>
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