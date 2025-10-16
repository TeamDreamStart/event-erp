package kr.co.dreamstart.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Transactional
	@Override
	public Map<String, Object> reservationWithPay(ReservationDTO rDTO, PaymentDTO pDTO) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = -1;
		result = rMapper.insert(rDTO);// 예약정보 넣기 성공하면
		if (result > 0) {
			if (result > 0) {
				pDTO.setReservationId(rDTO.getReservationId());
				result = pMapper.insert(pDTO); // 결제정보 넣기
				if (result > 0) {
					map.put("result", "success");
					map.put("resultType", "예약 및 결제");
				} else {
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

	@Override
	public long makeId(long eventId) {
	    // 현재 날짜
	    LocalDate today = LocalDate.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
	    String dateStr = today.format(formatter);

	    // 랜덤 4자리 숫자
	    int random = (int)(Math.random() * 9000) + 1000; // 1000~9999

	    // 예약번호 = 날짜 + 이벤트ID + 유저ID + 랜덤
	    String reservationIdStr = dateStr + eventId + random;

	    return Long.parseLong(reservationIdStr);
	}

	@Override
	public ReservationDTO selectById(long reservationId) {
		return rMapper.select(reservationId);
	}


}
