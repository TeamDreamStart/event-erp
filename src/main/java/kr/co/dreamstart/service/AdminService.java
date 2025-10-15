package kr.co.dreamstart.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.AdminActionLogDTO;
import kr.co.dreamstart.dto.AdminJoinDTO;

@Service
public interface AdminService {
	public void recordAdminLog(AdminActionLogDTO adminActionLogDTO);
	public List<AdminJoinDTO> selectReservationPaymentByUserId(long userId);
}
