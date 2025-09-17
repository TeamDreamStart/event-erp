package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.dreamstart.dto.UserDTO;

@Mapper
public interface UserMapper {
	public List<UserDTO> userSelectAll();
}


