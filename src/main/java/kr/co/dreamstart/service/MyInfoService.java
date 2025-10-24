package kr.co.dreamstart.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyInfoService {
	
	private final UserService userService;
	private final SurveyService surveyService;
	private final PasswordEncoder passwordEncoder;
	
	/* 마이페이지 메인 */
	public void loadMyInfo(Long userId, Model model) {
		// 기본 유저 정보
		model.addAttribute("user", userService.findByUserId(userId));
		
		// 나의 예약 목록 
		List<Map<String, Object>> reservationList = surveyService.openSurveyReservations(userId);
		model.addAttribute("reservationList", reservationList);
		
		// 설문 가능한 목록 (이벤트종료 -> 설문오픈 -> 미응답)
		List<Map<String, Object>> availableSurveys = surveyService.allSurveyReservations(userId);
		model.addAttribute("availableSurveys", surveyService.allSurveyReservations(userId));
		log.info("[MY-INFO] 마이페이지 로드 완료 userId={} | 예약 {}건, 설문 가능 {}건", 
										userId, reservationList.size(), availableSurveys.size());
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
		boolean saved = surveyService.saveResponse(userId, eventId, null);
		
		if (saved) {
			if (ra != null) ra.addFlashAttribute("msg", "설문이 정상적으로 제출되었습니다.");
			log.info("[SURVEY SUBMIT SUCCESS] userId={}, eventId={}, surveyId={}", userId, eventId, targetSurveyId);
		} else {
			if (ra != null) ra.addFlashAttribute("msg", "이미 설문에 참여 하셨습니다.");
			log.info("[SURVEY DUPLICATE] userId={}, eventId={}, surveyId={}", userId, eventId, targetSurveyId);
		}
	}
	
	/* 회원탈퇴 */
	public void withdrawUser(Long userId, HttpSession session, RedirectAttributes ra) {
		
		try {
			int updated = userService.stopActivityUser(userId);
			
			if (updated > 0) {
				// 1) 시큐리티 인증 정보 제거
				SecurityContextHolder.clearContext();
				
				// 2) 세션만료
				session.invalidate();
				
				// 3) 메시지 설정
				ra.addFlashAttribute("msg", "회원 탈퇴가 완료되었습니다. 이용해주셔서 감사합니다. (계정이 비활성 상태로 전환됩니다.)");
				log.info("[WITHDRAW SUCCESS] userId={} -> is_active=0", userId);
			} else {
				ra.addFlashAttribute("msg", "회원 탈퇴에 실패했습니다.");
				log.info("[WITHDRAW FAIL], userId={}", userId);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			log.error("[WITHDRAW ERROR] userId={}, message={}", userId, e.getMessage());
			ra.addFlashAttribute("msg", "시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
		}
	}
	
	/* 로그인 시 미응답 설문 조회 */
	public List<Map<String, Object>> findUnansweredSurveyByUser(Long userId) {
		List<Map<String, Object>> unanswered = surveyService.findUnansweredSurveysByUser(userId);
		log.info("[MY-INFO] userId={} 미응답 설문 {}건", userId, unanswered.size());
		return unanswered;
	}
	
	/* === 회원정보수정 === */
	public void editForm(HttpSession session, Model model) {
		Object userIdObj = session.getAttribute("userId");
		
		// 세션 검증
		if (!(userIdObj instanceof Long)) {
			log.warn("[MYINFO EDIT] 세션에 userId 없음 -> 로그인으로 리다이렉트");
			model.addAttribute("msg", "세션이 만료되었습니다. 다시 로그인해주세요!");
			return;
		} 
		
		Long userId = (long) userIdObj;
		log.info("[MYINFO EDIT] userId={}", userId);
		
		// 유저 정보 조회
		UserDTO dto = userService.findByUserId(userId);
		if (dto == null) {
			log.warn("[MYINFO EDIT] userId={}에 해당하는 유저 정보 없음", userId);
			model.addAttribute("msg", "회원 정보를 불러오지 못했습니다. 다시 로그인해주세요!");
			return;
		}
		
		// jsp로 넘길 모델 등록
		model.addAttribute("userDTO", dto);
		log.info("[MYINFO EDIT] userId={} 정보 로드 완료", userId);
	}
	
	// 수정 정보 저장
	public void updateUserInfo(Long userId,
								UserDTO form,
								RedirectAttributes ra) {

		try {
			form.setUserId(userId);
			// update 실행
			int updated = userService.updateUserInfo(form);
			
			if (updated > 0) {
				ra.addFlashAttribute("msg", "회원 정보가 성공적으로 수정되었습니다.");
				log.info("[UPDATED INFO SUCCESS] userId={}", userId);
			} else {
				ra.addFlashAttribute("msg", "회원 수정이 실패했습니다.");
				log.info("[UPDATED INFO FAIL] userId={}", userId);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			log.error("[UPDATE INFO ERROR] userId={}, msg={}", userId, e.getMessage());
			ra.addFlashAttribute("msg", "시스템 오류가 발생했습니다.");
		}
	}
	
	// 비밀번호 변경
	public boolean changePassword(Long userId, 
								String currentPassword,
								String newPassword, 
								RedirectAttributes ra) {
		
		try {
			// 1) 사용자 조회
			UserDTO dto = userService.findByUserId(userId);
			if (dto == null) {
				ra.addFlashAttribute("msg", "사용자를 찾을 수 없습니다.");
				log.warn("[PASSWORD CHANGE FAIL] userId={} not found", userId);
				return false;
			}
			
			// 2) 입력값 검증
			if (currentPassword == null || newPassword == null || newPassword.isBlank()) {
				ra.addFlashAttribute("msg", "비밀번호 값이 올바르지 않습니다.");
				log.warn("[PASSWORD CHAGE FAIL] userId={}, invalid args", userId);
				return false;
			}
			
			// 3) 현재 비밀번호 검증
			if (!passwordEncoder.matches(currentPassword, dto.getPassword())) {
				ra.addFlashAttribute("msg", "현재 비밀번호가 일치하지 않습니다.");
				log.warn("[PASSWORD CHAGE FAIL] userId={}, current password missmatch", userId);
				return false;
			}
			
			// 4) 비밀번호 암호화
			String encoded = passwordEncoder.encode(newPassword);
			// 비밀번호 변경 로직
			int update = userService.updatePasswordById(userId, encoded);
			if (update != 1) {
				ra.addFlashAttribute("msg", "비밀번호가 변경 중 오료가 발생했습니다.");
				log.warn("[PASSWORD CHANGE FAIL] userId={}", userId);
				return false; //성공
			}
			
			ra.addFlashAttribute("msg", "비밀번호가 변경되었습니다.");
			log.info("[PASSWORD CHAGE SUCCESS] userId={}", userId);
			return true;
			
		} catch (Exception e) {
			// TODO: handle exception
			ra.addFlashAttribute("msg", "비밀번호 변경에 실패했습니다." + e.getMessage());
			log.error("[PASSWORD CHAGE ERROR] userId={}, ex={}", userId, e.toString() );
			return false;
		}
	}
		
}
