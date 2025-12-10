package dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter @Setter
public class BankProductDTO extends ProductDTO {
	private String bpType;
	private BigDecimal rate;
	private Integer termDays;
	
	public BankProductDTO(String productName, String bpType, BigDecimal rate, Integer termDays) {
		// 부모 생성자 호출 (ID는 null, 타입은 "STOCK" 고정, 이름은 받아서 넘김)
        super(null, "BANK", productName);
        
        // 내 필드 초기화
        this.bpType = bpType;
        this.rate = rate;
        this.termDays = termDays;
	}
}
