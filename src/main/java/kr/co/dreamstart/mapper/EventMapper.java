package kr.co.dreamstart.mapper;

import java.util.List;
import kr.co.dreamstart.dto.EventDTO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EventMapper {
	public List<EventDTO> eventAll();
}
