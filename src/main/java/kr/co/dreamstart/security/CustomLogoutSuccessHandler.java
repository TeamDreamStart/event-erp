package kr.co.dreamstart.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest request, 
								HttpServletResponse response, 
								Authentication authentication)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		String ctx = request.getContextPath();
		// 폼에서 hidden으로 넘김
		String from = request.getParameter("from");
		
		// 1순위 : 파라미터
		if ("admin".equalsIgnoreCase(from)) {
			response.sendRedirect(ctx + "/login?mode=admin");
			return;
		} 
		if ("member".equalsIgnoreCase(from)) {
			response.sendRedirect(ctx + "/");
			return;
		}
		
		// 2순위 : /admin 이면 관리자가라고 간주
		String referer = request.getHeader("Referer");
		if (referer != null && referer.contains(ctx + "/admin")) {
			response.sendRedirect(ctx + "/login?mode=admin");
		} else {
			response.sendRedirect(ctx + "/");
		}
	}

}
