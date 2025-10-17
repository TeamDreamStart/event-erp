package kr.co.dreamstart.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.service.EventService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/events") // 공통 url
@RequiredArgsConstructor
@Slf4j
public class EventController {
	
	@Autowired
	private EventService eventService;
	
	@GetMapping("/main")
	public String main() {
		log.info("GET events/main 호출");
		log.warn("경고!");
		return "event/eventMain";
	}
	
	@GetMapping()
	public String list(Criteria cri, Model model) {
		log.info("GET event/list 호출");
		return "event/eventList";
	}

	@GetMapping("/{id:\\d+}")
	public String detail(@PathVariable Long id, Model model) {
		log.info("GET event/{} 호출", id);
		model.addAttribute("event", eventService.findById(id));
		return "event/eventDetail";
	}
	
	
}
