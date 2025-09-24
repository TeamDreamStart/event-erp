package kr.co.dreamstart.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class SurveyDTO {
    private Long surveyId;
    private Long eventId;
    private String title;
    private String description;
    private SurveyStatus status;
    private boolean isAnonymous; // TINYINT
    private Long cloneFromSurveyId; // NULL 이면 클론 아님 (원본 사용한다는 의미임)
    private LocalDateTime openAt;
    private LocalDateTime closeAt;
    private Long createdBy;
    private LocalDateTime createdAt;
    private LocalDateTime updateAt;
    private boolean isTemplate;
    private String templateKey;
    
    public enum SurveyStatus {DRAFT, OPEN, CLOSED, ARCHIVED} // ENUM 정의
}
