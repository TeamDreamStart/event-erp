package kr.co.dreamstart.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

public class CustomUserDetails extends User {
	@Getter private final Long userId;
	@Getter private final String name;
	@Getter private final String email;	
	
	public CustomUserDetails(Long userId,
							String name, 
							String email, 
							String password, 
							Boolean enabled,
							Collection<? extends GrantedAuthority> authorities) {
		// 부모(User) 생성자: enabled, accountNonExpired, credentialsNonExpired, accountNonLocked
		super(
				email, 
				password, 
				enabled, 
				true, true, true, 
				authorities);
		this.userId = userId;
		this.name = name;
		this.email = email;
		// TODO Auto-generated constructor stub
	}
	public Long getUserId() { return userId; }
    public String getName() { return name; } 
    public String getEmail() { return email; }
}
