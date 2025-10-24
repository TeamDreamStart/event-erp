package kr.co.dreamstart.security;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

@Component("customAccessDeniedHandler")
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		// TODO Auto-generated method stub
		boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"))
						|| (request.getHeader("Accept") != null && request.getHeader("Accept").contains("application/json"));
		
		if (isAjax) {
			response.setStatus(HttpServletResponse.SC_FORBIDDEN); // 403
			response.setContentType(MediaType.APPLICATION_JSON_VALUE);
			response.getWriter().write("{\"code\":403,\"message\":\"접근 권한이 없습니다.\"}");
			return;
		}
		
		// 일반 요청 : JSP로 forword (WEB-INF 안이라 redirect 불가)
		response.setStatus(HttpServletResponse.SC_FORBIDDEN);
		request.setAttribute("errorMessage", "접근 권한이 없습니다.");
		try {
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/error/403.jsp");
			rd.forward(request, response);
		} catch (Exception ignore) {}
	}

}
