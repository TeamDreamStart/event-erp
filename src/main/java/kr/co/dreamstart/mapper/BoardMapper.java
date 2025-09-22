package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;

@Mapper
public interface BoardMapper {
	// 공지사항 / Q&A 전체 목록 조회
	public List<BoardPostDTO> boardList(String category);
	
	// 관리자 - 공지사항 작성
	
	//일반회원 - Q(질문) 작성
	
}
