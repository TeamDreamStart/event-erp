package kr.co.dreamstart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ErrorController {
	// 접근 권한 없음
	@GetMapping("/error/403")
	public String error403() {
		return "error/403";
	}
	
	// 페이지 찾을 수 없음
	@GetMapping("/error/404")
	public String error404() {
		return "error/404";
	}
	
	// 서버 내부 에러 (컨트롤러/서비스 예외 터져서 서버가 처리 못할경우)
	@GetMapping("/error/500") 
	public String error500() {
		return "error/500";
	}
}
