package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class UserRoleDTO {
	private long userId;
	private int roleId;
	private String assignedAt;
}
