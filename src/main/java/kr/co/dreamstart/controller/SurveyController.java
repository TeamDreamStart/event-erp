package kr.co.dreamstart.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.mapper.SurveyMapper;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SurveyController {
	
	@Autowired
	SurveyMapper surveyMapper;
	
	// 조회용
	// 설문목록(이벤트필터 + 검색 + 페이징 파라미터만 받음)
	@GetMapping("/survey-list")
	public String list(@RequestParam(required = false) Long eventId, 
					@RequestParam(required = false) String keyword,
					Criteria cri, Model model) {
		log.info("[GET /surveys] eventId={}, page={}, size={}, keyword={}",
				eventId, cri.getPage(), cri.getPerPageNum(), keyword);
		return "/survey/surveyListTest";
	}
	
//	@GetMapping("/survey-test")
//	public String surveyTest(@RequestParam(required = false) Long eventId,
//			@RequestParam(required = false, defaultValue = "all") String field,
//			@RequestParam(required = false) String keyword, @RequestParam(required = false) Integer anon, // 1 or 0
//			Criteria cri, Model model) {
//		log.info("[/survey-test] eventId={}, page={}, perPageNum={}, pageStart={}, keyword={}", eventId, cri.getPage(),
//				cri.getPerPageNum(), cri.getPageStart(), keyword);
//
//		// 고정 템플릿 4개
//		List<SurveyDTO> fixed = surveyMapper.fixedTemplates();
//
//		// 일반 목록
//		List<SurveyDTO> list = surveyMapper.surveyPage(eventId, cri, keyword, field, anon);
//		log.info("surveyList rows={}", list.size());
//		int total = surveyMapper.surveyCount(eventId, keyword, field, anon);
//
//		PageVO pageVO = new PageVO();
//		pageVO.setCri(cri);
//		pageVO.setTotalCount(total);
//
//		model.addAttribute("fixedList", fixed);
//		model.addAttribute("surveyList", list);
//		model.addAttribute("pageVO", pageVO);
//		model.addAttribute("total", total);
//
//		// 유지 파라미터
//		model.addAttribute("eventId", eventId);
//		model.addAttribute("field", field);
//		model.addAttribute("keyword", keyword);
//		model.addAttribute("anon", anon);
//
//		return "test/surveyListTest";
//	}
	
	// 상세보기
	@GetMapping("/survey-list/detail")
	public String datail(@RequestParam Long surveyId, Model model) {
		log.info("[GET /survey-list/datail] surveyId={}", surveyId);
		model.addAttribute("surveyId", surveyId);
		return "/survey/surveyDetailTest";
	}
	
	// 상세보기
//	@GetMapping("/survey-test/detail")
//	public String surveyDetail(@RequestParam Long surveyId, Model model) {
//		SurveyDTO survey = surveyMapper.findSurvey(surveyId);
//		if (survey == null)
//			throw new IllegalArgumentException("잘못된 설문 ID");
//
//		List<SurveyQuestionDTO> questions = surveyMapper.questionList(surveyId);
//
//		Map<Long, List<SurveyOptionDTO>> optionsByQ = new LinkedHashMap<>();
//		for (SurveyQuestionDTO q : questions) {
//			optionsByQ.put(q.getQuestionId(), surveyMapper.optionList(q.getQuestionId()));
//		}
//
//		model.addAttribute("survey", survey);
//		model.addAttribute("questions", questions);
//		model.addAttribute("optionsByQ", optionsByQ);
//		return "test/surveyDetailTest";
//	}
	
	
	// 클론폼
	@GetMapping("/clone-form")
	public String cloneForm(@RequestParam(required = false) Long eventId,
							@RequestParam(required = false) Long userId,
							Model model) {
		log.info("[GET /clone-form] eventId={}, userId={}", eventId, userId);
		model.addAttribute("templates", surveyMapper.fixedTemplates());
		model.addAttribute("eventId", eventId);
		model.addAttribute("userId", userId);
		return "survey/cloneForm";
	}
	
	// 템플릿 폼
//	@GetMapping("/survey-test/clone-form")
//	public String cloneForm(@RequestParam(required = false) Long templateId,
//			@RequestParam(required = false) Long eventId, @RequestParam(required = false) Long userId, Model model) {
//		log.info("[/survey-test/clone-form] templateId={}, eventId={}, userId={}", templateId, eventId, userId);
//
//		List<SurveyDTO> tmplates = surveyMapper.fixedTemplates();
//		List<EventDTO> eventList = eventMapper.eventAll();
//
//		model.addAttribute("templates", tmplates); // jsp 렌더링
//		model.addAttribute("eventList", eventList);
//		model.addAttribute("eventId", eventId);
//		model.addAttribute("userId", userId);
//
//		return "test/surveyCloneFormTest";
//	}
	
	

	
}
