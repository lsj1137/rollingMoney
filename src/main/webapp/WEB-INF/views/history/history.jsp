<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="p-4 sm:p-8">
    <div class="max-w-6xl mx-auto">

        <h1 class="text-3xl font-extrabold text-gray-900 mb-6 pb-2">
            자산 및 거래 기록
        </h1>

        <div class="flex justify-between items-center mb-6">
            <p class="text-gray-600">총 <span class="font-bold text-blue-600">${fn:length(historyList)}</span>건의 기록이 있습니다.</p>
            </div>

        <div class="bg-white shadow-xl rounded-xl overflow-hidden">
            <div class="overflow-x-auto">
                
                <table class="w-full divide-y divide-gray-200">
                    <thead class="bg-gray-100">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                순번
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                기록 일시
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                자산 총액
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                구분
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                종목/상세
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                변동 금액
                            </th>
                        </tr>
                    </thead>
                    
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:choose>
                            <c:when test="${not empty historyList}">
                                <c:forEach var="history" items="${historyList}" varStatus="status">
                                    <tr class="hover:bg-gray-50">
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                            ${status.count}
                                        </td>
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            <fmt:formatDate value="${history.recordDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
                                        </td>
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-gray-900">
                                            <fmt:formatNumber value="${history.totalAsset}" type="currency" currencyCode="KRW" pattern="#,##0원"/>
                                        </td>
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm">
                                            <span class="px-2 inline-flex text-sm leading-5 font-semibold rounded-full bg-gray-100
                                        	<c:choose>
                                        	<c:when test="${history.actionType eq 'buy'}">
                                        		text-green-600
                                        	</c:when>
                                        	<c:otherwise>
                                        		text-red-600
                                        	</c:otherwise>
                                        	</c:choose>
                                        	">${history.actionType}</span>
                                        </td>
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                            <c:out value="${history.productName}" default="상품명"/>
                                        </td>
                                        
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-bold">
                                            <c:choose>
                                                <%-- 첫 번째 행 (인덱스 0)은 이전 기록이 없으므로 N/A 표시 --%>
                                                <c:when test="${status.index == 0}">
                                                    <span class="text-gray-400">---</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <%-- 
                                                        직전 행의 totalAsset 값을 가져옴:
                                                        historyList[status.index - 1].totalAsset
                                                    --%>
                                                    <c:set var="prevAsset" value="${historyList[status.index - 1].totalAsset}" />
                                                    
                                                    <%-- 현재 자산 - 직전 자산 = 변동 금액 --%>
                                                    <c:set var="changeAmount" value="${history.totalAsset - prevAsset}" />
                                                    
                                                    <%-- 변동 금액에 따라 색상 클래스 결정 --%>
                                                    <c:set var="changeClass" value="text-gray-700" />
                                                    <c:if test="${changeAmount > 0}">
                                                        <c:set var="changeClass" value="text-red-600" />
                                                    </c:if>
                                                    <c:if test="${changeAmount < 0}">
                                                        <c:set var="changeClass" value="text-blue-600" />
                                                    </c:if>
                                                    
                                                    <%-- 변동 금액 출력 --%>
                                                    <span class="${changeClass}">
                                                        <c:if test="${changeAmount > 0}">▲</c:if>
                                                        <c:if test="${changeAmount < 0}">▼</c:if>
                                                        <fmt:formatNumber value="${changeAmount}" type="currency" currencyCode="KRW" pattern="#,##0원"/>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="px-6 py-12 text-center text-gray-500 text-lg">
                                        아직 기록된 자산 및 거래 내역이 없습니다.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                
            </div>
        </div>
        
	    <h1 class="text-3xl font-extrabold text-gray-800 mt-[48px] mb-6">
	    자산 총액 변화 추이
	    </h1>
		<div class="bg-white shadow-xl rounded-xl p-6 h-full">
            <canvas id="assetChart" style="height: 350px;"></canvas>
        </div>
    </div>
            
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<script>
    // Chart.js 데이터 준비

    // JSP에서 Java List 데이터를 JavaScript 배열로 변환
    const historyListJson = JSON.parse('${historyListJson}');
    
    // Chart.js에 필요한 레이블(X축)과 데이터셋(Y축) 추출
    const labels = [];      // 기록 일시 (X축)
    const totalAssets = []; // 자산 총액 (Y축)
    
    // 데이터가 DB에 최신순으로 저장되었는지, 아니면 가장 오래된 순으로 저장되었는지에 따라
    // 순서를 뒤집거나 그대로 사용해야 합니다. 여기서는 '오래된 순'으로 정렬되었다고 가정하고 그대로 사용합니다.
    historyListJson.forEach(history => {
        // 기록 일시를 YYYY-MM-DD HH:MM 형태로 간결하게 변환
        const date = new Date(history.recordDate);
        const formattedDate = date.toLocaleDateString('ko-KR', {
            month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'
        });
        labels.push(formattedDate);
        
        // totalAsset은 BigDecimal이므로 문자열일 수 있습니다. 숫자로 변환합니다.
        totalAssets.push(parseFloat(history.totalAsset)); 
    });

    const maxAsset = Math.max(...totalAssets);
    const maxPadding = maxAsset * 0.05; // 5% 여유분
    const suggestedMax = maxAsset + maxPadding;

    // Chart.js 차트 생성
    const ctx = document.getElementById('assetChart').getContext('2d');
    
    const assetChart = new Chart(ctx, {
        type: 'line', // 꺾은선 그래프 타입
        data: {
            labels: labels, // X축 레이블 (시간)
            datasets: [{
                label: '자산 총액 (원)',
                data: totalAssets, // Y축 데이터 (자산 금액)
                borderColor: 'rgb(59, 130, 246)', // indigo-600 색상
                backgroundColor: 'rgba(59, 130, 246, 0.1)', // 배경 채우기
                fill: true,
                tension: 0, // 곡선 부드럽게
                pointRadius: 3 // 데이터 포인트 크기
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false, // height: 400px CSS 적용을 위해 필요
            scales: {
                y: {
                    beginAtZero: true,
                    min: 0,
                    suggestedMax: suggestedMax,
                    // Y축 금액에 쉼표 추가 (통화 포맷팅)
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString('ko-KR') + '원';
                        }
                    }
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'top',
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed.y !== null) {
                                label += context.parsed.y.toLocaleString('ko-KR') + '원';
                            }
                            return label;
                        }
                    }
                }
            }
        }
    });

</script>