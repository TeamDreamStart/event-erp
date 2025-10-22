package kr.co.dreamstart.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BoardPostDTO {
    private long postId;
    private String category;   // NOTICE, QNA
    private String title;
    private String content;
    private long userId;
    private int pinned;
    private String visibility;
    private int viewCount;
    private Date  createdAt;
    private Date  updatedAt;
    private String publishedAt;
    
    
    //댓글 개수
    private int commentCount;
    
    //사용자 화면에서 리스트에 댓글 표시
    private String commentContent;
    private String commentCreatedAt;
    
    
}
