package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class BoardPostDTO {
    private long postId;
    private String category;   // NOTICE, QNA
    private String title;
    private String content;
    private long userId;
    private boolean isPinned;
    private String visibility;
    private int viewCount;
    private String createdAt;
    private String updatedAt;
}
