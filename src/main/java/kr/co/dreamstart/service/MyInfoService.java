package kr.co.dreamstart.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyInfoService {
	
	private final UserService userService;
	private final SurveyService surveyService;
	
	/* 마이페이지 메인 */
	public void loadMyInfo(Long userId, Model model) {
		model.addAttribute("user", userService.findByUserId(userId));
		model.addAttribute("SurveyList", surveyService.openSurveyReservations(userId));
		
		// 로그인 직후 알림용 (없으면 빈 리스트)
		model.addAttribute("unanswered", surveyService.findUnansweredSurveysByUser(userId));
		log.info("[MY-INFO] userId={} 마이페이지 로드 완료", userId);
	}
	
	/* 해당 유저가 참여가능한 설문 보여주기 */
    public boolean prepareSurveyForm(Long userId, Long eventId, Model model) {
        // 이벤트에 '열린' 설문 1건만 조회 (네가 준 쿼리 재활용)
        Long surveyId = surveyService.findSurveyIdByEvent(eventId);

        if (surveyId == null) {
            // (선택) 최근 설문 상태를 조회해서 '마감' 문구 분리하고, 없으면 기본 메시지
            String latestStatus = null;
            try {
                latestStatus = surveyService.findLatestSurveyStatusByEvent(eventId); // 없으면 null
            } catch (Exception ignore) {}

            if ("CLOSED".equalsIgnoreCase(String.valueOf(latestStatus))) {
                model.addAttribute("msg", "설문이 마감되었습니다!");
            } else {
                model.addAttribute("msg", "설문이 없습니다!");
            }
            log.info("[SURVEY FORM] open 설문 없음: userId={}, eventId={}", userId, eventId);
            return false;
        }

        // 열려있으면 폼 데이터 세팅
        List<SurveyQuestionDTO> questions = surveyService.questionList(surveyId);
        Map<Long, List<SurveyOptionDTO>> options = surveyService.optionsByQuestion(surveyId);

        model.addAttribute("surveyId", surveyId);
        model.addAttribute("eventId", eventId);
        model.addAttribute("userId", userId);
        model.addAttribute("questions", questions);
        model.addAttribute("options", options);
        log.info("[SURVEY FORM] userId={}, eventId={}, surveyId={}, questions={}",
                userId, eventId, surveyId, questions.size());
        return true;
    }
	
	/* 설문제출 */
	public void submitSurvey(Long userId, Long eventId, RedirectAttributes ra) {
		
		Long targetSurveyId = surveyService.findSurveyIdByEvent(eventId);
		
		// surveyId가 명시되지 않았다면 eventId 기준으로 찾기
		if (targetSurveyId == null) {
	        ra.addFlashAttribute("msg", "해당 이벤트의 설문이 존재하지 않습니다.");
	        log.warn("[SURVEY SUBMIT FAIL] 설문 없음: eventId={}", eventId);
	        return;
	    }
		
		// 해당유저의 이벤트 목록 불러오기 
		boolean responseAnswer = surveyService.saveResponse(userId, eventId, null);
		
		if (responseAnswer) {
			if (ra != null) ra.addFlashAttribute("msg", "설문이 정상적으로 제출되었습니다.");
			log.info("[SURVEY SUBMIT SUCCESS] userId={}, eventId={}, surveyId={}", userId, eventId, targetSurveyId);
		} else {
			if (ra != null) ra.addFlashAttribute("msg", "이미 설문에 참여 하셨습니다.");
			log.info("[SURVEY DUPLICATE] userId={}, eventId={}, surveyId={}", userId, eventId, targetSurveyId);
		}
	}
	
	/* 회원탈퇴 */
	public void withdrawUser(Long userId, HttpSession session, RedirectAttributes ra) {
		int deleted = userService.deleteUser(userId);
		
		if (deleted > 0) {
			session.invalidate();
			ra.addFlashAttribute("msg", "회원 탈퇴가 완료되었습니다.");
			log.info("[WITHDRAW SUCCESS] userId={}", userId);
		} else {
			ra.addFlashAttribute("msg", "회원 탈퇴에 실패했습니다.");
			log.info("[WITHDRAW FAIL], userId={}", userId);
		}
	}
	
	/* 로그인 시 미응답 설문 조회 */
	public List<Map<String, Object>> findUnansweredSurveyByUser(Long userId) {
		List<Map<String, Object>> unanswered = surveyService.findUnansweredSurveysByUser(userId);
		log.info("[MY-INFO] userId={} 미응답 설문 {}건", userId, unanswered.size());
		return unanswered;
	}
}
