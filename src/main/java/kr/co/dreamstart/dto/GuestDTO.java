package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class GuestDTO {
	private long guestId;
	private String name;
	private String password;
	private String createdAt;
}
