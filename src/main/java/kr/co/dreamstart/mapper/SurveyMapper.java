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
//	������Ÿ
	public List<SurveyDTO> surveyAll();
	
//	���
	public List<SurveyAnswerDTO> answerAll();
	
//	������
	public List<SurveyOptionDTO> optionAll();
	
//	���׸���Ʈ
	public List<SurveyQuestionDTO> questionAll();
	
//	�����̷�
	public List<SurveyResponseDTO> responseAll();
}
