package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class EmailVerificationTokenDTO {
    private long tokenId;
    private long userId;
    private String token;
    private String expiresAt;
    private String verifiedAt;
    private String createdAt;
	
}
