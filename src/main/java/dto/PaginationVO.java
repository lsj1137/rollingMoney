// PaginationVO.java
package dto; // 실제 패키지 경로에 맞게 수정하세요

public class PaginationVO {

    // --- 1. 입력 변수 (초기값) ---
    private int currentPage;   // 현재 페이지 번호
    private int pageSize;      // 한 페이지당 아이템 수 (예: 9개)
    private int totalCount;    // 전체 아이템 수

    // --- 2. 계산 결과 변수 ---
    private int totalPage;     // 전체 페이지 수
    private int startPage;     // 현재 페이지 블록의 시작 페이지 번호 (예: 1, 11, 21...)
    private int endPage;       // 현재 페이지 블록의 끝 페이지 번호 (예: 10, 20, 30...)
    private final int pageBlock = 10; // 한 화면에 보여줄 페이지 번호 개수 (예: 10개)
    
    private boolean prev;      // 이전 페이지 블록 링크 활성화 여부
    private boolean next;      // 다음 페이지 블록 링크 활성화 여부


    // --- 3. 생성자 (계산 로직 포함) ---
    public PaginationVO(int currentPage, int pageSize, int totalCount) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        
        // 핵심 계산 메서드 호출
        calcPagination(); 
    }

    /**
     * 페이지네이션에 필요한 모든 값들을 계산합니다.
     */
    private void calcPagination() {
        
        // 1. 전체 페이지 수 계산
        // totalCount / pageSize 를 올림 처리합니다.
        // 예: 100개 / 9개 = 11.11 -> 12페이지
        this.totalPage = (int) Math.ceil((double) this.totalCount / this.pageSize);

        // 2. 현재 페이지 블록의 끝 페이지 번호 계산
        // currentPage를 pageBlock으로 나눈 후 올림하고 pageBlock을 다시 곱합니다.
        // 예: currentPage=15, pageBlock=10 -> ceil(1.5) * 10 = 20
        this.endPage = (int) (Math.ceil((double) this.currentPage / this.pageBlock) * this.pageBlock);
        
        // 3. 현재 페이지 블록의 시작 페이지 번호 계산
        // endPage에서 pageBlock - 1을 뺍니다.
        // 예: endPage=20, pageBlock=10 -> 20 - 9 = 11
        this.startPage = this.endPage - this.pageBlock + 1;
        
        // 4. endPage가 실제 totalPage보다 큰 경우 조정
        if (this.endPage > this.totalPage) {
            this.endPage = this.totalPage;
        }

        // 5. 이전 버튼 (prev) 활성화 여부
        // startPage가 1보다 크면 '이전' 블록이 존재합니다.
        this.prev = this.startPage > 1;

        // 6. 다음 버튼 (next) 활성화 여부
        // endPage가 totalPage보다 작으면 '다음' 블록이 존재합니다.
        this.next = this.endPage < this.totalPage;
    }

    // --- 4. Getter 및 Setter (필수) ---
    // (JSP의 EL(Expression Language) 접근을 위해 반드시 Getter가 필요합니다.)
    
    // Getter
    public int getCurrentPage() { return currentPage; }
    public int getPageSize() { return pageSize; }
    public int getTotalCount() { return totalCount; }
    public int getTotalPage() { return totalPage; }
    public int getStartPage() { return startPage; }
    public int getEndPage() { return endPage; }
    public boolean isPrev() { return prev; } // Boolean 타입은 is-로 시작하는 것이 관례
    public boolean isNext() { return next; } 
    public int getPageBlock() { return pageBlock; } // 필요하다면 노출
    
    // Setter (필요하다면 추가. 보통 VO는 불변성을 유지하는 것이 좋으므로 생략 가능)
    // public void setCurrentPage(int currentPage) { this.currentPage = currentPage; }
    // ...
}