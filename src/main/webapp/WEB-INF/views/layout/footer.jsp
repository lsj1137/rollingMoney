<%-- /WEB-INF/views/layout/footer.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="bg-gray-800 text-white mt-auto">
	<!-- 로딩창 -->
	<div id="global-loader" 
     class="hidden fixed inset-0 z-[9999] flex flex-col items-center justify-center bg-white/80 backdrop-blur-sm transition-all duration-300">
    
    <div class="relative flex items-center justify-center mb-4">
        
        <div class="w-20 h-20 rounded-full border-[6px] border-blue-100"></div>
        <div class="absolute w-20 h-20 rounded-full border-[6px] border-blue-600 border-t-transparent animate-spin"></div>
        
        <div class="absolute text-blue-600 text-2xl font-bold">
            <i class="fas fa-won-sign"></i> </div>
    </div>

    <div class="text-center">
        <h3 class="text-lg font-bold text-gray-800 tracking-tight">잠시만 기다려주세요</h3>
        <p class="text-sm text-blue-500 font-medium mt-1 animate-pulse">
            정보를 불러오고 있습니다...
        </p>
    </div>
    
	</div>
    <div class="container mx-auto px-4 py-6 text-center text-sm">
        &copy; <%= new java.util.Date().getYear() + 1900 %> Rolling Money Project. All rights reserved.
    </div>
    
    <%-- 모든 페이지에 공통적으로 필요한 스크립트 추가 --%>
    <%-- <script src="${pageContext.request.contextPath}/resources/js/common.js"></script> --%>
</footer>

<script>
    // 로딩 화면 켜기 함수
    function showLoading() {
        const loader = document.getElementById('global-loader');
        if (loader) {
            loader.classList.remove('hidden'); // hidden 클래스 제거 -> 보임
        }
    }

    // 로딩 화면 끄기 함수 (필요 시 사용, 보통 페이지 이동하면 자동 해제됨)
    function hideLoading() {
        const loader = document.getElementById('global-loader');
        if (loader) {
            loader.classList.add('hidden');
        }
    }
    
 	// DOM 트리가 구성되기 시작할 때 로딩 화면 즉시 띄우기
    // (서버에서 데이터를 받아와 페이지를 그리기 시작하는 시점)
    document.addEventListener('DOMContentLoaded', function() {
        // 이미 로딩 중인 상태가 아니라면 (예: click 이벤트로 이미 띄운 상태가 아니라면)
        showLoading();
    });

    // 페이지의 모든 요소(이미지, CSS 등) 로드가 완료되었을 때 로딩 화면 숨기기
    // (사용자가 콘텐츠를 볼 준비가 되었을 때)
    window.addEventListener('load', function() {
        hideLoading();
    });

    // (로그인, 회원가입, 매수/매도 등 폼 전송 시 자동 작동)
    document.addEventListener('submit', function(e) {
        // 폼이 유효하지 않으면(required 체크 등) 로딩 안 띄움
        if (!e.target.checkValidity()) {
            return;
        }
        showLoading();
    });

    // (단순 페이지 이동인데 로딩이 필요한 경우 사용)
    document.addEventListener('click', function(e) {
        // 클릭된 요소가 .btn-loading 클래스를 가졌거나, 그 부모가 가졌을 때
        if (e.target.closest('.btn-loading')) {
            showLoading();
        }
    });
    
    // 페이지가 뒤로가기로 돌아왔을 때 로딩바가 남아있는 경우 방지 (BFCache 대응)
    window.addEventListener('pageshow', function(event) {
        if (event.persisted) {
            hideLoading();
        }
    });
</script>