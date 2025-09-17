package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class SurveyOptionDTO {
    private long optionId;
    private long questionId;
    private String label;
    private String optValue;
    private int sortOrder;
}
