package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class PaymentDTO {
    private long paymentId;
    private long reservationId;
    private double amount;
    private String method;     // CARD, KAKAO, NAVER, BANK
    private String status;     // PAID, REFUNDED, FAILED, CANCELLED
    private String paidAt;
    private String cancelledAt;
    private Double refundAmount;
    private String approveNo;
    private String pgTid;
    private String memo;
    private String createdAt;
}
