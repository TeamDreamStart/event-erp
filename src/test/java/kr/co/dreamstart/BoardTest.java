package kr.co.dreamstart;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.mapper.BoardMapper;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
@Slf4j
public class BoardTest {

	@Autowired
	private SqlSessionFactory sqlFactory;

	@Test
	public void boardListTest() {
		try (SqlSession session = sqlFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			Criteria cri = new Criteria(2, 10);
			List<BoardPostDTO> list = mapper.noticeList(cri);

			for (BoardPostDTO DTO : list) {
				System.out.println(DTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void boardSelectTest() {
		try (SqlSession session = sqlFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			BoardPostDTO postDTO = mapper.select(13);
			int view = mapper.viewCount(13);
			log.info("select test result : {}", postDTO);
			log.info("viewCount result : {}", view);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void boardInsertTest() {
		int result = -1;
		try (SqlSession session = sqlFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			BoardPostDTO post = new BoardPostDTO();
			post.setCategory("QNA");
			post.setTitle("test");
			post.setContent("test");
			post.setUserId(1);
			post.setVisibility("PUBLIC");
			result = mapper.postInsert(post);
			if (result > 0) {
				log.info("boardInsertTest : success");
				log.info("새로 생성된 post_id : " + post.getPostId());
				result = -1;
			}
			BoardPostDTO resultDTO = mapper.select(post.getPostId());
			log.info("insert result : {}", resultDTO);
			System.out.println(resultDTO);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void searchTest() {
		try (SqlSession session = sqlFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			String category = "QNA";
			List<BoardPostDTO> list = mapper.postSearch(category,"TITLE","test");
			if (list!=null) {
				for (BoardPostDTO postDTO : list) {
					System.out.println(postDTO);
				}
			} else {
				System.out.println("검색 결과가 없습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void Test2() {
		try (SqlSession session = sqlFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void Test3() {
		try (SqlSession session = sqlFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
