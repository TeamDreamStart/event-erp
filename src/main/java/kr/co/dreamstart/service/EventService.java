package kr.co.dreamstart.service;

import java.util.List;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;

public interface EventService {
	// 목록 페이징
	public List<EventDTO> page(Criteria cri);
	// 전체 목록
	public List<EventDTO> all();
	// 아이디로 단건 조회
	public EventDTO findById(Long eventId);
	
	// 총건수
	public int count(Criteria cri);
	
	// 저장/생성/수정/삭제
	public Long save(EventDTO dto, Long userId);
	public Long create(EventDTO dto); // 생성후 pk 반환
	public int update(EventDTO dto);
	public int delete(Long eventId);
	
	// 자동 상태 전환
	public int closeExpiredEvents();
}
