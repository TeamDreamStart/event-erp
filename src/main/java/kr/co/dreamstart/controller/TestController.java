package kr.co.dreamstart.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
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
import kr.co.dreamstart.dto.PaymentDTO;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.BoardMapper;
import kr.co.dreamstart.mapper.FileAssetMapper;
import kr.co.dreamstart.mapper.UserMapper;
import kr.co.dreamstart.service.PaymentService;
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
	public String map() {

		return "test/mapTest";
	}

	@GetMapping("/pay-test")
	public String pay(Model model) {
		// 결제정보 입력 form 에서 전달
		EventDTO eventDTO = eventMapper.selectByEventId(6);
//		eventDTO.setEventId(1L);
//		eventDTO.setTitle("Spring Festival 2025");
//		eventDTO.setDescription("봄맞이 특별 공연");
//		eventDTO.setLocation("서울 강남구 코엑스");
//		eventDTO.setStartDate("2025-10-05");
//		eventDTO.setEndDate("2025-10-05");
//		eventDTO.setCapacity(200);
//		eventDTO.setStatus("OPEN");
//		eventDTO.setVisibility("PUBLIC");
//		eventDTO.setPosterUrl("C:/teamDS/upload/test.png");
//		eventDTO.setCreatedBy(100L);
//		eventDTO.setCreatedAt("2025-09-19");
//		eventDTO.setUpdatedAt("2025-09-19");

		model.addAttribute("eventDTO", eventDTO);

		return "/test/payTest";
	}

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

	@GetMapping("/survey-test")
	public String surveyTest(@RequestParam(required = false) Long eventId,
			@RequestParam(required = false, defaultValue = "all") String field,
			@RequestParam(required = false) String keyword, @RequestParam(required = false) Integer anon, // 1 or 0
			Criteria cri, Model model) {
		log.info("[/survey-test] eventId={}, page={}, perPageNum={}, pageStart={}, keyword={}", eventId, cri.getPage(),
				cri.getPerPageNum(), cri.getPageStart(), keyword);

		// 고정 템플릿 4개
		List<SurveyDTO> fixed = surveyMapper.fixedTemplates();

		// 일반 목록
		List<SurveyDTO> list = surveyMapper.surveyPage(eventId, cri, keyword, field, anon);
		log.info("surveyList rows={}", list.size());
		int total = surveyMapper.surveyCount(eventId, keyword, field, anon);

		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(total);

		model.addAttribute("fixedList", fixed);
		model.addAttribute("surveyList", list);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("total", total);

		// 유지 파라미터
		model.addAttribute("eventId", eventId);
		model.addAttribute("field", field);
		model.addAttribute("keyword", keyword);
		model.addAttribute("anon", anon);

		return "test/surveyListTest";
	}

	// 상세보기
	@GetMapping("/survey-test/detail")
	public String surveyDetail(@RequestParam Long surveyId, Model model) {
		SurveyDTO survey = surveyMapper.findSurvey(surveyId);
		if (survey == null)
			throw new IllegalArgumentException("잘못된 설문 ID");

		List<SurveyQuestionDTO> questions = surveyMapper.questionList(surveyId);

		Map<Long, List<SurveyOptionDTO>> optionsByQ = new LinkedHashMap<>();
		for (SurveyQuestionDTO q : questions) {
			optionsByQ.put(q.getQuestionId(), surveyMapper.optionList(q.getQuestionId()));
		}

		model.addAttribute("survey", survey);
		model.addAttribute("questions", questions);
		model.addAttribute("optionsByQ", optionsByQ);
		return "test/surveyDetailTest";
	}

	// 템플릿 폼
	@GetMapping("/survey-test/clone-form")
	public String cloneForm(@RequestParam(required = false) Long templateId,
			@RequestParam(required = false) Long eventId, @RequestParam(required = false) Long userId, Model model) {
		log.info("[/survey-test/clone-form] templateId={}, eventId={}, userId={}", templateId, eventId, userId);

		List<SurveyDTO> tmplates = surveyMapper.fixedTemplates();
		List<EventDTO> eventList = eventMapper.eventAll();

		model.addAttribute("templates", tmplates); // jsp 렌더링
		model.addAttribute("eventList", eventList);
		model.addAttribute("eventId", eventId);
		model.addAttribute("userId", userId);

		return "test/surveyCloneFormTest";
	}

	// 템플릿 클론(헤더/문항/보기)
	@PostMapping("/survey-test/clone")
	@Transactional
	public String cloneSurvey(@RequestParam Long templateId, @RequestParam Long eventId, @RequestParam Long userId,
			@RequestParam(defaultValue = "default") String scheduleMode,
			@RequestParam(required = false, defaultValue = "0") int openDelayHours,
			@RequestParam(required = false, defaultValue = "7") int closeAfterDays, RedirectAttributes ra) {
		log.info("[/survey-test/clone] templateId={}, eventId={}, userId={}, mode={}, delayH={}, closeD={}", templateId,
				eventId, userId, scheduleMode, openDelayHours, closeAfterDays);

		try {
			// 1)기본/오프셋 분기
			int result = surveyMapper.cloneSurvey(templateId, eventId, userId);

			if (result != 1) {
				ra.addFlashAttribute("ERROR", "설문 헤더 클론 실패!");
				return "redirect:/survey-test/clone-form?eventId=" + eventId + "&err=1";
			}

			// 2) new survey_id
			Long newSurveyId = surveyMapper.lastInsertId();
			log.info(" -> newSurveyId={}", newSurveyId);

			// 3) 원본 템플릿 문항 조회
			List<SurveyQuestionDTO> questionDTO = surveyMapper.questionList(templateId);

			// 4) 문항/보기 복제
			for (SurveyQuestionDTO q : questionDTO) {
				SurveyQuestionDTO nq = new SurveyQuestionDTO();
				nq.setSurveyId(newSurveyId);
				nq.setQuestion(q.getQuestion());
				nq.setType(q.getType());
				surveyMapper.insertQuestion(nq); // useGeneratedKeys 로 questionId 채워짐
				Long newQuestionId = nq.getQuestionId();

				List<SurveyOptionDTO> opts = surveyMapper.optionList(q.getQuestionId());
				for (SurveyOptionDTO op : opts) {
					SurveyOptionDTO nop = new SurveyOptionDTO();
					nop.setQuestionId(newQuestionId);
					nop.setLabel(op.getLabel());
					nop.setOptValue(op.getOptValue());
					surveyMapper.insertOption(nop);
				}
			}

			// 복제 성공 -> 모달로 성공 보여주고 목록으로 이동 시킴
			return "redirect:/survey-test/clone-form?eventId=" + eventId + "&ok=1";

		} catch (Exception e) {
			// TODO: handle exception
			log.info("[CLONE] unexpected error", e);
			ra.addFlashAttribute("ERROR", "알 수 없는 오류로 클론 실패 !");
		}

		return "redirect:/survey-test/clone-form?eventId=" + eventId + "&err=1";
	}

	// 문항+보기 묶음 조회(JSON)
	@GetMapping("/survey-test/template-qa")
	@ResponseBody
	public Map<String, Object> templateQA(@RequestParam Long templateId) {
		Map<String, Object> res = new LinkedHashMap<>();
		List<SurveyQuestionDTO> qs = surveyMapper.questionList(templateId);

		Map<Long, List<SurveyOptionDTO>> options = new LinkedHashMap<>();
		for (SurveyQuestionDTO q : qs) {
			options.put(q.getQuestionId(), surveyMapper.optionList(q.getQuestionId()));
		}

		res.put("questions", qs);
		res.put("optionsByQ", options);
		return res;
	}

	// JSON POST → 기존 메서드만 써서 inline clone
	@PostMapping(value = "/survey-test/clone-inline", consumes = "application/json")
	@Transactional
	@ResponseBody
	public Map<String, Object> cloneInline(@RequestBody Map<String, Object> req) {
		Long templateId = ((Number) req.get("templateId")).longValue();
		Long eventId = ((Number) req.get("eventId")).longValue();
		Long userId = ((Number) req.get("userId")).longValue();

		String scheduleMode = (String) req.get("scheduleMode");
		int openDelayHours = req.get("openDelayHours") == null ? 0 : ((Number) req.get("openDelayHours")).intValue();
		int closeAfterDays = req.get("closeAfterDays") == null ? 7 : ((Number) req.get("closeAfterDays")).intValue();

		// 1. 설문 헤더 복제 (offset 모드 안 씀)
		int result = surveyMapper.cloneSurvey(templateId, eventId, userId);
		if (result != 1)
			throw new RuntimeException("설문 헤더 클론 실패");

		Long newSurveyId = surveyMapper.lastInsertId();

		// 2. QA 복사
		List<Map<String, Object>> questions = (List<Map<String, Object>>) req.get("questions");
		if (questions != null) {
			for (Map<String, Object> q : questions) {
				String type = (String) q.get("type"); // "single" | "multi" | "SCALE_5"
				String question = (String) q.get("question");
				if (type == null || question == null)
					continue;

				SurveyQuestionDTO nq = new SurveyQuestionDTO();
				nq.setSurveyId(newSurveyId);

				// 문자열 → enum 매핑
				SurveyQuestionDTO.QuestionType qType;
				switch (type.toLowerCase()) {
				case "single":
					qType = SurveyQuestionDTO.QuestionType.SINGLE;
					break;
				case "multi":
					qType = SurveyQuestionDTO.QuestionType.MULTI;
					break;
				case "SCALE_5":
				default:
					qType = SurveyQuestionDTO.QuestionType.SCALE_5;
					break;
				}
				nq.setType(qType);

				nq.setQuestion(question);
				surveyMapper.insertQuestion(nq); // questionId 자동 세팅
				Long newQid = nq.getQuestionId();
				List<Map<String, Object>> options = (List<Map<String, Object>>) q.get("options");
				if (options != null) {
					for (Map<String, Object> op : options) {
						String label = (String) op.get("label");
						String optValueStr = (String) op.get("optValue");
						if (label == null)
							continue;

						SurveyOptionDTO no = new SurveyOptionDTO();
						no.setQuestionId(newQid);
						no.setLabel(label);

						Integer optValue = null;
						if (optValueStr != null && !optValueStr.isBlank()) {
							try {
								optValue = Integer.valueOf(optValueStr);
							} catch (NumberFormatException ignore) {
							}
						}
						no.setOptValue(optValue); // Integer로 세팅
						surveyMapper.insertOption(no);
					}
				}
			}
		}

		// return Map.of("ok", true, "surveyId", newSurveyId);
		Map<String, Object> res = new LinkedHashMap<>();
		res.put("ok", true);
		res.put("surveyId", newSurveyId);
		return res;

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


}
