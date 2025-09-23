package kr.co.dreamstart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.dreamstart.dto.Criteria;

@Controller
public class BoardController {

	//공지사항 목록
	@GetMapping("/notices")
	public String noticeList(@RequestParam(required = false)String search,Criteria cri,Model model) {
		
		return "/board/noticeList";
	}
	
	// 공지사항 상세보기
	@GetMapping("/notices/{boardId}")
	public String noticeDetail(@PathVariable("boardId") long boardId,Model model) {
		
		return "/board/noticeDetail";
	}
	
	// 관리자 공지사항 등록
	@GetMapping("/admin/notices/form")
	public String noticeForm() {
		
		
		return "/board/noticeForm";
	}
	
	// 관리자 공지사항 수정
	@GetMapping("/admin/notices/{boardId}/update")
	public String noticeUpdate(@PathVariable("")long boardId,Model model) {
		
		
		return "/board/noticeForm";
	}
	
	
	
	// Q&A 목록
	@GetMapping("/qna")
	public String qnaList(Model model) {
		
		
		return "/board/qnaList";
	}
	
	// Q&A 상세보기
	@GetMapping("/qna/{boardId}")
	public String qnaDetail(@PathVariable("boardId") long boardId,Model model) {
		
		
		return "/board/qnaDetail";
	}
	
	// Q&A 등록
	@GetMapping("/qna/form")
	public String qnaForm(Model model) {
		
		return "/board/qnaForm";
	}
	
	// Q&A 수정
	@GetMapping("/qna/{boardId}/update")
	public String qnaUpdate(@PathVariable("boardId") long boardId,Model model) {
		
		return "/board/qnaForm";
	}
	
}
