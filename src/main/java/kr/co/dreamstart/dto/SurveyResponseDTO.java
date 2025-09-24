package kr.co.dreamstart.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class SurveyResponseDTO {
    private Long responseId;
    private Long surveyId;
    private Long userId;
    private LocalDateTime respondedAt; // DEFAULT CURRENT_TIMESTAMP
}
