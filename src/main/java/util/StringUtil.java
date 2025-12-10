package util;

import java.math.BigDecimal;
import java.text.DecimalFormat;

public class StringUtil {
	public static String getPaddingString(String original, int targetWidth) {
	    if (original == null) original = "";
	    targetWidth = targetWidth * 2;

	    // 현재 문자열의 시각적 길이 계산 및 자르기
	    StringBuilder sb = new StringBuilder();
	    int currentWidth = 0;

	    for (char c : original.toCharArray()) {
	        int charWidth = (c >= '가' && c <= '힣') ? 2 : 1;
	        if (currentWidth + charWidth > targetWidth) {
	            int dotsWidth = 2; // '..'의 너비
	            while (currentWidth > targetWidth - dotsWidth) {
	                if (sb.length() == 0) break; 
	                char lastChar = sb.charAt(sb.length() - 1);
	                int lastCharWidth = (lastChar >= '가' && lastChar <= '힣') ? 2 : 1;
	                sb.deleteCharAt(sb.length() - 1);
	                currentWidth -= lastCharWidth;
	            }
	            sb.append("..");
	            currentWidth += 2;
	            break;
	        }

	        sb.append(c);
	        currentWidth += charWidth;
	    }

	    // 2. 남은 공간만큼 공백 채우기
	    while (currentWidth < targetWidth) {
	        sb.append(" ");
	        currentWidth++;
	    }

	    return sb.toString();
	}
	
	public static String formatNumber(long number) {
        // "###,###" 또는 "#,###" 패턴을 사용합니다.
        // #은 해당 자리에 숫자가 없으면 표시하지 않음을 의미합니다.
        DecimalFormat formatter = new DecimalFormat("#,###"); 
        
        return formatter.format(number);
    }

	public static String formatNumber(BigDecimal number) {
        DecimalFormat formatter = new DecimalFormat("#,###"); 
        
        return formatter.format(number);
    }
}
