package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class UserDTO {
	private long userId;
	private String username;
	private String password;
	private String name;
	private String email;
	private String phone;
	private Integer gender; //female(0)male(1)
	private String lastLoginAt;
	private String createdAt;
	private String updatedAt;
	private String birthDate;
	private int isActive;
	private String snsId;
	//USER ~ USER_ROLE ~ ROLE / DB에서 테이블 분리되어있음, Join시 UserDTO로 받아올 수 있다
	private String roleName;

}
