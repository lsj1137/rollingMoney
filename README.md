# 📈 Money Tracker (머니트래커)

> **신한 DS 아카데미** JSP/Servlet 실습 프로젝트  
> **개발 기간:** 2025.12.10 ~ 2024.12.15

## 📖 프로젝트 소개
**Money Tracker**는 주식 및 은행 상품 투자를 통해 자산을 관리하고 불려나가는 과정을 시뮬레이션할 수 있는 웹 애플리케이션입니다.

Java Web 개발의 핵심인 **Servlet/JSP**와 **MVC 패턴**을 기반으로 구축되었으며, 실제 금융 API(한국투자증권)를 연동하여 실시간에 가까운 주식 시세를 반영합니다. 사용자는 보유한 현금으로 다양한 금융 상품에 가입/해지하며 총 자산의 변동을 시각적으로 확인할 수 있습니다.

---

## 🛠️ 기술 스택 (Tech Stack)

### Backend
- **Java 11+**
- **Servlet & JSP** (MVC Pattern)
- **Apache Tomcat 9.0**
- **Oracle DB** (JDBC, Connection Pool)

### Frontend
- **HTML5 / CSS3**
- **Tailwind CSS** (Utility-first framework)
- **JSTL / EL**
- **JavaScript (ES6)**

### Infrastructure & Tools
- **Eclipse IDE**
- **Git / GitHub**
- **KIS Open API** (한국투자증권 주식 시세 연동)

---

## ✨ 주요 기능 (Key Features)

### 1. 💰 자산 관리 (Asset Management)
- **통합 자산 대시보드:** 보유 현금과 투자 자산(주식, 은행 상품)을 합산한 **총 자산 가치**를 실시간으로 계산하여 표시합니다.
- **보유 자산 목록:** 현재 보유 중인 모든 상품의 수익률, 평가 금액, 만기일 등을 한눈에 관리합니다.

### 2. 📉 주식 거래 (Stock Trading)
- **실시간 시세 연동:** 외부 API를 통해 KOSPI/NASDAQ 종목의 현재가를 조회합니다.
- **매수/매도 시스템:** 보유 현금 한도 내에서 주식을 매수하고, 실시간 가격으로 매도하여 차익을 실현합니다.
- **병렬 처리 최적화:** 다수 종목의 현재가를 갱신할 때 `ExecutorService` 스레드 풀을 사용하여 네트워크 대기 시간을 최소화했습니다.

### 3. 🏦 은행 상품 (Banking Products)
- **예금/적금 가입:** 안정적인 자산 증식을 위한 은행 상품 가입 기능을 제공합니다.
- **중도 해지 및 만기:** 상품 해지 시 원금과 약정된 이율에 따른 이자를 계산하여 현금으로 반환합니다.

### 4. 🔒 회원 및 보안 (Member & Security)
- **인증 시스템:** 세션(Session) 기반의 로그인/로그아웃 및 접근 제어.
- **마이페이지:** 개인 정보 수정 및 비밀번호 변경 (보안 유효성 검사 적용).

---

## ⚙️ 아키텍처 및 설계 포인트

### MVC 패턴 적용
- **Controller:** 모든 요청을 `FrontController` 혹은 기능별 서블릿(`StockController`, `HoldingsController` 등)에서 받아 비즈니스 로직으로 위임.
- **Service/DAO:** 비즈니스 로직과 데이터베이스 접근 계층을 철저히 분리.
- **View:** JSP와 JSTL을 사용하여 서버 데이터를 렌더링.

### 자원 관리 최적화
- **ThreadPoolManager (Singleton):** API 요청 등 무거운 작업을 처리하기 위해 스레드 풀을 싱글턴으로 관리.
- **AppContextListener:** 웹 애플리케이션 종료(`destroy`) 시 스레드 풀을 안전하게 종료(Shutdown)하여 **메모리 누수(Memory Leak) 방지**.
- **Tailwind CSS CLI:** 생산성 높은 UI 개발을 위해 Tailwind CLI 빌드 환경 구축.

---

## 💾 데이터베이스 구조 (ERD)
주요 테이블 구성은 다음과 같습니다.

| 테이블명 | 역할 | 비고 |
| :--- | :--- | :--- |
| **MEMBER** | 사용자 정보 관리 | ID, 비밀번호, 이름, **보유 현금(CASH)** |
| **STOCK** | 주식 종목 정보 | 종목코드(Ticker), 회사명, 현재가 |
| **BANK_PRODUCT** | 은행 상품 정보 | 상품명, 이율, 가입 기간 |
| **HOLDING** | 보유 자산 정보 | 사용자가 보유한 주식/은행 상품 내역 및 수량 |

---

## 🚀 설치 및 실행 방법 (Getting Started)

### 1. 프로젝트 클론
```bash
git clone https://github.com/lsj1137/rollingMoney.git
cd rollingMoney
npm install # 사전에 node.js 설치 필요
```
### 2. 데이터베이스 설정
config.properties 파일을 src/main/webapp/WEB-INF/classes에 위치 시킵니다.  
(config.properties 파일이 필요하시면 요청하세요.)

### 3. Tailwind CSS 빌드
CSS 스타일이 깨질 경우 아래 명령어로 CSS를 다시 빌드해야 합니다.
```Bash
# 프로젝트 루트 경로에서 실행
npx @tailwindcss/cli -i ./src/main/webapp/resources/css/input.css -o ./src/main/webapp/resources/css/output.css
```

### 4. 서버 실행
Eclipse에 프로젝트를 Import 합니다.  
Apache Tomcat 서버에 프로젝트를 추가(Add)하고 서버를 시작(Start)합니다.  
브라우저에서 http://localhost:8080/rollingMoney (혹은 설정한 Context Path)로 접속합니다.  


## 📝 라이선스
This project is for educational purposes only.
