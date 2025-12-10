package config;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class ConfigLoader {
	private static Properties properties = new Properties();
	// 클래스가 로딩될 때 딱 한 번 실행 (파일 읽기)
    static {
        try {
            // 프로젝트 루트에 있는 config.properties 파일 로딩
            FileInputStream fis = new FileInputStream("config.properties");
            properties.load(fis);
            fis.close();
        } catch (IOException e) {
            System.err.println("❌ config.properties 파일을 찾을 수 없습니다.");
            e.printStackTrace();
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
