package kr.co.dreamstart.service;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.FileAssetDTO;
import kr.co.dreamstart.mapper.EventMapper;
import kr.co.dreamstart.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class EventServiceImpl implements EventService {

	private final EventMapper eventMapper;
	private final FileService fileService;
	private final UserMapper userMapper;

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
		
		// 로그인 사용자 이름
		String loginName = (userId == null) ? null : userMapper.findNameById(userId);
		
		// 등록
		if (dto.getEventId() == null) { // 신규
			if (dto.getCreatedBy() == null) dto.setCreatedBy(userId);
			dto.setCreatedByName(loginName);
			dto.setUpdatedBy(null);
			dto.setUpdatedByName(null);
			return create(dto);
		} else {
			// 수정
			dto.setUpdatedBy(userId);
			dto.setUpdatedByName(loginName);			
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

	@Override
	public Long saveWithFiles(EventDTO dto, MultipartFile image, MultipartFile[] files, Long userId,
			HttpServletRequest request) {
		// TODO Auto-generated method stub
		// 1) 이벤트 메타 저장/수정
		Long id = save(dto, userId);
		
//		// 2) 파일 합쳐서 fileService에 위임 
//		List<MultipartFile> all = new ArrayList<>();
//		if (image != null && !image.isEmpty()) all.add(image);
//		if (files != null) {
//			for (MultipartFile f : files) {
//				if (f != null && !f.isEmpty()) {
//					all.add(f);
//				}
//			}
//		}
//		if (!all.isEmpty()) {
//			fileService.saveFiles(request, all.toArray(new MultipartFile[0]), "event", id);
//		}
		// 지은) 파일 서비스에서 파일 리스트를 순회해서 DB에 저장해 주기 때문에 그냥 멀티파트파일 배열 상태로 넘기면 됩니다
		//  
		if (files != null && files.length > 0) {
			// 비어있지 않은 경우
			fileService.saveFiles(request, files, "event", dto.getEventId());
		}
		
		
		// 3) 첫번째 이미지 파일을 대표로 지정 (없으면 패스)
		List<FileAssetDTO> saved = fileService.list("event", id);
		for (FileAssetDTO fa : saved) {
			if (fa.getMimeType() != null && fa.getMimeType().toLowerCase().startsWith("image")) {
				String coverUrl = "/resources/uploadTemp/" + fa.getStoredPath()+ "/"
								+ fa.getUuid() + "_" + fa.getOriginalName();
				setPosterUrl(id, coverUrl);
				break;
			}
		}
		
		
		return id;
	}

	@Override
	@Transactional
	public void deleteWithFiles(Long eventId) {
		// TODO Auto-generated method stub
		// 파일/db참조 먼저 정리
		fileService.deleteByOwner("EVENT", eventId);
		// 이벤트 삭제
		eventMapper.delete(eventId);
	}
	
	@Override
	@Transactional
	public void setPosterUrl(Long evenId, String posterUrl) {
		// TODO Auto-generated method stub
		eventMapper.updatePosterUrl(evenId, posterUrl);
		
	}

	// 30분 마다 자동 갱신
	@Override
	public int autoCloseExpiredEvents() {
		// TODO Auto-generated method stub
		return eventMapper.closeExpiredEvents();
	}
}
