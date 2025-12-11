<%-- /WEB-INF/views/stock/list.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="container mx-auto p-4 md:p-6">
    <h2 class="text-3xl font-bold text-gray-800 mb-6 border-b pb-2">
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

    <div class="mt-8">
	    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"> 
	        <c:choose>
	            <c:when test="${not empty stocklist}">
	                <c:forEach var="stock" items="${stocklist}" varStatus="status">
	                    <div class="bg-white rounded-xl shadow-xl hover:shadow-2xl transition duration-300 p-6 flex flex-col justify-between">
	                        <div class="mb-4">
	                            <h3 class="text-xl font-bold text-gray-900 truncate">
	                                <a href="${path}/stock/detail?ticker=${stock.ticker}" class="hover:text-blue-600">
	                                    ${stock.abrvName}
	                                </a>
	                            </h3>
	                            <p class="text-sm text-gray-500">${stock.ticker}</p>
	                        </div>
	
	                        <div class="flex items-end justify-between border-t pt-4">
	                            <div>
                                    <fmt:formatNumber value="${stock.curPrice}" pattern="#,###.##"/>
                                    ${category eq 'us' ? '$' : '원'}
	                            </div>
	                            <a href="${path}/stock/buy?ticker=${stock.ticker}" 
	                               class="text-white bg-green-500 hover:bg-green-600 px-4 py-2 rounded-[8px] font-medium text-sm shadow-md transition duration-150">
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
	
	
	<c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
	    <c:url var="pageUrl" value="${path}/stock/list/${currentCategory}">
	        <c:param name="page" value="${pageNum}" />
	    </c:url>
	    
	    <a href="${pageUrl}" 
            class="relative inline-flex items-center px-4 py-2 border text-sm font-medium 
            <c:choose>
                <c:when test='${pageNum == pagination.currentPage}'>
                    bg-blue-600 border-blue-600 text-white z-10
                </c:when>
                <c:otherwise>
                    bg-white border-gray-300 text-gray-700 hover:bg-gray-50
                </c:otherwise>
            </c:choose>
            ">
             ${pageNum}
         </a>
	</c:forEach>
	
</div>