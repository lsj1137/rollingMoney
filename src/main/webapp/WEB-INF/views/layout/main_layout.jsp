<%-- /WEB-INF/views/layout/main_layout.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%-- 1. 헤더 (메타태그, CSS 연결) --%>
    <jsp:include page="header.jsp" />
</head>
<body class="bg-white flex flex-col min-h-screen">
	
	<c:set var="isIndexPage" value="${contentPage eq '/WEB-INF/views/index.jsp'}" />
    <c:choose>
  	<c:when test="${isIndexPage}">
  		<c:set var="contentClasses" value="flex-grow" />
  	</c:when>
  	<c:otherwise>
  		<c:set var="contentClasses" value="flex-grow container mx-auto sm:px-6 lg:px-8" />
  	</c:otherwise>
  	</c:choose>
    <%-- 네비게이션 및 메인 콘텐츠 영역 --%>
    <div class="${contentClasses}">
        <%-- **서블릿이 지정한 실제 컨텐츠 뷰 포함** --%>
        <c:choose>
            <c:when test="${not empty contentPage}">
                <jsp:include page="${contentPage}" />
            </c:when>
            <c:otherwise>
                <%-- contentPage가 설정되지 않은 경우 처리할 기본 내용 또는 에러 메시지 --%>
                <div class="text-center py-10">
                    <p class="text-red-500">페이지를 찾을 수 없습니다. (Content Page Not Set)</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 3. 푸터 --%>
    <jsp:include page="footer.jsp" />
    
</body>
<script>
let alertMsg = "${alertMsg}";
if (alertMsg) {
	alert(alertMsg);
	alertMsg = null;
}
</script>
</html>