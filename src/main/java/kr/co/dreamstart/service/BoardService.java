package kr.co.dreamstart.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.FileAssetDTO;

@Service
public interface BoardService {
	// 일반 사용자 리스트 + 조회수 + PUBLIC
	// 관리자 페이지 리스트 + 조회수 PUBLIC/PRIVATE
	public Map<String, Object> postList(Criteria cri, String category, String visibility, String searchType,
			String keyword);

	public Map<String, Object> postDetail(String category, long postId);

	// insert update delete
	public Map<String, Object> postInsert(HttpServletRequest request, BoardPostDTO postDTO,
			MultipartFile[] uploadFile);

	public Map<String, Object> postUpdate(HttpServletRequest request ,@ModelAttribute BoardPostDTO postDTO, 
			 @RequestParam(value="uploadFile", required=false)MultipartFile[] uploadFile);
	//Public -> Private
//	public int postDelete(long postId);

	// DB에서도 삭제
	public Map<String, Object> postRealDelete(String boardType,long postId);

	// 댓글
	public List<BoardCommentDTO> commentList(long postId);

	public int commentInsert(BoardCommentDTO commentDTO);

	public int commentDelete(long commentId);
	
	public List<BoardPostDTO> selectPostByUserID(long userId);
//	public int commentDeleteByPostId(long postId);
}
