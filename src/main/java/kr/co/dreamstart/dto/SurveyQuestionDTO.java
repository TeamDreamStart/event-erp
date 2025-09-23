package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class SurveyQuestionDTO {
    private Long questionId;
    private Long surveyId;
    private String question;
    private QuestionType type;
    
    public enum QuestionType{SINGLE, MULTI, SCALE_5}; // DEFAULT : SINGLE
}
