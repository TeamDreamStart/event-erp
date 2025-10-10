package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class SurveyQuestionDTO {
    private Long questionId;
    private Long surveyId;
    private String question;
    private QuestionType type = QuestionType.SCALE_5; // 기본값 정의
    private Boolean required = true;	// 정의값
    private Boolean	effectiveRequired;	// 계산값(READ-ONLY, DB GENERATED)
    
    public enum QuestionType{SINGLE, MULTI, SCALE_5, TEXT; // DEFAULT : SCALE_5
    	@com.fasterxml.jackson.annotation.JsonCreator
    	public static QuestionType from (String raw) {
    		if (raw == null)return null;
    		return QuestionType.valueOf(raw.trim().toUpperCase()); // 소문자 입력시 대문자 변환 (json)
    	}
    }
}
