package kr.co.dreamstart.service;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.dreamstart.dto.CloneInlineReqDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.QuestionPayLoadDTO;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;
import kr.co.dreamstart.mapper.EventMapper;
import kr.co.dreamstart.mapper.SurveyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SurveyServiceImpl implements SurveyService {
	@Autowired
	private SurveyMapper surveyMapper;
	
	@Autowired
	private EventMapper eventMapper;
	
	// 조회/유지보수
	@Override
	public List<SurveyDTO> fixedTemplates() {
		// TODO Auto-generated method stub
		return surveyMapper.fixedTemplates();
	}

	@Override
	public List<SurveyDTO> surveyPage(Long eventId, Criteria cri, String keyword, String field, Integer anon) {
		// TODO Auto-generated method stub
		return surveyMapper.surveyPage(eventId, cri, keyword, field, anon);
	}

	@Override
	public int surveyCount(Long eventId, String keyword, String field, Integer anon) {
		// TODO Auto-generated method stub
		return surveyMapper.surveyCount(eventId, keyword, field, anon);
	}

	@Override
	public SurveyDTO findSurvey(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.findSurvey(surveyId);
	}

	@Override
	public List<SurveyQuestionDTO> questionList(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.questionList(surveyId);
	}

	@Override
	public List<SurveyOptionDTO> optionList(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.optionList(surveyId);
	}

	@Override
	public Map<Long, List<SurveyOptionDTO>> optionsByQuestion(Long surveyId) {
		// TODO Auto-generated method stub
		Map<Long, List<SurveyOptionDTO>> map = new LinkedHashMap<>();
		
		for (SurveyQuestionDTO q : questionList(surveyId)) {
			map.put(q.getQuestionId(), optionList(q.getQuestionId()));
		}
		return map;
	}

	// 응답
	@Override
	public List<SurveyResponseDTO> responseList(Long surveyId, Criteria cri) {
		// TODO Auto-generated method stub
		return surveyMapper.responseList(surveyId, cri);
	}

	@Override
	public int responseCount(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.responseCount(surveyId);
	}

	@Override
	public List<Map<String, Object>> responseDetailFlat(Long responseId) {
		// TODO Auto-generated method stub
		return surveyMapper.responseDetailFlat(responseId);
	}

	// 유지보수
	@Override
	public int updateSurveyHeader(Long surveyId, String title, String description, Integer isAnonymous) {
		// TODO Auto-generated method stub
		return surveyMapper.updateSurveyHeader(surveyId, title, description, isAnonymous);
	}

	// 클론1 - 템플릿 전체 복제(헤더 + 문항 + 보기)
	@Override
	@Transactional(rollbackFor = Exception.class) // 정상 종료 = 커밋, 예외 = 롤백
	public Long cloneFromTemplate(Long templateId, Long eventId, Long userId, CloneInlineReqDTO.SurveyStatus status) {
		// TODO Auto-generated method stub

		// 1) 헤더복제
		CloneInlineReqDTO req = new CloneInlineReqDTO();
		req.setTemplateId(templateId);
		req.setEventId(eventId);
		req.setUserId(userId);
		req.setStatus(status == null ? CloneInlineReqDTO.SurveyStatus.OPEN : status);
		
		int header = surveyMapper.cloneSurvey(req);
		if (header != 1) throw new IllegalStateException("설문 헤더 클론 실패!"); 
		
		// 2) new survey_id
		Long newSurveyId = req.getNewSurveyId();
		if (newSurveyId == null || newSurveyId <= 0) {
			throw new IllegalStateException("신규 설문 id 조회 실패 !");
		}
		log.info("[cloneFromTemplate] newSurveyId={}", newSurveyId);
		
		// 3) 원본 템플릿 문항 조회
		List<SurveyQuestionDTO> questionDTO = surveyMapper.questionList(templateId);

		// 4) 문항/보기 복제
		for (SurveyQuestionDTO q : questionDTO) {
			// 새문항
			SurveyQuestionDTO nq = new SurveyQuestionDTO();
			nq.setSurveyId(newSurveyId);
			nq.setQuestion(q.getQuestion());
			nq.setType(q.getType());
			surveyMapper.insertQuestion(nq); // useGeneratedKeys 로 questionId 채워짐
			Long newQuestionId = nq.getQuestionId();

			// 보기복제
			List<SurveyOptionDTO> options = surveyMapper.optionList(q.getQuestionId());
			for (SurveyOptionDTO o : options) {
				SurveyOptionDTO nop = new SurveyOptionDTO();
				nop.setQuestionId(newQuestionId);
				nop.setLabel(o.getLabel());
				nop.setOptValue(o.getOptValue());
				surveyMapper.insertOption(nop);
			}
		}

		// 복제 성공 -> 모달로 성공 보여주고 목록으로 이동 시킴
		return newSurveyId;

	}

	// 클론2 - 인라인 JSON을 새 설문으로 복제
	// controller에서 json을 dto들로 변환해 넘겨줌
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Long cloneInline(CloneInlineReqDTO req, Long userId) {
		// TODO Auto-generated method stub
		// 0) 작성자
		req.setUserId(userId != null ? userId : 1L);
		
		// 1) 이벤트 종료시각 조회 (eventMapper or surveyMapper에서)
		LocalDateTime eventEnd = eventMapper.findEndDateByEventId(req.getEventId());
		if (eventEnd == null) throw new IllegalStateException("이벤트 시각이 없습니다.");
		
		// 2) open/close 계산
		if ("offset".equalsIgnoreCase(req.getScheduleMode())) {
			int h = (req.getOpenDelayHours() == null ? 0 : req.getOpenDelayHours());
			int d = (req.getCloseAfterDays() == null ? 7 : req.getCloseAfterDays());
			req.setOpenAt(eventEnd.plusHours(h));
			req.setCloseAt(req.getOpenAt().plusDays(d));
		} else {
			// deflut : 종료 즉시 오픈, 7일후 종료
			req.setOpenAt(eventEnd);
			req.setCloseAt(eventEnd.plusDays(7));
		}
		
		// 3) status 기본값
		if (req.getStatus() == null) req.setStatus(CloneInlineReqDTO.SurveyStatus.DRAFT);
		
		// 4) 헤더복제
		int header = surveyMapper.insertSurveyHeaderFromInline(req);
		if (header != 1) throw new IllegalStateException("설문 헤더 클론 실패");
		
		// 5) new sueveyId
		Long newSurveyId = req.getNewSurveyId();
		if (newSurveyId == null || newSurveyId <= 0) {
			throw new IllegalStateException("신규 설문 id 조회 실패");
		}
		log.info("[cloneInline] newSurveyId={}", newSurveyId);
		
		// 6) 문항/보기 insert (newSurveyId 사용)
		if (req.getQuestions() != null) {
			for (QuestionPayLoadDTO q : req.getQuestions()) {
				// 요청용 DTO(QuestionPayLoadDTO) -> 저장용DTO(SurveyQuestionDTO)
				SurveyQuestionDTO nq = new SurveyQuestionDTO();
				nq.setSurveyId(newSurveyId);
				nq.setQuestion(q.getQuestion());
				// 타입 기본/정규화
				SurveyQuestionDTO.QuestionType type = 
						(q.getType() == null ? SurveyQuestionDTO.QuestionType.SCALE_5 : q.getType());
				nq.setType(type);
				
				// required 기본값을 Boolean으로 명시
				// 제약(chk_required_vs_type) 회피: null 금지, TEXT도 false 허용으로 처리
				Boolean reqRequired = (type != SurveyQuestionDTO.QuestionType.TEXT);
 				nq.setRequired(Boolean.valueOf(reqRequired));
				
				surveyMapper.insertQuestion(nq);
				Long newQuestionId = nq.getQuestionId();
				
				// 옵션
				if (q.getOptions() != null) {
					for (SurveyOptionDTO o : q.getOptions()) {
						SurveyOptionDTO nop = new SurveyOptionDTO();
						nop.setQuestionId(newQuestionId);	// 새 문항 ID로 매핑
						nop.setLabel(o.getLabel());
						nop.setOptValue(o.getOptValue());
						surveyMapper.insertOption(nop);
					}
				}
			}
		}
		
		return newSurveyId;
	}

	// 설문삭제
	@Override
	public int deleteCloneSurvey(Long surveyId) {
		// TODO Auto-generated method stub
		// 응답이 있으면 0, 없으면 삭제
		int d1 = surveyMapper.deleteCloneOptions(surveyId);
		int d2 = surveyMapper.deleteCloneQuestions(surveyId);
		int d3 = surveyMapper.deleteCloneSurvey(surveyId);
		
		return d1 + d2 + d3;
	}

	// 설문상세(이벤트제목포함용)
	@Override
	public String findEventTitleBySurveyId(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.findEventTitleBySurveyId(surveyId);
	}

	// 문항/옵션 통계용 (응답자수 + 퍼센트지화)
	@Override
	public List<Map<String, Object>> surveyStatus(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.surveyStatus(surveyId);
	}

	@Override
	public String findUserNameById(Long useeId) {
		// TODO Auto-generated method stub
		return surveyMapper.findUserNameById(useeId);
	}

	@Override
	public int applicantCountBySurvey(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.applicantCountBySurvey(surveyId);
	}

	@Override
	public Map<String, Object> topRate(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.topRate(surveyId);
	}

	@Override
	public List<Map<String, Object>> surveyStatusAgainstApplicants(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.surveyStatusAgainstApplicants(surveyId);
	}

	@Override
	public Map<String, Object> cloneFormPrefill(Long templateId, Long eventId, Long surveyId) {
		// TODO Auto-generated method stub
		Long selectedTemplateId = templateId;
		Long selectedEventId = eventId;
		String prefillTitle = "";	// 템플릿 제목
		String prefillDesc = "";	// 템플릿 설명
		
		if (surveyId != null) {
			// 상세->수정 진입 :  해당 설문 정보로 프리필/선택 세팅
			SurveyDTO s = findSurvey(surveyId);
			if (s != null) {
				if (s.getEventId() != null) selectedEventId = s.getEventId();
				// 원본 템플릿 id가 있으면 사용(없으면 그대로 둠)
				if (s.getCloneFromSurveyId() != null) selectedTemplateId = s.getCloneFromSurveyId();
				prefillTitle = s.getTitle();
				prefillDesc = s.getDescription();
			}
		}
		
		Map<String, Object> out = new LinkedHashMap<>();
		out.put("selectedTemplateId", selectedTemplateId);
		out.put("selectedEventId", selectedEventId );
		out.put("prefillTitle", prefillTitle);
		out.put("prefillDesc", prefillDesc);
		
		return out;
	}

//	@Override
//	public int ensureLikert5ForSurvey(Long surveyId) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
}
