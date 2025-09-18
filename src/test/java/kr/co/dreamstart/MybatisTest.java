package kr.co.dreamstart;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.PaymentDTO;
import kr.co.dreamstart.dto.ReservationDTO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.BoardMapper;
import kr.co.dreamstart.mapper.PaymentMapper;
import kr.co.dreamstart.mapper.ReservationMapper;
import kr.co.dreamstart.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MybatisTest {
	
	@Autowired
	private SqlSessionFactory sqlFactory;
	
	@Test
	public void testFactory() {
		System.out.println(sqlFactory);
		System.out.println("Factory Test Success");
	}
	
	@Test
	public void testSession() {
		try(SqlSession session = sqlFactory.openSession()){
			System.out.println(session);
			System.out.println("Session Test Success");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Test
	public void userSelectTest() {
		try(SqlSession session = sqlFactory.openSession()){
			UserMapper mapper = session.getMapper(UserMapper.class);
			List<UserDTO> list= mapper.userSelectAll();
			for(UserDTO user : list) {
				System.out.println(user);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@Test
	public void userCountTest() {
		try(SqlSession session = sqlFactory.openSession()){
			UserMapper mapper = session.getMapper(UserMapper.class);
			int userCount = mapper.userCount();
			System.out.println("현재 총 회원 : "+userCount+"명");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@Test
	public void boardPostTest() {
		try(SqlSession session = sqlFactory.openSession()){
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			List<BoardPostDTO> list = mapper.boardPostAll();
			if(list.size()==0) {
				System.out.println("데이터가 없습니다.");
			}else {
				for(BoardPostDTO bpDTO : list) {
					System.out.println(bpDTO);
				}
				System.out.println("출력완료");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@Test
	public void boardCommentTest() {
		try(SqlSession session = sqlFactory.openSession()){
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			List<BoardCommentDTO> list = mapper.boardCommentAll();
			if(list.size()==0) {
				System.out.println("데이터가 없습니다.");
			}else {
				for(BoardCommentDTO bcDTO : list) {
					System.out.println(bcDTO);
				}
				System.out.println("출력완료");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@Test
	public void resSelectTest() {
		try(SqlSession session = sqlFactory.openSession()){
			ReservationMapper mapper = session.getMapper(ReservationMapper.class);
			List<ReservationDTO> list = mapper.reservationSelectAll();
			if(list.size()==0) {
				System.out.println("데이터가 없습니다.");
			}else {
				for(ReservationDTO rDTO : list) {
					System.out.println(rDTO);
				}
				System.out.println("출력완료");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@Test
	public void paymentSelectTest() {
		try(SqlSession session = sqlFactory.openSession()){
			PaymentMapper mapper = session.getMapper(PaymentMapper.class);
			List<PaymentDTO> list = mapper.paymentSelectAll();
			if(list.size()==0) {
				System.out.println("데이터가 없습니다.");
			}else {
				for(PaymentDTO DTO : list) {
					System.out.println(DTO);
				}
				System.out.println("출력완료");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
