package kr.co.dreamstart.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/event") // 공통 url
public class EventController {
	private static final Logger log = LoggerFactory.getLogger(EventController.class);

	@GetMapping("/main")
	public String main() {
		log.info("GET event/main 요청");
		return "redirect:/event/eventMain";
	}
	
	@GetMapping("/datail")
	public String detail() {
		log.info("GET event/detail 요청");
		return "event/eventDetail";
	}
	
	@GetMapping("/list")
	public String list() {
		log.info("GET event/list 요청");
		return "event/eventList";
	}
	
	@GetMapping("/form")
	public String form() {
		log.info("GET event/form 요청");
		return "event/eventForm";
	}
	
	
}
