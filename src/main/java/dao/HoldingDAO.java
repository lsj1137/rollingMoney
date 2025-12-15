package dao;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import dto.HoldingDTO;
import dto.MemberDTO;
import dto.StockDTO;
import util.DBUtil;

public class HoldingDAO {
	static final String SQL_SELECT_WITH_ID = """
select *
from HOLDINGS join PRODUCTS using (product_id, product_type)
where MEMBER_ID = ?
""";
	
	static final String SQL_SELECT_STOCK_WITH_ID = """
select *
from HOLDINGS
where PRODUCT_TYPE='STOCK' and MEMBER_ID = ?
""";
	
	static final String SQL_INSERT = """
insert into holdings (member_id, product_id, product_type, quantity, buy_price, buy_amount, buy_date, matured_at)
values (?,?,?,?,?,?,?,?)
""";
	
	static final String SQL_UPDATE_CASH = """
update MEMBERS
set CASH = ?
where MEMBER_ID = ?
""";
	
	static final String SQL_UPDATE_QUANTITY = """
update HOLDINGS
set QUANTITY = ?
where holding_id = ?
""";

	static final String SQL_DELETE = """
delete from HOLDINGS
where holding_id = ?
""";
	
	static final String SQL_SELECT_EXISTING_HOLDING = """
SELECT *
FROM HOLDINGS
WHERE MEMBER_ID = ? AND PRODUCT_ID = ? AND PRODUCT_TYPE = ?
""";

static final String SQL_UPDATE_HOLDING_INFO = """
UPDATE HOLDINGS
SET QUANTITY = ?, BUY_PRICE = ?, BUY_AMOUNT = ?
WHERE HOLDING_ID = ?
""";

static final String SQL_SELECT_WITH_PID = """
select *
from HOLDINGS
where MEMBER_ID=? AND PRODUCT_ID = ?
""";

	private HoldingDTO makeHolding(ResultSet rs) throws SQLException {
		HoldingDTO holding = new HoldingDTO();
		holding.setHoldingId(rs.getLong("holding_id"));
		holding.setProductId(rs.getLong("product_id"));
		try {
			holding.setProductName(rs.getString("product_name"));
		} catch (SQLException e) {
			holding.setProductName(null);
		}
		holding.setProductType(rs.getString("product_type"));
		holding.setMemberId(rs.getLong("member_id"));
		holding.setQuantity(rs.getInt("quantity"));
		holding.setBuyDate(rs.getDate("buy_date"));
		holding.setBuyPrice(rs.getBigDecimal("buy_price"));
		holding.setBuyAmount(rs.getBigDecimal("buy_amount"));
		holding.setMaturedAt(rs.getDate("matured_at"));
		return holding;
	}

	public List<HoldingDTO> getAllHoldings(Long loggedInMemberId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		List<HoldingDTO> holdingList = new ArrayList<>();

        try {
            conn = DBUtil.dbConnect();
            pstmt = conn.prepareStatement(SQL_SELECT_WITH_ID);
            pstmt.setLong(1, loggedInMemberId);
            rs = pstmt.executeQuery();
			while (rs.next()) {
				HoldingDTO newStock = makeHolding(rs);
				holdingList.add(newStock);
			}
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.dbDisconnect(conn, pstmt, rs);
        }
		return holdingList;
	}
	
	
	public int buyStock(MemberDTO member, StockDTO stock, int quantity) {
		int resultCode = 0;

		Connection conn = null;
        PreparedStatement pstmt = null;
        
        // 현재 매수 관련 기본 정보 계산
        BigDecimal currentPrice = stock.getCurPrice();
        BigDecimal purchaseAmount = currentPrice.multiply(new BigDecimal(quantity));
        BigDecimal curCash = member.getCash();
        BigDecimal newCash = curCash.subtract(purchaseAmount);
		
		try {
			conn = DBUtil.dbConnect();
			conn.setAutoCommit(false);
			
			if (newCash.compareTo(BigDecimal.ZERO)<0) {
				resultCode = -1;
				return resultCode;
			}
			
			// 기존 보유 주식 확인
	        HoldingDTO existingHolding = null;
	        pstmt = conn.prepareStatement(SQL_SELECT_EXISTING_HOLDING);
	        pstmt.setLong(1, member.getMemberId());
	        pstmt.setLong(2, stock.getProductId());
	        pstmt.setString(3, stock.getProductType());
	        
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            existingHolding = makeHolding(rs);
	        }
	        rs.close();
	        int result1 = 0;
	        
	        // 주식을 이미 가지고 있는 경우 (UPDATE)
	        if (existingHolding != null) {
	            
	            // 가중 평균 평단가 재계산 로직
	            int newQuantity = existingHolding.getQuantity() + quantity;
	            BigDecimal oldBuyAmount = existingHolding.getBuyAmount();
	            
	            // 새로운 총 매수 금액: 기존 총액 + 이번 매수 금액
	            BigDecimal newBuyAmount = oldBuyAmount.add(purchaseAmount);
	            
	            // 새로운 평균 매수 단가 (평단가): 새로운 총액 / 새로운 수량
	            // 소수점 6자리까지 반올림 (정밀도 유지를 위해 넉넉하게 지정)
	            BigDecimal newAvgPrice = newBuyAmount.divide(
	                new BigDecimal(newQuantity), 
	                6, 
	                RoundingMode.HALF_UP
	            );
	            
	            pstmt = conn.prepareStatement(SQL_UPDATE_HOLDING_INFO);
	            pstmt.setInt(1, newQuantity);
	            pstmt.setBigDecimal(2, newAvgPrice);
	            pstmt.setBigDecimal(3, newBuyAmount);
	            pstmt.setLong(4, existingHolding.getHoldingId());
	            
	            result1 = pstmt.executeUpdate();
	        } else {
	        	pstmt = conn.prepareStatement(SQL_INSERT);
	        	pstmt.setLong(1, member.getMemberId());
				pstmt.setLong(2, stock.getProductId());
				pstmt.setString(3, stock.getProductType());
				pstmt.setLong(4, quantity);
				pstmt.setBigDecimal(5, stock.getCurPrice());
				pstmt.setBigDecimal(6, purchaseAmount);
				pstmt.setDate(7, Date.valueOf(LocalDate.now()));
				pstmt.setDate(8, null);
				result1 = pstmt.executeUpdate();
	        }

	        pstmt = conn.prepareStatement(SQL_UPDATE_CASH);
	        pstmt.setBigDecimal(1, newCash);
			pstmt.setLong(2, member.getMemberId());
			int result2 = pstmt.executeUpdate();
			if (result1>0 && result2>0) {
				conn.commit();
				member.setCash(newCash);
				resultCode = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			resultCode = -2;
		} finally {
			DBUtil.dbDisconnect(conn, pstmt, null);
		}
		
		return resultCode;
	}


	public List<HoldingDTO> getAllStocks(Long loggedInMemberId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		List<HoldingDTO> holdingList = new ArrayList<>();

        try {
            conn = DBUtil.dbConnect();
            pstmt = conn.prepareStatement(SQL_SELECT_STOCK_WITH_ID);
            pstmt.setLong(1, loggedInMemberId);
            rs = pstmt.executeQuery();
			while (rs.next()) {
				HoldingDTO newStock = makeHolding(rs);
				holdingList.add(newStock);
			}
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.dbDisconnect(conn, pstmt, rs);
        }
		return holdingList;
	}
	
	
	public int sellStock(MemberDTO member, StockDTO stock, HoldingDTO holding, int quantity) {
		int resultCode = 0;

		Connection conn = null;
        PreparedStatement updateStmt1 = null;
        PreparedStatement updateStmt2 = null;
		
		try {
			conn = DBUtil.dbConnect();
			conn.setAutoCommit(false);
			int remainQty = holding.getQuantity()-quantity;
			int result1 = 0;
			if (remainQty>0) {
				updateStmt1 = conn.prepareStatement(SQL_UPDATE_QUANTITY);
				updateStmt1.setLong(1, remainQty);
				updateStmt1.setLong(2, holding.getHoldingId());
				result1 = updateStmt1.executeUpdate();
			} else {
				updateStmt1 = conn.prepareStatement(SQL_DELETE);
				updateStmt1.setLong(1, holding.getHoldingId());
				result1 = updateStmt1.executeUpdate();
			}
 
			updateStmt2 = conn.prepareStatement(SQL_UPDATE_CASH);
			BigDecimal curCash = member.getCash();
			System.out.println("1>> "+curCash);
			BigDecimal amount = stock.getCurPrice().multiply(new BigDecimal(quantity));
			System.out.println("2>> "+amount);
			BigDecimal newCash = curCash.add(amount);
			System.out.println("3>> "+newCash);
			updateStmt2.setBigDecimal(1, newCash);
			updateStmt2.setLong(2, member.getMemberId());
			int result2 = updateStmt2.executeUpdate();
			if (result1>0 && result2>0) {
				resultCode = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			resultCode = -1;
		} finally {
			if (updateStmt2 != null)
				try {
					updateStmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			DBUtil.dbDisconnect(conn, updateStmt1, null);
		}
		
		return resultCode;
	}

	public HoldingDTO getHoldingByPid(Long memberId, Long productId) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		HoldingDTO holdingDTO = null;

        try {
            conn = DBUtil.dbConnect();
            pstmt = conn.prepareStatement(SQL_SELECT_WITH_PID);
            pstmt.setLong(1, memberId);
            pstmt.setLong(2, productId);
            rs = pstmt.executeQuery();
			while (rs.next()) {
				holdingDTO = makeHolding(rs);
			}
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.dbDisconnect(conn, pstmt, rs);
        }
		return holdingDTO;
	}
}
