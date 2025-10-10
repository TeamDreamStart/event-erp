package kr.co.dreamstart.service;

import java.util.List;

import kr.co.dreamstart.dto.UserDTO;

public interface UserService {
	// 회원가입 + 기본권환
	public long register(UserDTO form);
	// 아이디/이메일 단건 조회
	public UserDTO findByLogin(String login);
	// user_role_name(admin, member)
	public List<String> findRoleNames(Long userId);
	// 마지막 로그인 시간 업데이트
	public void touchLastLogin(Long userId);
}
