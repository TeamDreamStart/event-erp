package kr.co.dreamstart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.SurveyDTO;
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
	
	// 상세보기
	@GetMapping("/survey-list/detail")
	public String datail(@RequestParam Long surveyId, Model model) {
		log.info("[GET /survey-list/datail] surveyId={}", surveyId);
		model.addAttribute("surveyId", surveyId);
		return "/survey/surveyDetailTest";
	}
	
	
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
	
	

	
}
