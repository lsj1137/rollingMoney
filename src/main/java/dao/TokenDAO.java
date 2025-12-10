package dao;

import util.DBUtil;
import java.sql.*;

public class TokenDAO {

    // 1. DB에 저장된 토큰 가져오기 (만료 시간 체크는 서비스에서 함)
    public String getToken() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String token = null;

        try {
            conn = DBUtil.dbConnect();
            String sql = "SELECT conf_value FROM APP_CONFIG WHERE conf_key = 'KIS_ACCESS_TOKEN'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                token = rs.getString("conf_value");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.dbDisconnect(conn, pstmt, rs);
        }
        return token;
    }

    // 2. 토큰이 언제 갱신되었는지 시간 가져오기
    public Timestamp getLastUpdatedAt() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Timestamp time = null;

        try {
            conn = DBUtil.dbConnect();
            String sql = "SELECT updated_at FROM APP_CONFIG WHERE conf_key = 'KIS_ACCESS_TOKEN'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                time = rs.getTimestamp("updated_at");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.dbDisconnect(conn, pstmt, rs);
        }
        return time;
    }

    // 3. 새 토큰 저장하기 (Upsert)
    public void saveToken(String newToken) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.dbConnect();
            // MERGE문: 이미 있으면 UPDATE, 없으면 INSERT
            String sql = """
                MERGE INTO APP_CONFIG a
                USING DUAL ON (a.conf_key = 'KIS_ACCESS_TOKEN')
                WHEN MATCHED THEN
                    UPDATE SET conf_value = ?, updated_at = SYSDATE
                WHEN NOT MATCHED THEN
                    INSERT (conf_key, conf_value, updated_at) VALUES ('KIS_ACCESS_TOKEN', ?, SYSDATE)
            """;
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newToken);
            pstmt.setString(2, newToken);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.dbDisconnect(conn, pstmt, null);
        }
    }
}
