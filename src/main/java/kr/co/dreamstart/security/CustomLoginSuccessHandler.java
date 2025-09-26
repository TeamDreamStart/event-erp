package kr.co.dreamstart.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.UserMapper;

@Component("customLoginSuccessHandler")
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	@Autowired
	private UserMapper userMapper;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, 
										HttpServletResponse response,
										Authentication authentication) 
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String username = authentication.getName(); // UserDeails.withUsername()값
		UserDTO u = userMapper.findByLogin(username);	// 아이디/이메일 조회
		
		if (u != null) {
			userMapper.updateLastLoginAt(u.getUserId());	// 마지막 로그인 시간 업데이트
		}
		
		// 저장된 요청으로 복귀 (없으면 dafault-target-url 로)
		super.onAuthenticationSuccess(request, response, authentication);
	}

	
	
}
