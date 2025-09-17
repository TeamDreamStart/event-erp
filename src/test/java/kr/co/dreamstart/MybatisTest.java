package kr.co.dreamstart;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.UserMapper;

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
	public void selectTest() {
		try(SqlSession session = sqlFactory.openSession()){
			UserMapper mapper = session.getMapper(UserMapper.class);
			List<UserDTO> list= mapper.selectAll();
			for(UserDTO user : list) {
				System.out.println(user);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
