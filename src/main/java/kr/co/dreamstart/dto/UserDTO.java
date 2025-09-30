package kr.co.dreamstart.dto;


import lombok.Data;

@Data
public class UserDTO {
	private long userId;
	private String userName;
	private String password;
	private String name;
	private String email;
	private String phone;
	private String lastLoginAt;
	private String createdAt;
	private String updatedAt;
	private int isActive;
}
