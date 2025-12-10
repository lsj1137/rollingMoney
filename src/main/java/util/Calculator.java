package util;

import java.math.BigDecimal;

public class Calculator {
	public static BigDecimal calProfit(BigDecimal buyPrice, BigDecimal curPrice, int quantity) {
		BigDecimal buyAmount = buyPrice.multiply(new BigDecimal(quantity));
		BigDecimal curAmount = curPrice.multiply(new BigDecimal(quantity));
		BigDecimal result = curAmount.subtract(buyAmount);
		return result;
	}
}
