package kr.co.dreamstart.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService service;

	// 공지사항 목록
	@GetMapping("/notices")
	public String noticeList(@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String keyword, Criteria cri, Model model) {
		Map<String, Object> map = service.postList(cri, "NOTICE", "PUBLIC", searchType, keyword);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("postList", map.get("postList"));
		model.addAttribute("pageVO", map.get("pageVO"));
		model.addAttribute("cri", map.get("cri"));

		System.out.println("postList");
		return "test/boardTest"; // 테스트용 페이지
//		return "/board/noticeList";
	}

	// 공지사항 상세보기
	@GetMapping("/notices/{postId}")
	public String noticeDetail(@PathVariable("postId") long postId, Model model) {
		Map<String, Object> map = service.postDetail("NOTICE", postId);
		model.addAttribute("postDTO", map.get("postDTO"));
		model.addAttribute("prevDTO", map.get("prevDTO"));
		model.addAttribute("nextDTO", map.get("nextDTO"));
		return "/board/noticeDetail";
	}

//	// 관리자 공지사항 등록
//	@GetMapping("/admin/notices/form")
//	public String noticeForm() {
//
//		return "/board/noticeForm";
//	}
//
//	// 관리자 공지사항 수정
//	@GetMapping("/admin/notices/{postId}/update")
//	public String noticeUpdate(@PathVariable("") long postId, Model model) {
//
//		return "/board/noticeForm";
//	} => admin Controller로 이동

	// Q&A 목록
	@GetMapping("/qna")
	public String qnaList(Model model) {

		return "/board/qnaList";
	}

	// Q&A 상세보기
	@GetMapping("/qna/{postId}")
	public String qnaDetail(@PathVariable("postId") long postId, Model model) {

		return "/board/qnaDetail";
	}

	// Q&A 등록
	@GetMapping("/qna/form")
	public String qnaForm(Model model) {

		return "/board/qnaForm";
	}

	// Q&A 수정
	@GetMapping("/qna/{boardId}/update")
	public String qnaUpdate(@PathVariable("postId") long postId, Model model) {

		return "/board/qnaForm";
	}

}
