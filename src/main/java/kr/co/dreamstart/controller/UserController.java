package kr.co.dreamstart.controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.UserMapper;
import kr.co.dreamstart.service.EmailSenderService;
import kr.co.dreamstart.service.UserService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {
	@Autowired
	private UserMapper userMapper; // DB연동

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private UserService userService;
	
	@Autowired
	private EmailSenderService emailService;

//	회원가입
	@GetMapping("/join")
	public String joinForm(Model model) {
		model.addAttribute("user", new UserDTO()); // 바인딩할 빈 객체 생성
		log.info("GET /joinForm 호출"); // 로그 기록 (확인용)
		return "account/join"; // JSP 경로 반환
	}

//	회원가입 처리 (개인정보 보호를 위해 post)
//	프론트에서 유효성검증 + 형식이 맞지 않을경우 폼에 빨간줄로 경고 뜨게 작동하는 방식
//	@PostMapping("/join")
//	public String joinSubmit(@ModelAttribute("user") UserDTO form, RedirectAttributes ra) {
//		log.info("POST /join - email={}", form.getEmail());
//		try {
//			int result = mapper.join(form);
//			if (result == 1) { // 성공 -> 로그인페이지로
//				ra.addFlashAttribute("msg", "회원가입이 완료되었습니다.");
//				return "redirect:/login";
//			} else { // 가입 실패 -> insert 실행 하지 않음
//				log.warn("[JOIN] insert result=0");
//				return "account/join";
//			}
//		} catch (Exception e) {
//			// TODO: handle exception
//			log.error("[JOIN] DB error",e);
//			return "account/join";
//		}
//	}

	@PostMapping("/join")
	public String joinSubmit(@ModelAttribute("user") UserDTO form, RedirectAttributes ra) {
		// 새로 가입한 가입자의 비밀번호 -> 해시로 바꿔치기
		form.setPassword(passwordEncoder.encode(form.getPassword()));

		int result = userMapper.join(form);
		if (result == 1) {
			userMapper.joinRole(form.getUserId());
			ra.addFlashAttribute("msg", "회원가입 완료되었습니다.");
			return "redirect:/login";
		} else {
			ra.addFlashAttribute("error", "회원가입 실패");
			return "redirect:/join";
		}
	}

	// 로그인
	@GetMapping("/login")
	public String loginForm() {
		log.info("GET /login - 로그인 폼 진입");
		return "test/loginTest";
	}

	// 정적템플릿 (login.html) 요청이 오면 시큐리티 로그인 페이지로 넘김 (어드민용)
	@GetMapping("/login.html")
	public String redirectLoginHtml() {
		return "redirect:/login?mode=admin";
	}

	// 네이버 로그인 api DB 업데이트 + Spring security
	@RequestMapping("/login/naver/callback")
	public String naverCallback(HttpServletRequest request, HttpSession session) {
		String code = request.getParameter("code");
		String state = request.getParameter("state");

		String accessToken = userService.getAccessToken(code, state);
		Map<String, String> naverUser = userService.getNaverUser(accessToken);
		UserDTO user = userService.saveOrUpdateNaverUser(naverUser);// DB 신규 INSERT,기존회원 UPDATE

		// 권한 직접 생성 (ROLE_USER 기본)
		List<GrantedAuthority> authorities = Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"));

		// 로그인 세션 생성
		UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(user, null,
				authorities);

		SecurityContextHolder.getContext().setAuthentication(authentication);
		session.setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());

		return "redirect:/"; // 로그인 후 메인 페이지로
	}

	// 이메일 인증 테스트
	@GetMapping("/find-password")
	public String emailGET(Model model, @RequestParam(required = false) String findType,
			@RequestParam(required = false) String email) {
		if (email != null && !email.isEmpty()) {
			// 이메일로 회원 존재여부 확인
			UserDTO userDTO = userMapper.findByEmail(email);
			if (userDTO != null && userDTO.getSnsId() == null) { // sns 회원 비밀번호 변경 방지
				String code = emailService.sendEmail(email);
				// codeCheck용
				model.addAttribute("code", code);
				model.addAttribute("email", email);
				model.addAttribute("msg", "인증번호가 발송되었습니다.");
				log.info("[TEST] EMAIL CODE : " + code);
				model.addAttribute("result", "success");
				model.addAttribute("findType", findType);
			} else { // 회원이 존재하지 않을 시
				model.addAttribute("result", "fail");
				model.addAttribute("msg", "해당 이메일로 가입된 회원이 존재하지 않습니다.");
				log.info("[TEST] UNKOWN EMAIL");
			}
		}
		return "/account/findPassword";
	}

	@PostMapping("/find-password")
	public String emailPOST(RedirectAttributes rttr, String email, String findType) {
		// 인증번호 일치시 넘어옴
		// findType에 따라 redirect 다르게 분기
		if (findType.equals("findId")) { // 이메일에 따른 아이디값 전달
			String userName = userService.findUserNameByEmail(email);
			rttr.addFlashAttribute("findUserName", userName);
			return "redirect:/find-password";// alert로 아이디 알려줌
		} else { // 이메일에 따른 아이디 비밀번호 재설정창으로 이동
			rttr.addFlashAttribute("email", email); // input hidden으로 값 넣어서 이걸로 userDTO 불러와서 password Update 할 수 있게 처리
			return "redirect:/reset-password"; //
		}
	}

	@GetMapping("/reset-password")
	public String resetGET() {
		return "/account/resetPassword";
	}

	@PostMapping("/reset-password")
	public String resetPOST(@RequestParam("email") String email, @RequestParam("newPass") String newPass) {

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		newPass = encoder.encode(newPass);

		userService.resetPassword(email, newPass);
		// 변경성공 alert
		return "redirect:/login";
	}

}
