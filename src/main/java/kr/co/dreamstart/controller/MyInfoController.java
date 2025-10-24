package kr.co.dreamstart.controller;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.security.CustomUserDetails;
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
	private final PasswordEncoder passwordEncoder;
	
    /**
     * 예약자 설문 작성 폼 진입
     * - 예약자만 접근 가능
     * - 이벤트 종료 후 오픈된 설문만 가능
     */

	// 마이페이지 메인 (url userId == 로그인 userId 인 경우만)
	@GetMapping("/{userId}")
	public String myInfo(@PathVariable("userId") Long userId,
			 			@AuthenticationPrincipal CustomUserDetails me,
						Model model) {
		if (me == null) return "redirect:/login";
		if (!Objects.equals(userId, me.getUserId())) {
			return "redirect:/access-denied";
		}
		log.info("[MYINFO] 접근 요청 : URL userId={} / 로그인 userId={}", userId, me.getUserId());
		
		// 유저 정보 넣는 부분
	    model.addAttribute("userDTO", userService.findByUserId(userId));
		
		// 로그인시 응답해야할 설문이 있을경우
		List<Map<String, Object>> availableSurveys = myInfoService.findUnansweredSurveyByUser(userId);
		model.addAttribute("availableSurveys", availableSurveys);
		
		// 내정보 + 예약 + 설문목록 로드
		log.info("[MYINFO] userId={} 마이페이지 데이터 로딩 시작", userId);
		myInfoService.loadMyInfo(userId, model);
		log.info("[MYINFO] userId={} 마이페이지 데이터 로딩 완료", userId);
		
		return "user/myInfo";
		
	}
	
	// 접근 거부시 내아이디로 로그인
	@GetMapping
	public String myInfoMe(@AuthenticationPrincipal CustomUserDetails me) {
		if (me == null) return "redirect:/login";
		return "redirect:/my-info/" + me.getUserId();
	}

	// 내 정보 수정 전 비밀번호 확인
	@PostMapping("/{userId}/confirmPassword")
	public String confirmPass(@PathVariable("userId") Long userId,
							@RequestParam("password") String password,
							@AuthenticationPrincipal CustomUserDetails me,
							RedirectAttributes ra) {
		if (me == null) return "redirect:/login";
		log.info("[CONFIRM PASSWORD] userId={} / principal={}", userId, me.getUserId());
		if (!userId.equals(me.getUserId())) return "redirect:/access-denied";
		
		UserDTO dto = userService.findByUserId(me.getUserId());
		if (passwordEncoder.matches(password, dto.getPassword())) {
			log.info("[CONFIRM PASSWORD] 비밀번호 일치 → 수정 페이지로 이동");
			return "redirect:/my-info/" + userId + "/edit";
		}
		
		ra.addFlashAttribute("resultType", "회원정보 수정 접근");
		ra.addFlashAttribute("result", "fail");
		log.warn("[CONFIRM PASSWORD] 비밀번호 불일치");
		return "redirect:/my-info/" + userId;
	}
	
	// ==== 회원 정보 수정 ====
	// 수정폼
	@GetMapping("/{userId}/edit")
	public String editForm(@PathVariable("userId") Long userId,
						@AuthenticationPrincipal CustomUserDetails me,
						Model model) {
		if (me == null) return "redirect:/login";
		if (!userId.equals(me.getUserId())) {
			log.warn("[EDIT FORM] 접근 거부 : userId 불일치");
			return "redirect:/access-denied";
		}
		
		model.addAttribute("userDTO", userService.findByUserId(userId));
		return "user/myInfoForm";
	}
		
	// 회원정보저장 / 비밀번호 수정
	@PostMapping("/{userId}/edit/{editType}")
	public String updateInfo(@PathVariable Long userId,
							@PathVariable("editType") String editType,
							@AuthenticationPrincipal CustomUserDetails me,
							@RequestParam(required = false) String newPassword,
							@RequestParam(required = false) String currentPassword,
							@RequestParam(required = false) String confirmPassword,
							UserDTO dto,
							HttpServletRequest request,
							HttpServletResponse response,
							HttpSession session,
							RedirectAttributes ra) {
		
		if (me == null) return "redirect:/login";
		if (!userId.equals(me.getUserId())) return "redirect:/access-denied"; 
		
		log.info("[MYINFO UPDATE] userId={} / editType={}", userId, editType);
		
		if ("info".equals(editType)) {
			myInfoService.updateUserInfo(userId, dto, ra);
			ra.addFlashAttribute("msg", "회원정보가 성공적으로 수정되었습니다.");
			return "redirect:/my-info/" + userId; 			
		}
		
		if ("pass".equals(editType)) {
			boolean changed = myInfoService.changePassword(userId, currentPassword, newPassword, ra);
			if (changed) {
				// 안전 로그아웃
				new SecurityContextLogoutHandler().logout(request, response, SecurityContextHolder.getContext().getAuthentication());
				session.invalidate();
				ra.addFlashAttribute("msg", "비밀번호가 변경되었습니다. 다시 로그인해주세요!");
				return "redirect:/login";
			} else {
				ra.addFlashAttribute("msg", "비밀번호 변경에 실패했습니다.");
				return "redirect:/my-info/" + userId + "/edit";				
			}
		}
		
		ra.addFlashAttribute("msg", "요청이 올바르지 않습니다.");
		return "redirect:/my-info/" + userId;
	}
	
	// 회원 탈퇴
	@PostMapping("/withdraw")
	public String withdraw(@AuthenticationPrincipal CustomUserDetails me,
							HttpServletRequest request,
							HttpServletResponse response,
							HttpSession session, 
							RedirectAttributes ra) {
		
		if (me == null) return "redirect:/login";
		Long userId = me.getUserId();
		log.info("[WITHDRAW] 요청 userId={}", userId);
		
		myInfoService.withdrawUser(userId, session, ra);

		new SecurityContextLogoutHandler().logout(request, response, SecurityContextHolder.getContext().getAuthentication());
		return "redirect:/";
	}
	
	// 사용자 설문 작성 폼 (이벤트 종료후 오픈된 설문만)
	@GetMapping("/survey/{eventId}")
	public String surveyForm(@PathVariable Long eventId, 
							@AuthenticationPrincipal CustomUserDetails me,
							Model model, 
							RedirectAttributes ra) {
		
		if (me == null) return "redirect:/login";
		Long userId = me.getUserId();
		log.info("[SURVEY FORM] 세션 userId={} / eventId={}", userId, eventId);
		
		// 이벤트 종료 후 오픈된 설문만
		boolean ok = myInfoService.prepareSurveyForm(userId, eventId, model);
		if (!ok) {			
			Object msg = model.asMap().get("msg");
            if (msg != null) ra.addFlashAttribute("msg", msg);
            log.info("[SURVEY FORM] 설문 없음: eventId={}", eventId);
            return "redirect:/my-info/" + userId;
		}
		
		log.info("[SURVEY FORM] userId={} / eventId={} 설문 폼 준비 완료", userId, eventId);
		return "user/surveyForm";
	}
	
	// 설문 응답 제출 처리
	@PostMapping("/survey/{eventId}/submit")
	public String submitSurvey(@PathVariable Long eventId,
								@AuthenticationPrincipal CustomUserDetails me,
								RedirectAttributes ra) {
		
		if (me == null) return "redirect:/login";
		Long userId = me.getUserId();
		log.info("[SURVEY SUBMIT] 세션 userId={} / eventId={}", userId, eventId);
		
		// 설문 응답 저장
		myInfoService.submitSurvey(userId, eventId, ra);
		log.info("[SURVEY SUBMIT] userId={}, eventId={} 설문 응답 저장 완료", userId, eventId);
		// 설문 완료후 다시 마이페이지로
		return "redirect:/my-info/" + userId;
	}
	
	
}
