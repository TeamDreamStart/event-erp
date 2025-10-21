package kr.co.dreamstart.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.Data;

@Data
public class ReservationJoinDTO {
	//event
	private long eventId;
	private String eventTitle;
	private String location;
	//user
	private long userId;
	private String userName;
	//reservation
	private Long reservationId;
    private Timestamp reservationDate;
    private String reservationStatus;
    private Integer headCount;
    private String userType; // USER, GUEST
    private String qrCode;
    private String cancelReason;
    private Date reservationCancelledAt;
    
    //payment
    private long paymentId;
    private BigDecimal paymentAmount;
    private String paymentStatus;
    private String paymentMethod;
    private BigDecimal refundAmount;
    private String approveNo;
    private String pgTid;
    private String memo;
    private LocalDateTime paidAt;
    private LocalDateTime paymentCancelledAt;
    private LocalDateTime paymentCreatedAt;
    
    //포트원 api 고유ID
    private String impUid;

}
