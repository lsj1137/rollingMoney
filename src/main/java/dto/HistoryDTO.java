package dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter @Setter
public class HistoryDTO {
	private long historyId;
	private long memberId;
	private Timestamp recordDate;
	private BigDecimal totalAsset;
	private String actionType;
	private String productName;
}
