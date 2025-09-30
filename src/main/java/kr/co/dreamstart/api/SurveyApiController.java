package kr.co.dreamstart.api;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.service.SurveyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/surveys")
public class SurveyApiController {
	private SurveyService surveyService;
	
	// 문항+보기 묶음 조회(JSON)
	@GetMapping("/survey-test/template-qa")
	@ResponseBody
	public Map<String, Object> templateQA(@RequestParam Long templateId) {
		Map<String, Object> res = new LinkedHashMap<>();
		List<SurveyQuestionDTO> qs = surveyMapper.questionList(templateId);

		Map<Long, List<SurveyOptionDTO>> options = new LinkedHashMap<>();
		for (SurveyQuestionDTO q : qs) {
			options.put(q.getQuestionId(), surveyMapper.optionList(q.getQuestionId()));
		}

		res.put("questions", qs);
		res.put("optionsByQ", options);
		return res;
	}
	
	// 템플릿 클론(헤더/문항/보기)
		@PostMapping("/survey-test/clone")
		@Transactional
		public String cloneSurvey(@RequestParam Long templateId, @RequestParam Long eventId, @RequestParam Long userId,
				@RequestParam(defaultValue = "default") String scheduleMode,
				@RequestParam(required = false, defaultValue = "0") int openDelayHours,
				@RequestParam(required = false, defaultValue = "7") int closeAfterDays, RedirectAttributes ra) {
			log.info("[/survey-test/clone] templateId={}, eventId={}, userId={}, mode={}, delayH={}, closeD={}", templateId,
					eventId, userId, scheduleMode, openDelayHours, closeAfterDays);

			try {
				// 1)기본/오프셋 분기
				int result = surveyMapper.cloneSurvey(templateId, eventId, userId);

				if (result != 1) {
					ra.addFlashAttribute("ERROR", "설문 헤더 클론 실패!");
					return "redirect:/survey-test/clone-form?eventId=" + eventId + "&err=1";
				}

				// 2) new survey_id
				Long newSurveyId = surveyMapper.lastInsertId();
				log.info(" -> newSurveyId={}", newSurveyId);

				// 3) 원본 템플릿 문항 조회
				List<SurveyQuestionDTO> questionDTO = surveyMapper.questionList(templateId);

				// 4) 문항/보기 복제
				for (SurveyQuestionDTO q : questionDTO) {
					SurveyQuestionDTO nq = new SurveyQuestionDTO();
					nq.setSurveyId(newSurveyId);
					nq.setQuestion(q.getQuestion());
					nq.setType(q.getType());
					surveyMapper.insertQuestion(nq); // useGeneratedKeys 로 questionId 채워짐
					Long newQuestionId = nq.getQuestionId();

					List<SurveyOptionDTO> opts = surveyMapper.optionList(q.getQuestionId());
					for (SurveyOptionDTO op : opts) {
						SurveyOptionDTO nop = new SurveyOptionDTO();
						nop.setQuestionId(newQuestionId);
						nop.setLabel(op.getLabel());
						nop.setOptValue(op.getOptValue());
						surveyMapper.insertOption(nop);
					}
				}

				// 복제 성공 -> 모달로 성공 보여주고 목록으로 이동 시킴
				return "redirect:/survey-test/clone-form?eventId=" + eventId + "&ok=1";

			} catch (Exception e) {
				// TODO: handle exception
				log.info("[CLONE] unexpected error", e);
				ra.addFlashAttribute("ERROR", "알 수 없는 오류로 클론 실패 !");
			}

			return "redirect:/survey-test/clone-form?eventId=" + eventId + "&err=1";
		}
	
	// JSON POST → 기존 메서드만 써서 inline clone
	@PostMapping(value = "/survey-test/clone-inline", consumes = "application/json")
	@Transactional
	@ResponseBody
	public Map<String, Object> cloneInline(@RequestBody Map<String, Object> req) {
		Long templateId = ((Number) req.get("templateId")).longValue();
		Long eventId = ((Number) req.get("eventId")).longValue();
		Long userId = ((Number) req.get("userId")).longValue();

		String scheduleMode = (String) req.get("scheduleMode");
		int openDelayHours = req.get("openDelayHours") == null ? 0 : ((Number) req.get("openDelayHours")).intValue();
		int closeAfterDays = req.get("closeAfterDays") == null ? 7 : ((Number) req.get("closeAfterDays")).intValue();

		// 1. 설문 헤더 복제 (offset 모드 안 씀)
		int result = surveyMapper.cloneSurvey(templateId, eventId, userId);
		if (result != 1)
			throw new RuntimeException("설문 헤더 클론 실패");

		Long newSurveyId = surveyMapper.lastInsertId();

		// 2. QA 복사
		List<Map<String, Object>> questions = (List<Map<String, Object>>) req.get("questions");
		if (questions != null) {
			for (Map<String, Object> q : questions) {
				String type = (String) q.get("type"); // "single" | "multi" | "SCALE_5"
				String question = (String) q.get("question");
				if (type == null || question == null)
					continue;

				SurveyQuestionDTO nq = new SurveyQuestionDTO();
				nq.setSurveyId(newSurveyId);

				// 문자열 → enum 매핑
				SurveyQuestionDTO.QuestionType qType;
				switch (type.toLowerCase()) {
				case "single":
					qType = SurveyQuestionDTO.QuestionType.SINGLE;
					break;
				case "multi":
					qType = SurveyQuestionDTO.QuestionType.MULTI;
					break;
				case "SCALE_5":
				default:
					qType = SurveyQuestionDTO.QuestionType.SCALE_5;
					break;
				}
				nq.setType(qType);

				nq.setQuestion(question);
				surveyMapper.insertQuestion(nq); // questionId 자동 세팅
				Long newQid = nq.getQuestionId();
				List<Map<String, Object>> options = (List<Map<String, Object>>) q.get("options");
				if (options != null) {
					for (Map<String, Object> op : options) {
						String label = (String) op.get("label");
						String optValueStr = (String) op.get("optValue");
						if (label == null)
							continue;

						SurveyOptionDTO no = new SurveyOptionDTO();
						no.setQuestionId(newQid);
						no.setLabel(label);

						Integer optValue = null;
						if (optValueStr != null && !optValueStr.isBlank()) {
							try {
								optValue = Integer.valueOf(optValueStr);
							} catch (NumberFormatException ignore) {
							}
						}
						no.setOptValue(optValue); // Integer로 세팅
						surveyMapper.insertOption(no);
					}
				}
			}
		}

		// return Map.of("ok", true, "surveyId", newSurveyId);
		Map<String, Object> res = new LinkedHashMap<>();
		res.put("ok", true);
		res.put("surveyId", newSurveyId);
		return res;

	}
}
