package kr.co.dreamstart.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.mapper.BoardMapper;

@Controller
public class BoardController {

	// 1. BoardMapper 주입 (DAO 역할)
	@Autowired
	private BoardMapper boardMapper; // BoardMapper 인터페이스 객체를 주입

	// 공지사항 목록
	@GetMapping("/notices")
	public String noticeList(@RequestParam(required = false) String search, Criteria cri, Model model) {

		// 2. Mapper를 직접 호출하여 데이터(BoardPostDTO 목록)를 가져옴
		// * 주의: 현재 Mapper XML에는 페이징만 있고 검색 로직이 없으므로, 검색(@RequestParam String search)은
		// 일단 무시됩니다.
		// * 주의: 페이징 정보(PageVO)를 생성하고 model에 추가하는 로직도 현재 Controller에 없습니다.
		// 테이블 출력만 우선으로 하려면 list만 가져옵니다.

		List<BoardPostDTO> boardList = boardMapper.list(cri); // Mapper의 list() 호출
		model.addAttribute("boardList", boardList); // JSP에서 사용할 이름 "boardList"로 저장

		// 3. (옵션) 임시로 PageVO 객체를 model에 넣어줘야 JSTL 오류가 안 납니다.
		// pageVO 객체가 null이면 JSP의 페이징 부분에서 오류가 발생합니다.
		// **실제 PageVO 로직은 Service에서 처리해야 하지만, 임시로 빈 객체 전달**
		// 이 부분은 복잡해질 수 있으므로, 일단은 boardList만 전달하고
		// JSP의 페이징 코드를 잠시 주석 처리하고 테스트하는 것이 더 빠를 수 있습니다.

		return "/board/noticeList";
	}

	// 공지사항 상세보기
	@GetMapping("/notices/{boardId}")
	public String noticeDetail(@PathVariable("boardId") long boardId, Model model) {

		return "/board/noticeDetail";
	}

	// 관리자 공지사항 등록
	@GetMapping("/admin/notices/form")
	public String noticeForm() {

		return "/board/noticeForm";
	}

	// 관리자 공지사항 수정
	@GetMapping("/admin/notices/{boardId}/update")
	public String noticeUpdate(@PathVariable("") long boardId, Model model) {

		return "/board/noticeForm";
	}

	// Q&A 목록
	@GetMapping("/qna")
	public String qnaList(Model model) {

		return "/board/qnaList";
	}

	// Q&A 상세보기
	@GetMapping("/qna/{boardId}")
	public String qnaDetail(@PathVariable("boardId") long boardId, Model model) {

		return "/board/qnaDetail";
	}

	// Q&A 등록
	@GetMapping("/qna/form")
	public String qnaForm(Model model) {

		return "/board/qnaForm";
	}

	// Q&A 수정
	@GetMapping("/qna/{boardId}/update")
	public String qnaUpdate(@PathVariable("boardId") long boardId, Model model) {

		return "/board/qnaForm";
	}

}
