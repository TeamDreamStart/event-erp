package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class UserRoleDTO {
	private long userId;
	private int roleId; // 0: ADMIN 1:MEMBER
	private String assignedAt;
}
