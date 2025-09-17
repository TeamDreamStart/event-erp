package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class SurveyQuestionDTO {
    private long questionId;
    private long surveyId;
    private String question;
    private String type;      // TEXT, MULTIPLE, SINGLE
    private int sortOrder;
}
