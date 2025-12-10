package util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import config.ConfigLoader;


public class DBUtil {
	public static Connection dbConnect() {
		
		Connection conn =null;
		
		try {
			String driver = ConfigLoader.getDbDriver();
			String url = ConfigLoader.getDbUrl();
			String id = ConfigLoader.getDbUserName();
			String password = ConfigLoader.getDbPassword();
			
			Class.forName(driver); //드라이버 로드
			
			conn = DriverManager.getConnection(url,id, password); //드라이브매니저로 connection
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return conn;
	}


	public static void dbDisconnect(Connection conn, Statement st, ResultSet rs) {
		// TODO Auto-generated method stub
		try {
			//생성된게 있으면 닫아라
			if(rs!=null) rs.close();
			if(st!=null) st.close();
			if(conn!=null) conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}