package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class BoardCommentDTO {
    private long commentId;
    private long postId;
    private long userId;
    private String content;
    private Long parentId;   // nullable
    private String createdAt;
}
