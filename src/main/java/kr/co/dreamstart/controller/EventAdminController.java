package kr.co.dreamstart.controller;

import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.security.CustomUserDetails;
import kr.co.dreamstart.service.EventService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
//@RequestMapping("/admin/events")
@RequiredArgsConstructor
@Slf4j
public class EventAdminController {

	@Autowired
	private EventService eventService;
	
	// 화면용 포맷터
	private final DateTimeFormatter VIEW_FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
	private final DateTimeFormatter HTML_FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

	// 목록(페이징)
	@GetMapping("/admin/events")
	public String page(Criteria cri, Model model) {
		List<EventDTO> list = eventService.page(cri);
		int total = eventService.count(cri);

		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(total);

		model.addAttribute("list", list);
		model.addAttribute("pageVO", pageVO);
		return "admin/eventList";
	}

	// 상세
	@GetMapping("/admin/events/{eventId:\\d+}")
	public String detail(@PathVariable Long eventId, Model model) {
		EventDTO e = eventService.findById(eventId);
		
		model.addAttribute("event", e);
		model.addAttribute("startView", e.getStartDate() == null ? "" : e.getStartDate().format(VIEW_FMT));
		model.addAttribute("endView", e.getEndDate() == null ? "" : e.getEndDate().format(VIEW_FMT));
		model.addAttribute("createdView", e.getCreatedAt() == null ? "" : e.getCreatedAt().format(VIEW_FMT));
	    model.addAttribute("updatedView", e.getUpdatedAt() == null ? "" : e.getUpdatedAt().format(VIEW_FMT));
		return "/admin/eventDetail";
	}

	// 폼(등록/수정 공용)
	@GetMapping("/admin/events/form")
	public String form(@RequestParam(value = "id", required = false) Long id, 
						Model model) {
		EventDTO e = (id != null) ? eventService.findById(id) : new EventDTO();
		
		model.addAttribute("event", e);
		model.addAttribute("startHtml", e.getStartDate() == null ? "" : e.getStartDate().format(HTML_FMT));
		model.addAttribute("endHtml", e.getEndDate() == null ? "" : e.getEndDate().format(HTML_FMT));
		model.addAttribute("createdView", e.getCreatedAt() == null ? "" : e.getCreatedAt().format(VIEW_FMT));
	    model.addAttribute("updatedView", e.getUpdatedAt() == null ? "" : e.getUpdatedAt().format(VIEW_FMT));
		
		return "admin/eventForm";
	}

	// 저장(등록/수정)
	@PostMapping("/admin/events/save")
	public String save(@ModelAttribute EventDTO event,
					BindingResult binding,
					@AuthenticationPrincipal(expression = "userId") Long userId,
					@RequestParam(defaultValue = "1") int page, 
					RedirectAttributes ra, Model model) {
		
		if (binding.hasErrors()) {
			model.addAttribute("startHtml", event.getStartDate() == null ? "" : event.getStartDate().format(HTML_FMT));
			model.addAttribute("endHtml", event.getEndDate() == null ? "" : event.getEndDate().format(HTML_FMT));
			return "admin/eventForm";
		}
		
		Long newId = eventService.save(event, userId);
		ra.addFlashAttribute("msg",
						(event.getEventId() == null ? "이벤트 생성 완료 (ID : " : "이벤트 수정 완료 (ID : ") + newId + ")");
		return "redirect:/admin/events?page=" + page;
	}

	// 삭제
	@PostMapping("/admin/events/{id}/delete")
	public String delete(@PathVariable long id,
						@RequestParam(value = "page", defaultValue = "1") int page,
						RedirectAttributes ra) {
		eventService.delete(id);
		ra.addFlashAttribute("msg", "이벤트 삭제 완료 (ID : " + id + ")");
		return "redirect:/admin/events?page=" + page;
	}
}
