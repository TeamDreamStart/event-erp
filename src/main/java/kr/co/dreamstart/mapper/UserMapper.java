package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.UserDTO;

@Mapper
public interface UserMapper {

	// 관리자 - 회원 전체 목록 + 페이징
	public List<UserDTO> list(@Param("cri") Criteria cri);

	// 관리자 - 회원 검색
	public List<UserDTO> search(@Param("cri") Criteria cri,@Param("role") Integer role,@Param("searchType") String searchType,
			@Param("keyword") String keyword, @Param("startDate") String startDate, @Param("endDate") String endDate);
	public int count();

	public int searchCount(@Param("role") Integer role,@Param("searchType") String searchType,
			@Param("keyword") String keyword, @Param("startDate") String startDate, @Param("endDate") String endDate);
	// user+userRole+role(roleName)
	public UserDTO findByUserId(long userId);
	public UserDTO findBySnsId(String snsId);

	// SNS 로그인
	public int joinNaver(UserDTO userDTO);
	public int updateNaver(UserDTO userDTO);
	
	// 관리자 - 회원 수 조회

	// 회원가입
	public int join(UserDTO userDTO);

	// 회원가입시 일반회원 권한 부여
	public int joinRole(@Param("userId") long userId);

	/*
	 * //회원가입 - 아이디 중복 확인 public String joinIdCheck(String userName); //회원가입 - 이메일
	 * 중복 확인 public String joinEmailCheck(String email);
	 * 
	 * // 회원 정보 수정 public int updateUser(UserDTO userDTO); // 회원 비밀번호 변경 public int
	 * updateUserPass(String password);
	 * 
	 * //회원 탈퇴 (is_active 상태 변경) public int stopActivityUser(int userName); //회원
	 * 탈퇴(실제 정보 삭제) public int deleteUser(int userName);
	 */

	// 로그인(아이디 또는 이메일로 사용자 조회)
	public UserDTO findByLogin(@Param("login") String login);

	// 사용자 권한 리스트 조회
	public List<String> findRoleNameByUserId(@Param("userId") long userId);

	// 마지막 로그인 시각 갱신
	public int updateLastLoginAt(@Param("userId") long userId);

	// 해시가 필요한 사용자 목록 (비밀번호가 bcrypt 형태가 아님)
	public List<UserDTO> findUsersNeedingHash();

	// 사용자 비번 업데이트
	public int updatePasswordById(@Param("userId") long userId, @Param("password") String password);

}
