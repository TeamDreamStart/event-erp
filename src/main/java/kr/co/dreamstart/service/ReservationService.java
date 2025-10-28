package kr.co.dreamstart.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.PaymentDTO;
import kr.co.dreamstart.dto.ReservationDTO;
import kr.co.dreamstart.dto.ReservationJoinDTO;

@Service
public interface ReservationService {
	public Map<String, Object> reservationWithPay(ReservationDTO rDTO, PaymentDTO pDTO);

	public int reservation(ReservationDTO rDTO);

	public long makeId(long eventId);

	public ReservationDTO selectById(long reservationId);

	public List<ReservationJoinDTO> selectJoinPayByUserId(long userId);

	public ReservationJoinDTO selectJoinPayById(long reservationId);

	public Map<String, Object> reservationCancel(long reservationId, String cancelReason);

	// 관리자 - 예약관리
	public List<ReservationJoinDTO> adminJoinList();
	// 관리자 - 예약관리(디테일)
	public ReservationJoinDTO adminJoinSelect(long reservationId);
	
	public String makeQR(long reservationId);
}
