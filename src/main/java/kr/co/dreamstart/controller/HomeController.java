package kr.co.dreamstart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	@GetMapping("/")
	public String home() {
		log.info("GET / home - 메인 호출");
		return "home";
	}
	
}
