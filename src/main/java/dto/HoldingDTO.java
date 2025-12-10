package dto;

import java.math.BigDecimal;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter @Setter
public class HoldingDTO {
	private long holdingId;
	private long productId;
	private String productType;
	private long memberId;
	private Integer quantity;
	private Date buyDate;
	private BigDecimal buyPrice;
	private BigDecimal buyAmount;
	private Date maturedAt;
	
}
