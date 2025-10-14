package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class RoleVO {
	private int roleId;
	private String roleName; //0:ADMIN 1:MEMBER
}
