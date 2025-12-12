<%-- /WEB-INF/views/stock/list.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="container mx-auto p-4 md:p-6">
    <h2 class="text-3xl font-bold text-gray-800 mb-6 border-b border-gray-500 pb-2">
        주식 시장 목록
    </h2>

    <div class="flex space-x-4 border-b border-blue-500 mb-6 text-lg">
        <a href="${path}/stock/list/kor" 
           class="pb-2 px-3 <c:if test='${category eq "kor"}'>text-blue-600 border-b-2 border-blue-600 font-semibold</c:if>">
            한국 주식
        </a>
        <a href="${path}/stock/list/us" 
           class="pb-2 px-3 <c:if test='${category eq "us"}'>text-blue-600 border-b-2 border-blue-600 font-semibold</c:if>">
            미국 주식
        </a>
        
    </div>

        <div class="mb-6 flex justify-end">
        <a href="${path}/stock/search" 
           class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-6 rounded-lg transition duration-150 shadow-md flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
            </svg>
            주식 검색
        </a>
    </div>
    <div class="mt-8">
	    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"> 
	        <c:choose>
	            <c:when test="${not empty stocklist}">
	                <c:forEach var="stock" items="${stocklist}" varStatus="status">
	                    <div class="bg-white rounded-xl shadow-custom hover:shadow-custom-hover transition-all duration-100 p-6 flex flex-col justify-between">
	                        <div class="mb-4">
	                            <h3 class="text-xl font-bold text-gray-900 truncate">
	                                <a href="${path}/stock/detail?ticker=${stock.ticker}" class="hover:text-blue-600">
	                                    ${stock.abrvName}
	                                </a>
	                            </h3>
	                            <p class="text-sm text-gray-500">${stock.ticker}</p>
	                        </div>
	
	                        <div class="flex items-end justify-between border-t border-gray-400 pt-4">
	                            <div>
                                    <fmt:formatNumber value="${stock.curPrice}" pattern="#,###.##"/>
                                    ${category eq 'us' ? '$' : '원'}
	                            </div>
	                            <a href="${path}/stock/buy?ticker=${stock.ticker}" 
	                               class="text-white bg-blue-500 hover:bg-blue-600 px-4 py-2 rounded-[8px] text-sm font-medium shadow-md transition duration-150">
	                                매수
	                            </a>
	                        </div>
	                    </div>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	                <div class="col-span-full p-10 text-center text-gray-500 bg-white rounded-lg shadow-lg">
	                    표시할 주식 목록이 없습니다.
	                </div>
	            </c:otherwise>
	        </c:choose>
	    </div>
	</div>
	
<%-- /WEB-INF/views/stock/list.jsp 의 페이지네이션 영역 --%>

	<div class="mt-10 flex w-full items-center justify-center">
	    <div class="flex space-x-2"> 
	        
	        <%-- 맨 처음 버튼 --%>
	        <c:if test="${pagination.currentPage > 4}">
	            <c:url var="firstPageUrl" value="/stock/list/${category}">
	                <c:param name="page" value="1" />
	            </c:url>
	            <a href="${firstPageUrl}" class="relative inline-flex items-center justify-center w-[56px] px-2 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-blue-100 rounded-l-md">
	                &lt;&lt;
	            </a>
	        </c:if>
	        
	        <%-- 100 페이지 이전 이동 --%>
	        <c:if test="${pagination.currentPage > 101}">
	            <c:url var="prev100Url" value="/stock/list/${category}">
	                <c:param name="page" value="${pagination.currentPage - 100}" /> 
	            </c:url>
	            <a href="${prev100Url}" class="relative inline-flex items-center justify-center w-[56px] px-3 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-blue-100">
	                ${pagination.currentPage - 100}
	            </a>
	        </c:if>
	        
	        <%-- 10 페이지 이전 이동 --%>
	        <c:if test="${pagination.currentPage > 11}">
	            <c:url var="prev10Url" value="/stock/list/${category}">
	                <c:param name="page" value="${pagination.currentPage - 10}" /> 
	            </c:url>
	            <a href="${prev10Url}" class="relative inline-flex items-center justify-center w-[56px] px-3 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-blue-100">
	                ${pagination.currentPage - 10}
	            </a>
	        </c:if>
	
	        <%-- 이전 윈도우 (...) 버튼 --%>
	        <c:if test="${pagination.startPage > 1}">
	            <c:url var="prevBlockUrl" value="/stock/list/${category}">
	                <c:param name="page" value="${pagination.startPage - 1}" /> 
	            </c:url>
	            <a href="${prevBlockUrl}" class="relative inline-flex items-center justify-center w-[56px] px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-blue-100">
	                &lt;
	            </a>
	        </c:if>
	
	        <%-- 슬라이딩 윈도우 페이지 번호 --%>
	        <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
	            <c:url var="pageUrl" value="/stock/list/${category}">
	                <c:param name="page" value="${pageNum}" />
	            </c:url>
	            
	            <a href="${pageUrl}" 
	               class="relative inline-flex items-center justify-center w-[56px] px-4 py-2 border text-sm font-medium
	               <c:choose>
	                   <c:when test='${pageNum == pagination.currentPage}'>bg-blue-600 border-blue-600 text-white z-10</c:when>
	                   <c:otherwise>bg-white border-gray-300 text-gray-700 hover:bg-blue-100</c:otherwise>
	               </c:choose>
	               ">
	                ${pageNum}
	            </a>
	        </c:forEach>
	
	        <%-- 다음 윈도우 (...) 버튼 --%>
	        <c:if test="${pagination.endPage < pagination.totalPage}">
	            <c:url var="nextBlockUrl" value="/stock/list/${category}">
	                <c:param name="page" value="${pagination.endPage + 1}" /> 
	            </c:url>
	            <a href="${nextBlockUrl}" class="relative inline-flex items-center justify-center w-[56px] px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-blue-100">
	                &gt;
	            </a>
	        </c:if>
	        
	        <%-- 10 페이지 다음 이동 --%>
	        <c:if test="${pagination.currentPage < pagination.totalPage - 10}">
	            <c:url var="next10Url" value="/stock/list/${category}">
	                <c:param name="page" value="${pagination.currentPage + 10}" />
	            </c:url>
	            <a href="${next10Url}" class="relative inline-flex items-center justify-center w-[56px] px-3 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-blue-100">
	                ${pagination.currentPage + 10}
	            </a>
	        </c:if>
	
	        <%-- 100 페이지 다음 이동 --%>
	        <c:if test="${pagination.currentPage < pagination.totalPage - 100}">
	            <c:url var="next100Url" value="/stock/list/${category}">
	                <c:param name="page" value="${pagination.currentPage + 100}" />
	            </c:url>
	            <a href="${next100Url}" class="relative inline-flex items-center justify-center w-[56px] px-3 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-blue-100">
	                ${pagination.currentPage + 100}
	            </a>
	        </c:if>
	
	        <%-- 맨 끝 버튼 --%>
	        <c:if test="${pagination.currentPage < pagination.totalPage-3}">
	            <c:url var="lastPageUrl" value="/stock/list/${category}">
	                <c:param name="page" value="${pagination.totalPage}" />
	            </c:url>
	            <a href="${lastPageUrl}" class="relative inline-flex items-center justify-center w-[56px] px-2 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-blue-100 rounded-r-md">
	                &gt;&gt;
	            </a>
	        </c:if>
	
	    </div>
	</div>
	
</div>