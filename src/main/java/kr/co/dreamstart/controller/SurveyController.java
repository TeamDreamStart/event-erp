package kr.co.dreamstart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.dreamstart.mapper.SurveyMapper;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/event") // 해당하는 이벤트 불러와야됨
public class SurveyController {
	@Autowired
	private SurveyMapper mapper;
	
	@GetMapping("/{eventId}/survey")
	public String surveyForm() {
		return null;
		
	}
	
}
