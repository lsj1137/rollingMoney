package service;

import dao.MemberDAO;
import dto.MemberDTO;

public class MemberService {
	private MemberDAO memberDAO = new MemberDAO();

	// 회원가입
	public Long register(String name) {
		// 이름 유효성 검사 (예: 빈 값 체크)
		if (name == null || name.trim().isEmpty()) {
			System.out.println("⚠️ 이름은 필수 입력값입니다.");
			return null;
		}

		// DAO 호출
		Long newId = memberDAO.insertMember(name);
		return newId;
	}

	// 로그인
	public MemberDTO login(Long memberId) {
		MemberDTO member = memberDAO.getMemberById(memberId);
		if (member == null) {
			System.out.println("❌ 존재하지 않는 회원 ID입니다.");
			return null;
		}
		return member;
	}
	
	public MemberDTO refresh(Long memberId) {
		return memberDAO.getMemberById(memberId);
	}

}
