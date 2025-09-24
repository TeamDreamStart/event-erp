package kr.co.dreamstart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.SurveyDTO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SurveyController {
	
	// 조회용
	// 설문목록(이벤트필터 + 검색 + 페이징 파라미터만 받음)
	public String surveylist(@RequestParam(required = false) Long eventId, 
							@RequestParam(required = false) String keyword,
							Criteria cri, Model model) {
		log.info("[GET /surveys] eventId={}, page={}, size={}, keyword={}",
				eventId, cri.getPage(), cri.getPerPageNum(), keyword);
		return "/survey/surveyList";
	}
	
	// 설문상세
//	public String
	
	

	
}
