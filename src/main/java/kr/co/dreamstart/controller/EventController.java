package kr.co.dreamstart.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/event") // ���� url
public class EventController {
	private static final Logger log = LoggerFactory.getLogger(EventController.class);

	@GetMapping("/main")
	public String main() {
		log.info("GET event/main ��û");
		return "redirect:/event/eventMain";
	}
	
	@GetMapping("/datail")
	public String detail() {
		log.info("GET event/detail ��û");
		return "event/eventDetail";
	}
	
	@GetMapping("/list")
	public String list() {
		log.info("GET event/list ��û");
		return "event/eventList";
	}
	
	@GetMapping("/form")
	public String form() {
		log.info("GET event/form ��û");
		return "event/eventForm";
	}
	
	
}
