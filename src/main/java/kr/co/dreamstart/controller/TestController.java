package kr.co.dreamstart.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.BoardMapper;
import kr.co.dreamstart.mapper.UserMapper;

@Controller
public class TestController {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private BoardMapper boardMapper;

	@GetMapping("/list-test")
	public String userList(@RequestParam(required = false) Integer userId, Criteria cri, Model model) {
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		// 특정 아이디 검색 값이 없다면 -> 회원 전체 목록
		if (userId == null) {
			List<UserDTO> userList = userMapper.list(cri);
			model.addAttribute("userList", userList);
			// 회원 전체 목록으로 페이징 값 (total) 계산
			pageVO.setTotalCount(userMapper.count());
		} else {// 특정 아이디 검색 값이 있다면 -> 목록에 특정 회원만 표시
//			UserDTO user = mapper.selectUser();

		}
		// 페이징에 필요한 값을 객체로 전달
		model.addAttribute("pageVO", pageVO);
		// 전체 회원 수
		model.addAttribute("userCount", userMapper.count());
		// 맨 뒤 페이지
		int lastPage = (int) pageVO.getTotal() / cri.getPerPageNum();
		if (pageVO.getTotal() % cri.getPerPageNum() != 0) {
			lastPage += 1;
		}
		model.addAttribute("lastPage", lastPage);
		return "test/listTest";
	}

	@PostMapping("/upload")
	public String handleFileUpload(@RequestParam("imageFile") MultipartFile file) {
		if (file.isEmpty()) {
			return "redirect:test/list-test"; // 업로드 실패 처리
		}

		// 외부 경로 (이미 존재하는 디렉토리 사용 or 코드에서 생성)
		String uploadDir = "C:/teamDS/upload";
		File dir = new File(uploadDir);
		if (!dir.exists()) {
			dir.mkdirs(); // 없으면 자동 생성
		}

		String fileName = file.getOriginalFilename();
		File dest = new File(uploadDir, fileName);

		try {
			file.transferTo(dest);
			// DB에는 웹에서 접근 가능한 상대경로만 저장
			// 예: "/upload/파일명"
		} catch (IOException e) {
			e.printStackTrace();
			return "redirect:/list-test";
		}

		return "redirect:test/list-test";
	}

	@GetMapping("/map-test")
	public String map() {

		return "test/mapTest";
	}

	@GetMapping("/pay-test")
	public String pay(Model model) {
		EventDTO event = new EventDTO();
		event.setEventId(1L);
		event.setTitle("Spring Festival 2025");
		event.setDescription("봄맞이 특별 공연");
		event.setLocation("서울 강남구 코엑스");
		event.setStartDate("2025-10-05");
		event.setEndDate("2025-10-05");
		event.setCapacity(200);
		event.setStatus("OPEN");
		event.setVisibility("PUBLIC");
		event.setPosterUrl("C:/teamDS/upload/test.png");
		event.setCreatedBy(100L);
		event.setCreatedAt("2025-09-19");
		event.setUpdatedAt("2025-09-19");

		model.addAttribute("event", event);

		// 가격은 임의로 만원
		model.addAttribute("price", 100);

		return "test/payTest";
	}

	@GetMapping("/kakao-test")
	public String kakaoTest(Model model) {
		String location = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=e1dafd936102e43b285b3a9893988593&redirect_uri=http://localhost:8080/map-test";
		model.addAttribute("location", location);

		return "test/kakaoTest";
	}

	@PostMapping("https://kauth.kakao.com/oauth/token")
	public String kakaoTokenTest() {

		return "test/map-test";
	}

	@GetMapping("/board-test")
	public String boardTest(/* @RequestParam(required = false) String search, */ Criteria cri, Model model) {
		int totalCount = boardMapper.postCount(); // 전체 게시물 수

		// 페이징 객체 먼저 세팅
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(totalCount); // totalCount 세팅 후 calcData() 호출

		// 현재 페이지가 총 페이지보다 크면 마지막 페이지로 보정
		if (cri.getPage() > pageVO.getTotalPage()) {
			cri.setPage(pageVO.getTotalPage() > 0 ? pageVO.getTotalPage() : 1);
		}

		// 현재 페이지 게시물 조회
		List<BoardPostDTO> boardList = boardMapper.noticeList(cri);

		model.addAttribute("boardList", boardList);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("cri", cri);

		return "test/boardTest";
	}

	@GetMapping("board-test/{boardId}")
	public String detailTest(@PathVariable("boardId") long boardId, Model model) {
		// detail 클릭할 때 마다 조회수 증가
		boardMapper.viewCountPlus(boardId);
		
		BoardPostDTO boardDTO = boardMapper.select(boardId);

		model.addAttribute("boardDTO", boardDTO);

		BoardPostDTO prevDTO = boardMapper.selectPrev("NOTICE", boardId);
		model.addAttribute("prevDTO", prevDTO);

		BoardPostDTO nextDTO = boardMapper.selectNext("NOTICE", boardId);
		model.addAttribute("nextDTO", nextDTO);
		
		int commentCount = boardMapper.commentCount(boardId);
		if(commentCount>0) {
			List<BoardCommentDTO> commentList = boardMapper.commentList(boardId);
			model.addAttribute("commentList", commentList);
		}
		return "test/boardDetailTest";
	}

	@GetMapping("board-test/{boardId}/update")
	public String updateTest(@PathVariable("boardId") long boardId, Model model) {
		BoardPostDTO boardDTO = boardMapper.select(boardId);

		model.addAttribute("boardDTO", boardDTO);

		return "test/boardFormTest";
	}

	@PostMapping("board-test/{boardId}/update")
	public String updatePostTest(@PathVariable("boardId") BoardPostDTO postDTO) {

		return "board-test/";
	}
}
