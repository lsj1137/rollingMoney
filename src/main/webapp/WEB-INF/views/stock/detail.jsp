<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class=" min-h-screen p-4 sm:p-8">
    
    <div class="max-w-4xl mx-auto">

        <div class="bg-white shadow-xl rounded-2xl p-6 sm:p-8 mb-8 border-t-4 border-blue-600">
            <div class="flex items-start justify-between">
                
                <div>
                    <h1 class="text-3xl sm:text-4xl font-extrabold text-gray-900 mb-1">
                        ${stock.productName} 
                        <span class="text-base font-semibold text-gray-500 ml-2">(${stock.ticker})</span>
                    </h1>
                    <p class="text-gray-500 text-sm">
                        ${stock.engName} / ${stock.abrvName}
                    </p>
                </div>

                <div class="text-right">
                    <p class="text-4xl sm:text-5xl font-bold mb-1 text-gray-900">
                        <fmt:formatNumber value="${stock.curPrice}" type="currency" currencyCode="KRW" pattern="#,##0"/>
                    </p>
                    
                    <p class="text-lg font-semibold text-gray-500">
                        전일 대비 정보 없음
                    </p>
                </div>
            </div>
        </div>

        <h2 class="text-xl font-bold text-gray-800 mb-4 pb-2">기본 정보</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            
            <%-- 항목 1: 티커 --%>
            <div class="bg-white p-5 rounded-xl shadow-md border border-gray-100">
                <p class="text-sm font-medium text-gray-500">티커 (종목 코드)</p>
                <p class="text-2xl font-semibold text-blue-600 mt-1">
                    ${stock.ticker}
                </p>
            </div>

            <%-- 항목 2: 영문명 --%>
            <div class="bg-white p-5 rounded-xl shadow-md border border-gray-100">
                <p class="text-sm font-medium text-gray-500">영문명</p>
                <p class="text-base font-semibold text-gray-800 mt-2">
                    ${stock.engName}
                </p>
            </div>
            
            <%-- 항목 3: 약어명 --%>
            <div class="bg-white p-5 rounded-xl shadow-md border border-gray-100">
                <p class="text-sm font-medium text-gray-500">약어명</p>
                <p class="text-base font-semibold text-gray-800 mt-2">
                    ${stock.abrvName}
                </p>
            </div>
        </div>
        
        <h2 class="text-xl font-bold text-gray-800 mb-4 mt-8 pb-2">분류</h2>
        <div class="bg-white p-6 rounded-xl shadow-md">
            <dl class="grid grid-cols-2 gap-x-4 gap-y-3">
                <div class="flex flex-col">
                    <dt class="text-sm font-medium text-gray-500">상품 유형</dt>
                    <dd class="text-base font-semibold text-blue-600">${stock.productType}</dd>
                </div>
                <div class="flex flex-col">
                    <dt class="text-sm font-medium text-gray-500">카테고리</dt>
                    <dd class="text-base font-semibold text-gray-900">${stock.category}</dd>
                </div>
            </dl>
        </div>

		<div class="mt-8 text-center">
            <a  href="${path}/stock/trade?id=${stock.productId}"
             class="bg-blue-600 text-white font-bold py-3 px-8 rounded-[8px] shadow-lg hover:bg-blue-700 transition-colors duration-300">
                거래하기
            </a>
        </div>

    </div>
</div>

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="bg-gray-50 min-h-screen p-4 sm:p-8">
    
    <div class="max-w-4xl mx-auto">

        <div class="bg-white shadow-xl rounded-2xl p-6 sm:p-8 mb-8 border-t-4 border-indigo-600">
            <div class="flex items-start justify-between">
                
                <div>
                    <h1 class="text-3xl sm:text-4xl font-extrabold text-gray-900 mb-1">
                        ${stock.abrvName} 
                        <span class="text-base font-semibold text-gray-500 ml-2">(${stock.ticker})</span>
                    </h1>
                    <p class="text-gray-500 text-sm">
                        <fmt:formatDate value="${stock.dataDate}" pattern="yyyy.MM.dd"/> 기준
                    </p>
                </div>

                <div class="text-right">
                    <p class="text-4xl sm:text-5xl font-bold mb-1 
                        <c:choose>
                            <c:when test="${stock.changeRate > 0}">text-red-600</c:when>
                            <c:when test="${stock.changeRate < 0}">text-blue-600</c:when>
                            <c:otherwise>text-gray-900</c:otherwise>
                        </c:choose>
                    ">
                        <fmt:formatNumber value="${stock.currentPrice}" type="currency" currencyCode="KRW" pattern="#,##0"/>
                    </p>
                    <p class="text-lg font-semibold 
                        <c:choose>
                            <c:when test="${stock.changeRate > 0}">text-red-500</c:when>
                            <c:when test="${stock.changeRate < 0}">text-blue-500</c:when>
                            <c:otherwise>text-gray-500</c:otherwise>
                        </c:choose>
                    ">
                        <c:if test="${stock.changeRate > 0}">▲</c:if>
                        <c:if test="${stock.changeRate < 0}">▼</c:if>
                        <fmt:formatNumber value="${stock.changeValue}" pattern="#,##0"/>
                        (<fmt:formatNumber value="${stock.changeRate}" pattern="#,##0.00"/>%)
                    </p>
                </div>
            </div>
        </div>

        <h2 class="text-xl font-bold text-gray-800 mb-4 border-b pb-2">주요 지표</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            
            항목 1: 거래량
            <div class="bg-white p-5 rounded-xl shadow-md border border-gray-100 hover:shadow-lg transition">
                <p class="text-sm font-medium text-gray-500">거래량 (Volume)</p>
                <p class="text-2xl font-semibold text-gray-800 mt-1">
                    <fmt:formatNumber value="${stock.tradingVolume}" pattern="#,##0"/> 주
                </p>
            </div>

            항목 2: 시가총액
            <div class="bg-white p-5 rounded-xl shadow-md border border-gray-100 hover:shadow-lg transition">
                <p class="text-sm font-medium text-gray-500">시가총액 (Market Cap)</p>
                <p class="text-2xl font-semibold text-gray-800 mt-1">
                    <fmt:formatNumber value="${stock.marketCap}" type="currency" currencyCode="KRW" pattern="#,##0억"/>
                </p>
            </div>
            
            항목 3: PER
            <div class="bg-white p-5 rounded-xl shadow-md border border-gray-100 hover:shadow-lg transition">
                <p class="text-sm font-medium text-gray-500">PER (주가수익비율)</p>
                <p class="text-2xl font-semibold text-gray-800 mt-1">
                    <c:if test="${stock.per != null}"><fmt:formatNumber value="${stock.per}" pattern="#,##0.00"/></c:if>
                    <c:if test="${stock.per == null}">N/A</c:if>
                </p>
            </div>

            항목 4: PBR
            <div class="bg-white p-5 rounded-xl shadow-md border border-gray-100 hover:shadow-lg transition">
                <p class="text-sm font-medium text-gray-500">PBR (주가순자산비율)</p>
                <p class="text-2xl font-semibold text-gray-800 mt-1">
                    <c:if test="${stock.pbr != null}"><fmt:formatNumber value="${stock.pbr}" pattern="#,##0.00"/></c:if>
                    <c:if test="${stock.pbr == null}">N/A</c:if>
                </p>
            </div>

            항목 5: 배당수익률
            <div class="bg-white p-5 rounded-xl shadow-md border border-gray-100 hover:shadow-lg transition">
                <p class="text-sm font-medium text-gray-500">배당수익률 (Div. Yield)</p>
                <p class="text-2xl font-semibold text-gray-800 mt-1">
                    <c:if test="${stock.dividendYield != null}"><fmt:formatNumber value="${stock.dividendYield}" pattern="#,##0.00"/>%</c:if>
                    <c:if test="${stock.dividendYield == null}">N/A</c:if>
                </p>
            </div>
            
            항목 6: 업종
            <div class="bg-white p-5 rounded-xl shadow-md border border-gray-100 hover:shadow-lg transition">
                <p class="text-sm font-medium text-gray-500">업종 (Industry)</p>
                <p class="text-base font-semibold text-indigo-600 mt-2">
                    ${stock.industry}
                </p>
            </div>
            
        </div>
        
        <h2 class="text-xl font-bold text-gray-800 mb-4 mt-8 border-b pb-2">기타 정보</h2>
        <div class="bg-white p-6 rounded-xl shadow-md">
            <dl class="grid grid-cols-2 gap-x-4 gap-y-3">
                <div class="flex flex-col">
                    <dt class="text-sm font-medium text-gray-500">시가</dt>
                    <dd class="text-base font-semibold text-gray-900"><fmt:formatNumber value="${stock.openingPrice}" pattern="#,##0"/></dd>
                </div>
                <div class="flex flex-col">
                    <dt class="text-sm font-medium text-gray-500">종가</dt>
                    <dd class="text-base font-semibold text-gray-900"><fmt:formatNumber value="${stock.closingPrice}" pattern="#,##0"/></dd>
                </div>
                <div class="flex flex-col">
                    <dt class="text-sm font-medium text-gray-500">고가</dt>
                    <dd class="text-base font-semibold text-red-600"><fmt:formatNumber value="${stock.highestPrice}" pattern="#,##0"/></dd>
                </div>
                <div class="flex flex-col">
                    <dt class="text-sm font-medium text-gray-500">저가</dt>
                    <dd class="text-base font-semibold text-blue-600"><fmt:formatNumber value="${stock.lowestPrice}" pattern="#,##0"/></dd>
                </div>
            </dl>
        </div>
        
        <div class="mt-8 text-center">
            <button class="bg-indigo-600 text-white font-bold py-3 px-8 rounded-full shadow-lg hover:bg-indigo-700 transition-colors duration-300">
                <i class="fa-solid fa-plus mr-2"></i> 포트폴리오에 추가
            </button>
        </div>

    </div>
</div> --%>