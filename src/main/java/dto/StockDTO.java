package dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@ToString
@Getter @Setter
public class StockDTO extends ProductDTO {
	private BigDecimal curPrice;
	private String ticker;
	private String abrvName;
	private String engName;
	
	public StockDTO() {
		super(null, "STOCK", null);
	}
	
	public StockDTO(String productName, String ticker, BigDecimal curPrice, String abrvName, String engName) {
		// 부모 생성자 호출 (ID는 null, 타입은 "STOCK" 고정, 이름은 받아서 넘김)
        super(null, "STOCK", productName);
        
        // 내 필드 초기화
        this.ticker = ticker;
        this.curPrice = curPrice;
        this.abrvName = abrvName;
        this.engName = engName;
	}
}
