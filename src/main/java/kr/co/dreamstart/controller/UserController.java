/*
 * Instanceof : 객체가 어떤 클래스인지, 어떤 클래스를 상속받았는지 확인하는데 사용하는 연산자
 * 1. 발송 → 세션에 코드/검증여부 저장
 * 2. 검증 → 세션에 true로 마크
 * 3. 가입 → 세션에서 evVerified:<email>가 true인지 확인
 * 4. 성공 시 정리 → removeAttribute(...)로 두 키 삭제
 * */

package kr.co.dreamstart.controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.AdminJoinDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.UserMapper;
import kr.co.dreamstart.service.AdminService;
import kr.co.dreamstart.service.BoardService;
import kr.co.dreamstart.service.EmailSenderService;
import kr.co.dreamstart.service.UserService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private UserService userService;

	@Autowired
	private EmailSenderService emailService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private AdminService adminService;

//	회원가입
	@GetMapping("/join") // 바인딩할 빈 객체 생성
	public String joinForm(@ModelAttribute("user") UserDTO user, Model model, HttpServletResponse resp,
			HttpSession session) {

		// 뒤로가기 복원 방지 : 캐시 금지
		resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
		resp.addHeader("Pragma", "no-cache");
		resp.setDateHeader("Expires", 0);

		// 플래시 모델이 없을때만 새객체 채워주기
		if (!model.containsAttribute("user")) {
			model.addAttribute("user", new UserDTO());
		}

		log.info("GET /joinForm 호출"); // 로그 기록 (확인용)
		return "account/join"; // JSP 경로 반환
	}

	@PostMapping("/join")
	public String joinSubmit(@Valid @ModelAttribute("user") UserDTO form, BindingResult binding, RedirectAttributes ra,
			HttpSession session) {

		// 성별 값 한번더 채크(0/1)
		if (form.getGender() == null || (form.getGender() != 0 && form.getGender() != 1)) {
			binding.rejectValue("gender", "gender.invalid", "성별을 올바르게 선택해 주세요.");
			return "account/join";
		}

		// 바인딩/검증 에러 -> 플래시에 싵고 PRG
		if (binding.hasErrors()) {
			ra.addFlashAttribute("user", form);
			ra.addFlashAttribute("org.springframework.validation.BindingResult.user", binding);
			return "redirect:/join";
		}

		// 이메일 정규화 (공백제거 + 소문자)
		String email = form.getEmail() == null ? null : form.getEmail().trim().toLowerCase();

		// 이메일 인증 완료 여부 확인
		String verifiedKey = "evVerified:" + email;
		boolean verified = Boolean.TRUE.equals(session.getAttribute(verifiedKey));
		if (!verified) {
			ra.addAttribute("user", form);
			ra.addAttribute("error", "이메일 인증을 먼저 완료해 주세요.");
			return "redirect:/join";
		}

		// 실제 가입 처리는 서비스에서 (포맷/인코딩 포함)
		userService.register(form);

		// 가입 성공시 세션 플래그 정리 -> 세션에 남아있는 메일, 인증번호 지우기
		session.removeAttribute("ev:" + email);
		session.removeAttribute("evVerified:" + email);

		// join 페이지에서 모달 띄우도록 플래시 세팅
		ra.addFlashAttribute("joinSuccess", true);

		// join으로 리다이렉트 -> 모달 노출 -> 확인 누르면 /login 이동
		return "redirect:/login";
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
			UserDTO userDTO = userService.findByEmail(email);
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

	// 로그인한 사용자의 ID와 URL 경로의 userId가 같을 때만 접근 허용
	@PreAuthorize("#userId == principal.userId")
	@GetMapping("/my-info/{userId}")
	public String myInfo(@PathVariable("userId") long userId, Model model) {
		UserDTO userDTO = userService.findByUserId(userId);
		model.addAttribute("userDTO", userDTO);
		List<AdminJoinDTO> list = adminService.selectJoinPayByUserId(userId); // 예약 및 결제정보
		model.addAttribute("reservationList", list);
		List<BoardPostDTO> postList = boardService.listWithCommentCountByUserId(userId);
		model.addAttribute("postList", postList);
		return "/user/myInfo";
	}

	// 로그인한 사용자의 ID와 URL 경로의 userId가 같을 때만 접근 허용
	@PreAuthorize("#userId == authentication.principal.userId")
	@GetMapping("/my-info/{userId}/update")
	public String myInfoForm(@PathVariable("userId") long userId, Model model) {
		UserDTO userDTO = userService.findByUserId(userId);
		model.addAttribute("userDTO", userDTO);
		return "/user/myInfoForm";
	}
	
	@PostMapping("/my-info/{userId}/update")
	public String myInfoUpdate(@PathVariable("userId") long userId,UserDTO userDTO,RedirectAttributes rttr) {
		// 회원 정보 수정
		
		return "";
	}
	

	// 로그인한 사용자의 ID와 URL 경로의 userId가 같을 때만 접근 허용
	@PreAuthorize("#userId == principal.userId")
	@GetMapping("/my-info/{userId}/survey")
	public String myInfoSurvey() {

		return "/user/surveyForm";
	}

}
