<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="min-h-screen p-4 sm:p-8">
    <div class="max-w-7xl mx-auto">

        <h1 class="text-3xl font-extrabold text-gray-900 mb-6 pb-2">
            보유 자산 목록
        </h1>

        <div class="mb-8 p-6 bg-blue-50 rounded-xl shadow-md border-l-4 border-blue-600">
            <p class="text-lg font-semibold text-blue-800">
                현재 총 <span class="text-2xl font-extrabold">${fn:length(holdingList)}</span>개의 자산을 보유하고 있습니다.
            </p>
            <p class="text-sm text-blue-600 mt-1">
                (매입 금액 기준으로 계산된 자산입니다.)
            </p>
        </div>

        <div class="bg-white shadow-xl rounded-xl overflow-hidden">
            <div class="overflow-x-auto">
                
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-100">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                구분
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                상품명
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                수량 / 원금
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                매입일
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                매입 금액
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                만기일
                            </th>
                            <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">
                                거래
                            </th>
                        </tr>
                    </thead>
                    
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:choose>
                            <c:when test="${not empty holdingList}">
                                <c:forEach var="holding" items="${holdingList}">
                                    <tr class="hover:bg-gray-50">
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <c:choose>
                                                <c:when test="${holding.productType eq 'STOCK'}">
                                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">주식</span>
                                                </c:when>
                                                <c:when test="${holding.productType eq 'BANKING'}">
                                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800">은행</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">${holding.productType}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                            ${holding.productName}
                                        </td>
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-gray-900">
                                            <c:choose>
                                                <c:when test="${holding.productType eq 'STOCK'}">
                                                    <fmt:formatNumber value="${holding.quantity}" pattern="#,##0"/> 주
                                                </c:when>
                                                <c:when test="${holding.productType eq 'BANKING'}">
                                                    <fmt:formatNumber value="${holding.buyAmount}" type="currency" currencyCode="KRW" pattern="#,##0원"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:formatNumber value="${holding.quantity}" pattern="#,##0"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            <fmt:formatDate value="${holding.buyDate}" pattern="yyyy.MM.dd"/>
                                        </td>
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                            <c:choose>
                                                <c:when test="${holding.productType eq 'STOCK'}">
                                                    <fmt:formatNumber value="${holding.buyPrice}" type="currency" currencyCode="KRW" pattern="#,##0원"/> (단가)
                                                </c:when>
                                                <c:otherwise>
                                                    ---
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            <c:choose>
                                                <c:when test="${holding.maturedAt != null}">
                                                    <fmt:formatDate value="${holding.maturedAt}" pattern="yyyy.MM.dd"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-gray-400">해당없음</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td class="px-6 py-4 whitespace-nowrap text-center text-sm font-medium">
                                            <c:choose>
                                                <c:when test="${holding.productType eq 'STOCK'}">
                                                    <a href="${path}/stock/trade?id=${holding.productId}" 
                                                       class="text-red-600 hover:text-red-900 font-bold p-2 rounded-md hover:bg-red-50 transition-colors">
                                                        매도
                                                    </a>
                                                </c:when>
                                                <c:when test="${holding.productType eq 'BANKING'}">
                                                    <a href="${path}/banking/liquidate?holdingId=${holding.holdingId}"
                                                       class="text-blue-600 hover:text-blue-900 font-bold p-2 rounded-md hover:bg-blue-50 transition-colors">
                                                        해지
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-gray-400">---</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="px-6 py-12 text-center text-gray-500 text-lg">
                                        현재 보유하고 있는 자산이 없습니다.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                
            </div>
        </div>

    </div>
</div>