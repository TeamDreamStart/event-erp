package kr.co.dreamstart.dto;

import java.util.List;
import lombok.Data;

@Data
public class CloneInlineReqDTO {
    private Long templateId;
    private Long eventId;
    private Long userId;

    private String scheduleMode;     // "default" | "offset"
    private Integer openDelayHours;  // N
    private Integer closeAfterDays;  // M

    // (선택) 헤더 오버라이드
    private String title;
    private String description;
    private Integer isAnonymous;     // 1/0

    // (선택) 에디터에서 보낸 문항/보기
    private List<Q> questions;

    @Data
    public static class Q {
        private String type;           // single|multi|text
        private String question;
        private List<O> options;       // text면 null/빈배열
    }

    @Data
    public static class O {
        private String label;
        private String optValue;
    }
}
