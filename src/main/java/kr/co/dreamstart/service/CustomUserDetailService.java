package kr.co.dreamstart.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.UserMapper;
import kr.co.dreamstart.security.CustomUserDetails;
import lombok.RequiredArgsConstructor;

@Service("userDetailsService")
@RequiredArgsConstructor
public class CustomUserDetailService implements UserDetailsService {

	@Autowired
	private UserService userService;
	
	@Override
	public UserDetails loadUserByUsername(String login) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		// 1) 사용자 조회 - 아이디/이메일 겸용 : 하나의 파라미터에 or 조회
		UserDTO u = userService.findByLogin(login);
		
		// 없으면 인증 실패
		if (u == null) {
			// 외부 노출 방지를 위해 log.warn 대신 throw로 예외처리
			throw new UsernameNotFoundException("User not found");
		}
		
		// 2) 권한 조회 -> GrantedAuthority로 변환 + ROLE_ 접두어 + 대문자 정규화
		List<String> roles = userService.findRoleNames(u.getUserId()); // ["admin","member"]
		List<SimpleGrantedAuthority> authorities = roles.stream()
				.map(r -> "ROLE_" + r.toUpperCase()) // "admin" -> "ROLE_ADMIN"
				.map(SimpleGrantedAuthority::new)
				.collect(Collectors.toList());
		
		boolean enabled = u.getIsActive() == 1;
		
		// UserDetails 생성 후 반환
		return new CustomUserDetails(
				u.getUserId(),
				u.getName(),	// name(표시용)
				u.getEmail(),	// =username
				u.getPassword(),
				enabled,
				authorities
		);
				
	}
	
}
