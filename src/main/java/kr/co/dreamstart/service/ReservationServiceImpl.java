package kr.co.dreamstart.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.PaymentDTO;
import kr.co.dreamstart.dto.ReservationDTO;
import kr.co.dreamstart.mapper.PaymentMapper;
import kr.co.dreamstart.mapper.ReservationMapper;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private ReservationMapper rMapper;
	@Autowired
	private PaymentMapper pMapper;
	
	
	
	@Override
	public Map<String, Object> reservationWithPay(ReservationDTO rDTO,PaymentDTO pDTO) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = -1;
		result = rMapper.insert(rDTO);
		if(result>0) {
			if(result>0) {
				pDTO.setReservationId(rDTO.getReservationId());
				result = pMapper.insert(pDTO);
				if (result > 0) {
					map.put("result", "success");
					map.put("resultType", "결제");
				}
				else {
					map.put("result", "fail");
					map.put("resultType", "예약 및 결제");
				}
			}
		}
		return map;
	}

	@Override
	public int reservation(ReservationDTO rDTO) {
		return rMapper.insert(rDTO);
	}

}
