package kr.co.dreamstart.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.service.BoardService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private BoardService service;
	
	@GetMapping("")
	public String adminMain() {

		return "/admin/adminMain";
	}

	@GetMapping("/notices")
	public String noticeList(@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String keyword,@RequestParam(required = false,defaultValue = "PUBLIC") String visibility, Criteria cri, Model model) {
		Map<String, Object> map = service.postList(cri, "NOTICE",visibility, searchType, keyword);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("postList", map.get("postList"));
		model.addAttribute("pageVO", map.get("pageVO"));
		model.addAttribute("cri", map.get("cri"));
		
		 // 검색 조건 별도 전달
	    model.addAttribute("visibility", visibility);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("keyword", keyword);


		return "/admin/adminNoticeList";
	}
	
	@GetMapping("/notices/{postId}")
	public String noticeDetail() {
		
		return "/admin/adminNoticeDetail";
	}

	@GetMapping("/notices/form")
	public String noticeForm() {

		return "/admin/boardForm";
	}

	// 공지사항 글 - 관리자 Qna 댓글 - 관리자

}
