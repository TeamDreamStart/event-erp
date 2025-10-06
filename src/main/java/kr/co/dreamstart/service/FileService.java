package kr.co.dreamstart.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.dreamstart.dto.FileAssetDTO;

@Service
public interface FileService {
	// detail
	public List<FileAssetDTO> list(@Param("ownerType") String ownerType, @Param("ownerId") long ownerId);

	// post insert시 실제 파일 저장 / DB에 저잗된 파일 정보 insert
	public void saveFiles(HttpServletRequest request, MultipartFile[] uploadFile, String ownerType, Long ownerId);

	public void deleteFiles(List<Long> deleteFileList);

	public FileAssetDTO getFile(long fileId);

}
