package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class AdminActionLogDTO {
    private long logId;
    private long adminId;
    private String targetType;
    private long targetId;
    private String action;
    private String reason;
    private String createdAt;
}
