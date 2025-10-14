package kr.co.dreamstart.mapper;

import java.time.LocalDateTime;
import java.util.List;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface EventMapper {
	// 페이지 페이징(만약 키워드/상태 필요시 파라미터로 확장)
	public List<EventDTO> page(@Param("cri") Criteria cri);
	
	// 전체 이벤트 목록
	public List<EventDTO> all();
	
	// 아이디로 단건 조회
	public EventDTO findById(@Param("eventId") Long eventId);
	
	// 이벤트 총건수
	public int count(@Param("cri") Criteria cri);
	
	// 생성/수정/삭제
	public int insert(EventDTO dto);
	public int update(EventDTO dto);
	public int delete(@Param("eventId") Long eventId);
	
	// Payment 테스트용으로 임시로 만들었음
	public EventDTO selectByEventId(long eventId);
	// 이벤트 종료 시각 조회
	public LocalDateTime findEndDateByEventId(@Param("eventId") Long eventId);
	
	// 자동 상태 전환(이벤트 종류후 설문조사 오픈을 위해)
	// end_date 지난 open 이벤트를 closed로 일괄 전환하고 영양 건수 리턴
	public int closeExpiredEvents();
	
	// 대표 이미지 경로만 업데이트
	public int updatePosterUrl(@Param("eventId") Long eventId,
							@Param("posterUrl") String posterUrl);

}
