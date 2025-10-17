package kr.co.dreamstart;

import static org.junit.Assert.*; // ���� ����ҰŶ� static����

import java.time.LocalDateTime;
import java.util.List;
import java.util.Properties;
import java.util.Scanner;
import java.util.UUID;

import javax.mail.internet.MimeMessage;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import kr.co.dreamstart.dto.AdminJoinDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.SurveyAnswerDTO;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;
import kr.co.dreamstart.dto.UserDTO;
import lombok.extern.slf4j.Slf4j;
import kr.co.dreamstart.mapper.AdminMapper;
import kr.co.dreamstart.mapper.BoardMapper;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import kr.co.dreamstart.mapper.EventMapper;
import kr.co.dreamstart.mapper.SurveyMapper;
import kr.co.dreamstart.mapper.UserMapper;
import kr.co.dreamstart.service.EventService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
@Slf4j
public class MybatisTest {
//	private static final Logger log = LoggerFactory.getLogger(MybatisTest.class);

	@Autowired
	private SqlSessionFactory sqlFactory;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private EventService eventService;

	@Autowired
	private AdminMapper adminMapper;
	
	@Test
	public void testFactory() {
		assertNotNull("sqlFactory is Null", sqlFactory); // ����
//		log.info("SqlSessionFactory={}");
//		System.out.println(sqlFactory);
//		System.out.println("Factory Test Success");
	}

	@Test
	public void testSession() {
		try (SqlSession session = sqlFactory.openSession()) {
			assertNotNull("session is null", session);
			log.info("SqlSession opened : {}", session);

//			System.out.println(session);
//			System.out.println("Session Test Success");
		} catch (Exception e) {
			log.error("testSession Error", e);
			fail(e.getMessage());
		}

	}

	/*
	 * @Test public void eventest() { try (SqlSession session =
	 * sqlFactory.openSession()) { //
	 * System.out.println(session.getConfiguration().hasStatement(
	 * "kr.co.dreamstart.mapper.EventMapper.eventAll")); EventMapper mapper =
	 * session.getMapper(EventMapper.class); Criteria cri = new Criteria(1,3);
	 * List<EventDTO> list = mapper.categoryList(cri,"SHOW");//
	 * SHOW,SPEACH,WORKSHOP,MARKET // System.out.println("rows : " + list.size());
	 * 
	 * // assertNotNull("list is Null", list); // assertFalse("list is empty",
	 * list.isEmpty()); log.info("event rows={}", list.size()); } catch (Exception
	 * e) { log.error("eventAllTest Error", e); fail(e.getMessage()); } }
	 */

	@Test
	public void surveySmokeTest() {
		try (SqlSession session = sqlFactory.openSession()) {
			SurveyMapper mapper = session.getMapper(SurveyMapper.class);

			List<SurveyDTO> surveyList = mapper.surveyAll();
			log.info("survey row={}", surveyList.size());

			List<SurveyAnswerDTO> answerList = mapper.answerAll();
			log.info("answer row={}", answerList.size());

			List<SurveyOptionDTO> optionList = mapper.optionAll();
			log.info("option row={}", optionList.size());

			List<SurveyQuestionDTO> questList = mapper.questionAll();
			log.info("quest row={}", questList.size());

			List<SurveyResponseDTO> responceList = mapper.responseAll();
			log.info("responce row={}", responceList.size());

		} catch (Exception e) {
			log.error("surveySmokeTest error", e);
			fail(e.getMessage());
		}
	}
	
	@Test
	public void surveyListTest() {
		try (SqlSession session = sqlFactory.openSession()){
			SurveyMapper mapper = session.getMapper(SurveyMapper.class);
			
			Criteria cri = new Criteria(1, 10);
			log.info("page={}, perPageNum={}, pageStart={}", cri.getPage(), cri.getPerPageNum(), cri.getPageStart());
			
			List<SurveyDTO> list = mapper.surveyPage(null, cri, null, null, null);
			int cnt = mapper.surveyCount(null, null, null, null);
			
			log.info("surveyPage rows={}, count={}", (list == null ? 0:list.size()), cnt);
			assertNotNull(list);
			assertTrue(cnt >= (list == null ? 0 : list.size()));
		} catch (Exception e) {
			// TODO: handle exception
			log.error("surveyPage error", e);
			fail(e.getMessage());
		}
	}
	

	@Test
	public void mailtrapQuickTest() {

		// @Autowiredprivate MailSender mailSender;
		// JavaMailSenderImpl을 직접 만들어서 사용 (Spring Bean 없이)
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
//		mailSender.setHost("sandbox.smtp.mailtrap.io"); // Mailtrap에서 받은 값
//		mailSender.setPort(2525); // 또는 587, 465 등
//		mailSender.setUsername("5fb50ec1a37392"); // Mailtrap에서 복사한 username
//		mailSender.setPassword("41fd5116fea25f"); // Mailtrap에서 복사한 password

		mailSender.setHost("smtp.gmail.com");
		mailSender.setPort(587);
		mailSender.setUsername("yoonje515@gmail.com");
		mailSender.setPassword("nqvp pkxd fmcb sgio");
		Properties props = mailSender.getJavaMailProperties();
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true"); // TLS
		props.put("mail.debug", "true");

		UUID uuid = UUID.randomUUID();
		String tmpPass = uuid.toString();// 임시 비밀번호? 인증번호?
		try {
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(msg, false, "UTF-8");
			helper.setFrom("teamDS@dreamstart.com"); // 임의 주소(받는사람이 Mailtrap에서 확인)
			helper.setTo("yje_515@naver.com"); // 임의 주소 (메일 트랩에서 수신)
			helper.setSubject("[테스트] Mailtrap + Email Api 테스트- 임시 비밀번호 발송");
			helper.setText("임시 비밀번호는 [" + tmpPass + "]입니다.", false);

			mailSender.send(msg);
			System.out.println("메일 전송 완료 - Mailtrap UI에서 확인하세요.");
		} catch (Exception e) {
			e.printStackTrace();
			fail("메일 전송 실패: " + e.getMessage());
		}

		Scanner scan = new Scanner(System.in);
		System.out.print("임시 비밀번호 입력:");
		String scanPass = scan.nextLine();
		if (tmpPass.equals(scanPass)) {
			System.out.println("비밀번호 일치");
		}

	}

	@Test
	public void userInsertTest() {
		try (SqlSession session = sqlFactory.openSession()) {
			UserMapper mapper = session.getMapper(UserMapper.class);
			UserDTO user = new UserDTO();
			user.setUsername("insertTest8");
			user.setPassword("1234");
			user.setName("테스트8");
			user.setEmail("insert8@test.com");
			String answer = "실패";
			int result = mapper.join(user);
			if (result > 0) {
				answer = "성공";
				mapper.joinRole(user.getUserId());
				log.info("userInsertTest result : " + answer);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	@Test
	public void userListTest() {
		try (SqlSession session = sqlFactory.openSession()) {
			UserMapper mapper = session.getMapper(UserMapper.class);
			Criteria cri = new Criteria(1, 3);
			List<UserDTO> list = mapper.list(cri);

			for (UserDTO DTO : list) {
				System.out.println(DTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}


	
	// 비밀번호 통일 + 랜덤 해시 생성	
	@Test
	public void resetAllToPassword() {
		final String raw = "1234";
		List<UserDTO> targets = userMapper.findUsersNeedingHash();
		log.info("[RESET] target users={}", targets.size());
		
		for(UserDTO u : targets) {
			String hash = passwordEncoder.encode(raw);
			userMapper.updatePasswordById(u.getUserId(), hash);
			log.info("[RESET] userId={} username={} -> DONE", u.getUserId(), u.getUsername());
		}
		log.info("[RESET] completed.");
	}
	
	// 아이디로 로그인 확인 - 이메일도 가져오기
	@Test
	public void loginQueryByUsername() {
		UserDTO dto = userMapper.findByLogin("admin");
		assertNotNull(dto);
		log.info("user={} email={}", dto.getUsername(), dto.getEmail());
	}

	@Test
	public void passwordMatch() {
		UserDTO dto = userMapper.findByLogin("admin");
		assertNotNull(dto);
		
		boolean ok = passwordEncoder.matches("1234", dto.getPassword());
		log.info("matches={}", ok);
	}
	
	
	
	@Test
	public void templateQaIntegrityTest() {
		try (SqlSession session = sqlFactory.openSession()) {
			SurveyMapper mapper = session.getMapper(SurveyMapper.class);

			List<SurveyDTO> surveys = mapper.surveyAll();
			List<SurveyQuestionDTO> allQuestions = mapper.questionAll();
			List<SurveyOptionDTO> allOptions = mapper.optionAll();

			assertNotNull("surveys null", surveys);
			assertNotNull("questions null", allQuestions);
			assertNotNull("options null", allOptions);

			// 템플릿만 필터링 (templateKey가 있는 설문을 템플릿으로 간주)
			int templateCount = 0;
			StringBuilder sb = new StringBuilder();

			for (SurveyDTO s : surveys) {
				String tkey = s.getTemplateKey(); // SurveyDTO에 templateKey 존재한다고 가정 (JSP에서 사용됨)
				if (tkey == null || tkey.trim().isEmpty()) continue; // 템플릿 아님

				templateCount++;

				// 템플릿의 문항 목록
				Long surveyId = s.getSurveyId();
				int questionCnt = 0;

				for (SurveyQuestionDTO q : allQuestions) {
					if (q.getSurveyId() == surveyId) questionCnt++;
				}

				log.info("[TEMPLATE] surveyId={} templateKey={} title='{}' -> questionCnt={}",
						surveyId, tkey, s.getTitle(), questionCnt);

				// 문항 20개 확인
				if (questionCnt != 20) {
					sb.append(String.format(" - [Q COUNT MISMATCH] surveyId=%d templateKey=%s expected=20 actual=%d%n",
							surveyId, tkey, questionCnt));
				}

				// 각 문항별 보기 5개 확인 (디테일 로그)
				for (SurveyQuestionDTO q : allQuestions) {
					if (q.getSurveyId() != surveyId) continue;

					Long qid = q.getQuestionId();
					int optCnt = 0;
					for (SurveyOptionDTO op : allOptions) {
						if (op.getQuestionId() == qid) optCnt++;
					}

					if (optCnt != 5) {
						sb.append(String.format("   * [OPT COUNT MISMATCH] surveyId=%d qId=%d expected=5 actual=%d%n",
								surveyId, qid, optCnt));
					}
				}
			}

			log.info("[TEMPLATE] total templates found={}", templateCount);
			if (templateCount == 0) {
				fail("템플릿이 한 건도 없습니다. (SurveyDTO.templateKey 기준)");
			}

			if (sb.length() > 0) {
				log.error("무결성 위반 내역:\n{}", sb);
				fail("템플릿 문항/보기 수 검증 실패. 로그를 확인하세요.");
			}
		} catch (Exception e) {
			log.error("templateQaIntegrityTest error", e);
			fail(e.getMessage());
		}
	}
	
	@Test
	public void userSearchTest() {
	/*
	 * 	public List<UserDTO> search(@Param("cri") Criteria cri,@Param("role") Integer role,@Param("searchType") String searchType,
			@Param("keyword") String keyword, @Param("startDate") String startDate, @Param("endDate") String endDate);

	 * */
		List<UserDTO> userList = userMapper.search(new Criteria(),null,"createdAt", null, "2025-09-22","2025-09-26");
		for(UserDTO userDTO : userList) {
			System.out.println(userDTO);
		}
	}
	@Transactional
	@Rollback
	public void insert_and_find_ok() {
		// arran
		Long loginUserId = 1L;
		EventDTO dto = new EventDTO();
		dto.setTitle("서비스-생성-라운드트립");
		dto.setDescription("service save test");
		dto.setLocation("Seoul");
		dto.setStartDate(LocalDateTime.now().plusDays(1));
		dto.setEndDate(dto.getStartDate().plusHours(2));
		dto.setCapacity(50);
		dto.setStatus("OPEN");
		dto.setVisibility("PUBLIC");
		dto.setPosterUrl(null);
		dto.setCurrency("KRW");
		dto.setCategory("SHOW");
		dto.setPaid(false);
		
		log.info("[GIVEN] dto={}", dto);
		
		// when
		Long newId = eventService.save(dto, loginUserId);
		log.info("[WHEN] save id={}", newId);
		EventDTO loaded = eventService.findById(newId);
		log.info("[THEN] loaded={}", loaded);
		
		// then
		assertNotNull(newId);
		assertNotNull(loaded);
		assertEquals(newId, loaded.getEventId());
		assertEquals("서비스-생성-라운드트립", loaded.getTitle());
		assertEquals("OPEN", loaded.getStatus());
	}
	
	@Test
	public void sasdTest() {
		List<AdminJoinDTO> dto = adminMapper.selectJoinPayByUserId(278);
		System.out.println(dto);
	}
	// 회원 가입 관련 테스트
	@Test
	public void existsByUserNameTest() {
		// 이미 존재하는 계정일 경우
		String existing = "admin";
		int cnt = userMapper.existsByUserName(existing);
		assertTrue("should exist, but count was" + cnt, cnt > 0);
		log.info("[EXISTS-USERNAME] {} -> count={}", existing,cnt);
	}
	@Test
	public void existsByUserName_notExistsTest() {
		// 존재하지 않는 계정일 경우
		String notExisting = "없지롱";
		int cnt = userMapper.existsByUserName(notExisting);
		assertEquals("non-existing username should be 0", 0, cnt);
		log.info("[NOT EXISTS-USERNAME] {} -> {}", notExisting, cnt);
	}
	@Test
	public void existsByEmailTest() {
		// 이미 존재하는 이메일일 경우
		String existing = "smoke@example.com";
		int cnt = userMapper.existsByEmail(existing);
		assertTrue("email should exist, but count was" + cnt, cnt > 0);
		log.info("[EXISTS-EMAIL] {} -> {}", existing, cnt);
	}
	@Test
	public void existsByEmail_notExistsTest() {
		// 존재하는 이메일일 경우
		String notExisting = "start1233456@naver.com";
		int cnt = userMapper.existsByEmail(notExisting);
		assertEquals("non-existing email should be 0", 0, cnt);
		log.info("[NOT EXISTS-EMAIL] {} -> {}", notExisting, cnt);
	}
	
}
