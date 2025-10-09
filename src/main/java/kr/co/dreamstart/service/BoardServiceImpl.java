package kr.co.dreamstart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.FileAssetDTO;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.mapper.BoardMapper;
import kr.co.dreamstart.mapper.FileAssetMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardMapper mapper;

	@Autowired
	private FileAssetMapper fileMapper;

	@Autowired
	private FileService fileService;

	@Override
	public Map<String, Object> postList(Criteria cri, String category, String visibility, String searchType,
			String keyword) {
		Map<String, Object> map = new HashMap<>();
		List<BoardPostDTO> postList = null;
		int totalPostCount = mapper.postCount(visibility, category);
		// 검색 안할시
		if (keyword == null || keyword.isEmpty()) {
			postList = mapper.postList(cri, visibility, category);
			totalPostCount = mapper.postCount(visibility, category);
		} else {
			// 검색어 공백 제거 처리
			keyword = keyword.replaceAll("\\s", "");
			postList = mapper.postSearch(cri, visibility, category, searchType, keyword);
			// 페이징 처리하기 위해 검색된 게시물 갯수만 받아옴
			totalPostCount = mapper.postSearchCount(visibility, category, searchType, keyword);
		}
		// 페이징 처리를 위한 객체
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(totalPostCount);
		// 현재 페이지가 총 페이지보다 크면 마지막 페이지로 보정
		if (cri.getPage() > pageVO.getTotalPage()) {
			cri.setPage(pageVO.getTotalPage() > 0 ? pageVO.getTotalPage() : 1);
		}
		map.put("totalCount", totalPostCount);
		map.put("postList", postList);
		map.put("pageVO", pageVO);
		map.put("cri", cri);

		return map;
	}

	@Override
	public Map<String, Object> postDetail(String category, long postId) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 조회수 증가
		mapper.viewCountPlus(postId);
		// 현재 게시물
		BoardPostDTO postDTO = mapper.select(category, postId);
		// 이전글
		BoardPostDTO prevDTO = mapper.selectPrev(category, postId);
		// 다음글
		BoardPostDTO nextDTO = mapper.selectNext(category, postId);
		map.put("postDTO", postDTO);
		map.put("prevDTO", prevDTO);
		map.put("nextDTO", nextDTO);
		// 해당 글 파일리스트
		List<FileAssetDTO> fileList = fileMapper.list("board_post", postId);
		map.put("fileList", fileList);

		List<BoardCommentDTO> commentList = mapper.commentList(postId);
		map.put("commentList", commentList);

		return map;
	}

	@Transactional
	@Override
	public Map<String, Object> postInsert(HttpServletRequest request, BoardPostDTO postDTO,
			MultipartFile[] uploadFile) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = -1;
		result = mapper.postInsert(postDTO);
		if (result > 0) {
			if (uploadFile != null && uploadFile.length > 0) {
				// 비어있지 않은 경우
				fileService.saveFiles(request, uploadFile, "board_post", postDTO.getPostId());
			}
			map.put("result", "success");
			map.put("postId", postDTO.getPostId());
		} else {
			map.put("result", "fail");
		}
		return map;
	}

	public Map<String, Object> postUpdate(HttpServletRequest request, @ModelAttribute BoardPostDTO postDTO,
			@RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = -1;
		// 수정한 게시물
		result = mapper.postUpdate(postDTO);
		if (result > 0) {
			map.put("result", "success");
		} else {
			map.put("result", "fail");
		}
		return map;
	}

	@Override
	public int postDelete(long boardId) {
		int result = -1;

		return result;
	}

	@Override
	public Map<String, Object> postRealDelete(String boardType, long postId) {
	    Map<String, Object> map = new HashMap<>();
	    int result = mapper.postDelete(postId);

	    if (result > 0) {
	        // QNA인 경우 댓글도 삭제
	        if (boardType.equals("qna")) {
	            if (mapper.commentCount(postId) > 0) {
	                mapper.commentDeleteByPostId(postId);
	            }
	        }
	        map.put("result", "success");
	        log.info("[BoardService] DELETE SUCCESS POSTID : "+postId);
	    } else {
	        map.put("result", "fail");
	        log.warn("[BoardService] DELETE FAIL POSTID : "+postId);
	    }

	    return map;
	}


	@Override
	public List<BoardCommentDTO> commentList(long postId) {
		return mapper.commentList(postId);
	}

	@Override
	public int commentInsert(BoardCommentDTO commentDTO) {
		return mapper.commentInsert(commentDTO);
	}

	@Override
	public int commentDelete(long commentId) {
		return mapper.commentDelete(commentId);
	}

}
