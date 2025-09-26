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
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.FileAssetDTO;
import kr.co.dreamstart.mapper.BoardMapper;
import kr.co.dreamstart.mapper.FileAssetMapper;
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
			List<BoardPostDTO> list = mapper.postList(cri,"PUBLIC","NOTICE");

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
			for(int i=0; i<10;i++) {
				
				BoardPostDTO post = new BoardPostDTO();
				post.setCategory("NOTICE");
				post.setTitle("title");
				post.setContent("content");
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
			}

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
	public void commentInsertTest() {
		try (SqlSession session = sqlFactory.openSession()) {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			BoardCommentDTO commentDTO = new BoardCommentDTO();
			commentDTO.setPostId(56);
			commentDTO.setContent("왜 취소했어요??");
			
			// 추후엔 세션에서 받아옴
			commentDTO.setUserId(1);
			int result = -1;
			result = mapper.commentInsert(commentDTO);
			if(result>0) {
				System.out.println("성공");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void fileInfoDBInsertTest() {
		try (SqlSession session = sqlFactory.openSession()) {
			FileAssetMapper mapper = session.getMapper(FileAssetMapper.class);
			FileAssetDTO fileDTO = new FileAssetDTO();
			fileDTO.setOwnerType("board_post");
			fileDTO.setOwnerId(1);
			fileDTO.setOriginalName("oil.jpg");
			fileDTO.setStoredPath("2025\\09\\26");
			fileDTO.setMimeType("image/jpeg");;
			fileDTO.setSizeBytes(47894);
			fileDTO.setUuid("dba45a62-fe1c-4d2c-bf9c-8a030db54b41");
			
			int result = -1;
			result = mapper.insert(fileDTO);
			if(result>0) {
				log.info("fileInfoDBInsertTest : success");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
