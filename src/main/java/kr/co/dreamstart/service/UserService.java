package kr.co.dreamstart.service;

import java.util.Map;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.UserDTO;

@Service
public interface UserService {
	//관리자(ADMIN)
	public Map<String,Object> userList(@Param("cri") Criteria cri,@Param("role") Integer role,@Param("searchType") String searchType,
			@Param("keyword") String keyword, @Param("startDate") String startDate, @Param("endDate") String endDate);
	
	public UserDTO userDetail(long userId);
	public Map<String,Object> adminUserUpdate(UserDTO userDTO, int roleId);
	
	//naver
	public Map<String, String> getNaverUser(String accessToken);
	public UserDTO saveOrUpdateNaverUser(Map<String, String> naverUser);
	public String getAccessToken(String code, String state);

	//유리쓰마죠리카
	// 회원가입 + 기본권환
	public long register(UserDTO form);
	// 아이디/이메일 단건 조회
	public UserDTO findByLogin(String login);
	// user_role_name(admin, member)
	public List<String> findRoleNames(Long userId);
	// 마지막 로그인 시간 업데이트
	public void touchLastLogin(Long userId);
}
