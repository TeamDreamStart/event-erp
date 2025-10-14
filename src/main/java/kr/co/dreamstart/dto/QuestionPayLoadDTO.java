/*
 * 인라인 클론 요청에서 들어오는 질문+옵션 한묶움
 * DB 엔티티아님 API 바인딩 용임
 */

package kr.co.dreamstart.dto;

import java.util.List;

import lombok.Data;

@Data
public class QuestionPayLoadDTO {
	private String question;
	
	// JSON : SINGLE/MULTI/SCALE_5 (없으면 서비스에서 기본값 처리)
	private SurveyQuestionDTO.QuestionType type;
	
	// 기존 surveyOptionDTO 재사용 (label, optValue)
	private List<SurveyOptionDTO> options;
}
