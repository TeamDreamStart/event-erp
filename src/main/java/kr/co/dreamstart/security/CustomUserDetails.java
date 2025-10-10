package kr.co.dreamstart.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUserDetails extends User {
	private final Long userId;
	
	public CustomUserDetails(Long userId,
							String username, 
							String password, 
							Boolean enabled,
							Collection<? extends GrantedAuthority> authorities) {
		// 부모(User) 생성자: enabled, accountNonExpired, credentialsNonExpired, accountNonLocked
		super(username, password, enabled, true, true, true, authorities);
		this.userId = userId;
		// TODO Auto-generated constructor stub
	}
	
	public Long getUserId() {
		return userId;
	}
}
