package kr.co.dreamstart.dto;

import java.time.LocalDateTime;
import java.util.List;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class CloneInlineReqDTO {

    @NotNull private Long templateId;
    @NotNull private Long eventId;
    private Long userId;
    @NotNull private SurveyStatus status;
    
    // 클론된 설문의 새로운 surveyId
    private Long newSurveyId;

    // ★ 프론트에서 입력한 새 설문 제목
    @NotBlank private String title;
    private String description;
    private Integer isAnonymous;

    // 스케줄 UI 값
    private String scheduleMode;     // "default" | "offset"
    private Integer openDelayHours;  // N시간
    private Integer closeAfterDays;  // M일

    // 최종 DB로 넣을 값 (MyBatis에서 #{openAt}, #{closeAt} 씀)
    private LocalDateTime openAt;
    private LocalDateTime closeAt;
    
    // 질문 + 옵션 묶음
    @Valid
    private List<QuestionPayLoadDTO> questions;
    
    public enum SurveyStatus { DRAFT, OPEN, CLOSED, ARCHIVED };
}
