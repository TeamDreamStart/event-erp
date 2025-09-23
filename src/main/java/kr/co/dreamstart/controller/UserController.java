package kr.co.dreamstart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {
	@Autowired
	private UserMapper mapper; // DB연동
	
//	Account
//	회원가입 폼
	@GetMapping("/join")
	public String joinForm(Model model) {
		model.addAttribute("user", new UserDTO()); // 바인딩할 빈 객체 생성
		log.info("GET /joinForm 호출"); // 로그 기록 (확인용)
		return "account/join"; // JSP 경로 반환
	}
	
//	회원가입 처리 (개인정보 보호를 위해 post)
//	프론트에서 유효성검증 + 형식이 맞지 않을경우 폼에 빨간줄로 경고 뜨게 작동하는 방식 java에서는 죄소한의 방어선만 구축
	@PostMapping("/join")
	public String joinSubmit(@ModelAttribute("user") UserDTO form, RedirectAttributes ra) {
//		최소 방어선 
		boolean hasError = false;
		if (form.getEmail() == null || form.getEmail().trim().isEmpty()) {
			log.warn("[JOIN] email blank");
			hasError = true;
		}
		if (form.getPassword() == null || form.getPassword().trim().isEmpty()) {
			log.warn("[JOIN] password blank");
			hasError = true;
		}
		if (form.getName() == null || form.getName().trim().isEmpty()) {
			log.warn("[JOIN] name blank");
			hasError = true;
		}
		if (form.getPhone() == null || form.getPhone().trim().isEmpty()) {
			log.warn("[JOIN] phone blank");
			hasError = true;
		}
		
//		하나라도 비어있으면 다시 가입폼으로
		if (hasError) {
			return "account/join";
		}
		
//		모든 값이 채워져있다면 DB 저장 시도
		try {
			int result = mapper.joinUser(form);
			if (result == 1) {
				log.info("[JOIN] 회원가입 성공 - email: {}", form.getEmail());
				
//				가입 성공 후 Login.jsp에 메세지 전달
				ra.addFlashAttribute("msg", "회원가입이 완료되었습니다.");
				return "redirect:/login";
			} else {
				log.warn("[JOIN] 회원가입 실패 - insert된 행 없음");
				return "account/join";
			}
		} catch (Exception e) {
			// TODO: handle exception
			log.error("[JOIN] DB 처리 중 예외 발생", e);
			return "account/join";
		}

		
	}
		
		
		
	
}
