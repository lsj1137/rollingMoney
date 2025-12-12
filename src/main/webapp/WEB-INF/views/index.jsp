<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RollingMoney - 스마트한 주식 투자의 시작</title>
    <link href="${path}/css/output.css" rel="stylesheet">
    <link rel="icon" href="${path}/favicon.ico" type="image/x-icon">
    <style>
        /* 커스텀 폰트 (선택 사항) */
        @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700;800&display=swap');
        body { font-family: 'Pretendard', sans-serif; }

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
</head>
<body class="bg-gray-50 text-gray-900 min-h-screen">

    <section class="relative bg-gradient-to-br from-blue-600 to-indigo-800 text-white py-20 md:py-32 flex items-center justify-center overflow-hidden bg-pattern">
        <div class="absolute inset-0 z-0 overflow-hidden">
        <img src="${path}/resources/image/banner.png" 
             alt="RollingMoney 메인 배너 이미지" 
             class="w-full h-full object-cover object-center" 
             style="filter: grayscale(100%) brightness(50%);"
        />
        </div>
        
        <div class="relative z-10 text-center max-w-4xl mx-auto px-4 fade-in-up" style="animation-delay: 0.1s;">
            <h1 class="text-4xl md:text-6xl font-extrabold leading-tight mb-6 drop-shadow-lg">
                돈 굴러가유
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
                돈 굴러가유가 제공하는 강력한 기능
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-10 fade-in-up" style="animation-delay: 0.5s;">
                
                <div class="bg-white p-8 rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 transform hover:-translate-y-1">
                    <img src="https://via.placeholder.com/80/6366F1/FFFFFF?text=📈" alt="실시간 데이터 아이콘" class="mx-auto mb-6 w-20 h-20 object-contain">
                    <h3 class="text-xl font-semibold mb-3">실시간 시장 데이터</h3>
                    <p class="text-gray-600">
                        지연 없는 국내외 주식 시세와 최신 뉴스로 <br>빠른 의사결정을 지원합니다.
                    </p>
                </div>
                
                <div class="bg-white p-8 rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 transform hover:-translate-y-1">
                    <img src="https://via.placeholder.com/80/22C55E/FFFFFF?text=🔍" alt="맞춤형 검색 아이콘" class="mx-auto mb-6 w-20 h-20 object-contain">
                    <h3 class="text-xl font-semibold mb-3">직관적인 검색 & 탐색</h3>
                    <p class="text-gray-600">
                        티커, 종목명으로 손쉽게 검색하고 <br>다양한 기준으로 주식을 탐색하세요.
                    </p>
                </div>
                
                <div class="bg-white p-8 rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 transform hover:-translate-y-1">
                    <img src="https://via.placeholder.com/80/FBBF24/FFFFFF?text=📊" alt="포트폴리오 관리 아이콘" class="mx-auto mb-6 w-20 h-20 object-contain">
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
                    왜 RollingMoney인가요?
                </span>
                <h2 class="text-3xl md:text-4xl font-bold text-gray-800 mb-6 leading-tight">
                    모두를 위한 스마트한 투자 환경을 <br>제공합니다.
                </h2>
                <p class="text-lg text-gray-600 mb-8">
                    초보 투자자부터 숙련된 전문가까지, RollingMoney는 당신의 투자 여정을 쉽고 성공적으로 만들도록 설계되었습니다. 복잡한 차트 분석 대신, 핵심 정보에 집중하여 현명한 결정을 내리세요.
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
                <img src="https://via.placeholder.com/500x350/E0F2FE/1E3A8A?text=App+Screenshot" alt="서비스 스크린샷" class="rounded-xl shadow-2xl border border-gray-200 transform rotate-3 hover:rotate-0 transition-transform duration-500">
            </div>
        </div>
    </section>

    <section class="py-16 md:py-24 bg-gradient-to-r from-blue-500 to-indigo-600 text-white text-center">
        <div class="max-w-4xl mx-auto px-4 fade-in-up" style="animation-delay: 1.1s;">
            <h2 class="text-3xl md:text-4xl font-bold mb-6 drop-shadow">
                지금 바로 당신의 투자 여정을 시작하세요!
            </h2>
            <p class="text-lg md:text-xl opacity-90 mb-10">
                RollingMoney와 함께라면 스마트한 투자가 더 이상 어렵지 않습니다.
            </p>
            <a href="${path}/stock/list/kor" 
               class="inline-flex items-center justify-center px-10 py-5 bg-yellow-300 text-blue-900 font-bold text-xl rounded-full shadow-xl hover:bg-yellow-200 transition-all duration-300 transform hover:-translate-y-1 hover:scale-105">
                RollingMoney 시작하기
                <svg class="w-6 h-6 ml-3 -mr-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10.293 15.707a1 1 0 010-1.414L14.586 10l-4.293-4.293a1 1 0 111.414-1.414l5 5a1 1 0 010 1.414l-5 5a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
            </a>
        </div>
    </section>

    <footer class="bg-gray-800 text-gray-400 py-8 text-center">
        <div class="max-w-6xl mx-auto px-4">
            <p>&copy; 2023 RollingMoney. All rights reserved.</p>
            <p class="mt-2 text-sm">
                <a href="#" class="hover:text-white mx-2">개인정보처리방침</a> | 
                <a href="#" class="hover:text-white mx-2">이용약관</a>
            </p>
        </div>
    </footer>

</body>
</html>