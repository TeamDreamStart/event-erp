package kr.co.dreamstart.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.mapper.EventMapper;

@Controller
@RequestMapping("/admin/events")
public class EventAdminController {
	
	@Autowired
	private EventMapper eventMapper;
	
	// 목록(간단히)
	@GetMapping
	public String list(Model model) {
		List<EventDTO> events = eventMapper.eventAll();
		model.addAttribute("events", events);
		return "admin/eventList";
	}
	
	// 등록폼
	@GetMapping("/admin/events/form")
	public String insertForm(@RequestParam(required = false) Long userId,
							Model model) {
		model.addAttribute("userId", userId); // 작성자 표시/전달용
		return "admin/eventForm";
	}
	
	// 등록처리
	@PostMapping
	public String insert(@ModelAttribute EventDTO dto, RedirectAttributes ra) {
		// 기본값 세팅
		if (dto.getStatus() == null || dto.getStatus().isEmpty()) {
			dto.setStatus("OPEN");
		}
		if (dto.getVisibility() == null || dto.getVisibility().isEmpty()) {
			dto.setVisibility("PUBLIC");
		}
		if (dto.getCurrency() == null || dto.getCurrency().isEmpty()) {
			dto.setCurrency("KRW");
		}
		
		eventMapper.insert(dto);
		ra.addFlashAttribute("msg", "이벤트 생성 완료 (ID : " + dto.getEventId() +")");
		
		return "redirect:/survey-test/clone-form?eventId=" + dto.getEventId();
	}
}
