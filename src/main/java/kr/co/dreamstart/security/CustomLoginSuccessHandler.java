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
import kr.co.dreamstart.service.UserService;
import lombok.RequiredArgsConstructor;

@Component("customLoginSuccessHandler")
@RequiredArgsConstructor
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	@Autowired
	private UserService userService;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, 
										HttpServletResponse response,
										Authentication authentication) 
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// principal에서 바로 userId 획득 (재조회 없음)
		CustomUserDetails me = (CustomUserDetails) authentication.getPrincipal();
		Long userId = me.getUserId();
		userService.touchLastLogin(userId);
		
		// 저장된 요청으로 복귀 (없으면 dafault-target-url 로)
		super.onAuthenticationSuccess(request, response, authentication);
	}

	
	
}
