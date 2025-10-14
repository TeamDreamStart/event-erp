package kr.co.dreamstart.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	// 공지사항 목록
	@GetMapping("/notices")
	public String noticeList(
			@RequestParam(required = false) String keyword, Criteria cri, Model model) {
		Map<String, Object> map = boardService.postList(cri, "NOTICE", "PUBLIC", "title", keyword);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("postList", map.get("postList")); // 해당 게시물 commentCount 포함
		model.addAttribute("pageVO", map.get("pageVO"));
		model.addAttribute("cri", map.get("cri"));

		// 검색 조건 별도 전달
		model.addAttribute("keyword", keyword);
		return "/board/noticeList";
	}

	// 공지사항 상세보기
	@GetMapping("/notices/{postId}")
	public String noticeDetail(@PathVariable("postId") long postId, Model model) {
		Map<String, Object> map = boardService.postDetail("NOTICE", postId);
		model.addAttribute("postDTO", map.get("postDTO"));
		model.addAttribute("prevDTO", map.get("prevDTO"));
		model.addAttribute("nextDTO", map.get("nextDTO"));
		model.addAttribute("fileList", map.get("fileList"));
		return "/board/noticeDetail";
	}

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
