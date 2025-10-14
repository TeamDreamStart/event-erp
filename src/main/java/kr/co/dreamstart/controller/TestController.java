package kr.co.dreamstart.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.dto.PaymentDTO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.BoardMapper;
import kr.co.dreamstart.mapper.FileAssetMapper;
import kr.co.dreamstart.mapper.UserMapper;
import kr.co.dreamstart.service.PaymentService;
import lombok.extern.slf4j.Slf4j;
import kr.co.dreamstart.mapper.EventMapper;
import kr.co.dreamstart.mapper.SurveyMapper;

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

	@Autowired
	private PaymentService paymentService;


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
	public String map(Model model) {
		model.addAttribute("location", "경기 수원시 팔달구 덕영대로895번길 9-1");
		model.addAttribute("latitude", "37.2689226891878");
		model.addAttribute("longitude", "126.99991127117");
		model.addAttribute("title", "가을페스티벌");
		
		return "test/mapTest";
	}

//	@GetMapping("/pay-test")
//	public String pay(Model model) {
//		EventDTO event = new EventDTO();
//		event.setEventId(1L);
//		event.setTitle("Spring Festival 2025");
//		event.setDescription("봄맞이 특별 공연");
//		event.setLocation("서울 강남구 코엑스");
//		event.setStartDate("2025-10-05");
//		event.setEndDate("2025-10-05");
//		event.setCapacity(200);
//		event.setStatus("OPEN");
//		event.setVisibility("PUBLIC");
//		event.setPosterUrl("C:/teamDS/upload/test.png");
//		event.setCreatedBy(100L);
//		event.setCreatedAt("2025-09-19");
//		event.setUpdatedAt("2025-09-19");
//
//		model.addAttribute("event", event);
//
//		// 가격은 임의로 만원
//		model.addAttribute("price", 100);
//
//		return "test/payTest";
//	}

	@RequestMapping(value="/payment/complete", method=RequestMethod.POST)
	public String paymentComplete(PaymentDTO payment, RedirectAttributes rttr) {
	    System.out.println("Controller 호출됨");
	    payment.setReservationId(1);
	    System.out.println(payment);

	    int result = paymentService.savePayment(payment);
	    rttr.addFlashAttribute("result", result > 0 ? "success" : "fail");

	    return "redirect:/pay-test"; // 결과 JSP
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
	
	@GetMapping("/find-password")
	public String findPass() {
		return "/account/findPassword";
	}

	@GetMapping("/reset-password")
	public String reseTest() {
		return "/account/resetPassword";
	}
	@GetMapping("/error")
	public String errorTest() {
		return "/common/error";
	}
	@GetMapping("/access-denied")
	public String accessTest() {
		return "/common/accessDenied";
	}


	@GetMapping("/notices/{id}")
	public String noticeDetail() {
		return "/board/noticeDetail";
	}
	@GetMapping("/qna/{id}")
	public String qnaDetail() {
		return "/board/qnaDetail";
	}
}
