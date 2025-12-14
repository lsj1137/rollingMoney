<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
    html, body {
		height: 100%; /* 뷰포트 높이를 차지하도록 설정 */
		margin: 0;
		padding: 0;
	}
		
    /* 배경 패턴 (선택 사항) */
    .bg-pattern {
        background-image: linear-gradient(to right, rgba(255,255,255,0.05) 1px, transparent 1px),
                          linear-gradient(to bottom, rgba(255,255,255,0.05) 1px, transparent 1px);
        background-size: 20px 20px;
    }

    /* 애니메이션 */
    .fade-in-up {
        animation: fadeInUp 0.8s ease-out forwards;
        opacity: 0;
        transform: translateY(20px);
    }
    .fade-in {
        animation: fadeIn 0.8s ease-out forwards;
        opacity: 0;
    }
    @keyframes fadeInUp {
        to { opacity: 1; transform: translateY(0); }
    }
    @keyframes fadeIn {
        to { opacity: 1; }
    }
</style>
<div class="bg-gray-50 text-gray-900 min-h-screen ">
	
    <section class="relative bg-gradient-to-br from-blue-600 to-indigo-800 text-white py-32 md:py-48 flex items-center justify-center overflow-hidden bg-pattern">
        <div class="absolute inset-0 z-0 overflow-hidden">
	        <div id="carousel-slides" class="w-full h-full transition-transform duration-700 ease-in-out">
		        <div class="carousel-item absolute inset-0 transition-opacity duration-1000 opacity-100">
		            <img src="${path}/resources/image/banner01.png" 
		                 alt="배너 이미지 1" 
		                 class="w-full h-full object-cover object-center" 
		                 style="filter: grayscale(100%) brightness(50%);"
		            />
		        </div>
		        <div class="carousel-item absolute inset-0 transition-opacity duration-1000 opacity-0">
		            <img src="${path}/resources/image/banner02.png" 
		                 alt="배너 이미지 2" 
		                 class="w-full h-full object-cover object-center" 
		                 style="filter: grayscale(100%) brightness(50%);"
		            />
		        </div>
		    </div>
	
	    	<div id="carousel-indicators" class="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-2 z-10"></div>
        </div>
        
        <div class="relative z-10 text-center max-w-4xl mx-auto px-4 fade-in-up" style="animation-delay: 0.1s;">
            <h1 class="text-4xl md:text-6xl font-extrabold leading-tight mb-6 drop-shadow-lg">
                머니트래커
            </h1>
            <p class="text-lg md:text-xl mb-10 opacity-90">
                당신의 자산이 불어나는 모습을 지켜보세요.
            </p>
            <a href="${path}/auth" 
               class="inline-flex items-center justify-center px-8 py-4 bg-yellow-400 text-blue-900 font-bold text-lg rounded-full shadow-lg hover:bg-yellow-300 transition-all duration-300 transform hover:-translate-y-1 hover:scale-105">
                바로 시작하기
                <svg class="w-5 h-5 ml-2 -mr-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10.293 15.707a1 1 0 010-1.414L14.586 10l-4.293-4.293a1 1 0 111.414-1.414l5 5a1 1 0 010 1.414l-5 5a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
            </a>
        </div>
    </section>

    <section class="py-16 md:py-24 bg-gray-100">
        <div class="max-w-6xl mx-auto px-4 text-center">
            <h2 class="text-3xl md:text-4xl font-bold text-gray-800 mb-12 fade-in" style="animation-delay: 0.3s;">
                머니트래커가 제공하는 강력한 기능
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-10 fade-in-up" style="animation-delay: 0.5s;">
                
                <div class="bg-white p-8 rounded-xl shadow-lg transition-shadow duration-300 transform">
                    <i class="fa-solid fa-chart-line fa-3x mx-auto mb-6 text-indigo-500"></i>
                    <h3 class="text-xl font-semibold mb-3">실시간 시장 데이터</h3>
                    <p class="text-gray-600">
                        지연 없는 국내외 주식 시세와 최신 뉴스로 <br>빠른 의사결정을 지원합니다.
                    </p>
                </div>
                
                <div class="bg-white p-8 rounded-xl shadow-lg transition-shadow duration-300 transform">
                    <i class="fa-solid fa-magnifying-glass fa-3x mx-auto mb-6 text-green-500"></i>
                    <h3 class="text-xl font-semibold mb-3">직관적인 검색 & 탐색</h3>
                    <p class="text-gray-600">
                        티커, 종목명으로 손쉽게 검색하고 <br>다양한 기준으로 주식을 탐색하세요.
                    </p>
                </div>
                
                <div class="bg-white p-8 rounded-xl shadow-lg transition-shadow duration-300 transform ">
                    <i class="fa-solid fa-briefcase fa-3x mx-auto mb-6 text-amber-500"></i>
                    <h3 class="text-xl font-semibold mb-3">간편한 포트폴리오 관리</h3>
                    <p class="text-gray-600">
                        나만의 가상 포트폴리오를 구성하고 <br>수익률을 추적하며 투자 감각을 익히세요.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <section class="py-16 md:py-24 bg-white">
        <div class="max-w-6xl mx-auto px-4 grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div class="text-center lg:text-left fade-in-up" style="animation-delay: 0.7s;">
                <span class="text-blue-600 font-bold text-sm uppercase tracking-wide mb-3 block">
                    왜 머니트래커인가요?
                </span>
                <h2 class="text-3xl md:text-4xl font-bold text-gray-800 mb-6 leading-tight">
                    모두를 위한 스마트한 투자 환경을 <br>제공합니다.
                </h2>
                <p class="text-lg text-gray-600 mb-8">
                    초보 투자자부터 숙련된 전문가까지, 머니트래커는 당신의 투자 여정을 쉽고 성공적으로 만들도록 설계되었습니다. 복잡한 차트 분석 대신, 핵심 정보에 집중하여 현명한 결정을 내리세요.
                </p>
                <ul class="text-left space-y-4 text-gray-700 text-base">
                    <li class="flex items-center">
                        <svg class="w-6 h-6 text-green-500 mr-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                        초보자도 쉽게 이해할 수 있는 직관적인 UI
                    </li>
                    <li class="flex items-center">
                        <svg class="w-6 h-6 text-green-500 mr-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                        불필요한 기능은 줄이고 핵심 기능에 집중
                    </li>
                    <li class="flex items-center">
                        <svg class="w-6 h-6 text-green-500 mr-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                        어디서든 접근 가능한 모바일 최적화
                    </li>
                </ul>
            </div>
            <div class="relative mt-8 lg:mt-0 flex justify-center fade-in" style="animation-delay: 0.9s;">
                <img src="${path }/resources/image/screenshot_sample.png" alt="서비스 스크린샷" class="rounded-xl shadow-2xl border border-gray-200 transform rotate-3 hover:rotate-0 transition-transform duration-500">
            </div>
        </div>
    </section>

    <section class="py-16 md:py-24 bg-gradient-to-r from-blue-500 to-indigo-600 text-white text-center">
        <div class="max-w-4xl mx-auto px-4 fade-in-up" style="animation-delay: 1.1s;">
            <h2 class="text-3xl md:text-4xl font-bold mb-6 drop-shadow">
                지금 바로 당신의 투자 여정을 시작하세요!
            </h2>
            <p class="text-lg md:text-xl opacity-90 mb-10">
                머니트래커와 함께라면 스마트한 투자가 더 이상 어렵지 않습니다.
            </p>
            <a href="${path}/auth" 
               class="inline-flex items-center justify-center px-10 py-5 bg-yellow-300 text-blue-900 font-bold text-xl rounded-full shadow-xl hover:bg-yellow-200 transition-all duration-300 transform hover:-translate-y-1 hover:scale-105">
                머니트래커 시작하기
                <svg class="w-6 h-6 ml-3 -mr-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10.293 15.707a1 1 0 010-1.414L14.586 10l-4.293-4.293a1 1 0 111.414-1.414l5 5a1 1 0 010 1.414l-5 5a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
            </a>
        </div>
    </section>
</div>

<script>
    // 1. 필요한 DOM 요소 가져오기
    const slides = document.querySelectorAll('.carousel-item');
    const indicatorsContainer = document.getElementById('carousel-indicators');
    const totalSlides = slides.length;
    let currentIndex = 0; // 현재 활성화된 슬라이드 인덱스
    const intervalTime = 3000; // 전환 시간 (2초)

    // 2. 페이지 표시 점 생성 및 이벤트 리스너 추가
    function createIndicators() {
        for (let i = 0; i < totalSlides; i++) {
            const dot = document.createElement('button');
            dot.classList.add('w-2', 'h-2', 'rounded-full', 'bg-gray-400', 'hover:bg-gray-200', 'transition-colors', 'duration-300');
            dot.setAttribute('data-index', i);
            
            // 점 클릭 시 해당 슬라이드로 이동
            dot.addEventListener('click', () => {
                goToSlide(i);
                resetInterval(); // 사용자가 수동 조작 시 타이머 리셋
            });
            indicatorsContainer.appendChild(dot);
        }
    }

    // 3. 슬라이드 전환 함수
    function goToSlide(index) {
        // 모든 슬라이드 숨기기 (투명도 0)
        slides.forEach(slide => {
            slide.classList.remove('opacity-100');
            slide.classList.add('opacity-0');
        });

        // 현재 인덱스 슬라이드 보이기 (투명도 100)
        slides[index].classList.remove('opacity-0');
        slides[index].classList.add('opacity-100');
        
        // 인디케이터 업데이트
        updateIndicators(index);
        currentIndex = index;
    }

    // 4. 인디케이터 업데이트 함수
    function updateIndicators(activeIndex) {
        const dots = indicatorsContainer.querySelectorAll('button');
        dots.forEach((dot, index) => {
            dot.classList.remove('bg-white'); // 활성화 색상 제거
            dot.classList.add('bg-gray-400'); // 기본 색상 적용
            
            if (index === activeIndex) {
                dot.classList.remove('bg-gray-400'); // 기본 색상 제거
                dot.classList.add('bg-white'); // 활성화 색상 적용
            }
        });
    }

    // 5. 자동 슬라이드 함수
    function nextSlide() {
        // 다음 인덱스 계산 (마지막이면 처음으로 돌아감)
        const nextIndex = (currentIndex + 1) % totalSlides;
        goToSlide(nextIndex);
    }
    
    // 6. 자동 전환 인터벌 설정 및 리셋
    let slideInterval;

    function startInterval() {
        slideInterval = setInterval(nextSlide, intervalTime);
    }

    function resetInterval() {
        clearInterval(slideInterval);
        startInterval();
    }

    // 초기화 및 시작
    createIndicators(); // 인디케이터 생성
    goToSlide(0);      // 첫 번째 슬라이드 표시
    startInterval();   // 자동 전환 시작

</script>