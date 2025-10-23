package kr.co.dreamstart.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import kr.co.dreamstart.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component("customLoginSuccessHandler")
@RequiredArgsConstructor
@Slf4j
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	
	private final UserService userService;

	private final RequestCache requestCache = new HttpSessionRequestCache();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, 
										HttpServletResponse response,
										Authentication authentication) 
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Object principal = authentication.getPrincipal();
		
		// 로그인 성공한 사용자 정보 확인
		if (principal instanceof CustomUserDetails) {
			CustomUserDetails me = (CustomUserDetails) authentication.getPrincipal();
			
			// 세션 저장
            request.getSession().setAttribute("userId", me.getUserId());
            request.getSession().setAttribute("username", me.getName());
            request.getSession().setAttribute("email", me.getEmail());

            // 마지막 로그인 시각 갱신
            userService.touchLastLogin(me.getUserId());
		}
		
		// saveRequest 있으면 원래 가려던 곳으로 (super 호츌)
		SavedRequest saved = requestCache.getRequest(request, response);
		if (saved != null) {
			super.onAuthenticationSuccess(request, response, authentication);
			return;
		}
		
		// 없으면 권한으로 분기(ADMIN 이면 /admin, 아니면 /)
		boolean isAdmin = authentication.getAuthorities().stream()
						.map(GrantedAuthority::getAuthority)
						.anyMatch("ROLE_ADMIN"::equals);
		
		String ctx = request.getContextPath();
		String target = isAdmin ? (ctx + "/admin") : (ctx + "/");
		getRedirectStrategy().sendRedirect(request, response, target);
		
	}

	
	
}
