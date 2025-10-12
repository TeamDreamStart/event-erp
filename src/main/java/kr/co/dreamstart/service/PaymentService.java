package kr.co.dreamstart.service;

import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.PaymentDTO;

@Service
public interface PaymentService {
	public void savePayment(PaymentDTO dto);

}
