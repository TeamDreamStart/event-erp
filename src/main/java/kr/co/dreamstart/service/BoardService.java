package kr.co.dreamstart.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.FileAssetDTO;

@Service
public interface BoardService {
	// 일반 사용자 리스트 + 조회수 + PUBLIC
	// 관리자 페이지 리스트 + 조회수 PUBLIC/PRIVATE
	public Map<String, Object> postList(Criteria cri, String category, String visibility, String searchType,
			String keyword);

	public Map<String,Object> postDetail(String category,long postId);
	
	
	//insert update delete
	public Map<String, Object> postInsert(HttpServletRequest request ,BoardPostDTO postDTO, MultipartFile[] uploadFile/* ,List<FileAssetDTO> fileList */);
	
	public Map<String, Object> postUpdate(HttpServletRequest request ,BoardPostDTO postDTO, MultipartFile[] uploadFile,List<Long> deleteFileId/* , List<FileAssetDTO> fileList */);
	
	//Public -> Private
	public Map<String,Object> postDelete(String boardId);
	
	//DB에서도 삭제
	public Map<String,Object> postRealDelete(String boardId);
}
