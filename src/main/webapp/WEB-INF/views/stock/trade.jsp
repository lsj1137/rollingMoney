<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="min-h-screen p-4 sm:p-8">
    <div class="max-w-4xl mx-auto">

        <div class="bg-white shadow-xl rounded-2xl p-6 mb-8 border-t-4 border-blue-600">
            <h1 class="text-2xl sm:text-3xl font-extrabold text-gray-900 mb-1">
                ${stock.productName} 
                <span class="text-base font-semibold text-gray-500 ml-2">(${stock.ticker})</span>
            </h1>
            
            <div class="flex items-center justify-between mt-4 border-t pt-4">
                <div class="flex flex-col">
                    <span class="text-sm font-medium text-gray-500">현재가</span>
                    <span class="text-3xl font-bold text-gray-900 mt-1">
                        <fmt:formatNumber value="${stock.curPrice}" type="currency" currencyCode="KRW" pattern="#,##0"/>
                    </span>
                </div>
                
                <div class="text-right">
                    <span class="text-lg font-semibold text-gray-500">
                        변동 기록 없음
                    </span>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 mb-8">
            
            <div class="bg-white p-5 rounded-xl shadow-md border border-green-100">
                <p class="text-sm font-medium text-gray-500">나의 보유 현금</p>
                <p class="text-2xl font-bold text-blue-600 mt-1">
                    <c:choose>
                        <c:when test="${member.cash != null}">
                            <fmt:formatNumber value="${member.cash}" type="currency" currencyCode="KRW" pattern="#,##0원"/>
                        </c:when>
                        <c:otherwise>
                            <span class="text-lg text-gray-400">계좌 정보 없음</span>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            
            <div class="bg-white p-5 rounded-xl shadow-md border border-blue-100">
                <p class="text-sm font-medium text-gray-500">${stock.productName} 보유 수량</p>
                <p class="text-2xl font-bold text-blue-600 mt-1">
                    <c:choose>
                        <c:when test="${holding.quantity != null}">
                            <fmt:formatNumber value="${holding.quantity}" pattern="#,##0"/> 주
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="0" pattern="#,##0"/> 주
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
        
        <div x-data="{ currentTab: 'buy' }" class="bg-white shadow-xl rounded-2xl p-6">
            
            <div class="flex border-b mb-6"
            	:class="{'border-green-600': currentTab === 'buy','border-red-600': currentTab === 'sell'}"
            >
                <button @click="currentTab = 'buy'" 
                        :class="{'border-green-600 text-green-600 font-bold': currentTab === 'buy', 'border-transparent text-gray-500': currentTab !== 'buy'}"
                        class="px-4 py-3 text-lg border-b-2 transition-colors duration-200">
                    매수 (사기)
                </button>
                <button @click="currentTab = 'sell'" 
                        :class="{'border-red-600 text-red-600 font-bold': currentTab === 'sell', 'border-transparent text-gray-500': currentTab !== 'sell'}"
                        class="px-4 py-3 text-lg border-b-2 transition-colors duration-200">
                    매도 (팔기)
                </button>
            </div>

            <div x-show="currentTab === 'buy'" class="space-y-6">
                <form action="${path}/stock/buy" method="post" id="buyForm">
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label for="buyPrice" class="block text-sm font-medium text-gray-700">주문 가격</label>
                            <input type="text" id="buyPrice" name="price" value="<fmt:formatNumber value="${stock.curPrice}" pattern="#,##0"/>" 
                                   class="mt-1 block w-full rounded-md border-gray-300 shadow-sm p-3 bg-gray-100 font-bold text-lg focus:ring-indigo-500 focus:border-indigo-500" readonly>
                            <p class="text-xs text-gray-500 mt-1">현재가 기준</p>
                        </div>
                        
                        <div>
                            <label for="buyQuantity" class="block text-sm font-medium text-gray-700">주문 수량 (주)</label>
                            <input type="number" id="buyQuantity" name="quantity" min="1" required placeholder="수량 입력"
                                   class="mt-1 block w-full rounded-md border-gray-300 shadow-sm p-3 text-lg focus:ring-indigo-500 focus:border-indigo-500">
                        </div>
                    </div>
                    
                    <div class="mt-6 p-4 bg-blue-50 rounded-lg text-center">
                        <p class="text-sm font-medium text-blue-700">매수 예상 금액</p>
                        <p id="buyTotalAmount" class="text-2xl font-extrabold text-blue-900 mt-1">
                            0원
                        </p>
                    </div>
                    
                    <button type="submit" 
                            class="w-full mt-6 bg-green-600 text-white py-3 rounded-md font-bold text-lg hover:bg-green-700 transition-colors duration-200">
                        매수 주문 실행
                    </button>
                </form>
            </div>

            <div x-show="currentTab === 'sell'" class="space-y-6">
                <form action="${path}/stock/sell" method="post" id="sellForm">
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label for="sellPrice" class="block text-sm font-medium text-gray-700">주문 가격</label>
                            <input type="text" id="sellPrice" name="price" value="<fmt:formatNumber value="${stock.curPrice}" pattern="#,##0"/>" 
                                   class="mt-1 block w-full rounded-md border-gray-300 shadow-sm p-3 bg-gray-100 font-bold text-lg focus:ring-indigo-500 focus:border-indigo-500" readonly>
                            <p class="text-xs text-gray-500 mt-1">현재가 기준</p>
                        </div>
                        
                        <div>
                            <label for="sellQuantity" class="block text-sm font-medium text-gray-700">주문 수량 (주)</label>
                            <input type="number" id="sellQuantity" name="quantity" min="1" max="${holding.quantity}" required placeholder="수량 입력"
                                   class="mt-1 block w-full rounded-md border-gray-300 shadow-sm p-3 text-lg focus:ring-indigo-500 focus:border-indigo-500">
                        </div>
                    </div>

                    <div class="mt-6 p-4 bg-blue-50 rounded-lg text-center">
                        <p class="text-sm font-medium text-blue-700">매도 예상 금액</p>
                        <p id="sellTotalAmount" class="text-2xl font-extrabold text-blue-900 mt-1">
                            0원
                        </p>
                    </div>

                    <button type="submit" 
                            class="w-full mt-6 bg-red-600 text-white py-3 rounded-md font-bold text-lg hover:bg-red-700 transition-colors duration-200">
                        매도 주문 실행
                    </button>
                </form>
            </div>
            
        </div>
        
    </div>
</div>

<script>
    // 가격 정보 (쉼표 제거 후 숫자로 변환)
    const currentPrice = parseInt("${stock.curPrice}".replace(/,/g, ''));
    const cash = "${member.cash}";
    const holdingQuantity = "${holding.quantity}";
    
    // 매수/매도 폼 요소
    const buyQuantityInput = document.getElementById('buyQuantity');
    const buyTotalAmountDisplay = document.getElementById('buyTotalAmount');
    let lastBuyQty = 0;
    const sellQuantityInput = document.getElementById('sellQuantity');
    const sellTotalAmountDisplay = document.getElementById('sellTotalAmount');
    let lastSellQty = 0;

    // 숫자를 통화 형식으로 포맷하는 함수
    function formatCurrency(number) {
        return number.toLocaleString('ko-KR') + '원';
    }

    // 매수 예상 금액 계산 및 업데이트
    function updateBuyTotal() {
        const quantity = parseInt(buyQuantityInput.value) || 0;
        const total = quantity * currentPrice;
        if (total>cash) {
        	alert("구매 수량은 보유 현금 이내로만 설정 가능합니다.");
        	buyQuantityInput.value = lastBuyQty;
        } else {
            buyTotalAmountDisplay.textContent = formatCurrency(total);
            lastBuyQty = quantity;
        }
    }
    
    // 매도 예상 금액 계산 및 업데이트
    function updateSellTotal() {
        const quantity = parseInt(sellQuantityInput.value) || 0;
        const total = quantity * currentPrice;
        if (quantity>holdingQuantity) {
        	alert("판매 수량은 보유 수량 이내로만 설정 가능합니다.");
        	sellQuantityInput.value = lastSellQty;
        } else {
            sellTotalAmountDisplay.textContent = formatCurrency(total);
            lastSellQty = quantity;
        }
    }

    // 입력값 변경 시 이벤트 리스너 추가
    buyQuantityInput.addEventListener('input', updateBuyTotal);
    sellQuantityInput.addEventListener('input', updateSellTotal);

    // 페이지 로드 시 초기값 계산
    updateBuyTotal();
    updateSellTotal();
    
    // Alpine.js (x-data 사용을 위한) 또는 유사 라이브러리가 필요합니다.
    // 만약 순수 JS로 탭 기능을 구현하려면 아래와 같이 수정해야 합니다.
    const buyTabButton = document.querySelector('[data-tab="buy"]');
    const sellTabButton = document.querySelector('[data-tab="sell"]');
    
</script>