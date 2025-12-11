package config;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class ConfigLoader {
	private static Properties properties = new Properties();
	// 클래스가 로딩될 때 딱 한 번 실행 (파일 읽기)
    static {
    	// getResourceAsStream()의 결과를 먼저 변수에 저장
        java.io.InputStream inStream = ConfigLoader.class.getClassLoader().getResourceAsStream("config.properties");
        
        if (inStream == null) {
            // 파일이 없을 경우에 대한 명시적인 예외 처리
            System.err.println("❌ config.properties 파일을 찾을 수 없습니다. 클래스패스 위치를 확인하세요.");
            // 예외를 던지거나, 시스템을 종료하거나, 기본값을 설정할 수 있습니다.
            // 여기서는 에러 메시지만 출력하고, 나머지 getter 메서드가 Null을 반환하게 둘 수 있습니다.
        } else {
            try {
                properties.load(inStream);
                inStream.close();
            } catch (IOException e) {
                System.err.println("❌ config.properties 파일 로딩 중 IO 오류 발생.");
                e.printStackTrace();
            }
        }
    }

    // 외부에서 값을 꺼내갈 수 있게 메서드 제공
    public static String getKisAppKey() {
        return properties.getProperty("kis.appKey");
    }

    public static String getKisAppSecret() {
        return properties.getProperty("kis.appSecret");
    }

    public static String getDbDriver() {
    	return properties.getProperty("db.driver");
    }
    
    public static String getDbUrl() {
        return properties.getProperty("db.url");
    }
    
    public static String getDbUserName() {
        return properties.getProperty("db.username");
    }
    
    public static String getDbPassword() {
        return properties.getProperty("db.password");
    }
}
