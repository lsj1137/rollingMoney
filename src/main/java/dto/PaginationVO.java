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
        
        // 전체 페이지 수 계산
        // totalCount / pageSize 를 올림 처리합니다.
        this.totalPage = (int) Math.ceil((double) this.totalCount / this.pageSize);
        
        // 새로운 슬라이딩 윈도우 시작/끝 페이지 계산
        final int displayRange = 2;
        
        // 시작 페이지 계산: Math.max(1, 현재 페이지 - 3)
        // 윈도우의 시작은 1보다 작아질 수 없습니다.
        this.startPage = Math.max(1, this.currentPage - displayRange);
        
        // 끝 페이지 계산: Math.min(전체 페이지, 현재 페이지 + 3)
        // 윈도우의 끝은 totalPage를 넘어갈 수 없습니다.
        this.endPage = Math.min(this.totalPage, this.currentPage + displayRange);
        
        // 윈도우 크기 고정 조정
        // 만약 시작/끝에서 윈도우 크기가 줄어들면, 반대쪽을 늘려 윈도우 크기를 7개로 유지
        if (this.endPage - this.startPage < 2 * displayRange) {
            if (this.startPage == 1 && this.totalPage > this.endPage) {
                // 시작이 1이지만 전체 페이지가 더 남은 경우, 끝 페이지를 최대 7개까지 확장
                this.endPage = Math.min(this.totalPage, this.startPage + 2 * displayRange);
            } else if (this.endPage == this.totalPage && this.startPage > 1) {
                // 끝이 totalPage이지만 시작 페이지가 1보다 큰 경우, 시작 페이지를 최소 7개까지 확장
                this.startPage = Math.max(1, this.endPage - 2 * displayRange);
            }
        }
        // 4. endPage가 실제 totalPage보다 큰 경우 조정
        if (this.endPage > this.totalPage) {
            this.endPage = this.totalPage;
        }

        this.prev = this.currentPage > 1; 
        this.next = this.currentPage < this.totalPage;
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