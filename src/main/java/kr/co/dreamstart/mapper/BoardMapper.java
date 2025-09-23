package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;

@Mapper
public interface BoardMapper {
	// (NOTICE / QNA ) 전체 목록 조회 내림차순 + 페이징
	public List<BoardPostDTO> list(@Param("cri")Criteria cri);
	// insert
	public int postInsert(BoardPostDTO boardPostDTO);
	// update
	public int postUpdate(@Param("boardPostDTO")BoardPostDTO boardPostDTO);
	
	//selectOne
	public BoardPostDTO select(long postId);
	// 게시물 삭제
	public int toPrivate(long postId);
	
	// 게시물 visibility 상태 변경
	public int toPublic(long postId);
	
	// viewCount++
	public int viewCount(long postId);
}
