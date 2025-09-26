package kr.co.dreamstart;

import static org.junit.Assert.*; // ���� ����ҰŶ� static����

import java.util.List;
import java.util.Properties;
import java.util.Scanner;
import java.util.UUID;

import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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
import kr.co.dreamstart.mapper.BoardMapper;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import kr.co.dreamstart.mapper.EventMapper;
import kr.co.dreamstart.mapper.SurveyMapper;
import kr.co.dreamstart.mapper.UserMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
@Slf4j
public class MybatisTest {
//	private static final Logger log = LoggerFactory.getLogger(MybatisTest.class);

	@Autowired
	private SqlSessionFactory sqlFactory;

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
	public void mailtrapQuickTest() {

		// @Autowiredprivate MailSender mailSender;
		// JavaMailSenderImpl을 직접 만들어서 사용 (Spring Bean 없이)
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost("sandbox.smtp.mailtrap.io"); // Mailtrap에서 받은 값
		mailSender.setPort(2525); // 또는 587, 465 등
		mailSender.setUsername("5fb50ec1a37392"); // Mailtrap에서 복사한 username
		mailSender.setPassword("41fd5116fea25f"); // Mailtrap에서 복사한 password

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
			helper.setFrom("from@example.com"); // 임의 주소(받는사람이 Mailtrap에서 확인)
			helper.setTo("to@example.com"); // 임의 주소 (메일 트랩에서 수신)
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
			user.setUserName("insertTest8");
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



}
