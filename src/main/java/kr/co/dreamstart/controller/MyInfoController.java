package kr.co.dreamstart.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.service.MyInfoService;
import kr.co.dreamstart.service.SurveyService;
import kr.co.dreamstart.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/my-info")
@RequiredArgsConstructor
public class MyInfoController {
	
	private final MyInfoService myInfoService;
	private final UserService userService;
	
    /**
     * 예약자 설문 작성 폼 진입
     * - 예약자만 접근 가능
     * - 이벤트 종료 후 오픈된 설문만 가능
     */

	// 마이페이지 메인
//	@GetMapping("/")
//	public String myInfo(Model model, HttpSession session) {
//		// 현재 로그인 유저 id 세션 가져오기
//		Object userIdObj = session.getAttribute("userId");  // 세션에서 userId 가져오기
//		Long userId = null; // 기본값 null 세팅 (세션에서 가져온 userId 형변환용)
//		
//		if (userIdObj instanceof Long) { // Long 타입 일경우
//			userId = (Long) userIdObj;	// 형변환하여 대입
//			log.info("[MYINFO] 세션에서 userId 확인 : {}", userId);
//		} else {
//			log.warn("userId가 없거나 타입이 다릅니다. (현재 userId : {})", userIdObj);
//			return "redirect:/login";
//		}
//		
//		// 유저 정보 넣는 부분
//	    model.addAttribute("userDTO", userService.findByUserId(userId));
//		
//		// 로그인시 응답해야할 설문이 있을경우
//		List<Map<String, Object>> availableSurveys = myInfoService.findUnansweredSurveyByUser(userId);
//		model.addAttribute("availableSurveys", availableSurveys);
//		
//		// 내정보 + 예약 + 설문목록 로드
//		log.info("[MYINFO] userId={} 마이페이지 데이터 로딩 시작", userId);
//		myInfoService.loadMyInfo(userId, model);
//		log.info("[MYINFO] userId={} 마이페이지 데이터 로딩 완료", userId);
//		
//		return "/user/myInfo";
//		
//	}

	// 사용자 설문 작성 폼
	@GetMapping("/survey/{eventId}")
	public String surveyForm(@PathVariable Long eventId, 
							HttpSession session, 
							Model model, 
							RedirectAttributes ra) {
		Object userIdObj = session.getAttribute("userId");
		Long userId = null;
		
		if (userIdObj instanceof Long) {
			userId = (Long) userIdObj;
			log.info("[SURVEY FORM] 세션 userId={} / eventId={}", userId, eventId);
		} else {
			log.warn("[SURVEY FORM] 세션에 userId 없음 (eventId={})", eventId);
			return "redirect:/login";
		}
		
		// 이벤트 종료 후 오픈된 설문만
		boolean ok = myInfoService.prepareSurveyForm(userId, eventId, model);
		if (!ok) {			
			Object msg = model.asMap().get("msg");
            if (msg != null) ra.addFlashAttribute("msg", msg);
            log.info("[SURVEY FORM] 설문 없음: eventId={}", eventId);
            return "redirect:/my-info";
		}
		
		log.info("[SURVEY FORM] userId={} / eventId={} 설문 폼 준비 완료", userId, eventId);
		return "/user/surveyForm";
	}
	
	// 설문 응답 제출 처리
	@PostMapping("/survey/{eventId}/submit")
	public String submitSurvey(@PathVariable Long eventId,
								RedirectAttributes ra,
								HttpSession session) {
		
		Object userIdObj = session.getAttribute("userId");
		Long userId = null;
		
		if (userIdObj instanceof Long) {
			userId = (Long) userIdObj;
			log.info("[SURVEY SUBMIT] 세션 userId={} / eventId={}", userId, eventId);
		} else {
			log.warn("[SURVEY SUBMIT] 세션에 userId 없음 (eventId={})", eventId);
			return "redirect:/login";
		}
		// 설문 응답 저장
		myInfoService.submitSurvey(userId, eventId, ra);
		log.info("[SURVEY SUBMIT] userId={}, eventId={} 설문 응답 저장 완료", userId, eventId);
		// 설문 완료후 다시 마이페이지로
		return "redirect:/my-info/";
	}
	
	// 회원 탈퇴
	@PostMapping("/withdraw")
	public String withdraw(HttpSession session, RedirectAttributes ra) {
		Object userIdObj = session.getAttribute("userId");
		if (userIdObj == null) {
			log.warn("[WITHDRAW] 세션에 userId 없음 - 로그인 상태를 확인해주세요.");
			return "redirect:/login";
		}
		
		Long userId = (Long) userIdObj;
		log.info("[WITHDRAW] 요청 userId={}", userId);
		
		myInfoService.withdrawUser(userId, session, ra);
		log.info("[WITHDRAW] userId={} 회원 탈퇴 완료 세션/시큐리티 종료", userId);
		
		return "redirect:/";
	}
	
	// ==== 회원 정보 수정 ====
//	// 수정폼
//	@GetMapping("/edit")
//	public String editForm(HttpSession session, Model model) {
//		myInfoService.editForm(session, model);
//		return "user/myInfoForm";
//	}
//	
//	// 회원정보저장
//	@PostMapping("/{userId}/edit/info")
//	public String updateInfo(@PathVariable Long userId,
//							UserDTO form,
//							HttpSession session,
//							RedirectAttributes ra) {
//		myInfoService.updateUserInfo(userId, form, session, ra);
//		return "redirect:/my-info";
//	}
	
//	// 비밀번호변경 -> 재로그인하기
//	@PostMapping("/{userId}/edit/pass")
//	public String changePassword(@PathVariable Long userId,
//								String newPassword,
//								String confirmPassword,
//								HttpSession session,
//								RedirectAttributes ra) {
//		boolean changed = myInfoService.changePassword(userId, newPassword, confirmPassword, session, ra);
//		
//		if (changed) {
//			// 변경 성공 -> 세션 초기화 + 로그인ㄴ 페이지로 고고씽
//			session.invalidate();
//			ra.addFlashAttribute("msg", "비밀번호가 변경되었습니다. 다시 로그인해주세요!");
//			return "redirect:/login";
//		} else {
//			// 실패시 다시 수정 페이지로
//			return "redirect:/my-info/edit";			
//		}
//	}
}
