package kr.co.dreamstart.controller;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.mapper.EventMapper;
import kr.co.dreamstart.service.SurveyService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class SurveyController {
	
	@Autowired
	SurveyService surveyService;
	@Autowired
	EventMapper eventMapper; // 임시 나중에 서비스로 바꿔야됨
	
	// 설문목록(이벤트필터 + 검색 + 페이징 파라미터만 받음)
	@GetMapping("/surveys")
	public String list(@RequestParam(required = false) Long eventId,
					@RequestParam(required = false) String field,
					@RequestParam(required = false) String keyword,
					@RequestParam(required = false) Integer anon,
					Criteria cri, Model model) {
		
		// 1) 상단 고정 템플릿 4개
		List<SurveyDTO> fixed = surveyService.fixedTemplates();
		model.addAttribute("templateList", fixed);
		
		// 2) 일반 설문 페이징 목록 (템플릿 제외)
		List<SurveyDTO> list = surveyService.surveyPage(eventId, cri, keyword, field, anon);
		int total = surveyService.surveyCount(eventId, keyword, field, anon);
		
		// 3) pageVO 세팅
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(total);
		
		model.addAttribute("surveyList", list);
		model.addAttribute("total", total);
		model.addAttribute("pageVO", pageVO);
		
		// 필터 보존용
		model.addAttribute("eventId", eventId);
		model.addAttribute("field", field);
		model.addAttribute("keyword", keyword);
		model.addAttribute("anon", anon);
		
		// 디버그
		log.info("[GET /surveys] eventId={}, page={}, size={}, keyword='{}', anon={}",
				eventId, cri.getPage(), cri.getPerPageNum(), keyword, anon);
		
		return "/admin/surveyList";
	}

	// 상세보기 (숫자만 매칭(폼충돌방지))
	@GetMapping("/surveys/{surveyId:\\d+}")
	public String detail(@PathVariable Long surveyId, Model model) {
		// 설문헤더
		SurveyDTO survey = surveyService.findSurvey(surveyId); 
		log.info("detail: surveyId={}, survey={}", surveyId, survey);
		
		// 이벤트 제목만
		String eventTitle = surveyService.findEventTitleBySurveyId(surveyId);
		log.info("detail: eventTitle={}", eventTitle);
		
		// LocalDateTime -> String
		DateTimeFormatter F = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String openAtStr = (survey != null && survey.getOpenAt() != null) ? survey.getOpenAt().format(F) : null;
		String closeAtStr = (survey != null && survey.getCloseAt() != null) ? survey.getCloseAt().format(F) : null;
		
		// 문항/보기
		List<SurveyQuestionDTO> questions = surveyService.questionList(surveyId);
		Map<Long, List<SurveyOptionDTO>> optionsByQ = surveyService.optionsByQuestion(surveyId);
		int responses = surveyService.responseCount(surveyId); // 응답횟수
		
		// 고정 템플릿 여부 : 1~4번이거나, DB에 플래그/키로 템플릿임이 확인되면 true
		boolean fixedIdRange = (surveyId != null && surveyId >= 1 && surveyId <= 4);
		boolean templateFlag = (survey != null && (survey.getIsTemplate() != null && survey.getIsTemplate() == 1));
		boolean hasTplKey = (survey != null && survey.getTemplateKey() != null && !survey.getTemplateKey().isBlank());
		boolean isTemplate = fixedIdRange || templateFlag || hasTplKey;
		
		model.addAttribute("survey", survey);
		model.addAttribute("eventTitle", eventTitle);
		model.addAttribute("openAtStr", openAtStr);
		model.addAttribute("closeAtStr", closeAtStr);
		model.addAttribute("questions", questions);
		model.addAttribute("optionsByQ", optionsByQ);
		model.addAttribute("responses", responses);
		model.addAttribute("isTemplate", isTemplate);
		
		log.info("[GET /admin/surveys/{}] isTemplate={}, responses={}", surveyId, isTemplate, responses);
		return "/admin/surveyDetail";
	}
	
	
	// 등록/수정폼
	// 1) 이전화면에서 post로 갑만 받고 -> 주소창 get으로 리다이렉트
	@PostMapping("/surveys/form-init")
	public String formInit(@RequestParam Long eventId,
						RedirectAttributes ra) {
		ra.addFlashAttribute("eventId", eventId); // url 노출 방지 (1회성)
		return "redirect:/admin/surveys/form";
	}
	
	// 2) 폼화면(주소창에는 /admin/surveys/form 만 보임)
	@GetMapping("/surveys/form")
	public String cloneForm(@RequestParam(required = false) Long eventId,
							Model model) {
		model.addAttribute("templates", surveyService.fixedTemplates());
		model.addAttribute("eventList", eventMapper.eventAll());
		model.addAttribute("eventId", eventId);
		return "/admin/surveyCloneForm";
		
	}
	
}
