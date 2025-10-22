package kr.co.dreamstart.service;

import java.util.Map;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.UserDTO;

public interface UserService {
	//관리자(ADMIN)
	public Map<String,Object> userList(@Param("cri") Criteria cri,
									@Param("role") Integer role,
									@Param("searchType") String searchType,
									@Param("keyword") String keyword, 
									@Param("startDate") String startDate, 
									@Param("endDate") String endDate);
	
	public Map<String,Object> adminUserUpdate(UserDTO userDTO, int roleId);
	
	// naver 회원
	public Map<String, String> getNaverUser(String accessToken);
	public UserDTO saveOrUpdateNaverUser(Map<String, String> naverUser);
	public String getAccessToken(String code, String state);

	// 회원가입 + 기본권환 / 로그인 -> 공통
	public long register(UserDTO form);
	// 아이디/이메일 단건 조회
	public UserDTO findByLogin(String login);
	// user_role_name(admin, member)
	public List<String> findRoleNameByUserId(Long userId);
	// 마지막 로그인 시간 업데이트
	public void touchLastLogin(Long userId);

	public String findUserNameByEmail(String email);
	
	// 비밀번호 재설정 ( 비밀번호 찾기/내 정보 수정에서 비밀번호 수정시) 이메일로 userId 찾아서 해당 회원 정보 update
	public int resetPassword(String email,String newPass);
	
	// 중복체크 관련
	// 아이디 중복 체크
	boolean existsByUserName(String username);
	// 이메일 중복 체크
	boolean existsByEmail(String email);
	
	//username
	public UserDTO findUserByUserName(String userName);
	//email
	public UserDTO findByEmail(String email);
	//userId
	public UserDTO findByUserId(long userId);
	
	//회원정보 수정 - 기본정보 수정 
	public Map<String,Object> userUpdate(UserDTO userDTO);
	
	
	
	// db에 있는 userId (자동 생성 번호라 겹치지 않아 더 안정적)
	public UserDTO findByUserId(Long userId);
	
	// 회원탈퇴
	public int deleteUser(Long userId);
	
	// 아이디로 이메일 찾기
	public Long findUserIdByEmail(String email);
}
