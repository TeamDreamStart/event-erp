package kr.co.dreamstart.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class PaymentDTO {
    private long paymentId;
    private long reservationId;
    private String method;     // CARD, KAKAO, NAVER, BANK
    private String status;     // PAID, REFUNDED, FAILED, CANCELLED
    private BigDecimal amount;
    private BigDecimal refundAmount;
    private String approveNo;
    private String pgTid;
    private String memo;
    private LocalDateTime paidAt;
    private LocalDateTime cancelledAt;
    private LocalDateTime createdAt;
    
    //포트원 api 고유ID
    private String impUid;
//    
//    public enum PaymentMethod { CARD, KAKAO, NAVER, BANK }
//    public enum PaymentStatus { PAID, REFUNDED, FAILED, CANCELLED }

}
