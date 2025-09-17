package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class OauthProviderDTO {
    private int providerId;
    private String providerKey;
    private String displayName;
}
