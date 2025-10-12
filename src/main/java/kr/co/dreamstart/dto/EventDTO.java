package kr.co.dreamstart.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EventDTO {
    private Long eventId;
    private String title;
    private String description;
    private String location;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime endDate;
    private Integer capacity;
    private String status;      // OPEN, CLOSED, CANCELLED
    private String visibility;  // PUBLIC, PRIVATE, UNLISTED
    private String posterUrl;
    private Long createdBy;
    private String createdByName;	// 트리거가 채움 (읽기전용)
    private Long updatedBy;
    private String updatedByName;	// 트리거가 채움 (읽기전용)
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private boolean paid;
    private BigDecimal price;
    private String currency;
    private String category;
}
