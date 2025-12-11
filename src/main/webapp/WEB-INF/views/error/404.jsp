<%-- /WEB-INF/views/error/404.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>404 Not Found</title>
    <%-- 메인 레이아웃의 CSS 링크를 그대로 사용하거나, 간단하게 구성합니다. --%>
    <link href="${pageContext.request.contextPath}/resources/css/output.css" rel="stylesheet">
</head>
<body class="bg-gray-50 flex items-center justify-center min-h-screen">
    <div class="text-center p-8 bg-white shadow-lg rounded-lg">
        <h1 class="text-9xl font-extrabold text-blue-600">404</h1>
        <p class="text-2xl md:text-3xl font-light text-gray-700 mt-4 mb-6">
            죄송합니다, 요청하신 페이지를 찾을 수 없습니다.
        </p>
        <p class="text-gray-500 mb-8">
            주소가 올바른지 확인해 주세요.
        </p>
        <a href="${pageContext.request.contextPath}/" 
           class="px-6 py-3 text-lg font-semibold text-white bg-blue-600 rounded-lg hover:bg-blue-700 transition duration-300">
            홈으로 돌아가기
        </a>
    </div>
</body>
</html>