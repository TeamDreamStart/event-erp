package kr.co.dreamstart.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

public class CustomUserDetails extends User {
	@Getter private final Long userId;
	@Getter private final String name;
	@Getter private final String email;
	
	public CustomUserDetails() {
		super("anonymous", "x", false, true, true, true, AuthorityUtils.NO_AUTHORITIES);
		this.userId = -1L;
		this.name = "";
		this.email = "anonumous";
	}
	
	public CustomUserDetails(Long userId,
							String name, 
							String email, 
							String password, 
							Boolean enabled,
							Collection<? extends GrantedAuthority> authorities) {
		
		super(
				email != null && !email.isEmpty() ? email : "anonumous",//getName시 첫번째 인자인 이메일을 받아옴 
				password != null && !password.isEmpty() ? password : "x", 
				enabled != null ? enabled : false, 
				true, true, true, 
				authorities != null ? authorities : AuthorityUtils.NO_AUTHORITIES
		);

		// 부모(User) 생성자: enabled, accountNonExpired, credentialsNonExpired, accountNonLocked
		if (userId == null || email == null || password == null || enabled == null || authorities == null) {
			throw new IllegalArgumentException("null in CustomUserDetails constructor");
		}
		
		this.userId = userId;
		this.name = name != null ? name : "";
		this.email = email != null ? email : "anonymous";
		// TODO Auto-generated constructor stub
	}
	public Long getUserId() { return userId; }
    public String getName() { return name; } 
    public String getEmail() { return email; }
}
