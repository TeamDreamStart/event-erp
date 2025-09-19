package kr.co.dreamstart;


import static org.junit.Assert.*; // ���� ����ҰŶ� static����
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
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

	
	
	
}
