package kr.co.dreamstart.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.PaymentDTO;
import kr.co.dreamstart.mapper.PaymentMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PaymentServiceImpl implements PaymentService {

	@Autowired
	private PaymentMapper mapper;
	
	@Override
    @Transactional
    public int savePayment(PaymentDTO dto) {
        return mapper.insert(dto);
    }

	@Override
	public List<PaymentDTO> list(Criteria cri) {
		return mapper.list(cri);
	}

	@Override
	public int insert(PaymentDTO paymentDTO) {
		return mapper.insert(paymentDTO);
	}

	@Override
	public PaymentDTO select(long paymentId) {
		return mapper.select(paymentId);
	}

	@Override
	public int cancel(long reservationId) {
		return mapper.cancel(reservationId);
	}

	@Override
	public PaymentDTO selectByReservationId(long reservationId) {
		return mapper.selectByReservationId(reservationId);
	}
}
	