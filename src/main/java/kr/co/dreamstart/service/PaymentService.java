package kr.co.dreamstart.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.PaymentDTO;

@Service
public interface PaymentService {
	public int savePayment(PaymentDTO dto);

	public List<PaymentDTO> list(Criteria cri);

	public int insert(PaymentDTO paymentDTO);

	public PaymentDTO select(long paymentId);

	public int cancel(@Param("reservationId") long reservationId);

	public PaymentDTO selectByReservationId(long reservationId);
}
