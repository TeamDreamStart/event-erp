package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class SurveyDTO {
    private long surveyId;
    private long eventId;
    private String title;
    private String description;
    private boolean isAnonymous;
    private String openFrom;
    private String openTo;
    private String createdAt;
}
