package kr.co.dreamstart.controller;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.mapper.UserMapper;
import kr.co.dreamstart.security.CustomUserDetails;
import kr.co.dreamstart.service.EventService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/events")
@RequiredArgsConstructor
@Slf4j
public class EventAdminController {

	@Autowired
	private EventService eventService;
	//카카오 api js key
	private final String KAKAOKEY = "ee21816e3b6c14b1f71c1db0b4fbc881";
	@Autowired
	private UserMapper userMapper;

	// 목록(페이징)
	@GetMapping
	public String page(Criteria cri, Model model) {
		List<EventDTO> list = eventService.page(cri);
		int total = eventService.count(cri);

		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(total);

		model.addAttribute("list", list);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("total", total);
		model.addAttribute("isAdmin", true);
		return "admin/eventList";
	}

	// 상세
	@GetMapping("/{eventId:\\d+}")
	public String detail(@PathVariable Long eventId, Model model) {
		EventDTO e = eventService.findById(eventId);
		
		model.addAttribute("event", e);
		model.addAttribute("kakaoKey",KAKAOKEY);
		return "admin/eventDetail";
	}

	// 폼(등록/수정 공용)
	@GetMapping("/form")
	public String form(@RequestParam(value = "id", required = false) Long id, 
					@AuthenticationPrincipal(expression = "userId") Long loginUserId,
					@AuthenticationPrincipal(expression = "name") String loginUserName,
					Model model) {
		EventDTO e = (id != null) ? eventService.findById(id) : new EventDTO();
		// name이 비어있으면 db에서 보완
		if (loginUserId != null && (loginUserName == null || loginUserName.isBlank())) {
			loginUserName = userMapper.findNameById(loginUserId);
		}
				
		model.addAttribute("event", e);
		model.addAttribute("kakaoKey",KAKAOKEY);
		// form에서 name, id 표시용, 히든값으로 사용
		model.addAttribute("loginUserId", loginUserId);
		model.addAttribute("loginUserName", loginUserName);
		return "admin/eventForm";
	}
	
	// 저장(등록/수정) - 일반 폼 전송 (파일없음)
	@PostMapping(path="/save", consumes = "application/x-www-form-urlencoded")
	public String saveUrlEncoded(@Valid @ModelAttribute("event") EventDTO event,
								BindingResult binding,
								@AuthenticationPrincipal(expression = "userId") Long loginUserId,
								@RequestParam(defaultValue = "1") int page,
								RedirectAttributes ra) {
		if (binding.hasErrors()) return "admin/eventForm";
		
		// 신규면 작성자, 수정자는 로그인 사용자
		if (event.getEventId() == null) event.setCreatedBy(loginUserId);
		event.setUpdatedBy(loginUserId);
		
		Long newId = eventService.save(event, loginUserId);
		ra.addFlashAttribute("msg", (event.getEventId()== null? "이벤트 생성 완료 (ID : ":"이벤트 수정 완료 (ID : ")+newId+")");
		return "redirect:/admin/events?page=" + page;
	}
	
	// 저장(등록/수정) - 파일 업로드 포함
	@PostMapping(path="/save", consumes = "multipart/form-data")
	public String saveMultipart(@Valid @ModelAttribute("event") EventDTO event,
								BindingResult binding,
								@RequestParam(value = "image", required = false) MultipartFile image,
								@RequestParam(value = "files", required = false) MultipartFile[] files,
								@AuthenticationPrincipal(expression = "userId") Long userId,
								@RequestParam(defaultValue = "1") int page,
								RedirectAttributes ra,
								HttpServletRequest request) {
		if (binding.hasErrors()) return "admin/eventForm";
		//임시값@@@@@@@@@@
		event.setCreatedBy(event.getCreatedBy());
		Long newId = eventService.saveWithFiles(event, image, files, userId, request);
		ra.addFlashAttribute("msg", (event.getEventId()==null? "이벤트 생성 완료 (ID : ":"이벤트 수정 완료 (ID : ")+newId+")");
		return "redirect:/admin/events?page=" + page;
	}
	

	// 삭제
	@PostMapping("/{id}/delete")
	public String delete(@PathVariable long id,
						@RequestParam(value = "page", defaultValue = "1") int page,
						RedirectAttributes ra) {
		eventService.deleteWithFiles(id);
		ra.addFlashAttribute("msg", "이벤트 삭제 완료 (ID : " + id + ")");
		return "redirect:/admin/events?page=" + page;
	}
}
