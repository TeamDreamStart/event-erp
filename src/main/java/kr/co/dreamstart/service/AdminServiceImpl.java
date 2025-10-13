package kr.co.dreamstart.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.AdminActionLogDTO;
import kr.co.dreamstart.mapper.AdminMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Override
	public void recordAdminLog(AdminActionLogDTO adminActionLogDTO) {
		int result = -1;
		result = adminMapper.recordAdminLog(adminActionLogDTO);
		if(result>0) {
			log.info("[ADMINSERVICE] ADMIN ACTION LOG SUCCESS");
		}else {
			log.warn("[ADMINSERVICE] ADMIN ACTION LOG FAIL");
		}
	}

}
