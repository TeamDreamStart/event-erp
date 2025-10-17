package kr.co.dreamstart.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
import kr.co.dreamstart.dto.ReservationDTO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.BoardMapper;
import kr.co.dreamstart.mapper.FileAssetMapper;
import kr.co.dreamstart.mapper.ReservationMapper;
import kr.co.dreamstart.mapper.UserMapper;
import kr.co.dreamstart.service.EmailSenderService;
import kr.co.dreamstart.service.PaymentService;
import kr.co.dreamstart.service.ReservationService;
import kr.co.dreamstart.service.UserService;
import lombok.extern.slf4j.Slf4j;
import kr.co.dreamstart.mapper.EventMapper;
import kr.co.dreamstart.mapper.SurveyMapper;

@Slf4j
@Controller
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

	@Autowired
	private EmailSenderService emailService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private ReservationService rService;

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

	@GetMapping("/pay-test")
	public String pay(Model model) {
		EventDTO event = eventMapper.findById((long) 6);

		model.addAttribute("event", event);

		// 가격은 임의로 만원
		model.addAttribute("price", 100);

		return "test/payTest";
	}

	//get으로 주고받으니까 되네 어이없어
	@Transactional
	@GetMapping("/payment/complete-pay")
	public String paymentComplete(PaymentDTO paymentDTO, RedirectAttributes rttr,@RequestParam("userId")long userId,@RequestParam("eventId")long eventId,@RequestParam("headCount")int headCount) {
		ReservationDTO rDTO = new ReservationDTO();
		rDTO.setUserId(userId);
		rDTO.setEventId(eventId);
		rDTO.setHeadCount(headCount);
		Map<String,Object> map = rService.reservationWithPay(rDTO, paymentDTO);
		//event 남은 정원 -1 해야함
		rttr.addFlashAttribute("result", map.get("result"));
		rttr.addFlashAttribute("resultType", map.get("resultType"));

		return "redirect:/pay-test"; // 결과 JSP
	}

	@PostMapping("https://kauth.kakao.com/oauth/token")
	public String kakaoTokenTest() {

		return "test/map-test";
	}

	@GetMapping("/error")
	public String errorTest() {
		return "/common/error";
	}

	@GetMapping("/access-denied")
	public String accessTest() {
		return "/common/accessDenied";
	}

}
