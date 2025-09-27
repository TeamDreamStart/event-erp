package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.FileAssetDTO;

@Mapper
public interface BoardMapper {

	// 카테고리별 , 게시 상태별 게시물 갯수 (category, visibility = PUBLIC)
	public int postCount(@Param("visibility") String visibility, 
			@Param("category") String category);

	// 카테고리별 , 게시 상태별 목록 조회 내림차순 + 페이징 list
	public List<BoardPostDTO> postList(@Param("cri") Criteria cri, 
			@Param("visibility") String visibility,
			@Param("category") String category);
	
	

	// insert visibility -> 일반회원 hidden, 관리자 select /  category -> hidden
	public int postInsert(BoardPostDTO postDTO);
	
	
	
	// update
	public int postUpdate(@Param("postDTO") BoardPostDTO postDTO);

	// 상세보기 selectOne - detail
	public BoardPostDTO select(@Param("category") String category,long postId);

	// 이전 글
	public BoardPostDTO selectPrev(@Param("category") String category, @Param("postId") long postId);

	// 다음 글
	public BoardPostDTO selectNext(@Param("category") String category, @Param("postId") long postId);

	// 게시물 visibility 상태 변경
	public int toPrivate(long postId);

	// 게시물 visibility 상태 변경
	public int toPublic(long postId);

	// 게시물별 조회수
	public int viewCount(long postId);

	// 해당 게시물 조회수 증가 viewCount++ - 상세보기 할 때마다 증가
	public int viewCountPlus(long postId);

	// 게시물 검색 - 공지/Q&A(category)- NOTICE/QNA,
	// 제목/내용,제목,내용(searchType)-TITLE/CONTENT/ALL, 검색어(keyword)
	public List<BoardPostDTO> postSearch(@Param("visibility")String visibility,@Param("category") String category, 
			@Param("searchType") String searchType,
			@Param("keyword") String keyword);

	public int postSearchCount(@Param("visibility")String visibility,@Param("category") String category, 
			@Param("searchType") String searchType,
			@Param("keyword") String keyword);
	// 게시물당 댓글 갯수
	public int commentCount(long postId);

	// 게시물 댓글 list
	public List<BoardCommentDTO> commentList(long postId);

	// 댓글(Q&A 답변) 작성
	public int commentInsert(BoardCommentDTO commentDTO);
	// 게시판 이미지 파일 첨부

}
