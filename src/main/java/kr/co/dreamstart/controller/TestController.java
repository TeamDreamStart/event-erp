package kr.co.dreamstart.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.UserMapper;

@Controller
public class TestController {

	@Autowired
	private UserMapper mapper;

	@GetMapping("/list-test")
	public String userList(@RequestParam(required = false) Integer userId, Criteria cri, Model model) {
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		// 특정 아이디 검색 값이 없다면 -> 회원 전체 목록
		if (userId == null) {
			List<UserDTO> userList = mapper.userPagingList(cri);
			model.addAttribute("userList", userList);
			// 회원 전체 목록으로 페이징 값 (total) 계산
			pageVO.setTotalCount(mapper.userCount());
		} else {// 특정 아이디 검색 값이 있다면 -> 목록에 특정 회원만 표시
//			UserDTO user = mapper.selectUser();

		}
		// 페이징에 필요한 값을 객체로 전달
		model.addAttribute("pageVO", pageVO);
		// 전체 회원 수
		model.addAttribute("userCount", mapper.userCount());
		return "/listTest";
	}

	@PostMapping("/upload")
	public String handleFileUpload(@RequestParam("imageFile") MultipartFile file) {
		if (file.isEmpty()) {
			return "redirect:/list-test"; // 업로드 실패 처리
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

		return "redirect:/list-test";
	}

	@GetMapping("/map-test")
	public String map() {

		return "/mapTest";
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
		model.addAttribute("price", 0);

		return "payTest";
	}
}
