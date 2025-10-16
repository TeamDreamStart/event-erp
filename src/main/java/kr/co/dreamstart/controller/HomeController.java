package kr.co.dreamstart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.dreamstart.service.EventService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {
	
	@Autowired
	private EventService eventService;
	
	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("events", eventService.all());
		log.info("GET / home - 메인 호출");
		return "home";
	}
	

}
