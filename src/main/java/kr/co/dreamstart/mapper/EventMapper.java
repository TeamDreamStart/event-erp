package kr.co.dreamstart.mapper;

import java.util.List;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface EventMapper {
	// 이벤트 전체 목록 조회 + 내림차순
	public List<EventDTO> list(@Param("cri")Criteria cri);
	
}
