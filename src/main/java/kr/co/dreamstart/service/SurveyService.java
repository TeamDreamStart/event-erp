package kr.co.dreamstart.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

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
	
	// 상세조회 (이벤트 제목 포함)
	public String findEventTitleBySurveyId(Long surveyId);
	
	// 응답
	public List<SurveyResponseDTO> responseList(Long surveyId, Criteria cri);
	public int responseCount(Long surveyId);
	public List<Map<String, Object>> responseDetailFlat(Long responseId);
	
	// 유지보수/수정
	public int updateSurveyHeader(Long surveyId, String title,
								String description, Integer isAnonymous);
	
	// 상위 유즈케이스 - 헤더 만들고 -> 새 surveyId 받기 -> 원본 문항/보기 전부 복제 (클론 헤더+QA복제/JSON 인라인 복제)
	public Long cloneFromTemplate(Long templateId, Long eventId, Long userId, CloneInlineReqDTO.SurveyStatus status);
	public Long cloneInline(CloneInlineReqDTO req, Long userId);
	
	// 응답없고, 클론인 설문 삭제
	public int deleteCloneSurvey(Long surveyId);
	
	// 문항/응답 통계
	public List<Map<String, Object>> surveyStatus(Long surveyId);
	
	// 생성자 userId -> name
	public String findUserNameById(@Param("userId") Long useeId);
	// 이벤트 예약지 카운트 : 설문 -> 이벤트 역참조
	public int applicantCountBySurvey(@Param("surveyId") Long surveyId);
	//상단 카드용 응답률
	public Map<String, Object> topRate(@Param("surveyId") Long surveyId);
	// 문항별 통계(분모) : 매우나쁨~매우좋음 가로바 + 퍼센트/응답자수, 모수 = 이벤트신청자수
	public List<Map<String, Object>> surveyStatusAgainstApplicants(@Param("surveyId") Long surveyId);
	
	// 폼 진입용프리필/사전선택 계산
	public Map<String, Object> cloneFormPrefill(Long templateId, Long eventId, Long surveyId);
	
	// 고정템플릿인지 확인하기 위해
	public boolean isTemplate(Long surveyId);
	
	// Likert(클른문항) 보정이 필요할때만 노출
//	public int ensureLikert5ForSurvey(Long surveyId);
}
