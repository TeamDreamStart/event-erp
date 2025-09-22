package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class SurveyDTO {
    private long surveyId;
    private long eventId;
    private String title;
    private String description;
    private boolean isAnonymous;
    private String openAt;
    private String closeAt;
    private long createdBy;
    private String createdAt;
    private String updateAt;
    private int isTemplate;
    private String templateKey;
}
