package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.ReservationJoinDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.ReservationDTO;

@Mapper
public interface ReservationMapper {

	// 예약 목록 전체 조회 + 최근 예약순(내림차순) 정렬 + 페이징
	public List<ReservationDTO> list(@Param("cri")Criteria cri);
	public ReservationDTO select(long reservationId);
	public int insert(ReservationDTO reservationDTO);
	
	
	//userDetail
	public List<ReservationJoinDTO> selectJoinPayByUserId(long userId);
	public ReservationJoinDTO selectJoinPayById(long reservationId);
	//예약취소
	public int cancel(@Param("cancelReason")String cancelReason,@Param("reservationId")long reservationId);
	
	//관리자 - 예약관리
	public List<ReservationJoinDTO> adminJoinList();
	public ReservationJoinDTO adminJoinSelect(long reservationId);
}
