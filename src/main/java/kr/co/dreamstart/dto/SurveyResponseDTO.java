package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class SurveyResponseDTO {
    private long responseId;
    private long surveyId;
    private long userId;
    private String respondedAt;
}
