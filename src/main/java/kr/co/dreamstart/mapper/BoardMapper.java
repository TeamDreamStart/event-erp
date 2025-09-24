package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;

@Mapper
public interface BoardMapper {

	public int postCount();

	// NOTICE 전체 목록 조회 내림차순 + 페이징 list
	public List<BoardPostDTO> noticeList(@Param("cri") Criteria cri);

	// QNA 전체 목록 조회 내림차순 + 페이징 list
	public List<BoardPostDTO> qnaList(@Param("cri") Criteria cri);
	


	// insert - form
	public int postInsert(BoardPostDTO boardPostDTO);

	// update - form
	public int postUpdate(@Param("boardPostDTO") BoardPostDTO boardPostDTO);

	// 상세보기 selectOne - detail
	public BoardPostDTO select(long postId);

	// 이전 글
	public BoardPostDTO selectPrev(@Param("category")String category,@Param("postId")long postId);

	// 다음 글
	public BoardPostDTO selectNext(@Param("category")String category,@Param("postId")long postId);

	// 게시물 삭제 - delete
	public int toPrivate(long postId);

	// 게시물 visibility 상태 변경
	public int toPublic(long postId);

	// 조회수
	public int viewCount(long postId);

	// 조회수 증가 viewCount++ - detail
	public int viewCountPlus(long postId);

	// 게시물 검색 - 공지/Q&A(category)- NOTICE/QNA,
	// 제목/내용,제목,내용(searchType)-TITLE/CONTENT/ALL, 검색어(keyword)
	public List<BoardPostDTO> postSearch(@Param("category") String category, @Param("searchType") String searchType,
			@Param("keyword") String keyword);
	
	
	
	
	// 게시물당 댓글 갯수
	public int commentCount(long postId);
	// 게시물 댓글 list
	public List<BoardCommentDTO> commentList(long postId);
	
	
	
	

}
