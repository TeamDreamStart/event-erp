package kr.co.dreamstart.dto;

import lombok.Data;

@Data
public class FileAssetDTO {
    private long fileId;
    private String ownerType;
    private long ownerId;
    private String originalName;
    private String storedPath;
    private String mimeType;
    private long sizeBytes;
    private String createdAt;
}
