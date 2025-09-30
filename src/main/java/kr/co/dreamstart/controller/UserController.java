package kr.co.dreamstart.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {
	@Autowired
	private UserMapper mapper; // DB연동
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
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
		
		int result = mapper.join(form);
		if (result == 1) {
			mapper.joinRole(form.getUserId());
			ra.addFlashAttribute("msg", "회원가입 완료되었습니다.");
			return "redirect:/login";
		} else {
			ra.addFlashAttribute("error", "회원가입 실패");
			return "redirect:/join";
		}
	}
	
	
//	로그인
	@GetMapping("/login")
	public String loginForm() {
		log.info("GET /login - 로그인 폼 진입");
		return "test/loginTest";
	}
	
//	@PostMapping("/login")
//	public String login(@RequestParam String) {
//		log.info("dnd");
//		return null;
//	}
	
	
	
	
	
	
	
	
}
