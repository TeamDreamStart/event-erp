package kr.co.dreamstart.mapper;

import kr.co.dreamstart.dto.UserDTO;

@org.apache.ibatis.annotations.Mapper
public interface UserMapper {
	public UserDTO selectAll();
}


