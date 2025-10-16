package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.dreamstart.dto.AdminActionLogDTO;
import kr.co.dreamstart.dto.AdminJoinDTO;
import kr.co.dreamstart.dto.BoardPostDTO;

@Mapper
public interface AdminMapper {
	public List<AdminActionLogDTO> adminActionList();
	public int recordAdminLog(AdminActionLogDTO logDTO);
	
	//userDetail
	//reservation으로 옮겨야...되는데...@@@@@@@@@@@@@@@@@@
	public List<AdminJoinDTO> selectJoinPayByUserId(long userId);
	public AdminJoinDTO selectJoinPayById(long reservationId);
	
	
}
