package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class PasswordResetTokenDTO {
    private long tokenId;
    private long userId;
    private String token;
    private String expiresAt;
    private String usedAt;
    private String createdAt;
}
