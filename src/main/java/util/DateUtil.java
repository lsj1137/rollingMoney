package util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

public class DateUtil {
	public static java.sql.Date convertToSQLDate(Date dt) {
		java.sql.Date dt2 = new java.sql.Date(dt.getTime());
		return dt2;
	}
	public static java.sql.Date convertToSQLDate(String dt) {
		SimpleDateFormat sdf = new SimpleDateFormat("y-M-d");
		Date d;
		java.sql.Date dt2 = null;
		try {
			d = sdf.parse(dt);
			dt2 = new java.sql.Date(d.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dt2;
	}
	
	public static Date convertToUtilDate(java.sql.Date dt) {
		Date dt2 = new Date(dt.getTime());
		return dt2;
	}
	
	public static String formatTimestamp(Timestamp timestamp) {
        if (timestamp == null) {
            return ""; // 또는 원하는 기본 값 반환
        }
        
        // 원하는 형식 지정
        SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm:ss");
        
        // Timestamp 객체를 지정된 형식의 문자열로 변환
        String formattedDate = sdf.format(timestamp);
        
        return formattedDate;
    }
	
}
