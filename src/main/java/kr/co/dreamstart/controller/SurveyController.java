package kr.co.dreamstart.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.dto.SurveyDTO;
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

	// 상세보기
	@GetMapping("/surveys/{surveyId}")
	public String detail(@PathVariable Long surveyId, Model model) {
		log.info("[GET /admin/survey-list/{}]", surveyId);
		model.addAttribute("surveyId", surveyId);
		return "/admin/surveyDetail";
	}
	
	
	// 등록/수정폼
	@PostMapping("/surveys/form")
	public String cloneForm(@RequestParam(required = false) Long eventId,
							Model model) {
		model.addAttribute("templates", surveyService.fixedTemplates());
		model.addAttribute("eventList", eventMapper.eventAll());
		model.addAttribute("eventId", eventId);
		return "/admin/surveyCloneForm";
		
	}
	
}
