package kr.co.dreamstart.service;

import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.AdminActionLogDTO;

@Service
public interface AdminService {
	public void recordAdminLog(AdminActionLogDTO adminActionLogDTO);

}
