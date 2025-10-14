package kr.co.dreamstart.dto;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class EventDTO {
    private long eventId;
    private String title;
    private String description;
    private String location;
    private String startDate;
    private String endDate;
    private int capacity;
    private String status;      // OPEN, CLOSED, CANCELLED
    private String visibility;  // PUBLIC, PRIVATE, UNLISTED
    private String posterUrl;
    private long createdBy;
    private String createdAt;
    private String updatedAt;
    private boolean isPaid;
    private BigDecimal price;
    private String currency;
    private String category;
    
    //주소로 받아오는 위도, 경도
    private BigDecimal latitude;
    private BigDecimal longitude;
}
