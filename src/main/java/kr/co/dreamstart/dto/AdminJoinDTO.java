package kr.co.dreamstart.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;


import lombok.Data;

@Data
public class AdminJoinDTO {
	
	private Long reservationId;
    private String eventTitle;
    private Timestamp reservationDate;
    private String reservationStatus;
    private Integer headcount;
    private BigDecimal paymentAmount;
    private String paymentStatus;
    private String paymentMethod;

}
