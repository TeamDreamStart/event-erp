package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.PaymentDTO;

@Mapper
public interface PaymentMapper {

	public List<PaymentDTO> list(Criteria cri);
	
	public int insert(PaymentDTO paymentDTO);
	
	public PaymentDTO select(long paymentId);
	
	public int cancel(@Param("reservationId")long reservationId);
	
	public PaymentDTO selectByReservationId(long reservationId);
}
