package kr.co.dreamstart.service;

import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
}
	