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

	/*
	 * @GetMapping("/board-test") public String boardTest(@RequestParam(required =
	 * false) String searchType,
	 * 
	 * @RequestParam(required = false) String keyword, Criteria cri, Model model) {
	 * int totalCount = boardMapper.postCount("PUBLIC", "NOTICE"); // 공개되어있는 게시물 수
	 * List<BoardPostDTO> boardList = null; if (keyword == null) { boardList =
	 * boardMapper.postList(cri, "PUBLIC", "NOTICE"); } else { // 넘어온 검색어 공백 제거 처리
	 * keyword = keyword.replaceAll("\\s", ""); boardList =
	 * boardMapper.postSearch("NOTICE", searchType, keyword); // 찾은 게시물 수를
	 * totalCount로 넘겨서 페이지네이션 적용 totalCount = boardList.size(); } // 페이징 객체 먼저 세팅
	 * PageVO pageVO = new PageVO(); pageVO.setCri(cri);
	 * pageVO.setTotalCount(totalCount); // totalCount 세팅 후 calcData() 호출
	 * 
	 * // 현재 페이지가 총 페이지보다 크면 마지막 페이지로 보정 if (cri.getPage() > pageVO.getTotalPage())
	 * { cri.setPage(pageVO.getTotalPage() > 0 ? pageVO.getTotalPage() : 1); }
	 * 
	 * // 현재 페이지 게시물 조회
	 * 
	 * model.addAttribute("totalCount", totalCount); model.addAttribute("boardList",
	 * boardList); model.addAttribute("pageVO", pageVO); model.addAttribute("cri",
	 * cri);
	 * 
	 * return "test/boardTest"; }
	 */

	// DETAIL
	@GetMapping("board-test/{postId}")
	public String detailTest(@PathVariable("postId") long postId, Model model) {
		// detail 클릭할 때 마다 조회수 증가
		boardMapper.viewCountPlus(postId);

		BoardPostDTO boardDTO = boardMapper.select("NOTICE",postId);

		model.addAttribute("boardDTO", boardDTO);

		BoardPostDTO prevDTO = boardMapper.selectPrev("NOTICE", postId);
		model.addAttribute("prevDTO", prevDTO);

		BoardPostDTO nextDTO = boardMapper.selectNext("NOTICE", postId);
		model.addAttribute("nextDTO", nextDTO);

		//댓글
		int commentCount = boardMapper.commentCount(postId);
		if (commentCount > 0) {
			List<BoardCommentDTO> commentList = boardMapper.commentList(postId);
			model.addAttribute("commentList", commentList);
		}
		return "test/boardDetailTest";
	}

	@GetMapping("board-test/{postId}/update")
	public String updateTest(@PathVariable("postId") long postId, Model model) {
		BoardPostDTO postDTO = boardMapper.select("NOTICE",postId);

		model.addAttribute("postDTO", postDTO);
		model.addAttribute("formType", "update");
		return "test/boardFormTest";
	}

	@PostMapping("board-test/{postId}/update")
	public String updatePostTest(BoardPostDTO postDTO) {
		int result = -1;
		result = boardMapper.postUpdate(postDTO);
		if (result > 0) {
			System.out.println("업데이트 성공");
		}
		return "redirect:/board-test/" + postDTO.getPostId();
	}

	@GetMapping("/board-test/form")
	public String formTest(Model model) {
		model.addAttribute("formType", "insert");
		model.addAttribute("category", "NOTICE");
		return "test/boardFormTest";
	}

	@PostMapping("/board-test/form")
	public String formPostTest(BoardPostDTO postDTO) {
		int result = -1;
		// Session에서 받아온 사용자 정보 미리 기입 userId@@@@@@@@@@@@
		// 현재는 임의값 넣어줌
		postDTO.setUserId(1);
		result = boardMapper.postInsert(postDTO);
		if (result > 0) {
			System.out.println("insert success");
			long postId = postDTO.getPostId();
			// 생성된 게시물의 상세페이지로 바로 이동
			return "redirect:/board-test/" + postId;
		}

		return "/board-test";
	}
	// 댓글 빡치게 해서 그냥 삭제함.. 다시 구현하자@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	@GetMapping("/board-test/{postId}/delete")
	public String postDeleteTest(@PathVariable("postId") long postId, RedirectAttributes redirectAttributes) {
		int result = -1;
		result = boardMapper.toPrivate(postId);
		if (result > 0) {
			redirectAttributes.addFlashAttribute("msg", "삭제");
		} else {
			redirectAttributes.addFlashAttribute("msg", "삭제가 실패");

		}
		return "redirect:/board-test";
	}

	@GetMapping("/upload")
	public String fileTest(Model model) {
		List<FileAssetDTO> fileList = fileMapper.list("board_post", 1);
		model.addAttribute("fileList", fileList);
		return "/test/fileTest";
	}

//	@PostMapping("/upload")
//	public String fileUploadTest(MultipartFile[] uploadFile, Model model/* ,@PathVariable("boardId")long boardId */) {
//		// 업로드된 파일을 저장할 폴더 경로
//		String uploadFolder = "c:\\upload";
//
//		for (MultipartFile multipartFile : uploadFile) {
//			log.info("---------------------------------");
//			log.info("upload File Name : " + multipartFile.getOriginalFilename());
//			log.info("upload File Size : " + multipartFile.getSize());
//
//			// 실제로 파일을 저장하기 위한 File 객체 생성
//			File savefile = new File(uploadFolder, multipartFile.getOriginalFilename());
//
//			try { // 파일을 지정된 경로에 저장
//				multipartFile.transferTo(savefile);
//			} catch (Exception e) { // 파일 저장 중 예외 발생 시 에러 메시지 출력
//				e.printStackTrace();
//			}
//		}
//		return "redirect:/upload";
//	}

	@PostMapping(value = "/uploadAjax", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody // json으로 반환
	public ResponseEntity<List<FileAssetDTO>> ajaxTest(@PathVariable(required = false)String ownerType,@PathVariable(required = false)long ownerId,  MultipartFile[] uploadFile) {

		// 업로드된 파일 정보를 담을 리스트 생성
		List<FileAssetDTO> fileList = new ArrayList<>();
		// 업로드 처리 로그 기록
		log.info("update ajax post.........");
		// 파일을 저장할 폴더 경로
		String uploadFolder = "C:\\upload";

		// 현재 날짜를 기준으로 업로드된 파일을 저장할 서브 폴더 경로를 생성하여 반환
		String uploadFolderPath = getFolder();

		// 현재 날짜를 기준으로 업로드된 파일을 저장할 서브 폴더 경로 생성
		File uploadPath = new File(uploadFolder, getFolder()); // C:\\upload\2024\02\12
		log.info("upload path : " + uploadPath);

		// 업로드할 서브 폴더가 없는 경우 생성
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		// 받은 파일들을 순회하며 정보를 로그에 출력하고 저장
		for (MultipartFile multipartFile : uploadFile) {

			log.info("-------------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			// 업로드된 파일 정보를 담을 객체 생성
			FileAssetDTO fileDTO = new FileAssetDTO();

			// 업로드된 파일의 이름만 추출하여 저장
			String uploadFileName = multipartFile.getOriginalFilename();

			// @@ DB에 넣을 이름 객체에 저장
			fileDTO.setOriginalName(uploadFileName);

			// Internet Explorer의 경우 파일 경로가 포함되므로 파일 이름만 추출
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);

			// UUID를 이용하여 파일명 중복을 방지하기 위해 파일명 변경
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			// 파일 저장을 위한 File 객체 생성
			File saveFile = new File(uploadPath, uploadFileName);

			try {
				// 업로드 폴더와 멀티파트 파일의 원본 파일 이름을 사용하여 File 객체를 생성
				/*
				 * File savefile = new File(uploadFolder, multipartFile.getOriginalFilename());
				 */
				// 파일을 지정된 경로에 저장
				multipartFile.transferTo(saveFile);

				// @@ UUID, 파일 경로 객체에 저장
				fileDTO.setOwnerType(ownerType);
				fileDTO.setOwnerId(ownerId);
				
				fileDTO.setUuid(uuid.toString());
				fileDTO.setStoredPath(uploadFolderPath);
				fileDTO.setMimeType(multipartFile.getContentType());
				fileDTO.setSizeBytes(multipartFile.getSize());
				System.out.println("ORIGINALNAME : "+fileDTO.getOriginalName());
				System.out.println("UUID : "+fileDTO.getUuid());
				System.out.println("STOREDPATH : "+fileDTO.getStoredPath());
				System.out.println("MIMETYPE : "+fileDTO.getMimeType());
				System.out.println("SIZEBYTES : "+fileDTO.getSizeBytes());
//				fileDTO.setCreatedAt(LocalDateTime.now().toString()); // DB에서 now() 써도 됨

				// 저장한 파일이 이미지인 경우 썸네일 생성
				if (checkImageType(saveFile)) {
					// 이미지 불린 처리
					fileDTO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close(); // 파일 출력 스트림을 닫음
				}
				// @@
				fileList.add(fileDTO);

			} catch (Exception e) { // 파일 저장 중 예외 발생 시 에러 메시지 출력
				log.error(e.getMessage());
			} // end catch
		}
		// @@ DB에 file 정보 넣어야함@@@@@@@@@@@@@@@@@@@@@@@@@@ list니까 foreach문 돌려야되나?
		for (FileAssetDTO fileDTO : fileList) {
		    fileMapper.insertFileInfo(fileDTO);  // 매퍼 메소드 호출
			/* fileMapper.insertFileOwner("board_post", fileDTO.getFileId()); */
		}
		// 클라이언트에게 업로드가 성공했음을 나타내는 HTTP 응답을 생성
		// 리스트는 업로드된 각 파일의 정보를 담고 있으며, HttpStatus.OK는 HTTP 상태 코드를 리턴
		return new ResponseEntity<List<FileAssetDTO>>(fileList, HttpStatus.OK);
	}

	// 현재 날짜를 기준으로 업로드된 파일을 저장할 서브 폴더 경로를 생성하는 메서드
	private String getFolder() {
		// 현재 날짜 정보를 포함한 경로 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		Date date = new Date();
		String str = sdf.format(date); // 2024-02-12
		// 현재 날짜를 기준으로 생성된 서브 폴더 경로 문자열
		return str.replace("-", File.separator);
	}

	// 이미지 파일 유무 체크. 마임타입 확인
	private boolean checkImageType(File file) {
		try {
			// 파일의 마임 타입을 확인하여 이미지인지 여부를 판단
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 마임 타입을 확인할 수 없는 경우 이미지가 아닌 것으로 간주
		return false;
	}

	@GetMapping("/display")
	@ResponseBody
	// 클라이언트에게 파일 전송
	// 파일 응답받음
	public ResponseEntity<byte[]> getFile(String fileName) {
		// 파일명
		log.info("display fileName : " + fileName);
		// 파일 경로
		File file = new File("c:\\upload\\" + fileName);

		log.info("file path :" + file);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();
			// MIME 타입 헤더에 추가
			header.add("Content-type", Files.probeContentType(file.toPath()));
			// 파일 내용 바이트 배열로 복사하여 ResponseEntity 생성
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping("/show")
	public String justShowTest(Model model) {
		List<FileAssetDTO> fileList = fileMapper.list("board_post", 1);
		model.addAttribute("fileList", fileList);
		for(FileAssetDTO fileDTO : fileList) {
			System.out.println(fileDTO);
		}
		return "/test/fileTest";
		
	}
	
	@GetMapping("/admin/main")
	public String bootTest() {
		
		return "/admin/index";
	}
	
	@GetMapping("/admin/tables")
	public String tablesTest() {
		
		return "/admin/tables";
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

}
