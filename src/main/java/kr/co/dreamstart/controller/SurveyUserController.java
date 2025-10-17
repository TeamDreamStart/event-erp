package kr.co.dreamstart.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.service.SurveyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/my-info/{userId}/events")
public class SurveyUserController {
	
	@Autowired
	private SurveyService surveyService;
	
    /**
     * 예약자 설문 작성 폼 진입
     * - 예약자만 접근 가능
     * - 이벤트 종료 후 오픈된 설문만 가능
     */

	// 사용자 설문 작성 폼
	@GetMapping("/{eventId}/survey")
	public String surveyForm(@PathVariable Long userId,
							@PathVariable Long eventId,
							Model model) {
		Map<String, Object> survey = surveyService.findSurveyIdByEvent(eventId);
		model.addAttribute(survey);
		log.info("[SURVEY FORM] userId={}, eventId={}, surveyId", userId, eventId, survey.get("survey_id"));
		return "/user/surveyForm";
	}
	
	// 설문 응답 제출 처리
	@PostMapping("/{eventId}/survey/submit")
	public String submitSurvey(@PathVariable Long userId,
							@PathVariable Long eventId,
							RedirectAttributes ra) {
		// 설문 응답 저장
		surveyService.saveResponse(userId, eventId, null);
		log.info("[SURVEY SUBMIT] userId={}, eventId={}", userId, eventId);
		return "redirect:/my-info/" + userId + "/events/" + eventId + "/survey/complate";
	}
    
}
