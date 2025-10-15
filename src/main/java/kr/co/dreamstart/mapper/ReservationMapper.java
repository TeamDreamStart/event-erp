package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.ReservationDTO;

@Mapper
public interface ReservationMapper {

	// 예약 목록 전체 조회 + 최근 예약순(내림차순) 정렬 + 페이징
	public List<ReservationDTO> reservationList(@Param("cri")Criteria cri);
	public ReservationDTO select(long reservationId);
	public int insert(ReservationDTO reservationDTO);
}
