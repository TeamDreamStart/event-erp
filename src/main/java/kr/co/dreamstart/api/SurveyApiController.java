package kr.co.dreamstart.api;

//import java.util.Collections.emptyList();
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import kr.co.dreamstart.dto.CloneInlineReqDTO;
import kr.co.dreamstart.dto.CloneInlineReqDTO.SurveyStatus;
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
	@GetMapping(value = "/template-qa", produces = "application/json; charset=UTF-8") // ★ JSON으로 못 박기
	public Map<String, Object> templateQA(@RequestParam Long templateId) {
		Map<String, Object> res = new LinkedHashMap<>();

		List<SurveyQuestionDTO> qs = surveyService.questionList(templateId);
		Map<Long, List<SurveyOptionDTO>> options = surveyService.optionsByQuestion(templateId);
		res.put("questions", qs);
		res.put("optionsByQ", options);
		return res;
	}

	// 템플릿 클론(헤더/문항/보기) - 서비스클래스에서 전부 수행 -> 원본 그대로 복제해서 사용하는경우
	@PostMapping(value = "/clone", produces = "application/json; charset=UTF-8")
	public Map<String, Object> cloneSurvey(
										@RequestParam Long templateId, 
										@RequestParam Long eventId,
										@RequestParam(required = false, defaultValue = "OPEN") String status) {
		log.info("[/clone] templateId={}, eventId={}, status={}", templateId, eventId, status);
		
		CloneInlineReqDTO.SurveyStatus st;
		
		try {
			st = CloneInlineReqDTO.SurveyStatus.valueOf(status.toUpperCase());
		} catch (Exception e) {
			// TODO: handle exception
			log.error("[CLONE] error", e);
			// 안전 기본값
			st = CloneInlineReqDTO.SurveyStatus.DRAFT;
		}
		// Long userId = user.getId();
		Long userId = 1L; // 임시
		Long newSurveyId = surveyService.cloneFromTemplate(templateId, eventId, userId, st);
		
		return Map.of("ok", true, "surveyId", newSurveyId);

	}

	// JSON POST -> 인라인 클론(요청 dto를 서비스에 위임) -> 원본 복제해서 수정해서 사용할경우
	@PostMapping(value="/clone-inline",
		    consumes="application/json",
		    produces="application/json; charset=UTF-8")
		public ResponseEntity<Map<String,Object>> cloneInline(
		    @Valid @RequestBody CloneInlineReqDTO req,
		    BindingResult br,
		    @AuthenticationPrincipal(expression="id") Long userId) {

		  if (br.hasErrors()) {
		    throw new ResponseStatusException(HttpStatus.BAD_REQUEST, br.getFieldError().getDefaultMessage());
		  }
		  if (req.getStatus() == null) req.setStatus(CloneInlineReqDTO.SurveyStatus.DRAFT);
		  
		  Long id = surveyService.cloneInline(req, userId);

		 return ResponseEntity.ok(Map.of("ok", true, "surveyId", id));
		}

	// 응답이없고, 클론인 설문만 삭제
	@DeleteMapping(value ="/{surveyId}",
				produces = "application/json; charset=UTF-8")
	public Map<String, Object> deleteCloned(@PathVariable Long surveyId) {
		int affected = surveyService.deleteCloneSurvey(surveyId);
		if (affected == 0) {
			throw new ResponseStatusException(HttpStatus.CONFLICT, "응답이 있거나 템플릿 원본은 삭제할 수 없습니다.");
		}
		return Map.of("ok", true, "deleted", surveyId);
	}
}
