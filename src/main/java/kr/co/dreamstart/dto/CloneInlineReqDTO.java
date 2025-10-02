package kr.co.dreamstart.dto;

import java.util.List;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class CloneInlineReqDTO {

    @NotNull private Long templateId;
    @NotNull private Long eventId;
    @NotNull private Long userId;

    // ★ 프론트에서 입력한 새 설문 제목
    @NotBlank(message = "제목은 필수입니다.")
    private String title;

    // ★ 스케줄 옵션 (기본: default / 오프셋: offset)
    private String scheduleMode;      // "default" | "offset"
    private Integer openDelayHours;   // offset일 때만 사용 (nullable 허용)
    private Integer closeAfterDays;   // offset일 때만 사용 (nullable 허용)

    // 질문 + 옵션 묶음
    @Valid
    private List<QuestionPayLoadDTO> questions;
}
