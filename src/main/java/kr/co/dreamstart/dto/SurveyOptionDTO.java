package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class SurveyOptionDTO {
    private Long optionId;
    private Long questionId;
    private String label;
    private Integer optValue; // 1~5
}
