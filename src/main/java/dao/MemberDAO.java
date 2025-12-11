package dao;

import dto.MemberDTO;
import util.DBUtil;

import java.sql.*;

public class MemberDAO {

    // 회원가입 (이름, 이메일, 비밀번호)
    public Long insertMember(String name, String email, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Long generatedId = null;

        try {
            conn = DBUtil.dbConnect();
            // MEMBER_ID는 트리거/시퀀스로 자동 생성되므로 NAME만 입력
            String sql = "INSERT INTO MEMBERS (NAME, EMAIL, PASSWORD, CASH) VALUES (?, ?, ?, 100000000)";
            
            // 생성된 키(ID)를 받아오겠다고 명시
            pstmt = conn.prepareStatement(sql, new String[]{"MEMBER_ID"});
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            
            int result = pstmt.executeUpdate();

            if (result > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getLong(1); // 생성된 ID 획득
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.dbDisconnect(conn, pstmt, rs);
        }
        return generatedId; // 실패 시 null, 성공 시 ID 반환
    }

    // 회원 조회
    public MemberDTO getMemberById(Long memberId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberDTO member = null;

        try {
            conn = DBUtil.dbConnect();
            String sql = "SELECT * FROM MEMBERS WHERE MEMBER_ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, memberId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                member = new MemberDTO();
                member.setMemberId(rs.getLong("MEMBER_ID"));
                member.setName(rs.getString("NAME"));
                member.setCash(rs.getBigDecimal("CASH"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.dbDisconnect(conn, pstmt, rs);
        }
        return member;
    }

	public MemberDTO login(String email, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberDTO member = null;
        
        try {
            conn = DBUtil.dbConnect();
            String sql = "SELECT * FROM MEMBERS WHERE EMAIL=? and PASSWORD=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                member = new MemberDTO();
                member.setMemberId(rs.getLong("MEMBER_ID"));
                member.setName(rs.getString("NAME"));
                member.setCash(rs.getBigDecimal("CASH"));
            }
        	
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.dbDisconnect(conn, pstmt, rs);
        }
		
		return member;
	}
}