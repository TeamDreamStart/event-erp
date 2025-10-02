package kr.co.dreamstart.service;

import java.util.List;
import java.util.Map;

import kr.co.dreamstart.dto.CloneInlineReqDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;

public interface SurveyService {
	// 고정템플릿/리스트/카운트
	public List<SurveyDTO> fixedTemplates();
	public List<SurveyDTO> surveyPage(Long eventId, Criteria cri, 
									String keyword, String field, Integer anon);
	public int surveyCount(Long eventId, String keyword, String field,
						Integer anon);
	
	// 상세조회
	public SurveyDTO findSurvey(Long surveyId);
	public List<SurveyQuestionDTO> questionList(Long surveyId);
	public List<SurveyOptionDTO> optionList(Long surveyId);
	public Map<Long, List<SurveyOptionDTO>> optionsByQuestion (Long surveyId);
	
	// 응답
	public List<SurveyResponseDTO> responseList(Long surveyId, Criteria cri);
	public int responseCount(Long surveyId);
	public List<Map<String, Object>> responseDetailFlat(Long responseId);
	
	// 유지보수/수정
	public int updateSurveyHeader(Long surveyId, String title,
								String description, Integer isAnonymous);
	
	// 상위 유즈케이스 - 헤더 만들고 -> 새 surveyId 받기 -> 원본 문항/보기 전부 복제 (클론 헤더+QA복제/JSON 인라인 복제)
	public Long cloneFromTemplate(Long templateId, Long eventId, Long userId);
	public Long cloneInline(CloneInlineReqDTO req);
	
	// Likert(클른문항) 보정이 필요할때만 노출
//	public int ensureLikert5ForSurvey(Long surveyId);
}
