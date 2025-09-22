package kr.co.dreamstart;


import static org.junit.Assert.*; // ���� ����ҰŶ� static����

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.Scanner;
import java.util.UUID;

import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.SurveyAnswerDTO;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import kr.co.dreamstart.mapper.EventMapper;
import kr.co.dreamstart.mapper.SurveyMapper;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Slf4j
public class MybatisTest {
//	private static final Logger log = LoggerFactory.getLogger(MybatisTest.class);
	
	@Autowired
	private SqlSessionFactory sqlFactory;
	
	@Autowired
	private MailSender mailSender;
	
	@Test
	public void testFactory() {
		assertNotNull("sqlFactory is Null", sqlFactory); // ����
//		log.info("SqlSessionFactory={}");
//		System.out.println(sqlFactory);
//		System.out.println("Factory Test Success");
	}
	
	@Test
	public void testSession() {
		try(SqlSession session = sqlFactory.openSession()){
			assertNotNull("session is null", session);
			log.info("SqlSession opened : {}", session);
			
//			System.out.println(session);
//			System.out.println("Session Test Success");
		}catch(Exception e) {
			log.error("testSession Error", e);
			fail(e.getMessage());
		}
		
	}
	
	@Test
	public void selectTest() {
		try(SqlSession session = sqlFactory.openSession()){
			UserMapper mapper = session.getMapper(UserMapper.class);
			List<UserDTO> list= mapper.userSelectAll();
			
//			assertNotNull("list is Null", list); // null ���� Ȯ��
//			assertFalse("list is empty", list.isEmpty()); // ��� �ִ��� Ȯ��
			log.info("select rows={}", list.size());
			
			for(UserDTO user : list) {
				log.info("user={}", user);
			}
		}catch(Exception e) {
			log.error("selectTest Error", e);
			fail(e.getMessage());
		}
	}
	
	@Test
	public void eventAllTest() {
		try(SqlSession session = sqlFactory.openSession()) {
//			System.out.println(session.getConfiguration().hasStatement("kr.co.dreamstart.mapper.EventMapper.eventAll")); 
			EventMapper mapper = session.getMapper(EventMapper.class);
			List<EventDTO> list = mapper.eventAll();
//			System.out.println("rows : " + list.size());
			
//			assertNotNull("list is Null", list);
//			assertFalse("list is empty", list.isEmpty());
			log.info("event rows={}", list.size());
		} catch (Exception e) {
			log.error("eventAllTest Error", e);
			fail(e.getMessage());
		}
	}
	
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
	public void emailTest() {
		Random r = new Random();
        int num = r.nextInt(999999); //랜덤 난수 
        
        StringBuilder sb = new StringBuilder();
        
        String setFrom = "test@naver.com";//발신자 이메일
        String tomail = "yje_515@naver.com";//수신자 이메일
        String title = "[TEKA] 비밀번호 변경 인증 이메일입니다.";
        sb.append(String.format("안녕하세요 %s님\n","지은"));
        sb.append(String.format("비밀번호 찾기(변경) 인증번호는 %d입니다.", num));
        String content = sb.toString();
        
		/*
		 * try { SimpleMailMessage msg = ((Object) mailSender).createMimeMessage();
		 * //true-> 첨부파일 기능 MimeMessageHelper msgHelper = new MimeMessageHelper(msg,
		 * false, "utf-8");
		 * 
		 * msgHelper.setFrom(setFrom); msgHelper.setTo(tomail);
		 * msgHelper.setSubject(title); msgHelper.setText(content);
		 * 
		 * //메일 전송 mailSender.send(msg);
		 * 
		 * }catch (Exception e) { // TODO: handle exception
		 * System.out.println(e.getMessage()); }
		 */
	}
	
	@Test
	public void mailtrapQuickTest() {
	    // JavaMailSenderImpl을 직접 만들어서 사용 (Spring Bean 없이)
	    org.springframework.mail.javamail.JavaMailSenderImpl mailSender = new org.springframework.mail.javamail.JavaMailSenderImpl();
	    mailSender.setHost("sandbox.smtp.mailtrap.io");    // Mailtrap에서 받은 값
	    mailSender.setPort(2525);                          // 또는 587, 465 등
	    mailSender.setUsername("5fb50ec1a37392");       // Mailtrap에서 복사한 username
	    mailSender.setPassword("41fd5116fea25f");       // Mailtrap에서 복사한 password

	    Properties props = mailSender.getJavaMailProperties();
	    props.put("mail.transport.protocol", "smtp");
	    props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.starttls.enable", "true"); // TLS
	    props.put("mail.debug", "true");

	    UUID uuid = UUID.randomUUID();
	    String tmpPass = uuid.toString();
	    try {
	        MimeMessage msg = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(msg, false, "UTF-8");
	        helper.setFrom("from@example.com"); // 임의 주소(받는사람이 Mailtrap에서 확인)
	        helper.setTo("to@example.com");
	        helper.setSubject("[테스트] Mailtrap JUnit 연동 - 임시 비밀번호 발송");
	        helper.setText("임시 비밀번호는 ["+tmpPass+"]입니다.", false);

	        mailSender.send(msg);
	        System.out.println("메일 전송 시도 완료 - Mailtrap UI에서 확인하세요.");
	    } catch (Exception e) {
	        e.printStackTrace();
	        fail("메일 전송 실패: " + e.getMessage());
	    }
	    
	    Scanner scan = new Scanner(System.in);
	    System.out.print("임시 비밀번호 입력:");
	    String scanPass = scan.nextLine();
	    if(tmpPass.equals(scanPass)) {
	    	System.out.println("비밀번호 일치");
	    }
	}


	
	
	
}
