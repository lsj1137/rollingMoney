package service;

import dao.MemberDAO;
import dto.MemberDTO;

public class MemberService {
	private MemberDAO memberDAO = new MemberDAO();

	// 회원가입
	public Long register(String name, String email, String password) {
		// 이름 유효성 검사 (예: 빈 값 체크)
		if (name == null || name.trim().isEmpty()) {
			System.out.println("⚠️ 이름은 필수 입력값입니다.");
			return -1L;
		} else if (email == null || email.trim().isEmpty()) {
			System.out.println("⚠️ 이메일은 필수 입력값입니다.");
			return -2L;
		} else if (password == null || password.trim().isEmpty()) {
			System.out.println("⚠️ 비밀번호는 필수 입력값입니다.");
			return -3L;
		}

		// DAO 호출
		Long newId = memberDAO.insertMember(name, email, password);
		return newId;
	}

	// 로그인
	public MemberDTO login(String email, String password) {
		MemberDTO member = memberDAO.login(email, password);
		
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
