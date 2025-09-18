package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyAnswerDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;

@Mapper
public interface SurveyMapper {
//	설문메타
	public List<SurveyDTO> surveyAll();
	
//	결과
	public List<SurveyAnswerDTO> answerAll();
	
//	객관식
	public List<SurveyOptionDTO> optionAll();
	
//	문항리스트
	public List<SurveyQuestionDTO> questionAll();
	
//	응답이력
	public List<SurveyResponseDTO> responseAll();
}
