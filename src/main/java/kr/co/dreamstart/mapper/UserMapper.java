package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.UserDTO;

@Mapper
public interface UserMapper {
	public List<UserDTO> userSelectAll();
	
	// 관리자 - 회원 목록
	public List<UserDTO> userPagingList(Criteria cri);
	// 관리자 - 총 회원 수 조회
	public int userCount();
	
	//회원가입
	public int joinUser(UserDTO userDTO);
	//회원가입 - 아이디 중복 확인
	public String joinIdCheck(String username);
	//회원가입 - 이메일 중복 확인
	public String joinEmailCheck(String email);
	
	// 회원 정보 수정
	public int updateUser(UserDTO userDTO);
	// 회원 비밀번호 변경
	public int updateUserPass(String password);
	
	//회원 탈퇴(active 상태 변경)
	public int stopActivityUser(int username);
	//회원 탈퇴(실제 정보 삭제)
	public int deleteUser(int username);
}


