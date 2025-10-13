package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.PaymentDTO;

@Mapper
public interface PaymentMapper {

	public List<PaymentDTO> list(Criteria cri);
	
	public int insert(PaymentDTO paymentDTO);
}
