package kr.co.dreamstart.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.PaymentDTO;
import kr.co.dreamstart.dto.ReservationDTO;

@Service
public interface ReservationService {
	public Map<String,Object> reservationWithPay(ReservationDTO rDTO,PaymentDTO pDTO);
	
	public int reservation(ReservationDTO rDTO);
}
