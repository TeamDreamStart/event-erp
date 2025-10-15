/*
 * 매핑할때 받고싶은 데이터를 강제하여 오류를 줄일 수 있다.
 * 그중하나가 Media Types
 * consumes와 produces의 차이
 * consumes는 클라이언트가 서버에게 보내는 데이터 타입을 명시한다. (들어오는 데이터 타입을 정의)
 * produces는 서버가 클라이언트에게 반환하는 데이터 타입을 명시한다 
 * */

package kr.co.dreamstart.api;

import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.dreamstart.service.EmailSenderService;
import kr.co.dreamstart.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@Slf4j
public class UserApiController {
	private final UserService userService;
	private final EmailSenderService emailSenderService;
	
	// 아이디가 존재하는지 체크
	@GetMapping(value = "/check-username", produces = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> chekUserName(@RequestParam String username) {
		boolean exists = userService.existsByUserName(username);
		log.info("[EXISTS-USERNAME] username='{}' -> exists={}", username, exists);
		return Map.of("ok", true, "exists", exists);
	}
	
	// 이메일이 존재하는지 체크
	@GetMapping(value = "/check-email", produces = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> checkEmail(@RequestParam String email) {
		boolean exists = userService.existsByEmail(email);
		log.info("[EXISTS-EMAIL] email='{}' -> exists={}", email, exists);
		return Map.of("ok", true, "exists", exists);
	}
	
	
	/* ========================
	 * 이메일 인증 -> JSON 버전 
	 * ======================== */
	
	
}
