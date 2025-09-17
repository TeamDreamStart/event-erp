package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class ReservationDTO {
    private long reservationId;
    private long userId;
    private long eventId;
    private String reservationDate;
    private String status;      // PENDING, CONFIRMED, CANCELLED
    private String qrCode;
    private int headcount;
    private String cancelReason;
    private String cancelledAt;
}
