package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.dreamstart.dto.AdminActionLogDTO;

@Mapper
public interface AdminMapper {
	public List<AdminActionLogDTO> adminActionList();
}
