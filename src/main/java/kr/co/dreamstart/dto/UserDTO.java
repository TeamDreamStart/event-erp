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
	private int gender; //female(0)male(1)
	private String lastLoginAt;
	private String createdAt;
	private String updatedAt;
	private String birthDate;
	private int isActive;
	private String snsId;
	private String roleName;
	

}
