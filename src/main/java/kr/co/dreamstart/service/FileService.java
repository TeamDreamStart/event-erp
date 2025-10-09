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

	// 게시물 수정시 체크한 사진 삭제
	public void deleteFiles(List<Long> deleteFileList);
	
	// 게시글 삭제시 해당 게시글 파일 정보 전부 삭1제
	public int deleteByOwner(@Param("ownerType") String ownerType, @Param("ownerId") long ownerId);

	public FileAssetDTO getFile(long fileId);

}
