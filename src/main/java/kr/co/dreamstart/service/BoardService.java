package kr.co.dreamstart.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.Criteria;

@Service
public interface BoardService {
	// 일반 사용자 리스트 + 조회수 + PUBLIC
	// 관리자 페이지 리스트 + 조회수 PUBLIC/PRIVATE
	public Map<String, Object> postList(Criteria cri, String category, String visibility, String searchType,
			String keyword);

	public Map<String,Object> postDetail(String category,long postId);
}
