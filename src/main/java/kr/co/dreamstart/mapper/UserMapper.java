package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.UserDTO;

@Mapper
public interface UserMapper {
	
	// 관리자 - 회원 전체 목록 + 페이징
	public List<UserDTO> list(@Param("cri")Criteria cri);
	// 관리자 - 회원 수 조회
	public int count();
	//회원가입
	public int join(UserDTO userDTO);
	//회원가입시 일반회원 권한 부여
	public int joinRole(@Param("userId")long userId);
	
/*	//회원가입 - 아이디 중복 확인
	public String joinIdCheck(String userName);
	//회원가입 - 이메일 중복 확인
	public String joinEmailCheck(String email);
	
	// 회원 정보 수정
	public int updateUser(UserDTO userDTO);
	// 회원 비밀번호 변경
	public int updateUserPass(String password);
	
	//회원 탈퇴 (is_active 상태 변경)
	public int stopActivityUser(int userName);
	//회원 탈퇴(실제 정보 삭제)
	public int deleteUser(int userName);
*/
}

