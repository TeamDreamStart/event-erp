package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;

@Mapper
public interface BoardMapper {
	//게시물 전체 조회
	public List<BoardPostDTO> boardPostAll();
	//댓글 전체 조회
	public List<BoardCommentDTO> boardCommentAll();
}
