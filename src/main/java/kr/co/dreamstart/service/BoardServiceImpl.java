package kr.co.dreamstart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.FileAssetDTO;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.mapper.BoardMapper;
import kr.co.dreamstart.mapper.FileAssetMapper;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private FileAssetMapper fileMapper;

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
			postList = mapper.postSearch(cri,visibility,category, searchType, keyword);
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
		BoardPostDTO postDTO = mapper.select(category,postId);
		// 이전글
		BoardPostDTO prevDTO = mapper.selectPrev(category, postId);
		// 다음글
		BoardPostDTO nextDTO = mapper.selectNext(category, postId);
		List<FileAssetDTO> fileList = fileMapper.select("board_post", postId);
		map.put("postDTO", postDTO);
		map.put("prevDTO", prevDTO);
		map.put("nextDTO", nextDTO);
		map.put("fileList",fileList);
		return map;
	}

}
