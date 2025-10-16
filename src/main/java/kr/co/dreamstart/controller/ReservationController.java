package kr.co.dreamstart.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.AdminJoinDTO;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.PaymentDTO;
import kr.co.dreamstart.dto.ReservationDTO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.service.AdminService;
import kr.co.dreamstart.service.EventService;
import kr.co.dreamstart.service.PaymentService;
import kr.co.dreamstart.service.ReservationService;
import kr.co.dreamstart.service.UserService;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService rService;

	@Autowired
	private PaymentService pService;

	@Autowired
	private EventService eService;

	@Autowired
	private UserService uService;
	
	@Autowired
	private AdminService aService;

	//예약폼
	// eventDetail -> 예약/결제정보 입력폼으로 이동
	@GetMapping("/events/{eventId}/reservations")
	public String reservationForm(@PathVariable("eventId") long eventId, Model model, Principal principal) {
		// 로그인한 사용자 정보
		UserDTO userDTO = uService.findUserByUserName(principal.getName()); // sns 사용일경우 어떻게 하지
		model.addAttribute("userDTO", userDTO);
		EventDTO eventDTO = eService.findById(eventId);
		model.addAttribute("eventDTO", eventDTO);
		return "/reservation/reservationForm";
	}

	// reservation headCount만큼 event 정원수에서 빼야함 @@@@@@@@@@@@@@@@@@@@
	//예약폼
	@Transactional
	@PostMapping("/events/{eventId}/reservations")
	public String reservationPOST(@PathVariable("eventId") long eventId,
			@RequestParam(required = false, defaultValue = "0") long userId, @RequestParam("headCount") int headCount,
			RedirectAttributes rttr) {
		// 주문번호 생성
		long reservationId = rService.makeId(eventId);
		ReservationDTO rDTO = new ReservationDTO();
		// eventId,UserId,headCount 값만 받아옴
		rDTO.setReservationId(reservationId);
		rDTO.setUserId(userId);
		rDTO.setEventId(eventId);
		rDTO.setHeadCount(headCount);
		int result = rService.reservation(rDTO);
		if (result > 0) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("resultType", "예약");
		} else {
			rttr.addFlashAttribute("result", "fail");
			rttr.addFlashAttribute("resultType", "예약");
		}
		return "redirect:/reservations/" + rDTO.getReservationId();
	}

	// 예약 폼 + 결제
	@Transactional
	@GetMapping("/events/{eventId}/reservations/payment")//get으로 해야 오류가 안 나는 이상한 마법
	public String reservationWithPay(@PathVariable("eventId") long eventId, @RequestParam("headCount") int headCount,
			PaymentDTO paymentDTO, RedirectAttributes rttr, Principal principal) {
		// 로그인한 사용자 정보
		UserDTO userDTO = uService.findUserByUserName(principal.getName());
		System.out.println(paymentDTO);
		// 주문번호 생성
		long reservationId = rService.makeId(eventId);
		ReservationDTO rDTO = new ReservationDTO();
		// eventId,UserId,headCount 값만 받아옴
		rDTO.setReservationId(reservationId);
		System.out.println("reservationId : "+reservationId);
		rDTO.setUserId(userDTO.getUserId());
		rDTO.setEventId(eventId);
		rDTO.setHeadCount(headCount);
		Map<String, Object> map = rService.reservationWithPay(rDTO, paymentDTO);
		// 예약정보 - userId eventId headCount
		// 결제유무 - reservation / withPay
		// 결제정보 - reservationId /
		rttr.addFlashAttribute("result", map.get("result"));
		rttr.addFlashAttribute("resultType", map.get("resultType"));

		return "redirect:/reservations/" + rDTO.getReservationId(); // 결제완료페이지 - 간단한 예약정보
	}

	// 예약 후 상세보기로 이동
	//reservation detail
	@GetMapping("/reservations/{reservationId}")
	public String reservationDetail(@PathVariable("reservationId")long reservationId,Model model) {
		AdminJoinDTO rDTO = aService.selectJoinPayById(reservationId);
		System.out.println(rDTO);
		model.addAttribute("reservationDTO", rDTO);
		return "/reservation/reservationDetail";
	}
	
	// detail -> 예약 취소 폼
	@GetMapping("/reservations/{reservationId}/cancel")
	public String reservationCencelForm(@PathVariable("reservationId")long reservationId,Model model) {
		
		return "/reservation/reservationCancel";
	}
	@PostMapping("/reservations/{reservationId}/cancel")
	public String reservationCencel(@PathVariable("reservationId")long reservationId,RedirectAttributes rttr) {
		
		return "redirect:/reservations/"+reservationId;
	}

//	@GetMapping()
//	public String () {
//		
//		return "";
//	}
//	@GetMapping()
//	public String () {
//		
//		return "";
//	}
}
