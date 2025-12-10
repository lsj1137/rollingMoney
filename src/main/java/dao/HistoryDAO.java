package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.HistoryDTO;
import dto.MemberDTO;
import util.DBUtil;

public class HistoryDAO {
	static final String SQL_INSERT = """
			INSERT INTO HISTORY (MEMBER_ID, TOTAL_ASSET, ACTION_TYPE, PRODUCT_NAME, RECORD_DATE)
			VALUES (?, ?, ?, ?,SYSDATE)
			""";
	static final String SQL_SELECT = """
			SELECT *
			FROM HISTORY
			WHERE MEMBER_ID = ?
			""";
	
	public HistoryDTO makeHistory(ResultSet rs) throws SQLException {
		HistoryDTO historyDTO = new HistoryDTO();
		historyDTO.setTotalAsset(rs.getBigDecimal("total_asset"));
		historyDTO.setRecordDate(rs.getTimestamp("record_date"));
		historyDTO.setActionType(rs.getString("action_type"));
		historyDTO.setProductName(rs.getString("product_name"));
		return historyDTO;
	}

	public String insertHistory(HistoryDTO history) {
		String message = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			conn = DBUtil.dbConnect();
			pstmt = conn.prepareStatement(SQL_INSERT);
			pstmt.setLong(1, history.getMemberId());
			pstmt.setBigDecimal(2, history.getTotalAsset());
			pstmt.setString(3, history.getActionType());
			pstmt.setString(4, history.getProductName());

			result = pstmt.executeUpdate();
			if (result > 0) {
				message = "변경사항을 기록해두었습니다.";
			}
		} catch (SQLException e) {
			message = "변경사항 기록에 실패했습니다.";
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, pstmt, rs);
		}
		return message;
	}

	public List<HistoryDTO> loadHistory(MemberDTO member) {
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<HistoryDTO> historyList = new ArrayList<>();
		try {
			conn = DBUtil.dbConnect();
			pstmt = conn.prepareStatement(SQL_SELECT);
            pstmt.setLong(1, member.getMemberId());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				HistoryDTO newHistory = makeHistory(rs);
				historyList.add(newHistory);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, pstmt, rs);
		}
		
		return historyList;
	}
}
