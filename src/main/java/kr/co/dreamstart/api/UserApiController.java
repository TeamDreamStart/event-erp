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

import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	 * 1. 세션에 인증코드/만료정보 저장
	 * 2. 사용자가 제출한 코드 세션값과 비교
	 * 3. 성공시 세션 죽임
	 * 4. 가입 진행
	 * ======================== */
	
	// 이메일 인증 번호 발송 (EmailSenderService -> 코드 생성 반환)
	@PostMapping(value = "/email-code", 
				consumes = MediaType.APPLICATION_JSON_VALUE,
				produces = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> sendEmailCode(@RequestBody Map<String, String> body,
											HttpSession session) {
		String email = body.get("email");
		if (email == null || email.isBlank()) {
			return Map.of("ok", false, "reason", "EMPTY_EMAIL");
		}
		String norm = email.trim().toLowerCase(); // 공백제거, 소문자 변환
		
		// 이미 가입되어 있는 이메일일 경우 발송 x
		if (userService.existsByEmail(norm)) {
			return Map.of("ok", false, "reason", "ALREADY_EXISTS");
		}
		
		// 메일전송 + uuid생성
		String code = emailSenderService.sendEmail(norm);
		// 유효시간 : 5분
		long ttlMs = 5 * 60 * 1000L;
		EmailVerify ev = new EmailVerify(code.toLowerCase(), 
										System.currentTimeMillis() 
										+ ttlMs, 0, norm);
		// 세션키 : ev:<email>
		session.setAttribute("ev:" + norm, ev );
		log.info("[EMAIL-CODE] send to={} ttlMs={}", norm, ttlMs);
		return Map.of("ok", true);
	}
	
	// 이메일 인증번호 검증
	@PostMapping(value = "/verify-email-code",
				consumes = MediaType.APPLICATION_JSON_VALUE,
				produces = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> verifyEmailCode(@RequestBody Map<String, String> body,
												HttpSession session) {
		String input = body.get("code");
		String email = body.get("email");
		// 인증번호 또는 이메일이 비어있을경우
		if (input == null || email == null) {
			return Map.of("ok", false, "reason", "INVALID_PARAM");
		}
		
		String norm = email.trim().toLowerCase();
		EmailVerify ev = (EmailVerify) session.getAttribute("ev:" + norm);
		// 세션에 EmailVerify가 비어 있을경우
		 if (ev == null) return Map.of("ok", false, "reason", "NO_SESSION");
		
		 // 유효시간을 초과했을경우
		 if (System.currentTimeMillis() > ev.expiresAt) {
			 session.removeAttribute("ev:" + norm);
			 return Map.of("ok", false, "reason", "EXPIRED");
		 }
		 
		 // 세션에 저장되어있는 이메일과 일치하지 않을 경우
		 if (!ev.email.equals(norm)) {
			 return Map.of("ok", false, "reason", "EMAIL_MISMATCH");
		 }
		 
		 // 실패횟수 : 5회 초과 될 경우
		 ev.attempts++;
		 if (ev.attempts > 5) {
			 session.removeAttribute("ev:" + norm);
			 return Map.of("ok", false, "reason", "TOO_MANY_ATTEMPTS");
		 }
		 
		 boolean ok = ev.code.equalsIgnoreCase(input.trim());
		 // 실패횟수 저장
		 if (!ok) {
			 session.setAttribute("ev:" + norm, ev);
			 return Map.of("ok", false, "reason", "CODE_MISMATCH");
		 }
 
		 // 성공시 -> 원타임 플래그 기록 후 발송용 세션은 제거
		 session.removeAttribute("ev:" + norm);
		 session.setAttribute("evVerified:" + norm, true);
		 return Map.of("ok", true);
	}
	
	// 세션 보관용 내부 클래스 (파일로 분리하기 싫어서....)
	public static class EmailVerify {
		String code;  
		long expiresAt; // ms 
		int attempts;	// 실패횟수
		String email;

		public EmailVerify(String code, long expiresAt, int attempts, String email) {
			super();
			this.code = code;
			this.expiresAt = expiresAt;
			this.attempts = attempts;
			this.email = email;
		}
	}
}
