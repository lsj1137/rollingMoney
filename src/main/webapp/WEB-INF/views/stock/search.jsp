<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="container my-auto p-4 md:p-6">

    <div id="search-container" class="flex flex-col items-center <c:choose>
            <c:when test="${not empty searchResults}">mt-10 mb-6</c:when>
            <c:otherwise> h-[700px] justify-center</c:otherwise></c:choose>">
        <form id="search-form" action="${path}/stock/search" method="get" 
              class="flex w-full max-w-xl shadow-custom rounded-[8px] border border-gray-200">
            
            <div class="relative">
                <select name="criteria" id="search-criteria" 
                        class="block appearance-none bg-gray-50 border-r border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded-l-[8px] focus:outline-none h-full">
                    <option value="name" <c:if test="${param.criteria eq 'name'}">selected</c:if>>이름</option>
                    <option value="ticker" <c:if test="${param.criteria eq 'ticker'}">selected</c:if>>티커</option>
                </select>
                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                </div>
            </div>

            <input type="search" name="query" placeholder="주식 종목을 입력하세요 (예: 삼성전자, GOOG)" 
                   value="${param.query}"
                   class="flex-grow p-4 text-gray-700 focus:outline-none rounded-r-[8px]"
                   required>
            
            <button type="submit" 
                    class="p-4 bg-blue-500 text-white rounded-r-[8px] hover:bg-blue-600 transition duration-150">
                 <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" viewBox="0 0 20 20" fill="currentColor">
                   <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
                 </svg>
            </button>
        </form>
    </div>

    <c:if test="${not empty searchResults}">
        <div class="w-full max-w-6xl mx-auto mt-6">
            
            <h3 class="text-xl font-medium text-gray-700 mb-4 border-b pb-2">
                총 ${fn:length(searchResults)} 건 검색됨
            </h3>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"> 
                <c:choose>
                    <c:when test="${not empty searchResults}">
                        <c:forEach var="stock" items="${searchResults}" varStatus="status">
                            <div class="bg-white rounded-xl shadow-custom hover:shadow-custom-hover transition duration-100 p-6 flex flex-col justify-between">
                                <div class="mb-4">
                                    <h3 class="text-xl font-bold text-gray-900 truncate">
                                        <a href="${path}/stock/detail?id=${stock.productId}" class="hover:text-blue-600">
                                            ${stock.abrvName}
                                        </a>
                                    </h3>
                                    <p class="text-sm text-gray-500">${stock.ticker}</p>
                                </div>
        
                                <div class="flex items-end justify-between border-t border-gray-400 pt-4">
                                    <div>
                                        <fmt:formatNumber value="${stock.curPrice}" pattern="#,###.##"/>
                                        ${stock.category eq 'us' ? '$' : '원'}
                                    </div>
                                    <a href="${path}/stock/trade?id=${stock.productId}" 
                                       class="text-white bg-blue-500 hover:bg-blue-600 px-4 py-2 rounded-[8px] text-sm font-medium shadow-md transition duration-150">
                                        거래
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-span-full p-10 text-center text-gray-500 bg-white rounded-lg shadow-lg">
                            "${param.query}"에 대한 검색 결과가 없습니다.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:if>
    
</div>