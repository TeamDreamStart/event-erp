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

@Service("userDetailsService")
public class CustomUserDetailService implements UserDetailsService {

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public UserDetails loadUserByUsername(String login) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		// 아이디/이메일 겸용 : 하나의 파라미터에 or 조회
		UserDTO u = userMapper.findByLogin(login);
		
		// 없으면 인증 실패
		if (u == null) {
			// 외부 노출 방지를 위해 log.warn 대신 throw로 예외처리
			throw new UsernameNotFoundException("User not found");
		}
		
		//권한 조회 -> GrantedAuthority로 변환
		List<String> roles = userMapper.findRoleNameByUserId(u.getUserId());
		List<SimpleGrantedAuthority> authorities = roles.stream()
				.map(SimpleGrantedAuthority::new)
				.collect(Collectors.toList());
		
		// UserDetails 생성 후 반환
		return org.springframework.security.core.userdetails.User
				.withUsername(u.getUserName())	// 세션에 올라갈 username
				.password(u.getPassword()) 	// bcrypt 해시
				.authorities(authorities)
				.disabled(u.getIsActive() == 0) // 1:활성, 0:비활성
				.accountExpired(false)
				.accountLocked(false)
				.credentialsExpired(false)
				.build();
	}
	
}
