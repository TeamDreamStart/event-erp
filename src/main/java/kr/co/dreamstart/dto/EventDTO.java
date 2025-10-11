package kr.co.dreamstart.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class EventDTO {
    private long eventId;
    private String title;
    private String description;
    private String location;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private int capacity;
    private String status;      // OPEN, CLOSED, CANCELLED
    private String visibility;  // PUBLIC, PRIVATE, UNLISTED
    private String posterUrl;
    private long createdBy;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private boolean isPaid;
    private BigDecimal price;
    private String currency;
    private String category;
}
