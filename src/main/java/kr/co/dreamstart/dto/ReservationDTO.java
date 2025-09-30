package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class ReservationDTO {
    private long reservationId;
    private String userType; // USER, GUEST
    private long userId;
    private long eventId;
    private String reservationDate;
    private String status;      // PENDING, CONFIRMED, CANCELLED
    private String qrCode;
    private int headCount;
    private String cancelReason;
    private String cancelledAt;
}
