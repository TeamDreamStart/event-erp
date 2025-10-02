package kr.co.dreamstart.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.dreamstart.dto.CloneInlineReqDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.QuestionPayLoadDTO;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;
import kr.co.dreamstart.mapper.SurveyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SurveyServiceImpl implements SurveyService {
	private final SurveyMapper surveyMapper;
	
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
	public Long cloneFromTemplate(Long templateId, Long eventId, Long userId) {
		// TODO Auto-generated method stub
		log.info("[/survey-test/clone] templateId={}, eventId={}, userId={}", 
				templateId, eventId, userId);

		// 1) 헤더복제
		int header = surveyMapper.cloneSurvey(templateId, eventId, userId);
		if (header != 1) throw new IllegalStateException("설문 헤더 클론 실패!"); 
		
		// 2) new survey_id
		Long newSurveyId = surveyMapper.lastInsertId();
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
	public Long cloneInline(CloneInlineReqDTO req) {
		// TODO Auto-generated method stub
		// 1) 헤더복제
		int header = surveyMapper.cloneSurvey(req.getTemplateId(),
												req.getEventId(),
												req.getUserId());
		if (header != 1) throw new IllegalStateException("설문 헤더 클론 실패");
		
		// 2) new sueveyId
		Long newSurveyId = surveyMapper.lastInsertId();
		log.info("[cloneInline] newSurveyId={}", newSurveyId);
		
		// 3) 문항/보기 변환 + 삽입(요청DTO -> 저장용DTO)
		if (req.getQuestions() != null) {
			for (QuestionPayLoadDTO q : req.getQuestions()) {
				// 요청용 DTO(QuestionPayLoadDTO) -> 저장용DTO(SurveyQuestionDTO)
				SurveyQuestionDTO nq = new SurveyQuestionDTO();
				nq.setSurveyId(newSurveyId);
				nq.setQuestion(q.getQuestion());
				nq.setType(q.getType() == null
							? SurveyQuestionDTO.QuestionType.SCALE_5
							: q.getType());
				surveyMapper.insertQuestion(nq);
				Long newQuestionId = nq.getQuestionId();
				
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

//	@Override
//	public int ensureLikert5ForSurvey(Long surveyId) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
}
