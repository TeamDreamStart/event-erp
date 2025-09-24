package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.SurveyAnswerDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;

@Mapper
public interface SurveyMapper {	
//	설문목록조회 (이벤트 필터 + 페이징)
	public List<SurveyDTO> surveyPage(@Param("eventId") Long eventId,
									@Param("cri") Criteria cri);
	int surveyCount(@Param("eventId") Long eventId);
	
//	설문문항 (설문기준)	
//	public List<SurveyQuestionDTO> questionList(@Param("surveyId") Long surveyId);
	
//	보기 (문항기준)
//	public List<SurveyOptionDTO> optionList(@Param("questionId") Long questionId);
	
//	응답이력 (설문기준, 페이징)
//	public List<SurveyResponseDTO> responseList(@Param("surveyId") Long surveyId,
//												@Param("cri") Criteria cri);
//	int reponseCount(@Param("surveyId") Long surveyId);
	
//	응답결과
//	public List<SurveyAnswerDTO> answerList(@Param("responseId") Long responseId);
	
	
	
//	테스트용
//	설문조회
	public List<SurveyDTO> surveyAll();
//	응답결과
	public List<SurveyAnswerDTO> answerAll();
//	설문보기
	public List<SurveyOptionDTO> optionAll();
//	설문문항
	public List<SurveyQuestionDTO> questionAll();
//	응답이력
	public List<SurveyResponseDTO> responseAll();
}
