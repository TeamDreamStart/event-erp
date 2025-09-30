package kr.co.dreamstart.mapper;

import java.util.List;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface EventMapper {
	// 이벤트 페이징 버전
	public List<EventDTO> list(@Param("cri")Criteria cri);
	
	// 전체 이벤트 목록(드롭다운용)
	public List<EventDTO> eventAll();
	
	// 신규이벤트등록
	public int insert(EventDTO dto);
	
	
}
