package kr.co.dreamstart.service;

import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.cj.x.protobuf.MysqlxCrud.Update;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.mapper.EventMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class EventServiceImpl implements EventService {

	private final EventMapper eventMapper;

	@Override
	public List<EventDTO> page(Criteria cri) {
		// TODO Auto-generated method stub
		return eventMapper.page(cri);
	}

	@Override
	public List<EventDTO> all() {
		// TODO Auto-generated method stub
		return eventMapper.all();
	}

	@Override
	public EventDTO findById(Long eventId) {
		// TODO Auto-generated method stub
		return eventMapper.findById(eventId);
	}
	
	@Override
	public int count(Criteria cri) {
		// TODO Auto-generated method stub
		return eventMapper.count(cri);
	}
	
	@Override
	@Transactional
	public Long save(EventDTO dto, Long userId) {
		// TODO Auto-generated method stub
		// 기본값 정의 및 가드
		if (dto.getStatus()== null) dto.setStatus("OPEN");
		if (dto.getVisibility() == null) dto.setVisibility("PUBLIC");
		if (dto.getCurrency() == null) dto.setCurrency("KRW");
		
		// 날짜 검증
		if (dto.getStartDate() != null && dto.getEndDate() != null &&
				dto.getEndDate().isBefore(dto.getStartDate())) {
			throw new IllegalArgumentException("EndDate가 StartDate보다 빠릅니다.");
		}
		
		// 등록
		if (dto.getEventId() == null) { // 신규
			if (dto.getCreatedBy() == null) dto.setCreatedBy(userId);
			dto.setUpdatedBy(null);
			return create(dto);
		} else {
			// 수정
			dto.setUpdatedBy(userId);
			update(dto);
			return dto.getEventId();
		}
	}

	@Override
	@Transactional
	public Long create(EventDTO dto) {
		// TODO Auto-generated method stub
		// 작성자 보증 (db 제약 위반 방지)
		if (dto.getCreatedBy() == null) {
			throw new IllegalStateException("createBy must not be null");
		}
		eventMapper.insert(dto);
		return dto.getEventId();
	}

	@Override
	@Transactional
	public int update(EventDTO dto) {
		// TODO Auto-generated method stub
		if (dto.getStartDate() != null && dto.getEndDate() != null &&
			dto.getEndDate().isBefore(dto.getStartDate())) {
			throw new IllegalArgumentException("EndDate가 StartDate보다 빠릅니다.");
		}
		return eventMapper.update(dto);
	}

	@Override
	@Transactional
	public int delete(Long eventId) {
		// TODO Auto-generated method stub
		return eventMapper.delete(eventId);
	}

	@Override
	public int closeExpiredEvents() {
		// TODO Auto-generated method stub
		return eventMapper.closeExpiredEvents();
	}
	
	
	// 30분마다 자동 마감 전환
	@Scheduled(cron = "0 */30 * * * *")
	public void autoCloseExpiredEvents() {
		int affected = closeExpiredEvents();
		if (affected > 0) {
			// 로그로 모니터링
			log.info("[Evnt] 자동 상태 전환(CLOSED) {}건", affected);
		}
		
	}
	
}
