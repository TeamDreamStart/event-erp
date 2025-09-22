package kr.co.dreamstart.mapper;

import java.util.List;
import kr.co.dreamstart.dto.EventDTO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EventMapper {
	// 이벤트 카테고리별 전체 목록 조회 내림차순
	public List<EventDTO> eventList(String category);
}
