package kr.co.dreamstart.service;

import java.util.Map;

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
	
}
