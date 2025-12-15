package service;

import java.util.List;

import dao.HoldingDAO;
import dto.HoldingDTO;
import dto.MemberDTO;
import dto.StockDTO;

public class HoldingService {
	private final HoldingDAO holdingDAO = new HoldingDAO();

	public List<HoldingDTO> getAllHoldings(Long loggedInMemberId) {
		return holdingDAO.getAllHoldings(loggedInMemberId);
	}

	public int buyStock(MemberDTO member, StockDTO stock, int quantity) {
		return holdingDAO.buyStock(member, stock, quantity);
	}

	public List<HoldingDTO> getAllStocks(Long loggedInMemberId) {
		return holdingDAO.getAllStocks(loggedInMemberId);
	}

	public int sellStock(MemberDTO member, StockDTO stockToSell, HoldingDTO holdingToSell, int quantity) {
		return holdingDAO.sellStock(member, stockToSell, holdingToSell, quantity);
	}

	public HoldingDTO getHoldingByPid(Long memberId, Long productId) {
		return holdingDAO.getHoldingByPid(memberId, productId);
	}
	
}
