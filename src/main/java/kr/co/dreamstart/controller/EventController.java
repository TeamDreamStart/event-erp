package kr.co.dreamstart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/event") // 공통 url
@Slf4j
public class EventController {

	@GetMapping("/main")
	public String main() {
		log.info("GET event/main 호출");
		log.warn("경고!");
		return "redirect:/event/eventMain";
	}
	
	@GetMapping("/datail")
	public String detail() {
		log.info("GET event/detail 호출");
		return "event/eventDetail";
	}
	
	@GetMapping("/list")
	public String list() {
		log.info("GET event/list 호출");
		return "event/eventList";
	}
	
	@GetMapping("/form")
	public String form() {
		log.info("GET event/form 호출");
		return "event/eventForm";
	}
	
	
}
