package kr.co.dreamstart.service;

import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.UserDTO;

@Service
public interface UserService {
	public Map<String,Object> userList(@Param("cri") Criteria cri,@Param("role") Integer role,@Param("searchType") String searchType,
			@Param("keyword") String keyword, @Param("startDate") String startDate, @Param("endDate") String endDate);
	
	public UserDTO userDetail(long userId);
	
	//naver
	public Map<String, String> getNaverUser(String accessToken);
	public void saveOrUpdateNaverUser(Map<String, String> naverUser);

	public String getAccessToken(String code, String state);
}
