package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class SurveyAnswerDTO {
    private long answerId;
    private long responseId;
    private long questionId;
    private long optionId;    // nullable
    private String answerText;
}
