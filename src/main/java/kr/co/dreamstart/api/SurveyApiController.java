package kr.co.dreamstart.api;

//import java.util.Collections.emptyList();
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import kr.co.dreamstart.dto.CloneInlineReqDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.service.SurveyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor // Lombot 라이브러리에서 제공하는 어느테이션/필수 인자를 가진 생성자를 자동 생성
@RequestMapping("/admin/api/surveys")
public class SurveyApiController {
	private final SurveyService surveyService;
	
	// 문항+보기 묶음 조회(JSON)
	@GetMapping(value = "/template-qa",
	        	produces = "application/json; charset=UTF-8") // ★ JSON으로 못 박기
	public Map<String, Object> templateQA(@RequestParam Long templateId) {
		Map<String, Object> res = new LinkedHashMap<>();
		
		List<SurveyQuestionDTO> qs = surveyService.questionList(templateId);
		Map<Long, List<SurveyOptionDTO>> options = surveyService.optionsByQuestion(templateId);
		res.put("questions", qs);
		res.put("optionsByQ", options);
		return res;
	}
	
	// 템플릿 클론(헤더/문항/보기) - 서비스클래스에서 전부 수행 -> 원본 그대로 복제해서 사용하는경우
	@PostMapping(value = "/clone",
	        	produces = "application/json; charset=UTF-8")
	public Map<String, Object> cloneSurvey(@RequestParam Long templateId, 
										@RequestParam Long eventId) {
		log.info("[/clone] templateId={}, eventId={}", 
				templateId, eventId);
		try {
			// Long userId = user.getId(); 
			Long userId = 1L; // 임시
			Long newSurveyId = surveyService.cloneFromTemplate(templateId, eventId, userId);
			
			return Map.of("ok", true, "surveyId", newSurveyId);
			
		} catch (Exception e) {
			// TODO: handle exception
			log.error("[CLONE] error", e);
			// 원하는 HTTP 상태와 메시지를 내려보냄 (여기서는 500)
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "클론 실패 !");
		}
		
	}
	
	// JSON POST -> 인라인 클론(요청 dto를 서비스에 위임) -> 원본 복제해서 수정해서 사용할경우
	@PostMapping(value = "/clone-inline",
	        	consumes = "application/json",
	        	produces = "application/json; charset=UTF-8")
	public Map<String, Object> cloneInline(@Valid @RequestBody CloneInlineReqDTO req) {
		try {
			 Long userId = 1L;
			 req.setUserId(userId);
			Long newSurveyId = surveyService.cloneInline(req);
			return Map.of("ok", true, "surveyId", newSurveyId);
		} catch (Exception e) {
			// TODO: handle exception
			log.error("[clone-inline] error", e);
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "인라인 클론 실패 !");
		}

	}
}
