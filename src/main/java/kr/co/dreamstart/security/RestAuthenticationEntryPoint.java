package kr.co.dreamstart.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

@Component("restAuthenticationEntryPoint")
public class RestAuthenticationEntryPoint implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {
		// TODO Auto-generated method stub
		boolean isAjax = "AMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"))
						|| (request.getHeader("Accept") != null && request.getHeader("Accept").contains("application/json"));
		if (isAjax) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
			response.setContentType(MediaType.APPLICATION_JSON_VALUE);
			response.getWriter().write("{\"code\":401,\"message\":\"로그인이 필요합니다.\"}");
			return;
		}
		
		// 일반 요청은 로그인 화면으로
		response.sendRedirect(request.getContextPath() + "/login");
	}

}
