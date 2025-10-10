package kr.co.dreamstart.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.FileAssetDTO;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.BoardMapper;
import kr.co.dreamstart.mapper.FileAssetMapper;
import kr.co.dreamstart.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;
import kr.co.dreamstart.mapper.EventMapper;
import kr.co.dreamstart.mapper.SurveyMapper;
import kr.co.dreamstart.mapper.UserMapper;

@Slf4j
@Controller
//@RequestMapping("/test")
public class TestController {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private BoardMapper boardMapper;

	@Autowired
	private FileAssetMapper fileMapper;

	@Autowired
	private SurveyMapper surveyMapper;

	@Autowired
	private EventMapper eventMapper;

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




}
