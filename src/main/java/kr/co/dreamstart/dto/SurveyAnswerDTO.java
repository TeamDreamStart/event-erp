package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class SurveyAnswerDTO {
    private Long answerId;
    private Long responseId;
    private Long questionId;
    private Long optionId;    // nullable
    private String answerText;
}
