package kr.co.dreamstart.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.FileAssetDTO;

@Mapper
public interface FileAssetMapper {
	// 사진이 해당하는 테이블,PK
	public List<FileAssetDTO> list(@Param("ownerType") String ownerType, @Param("ownerId") long ownerId);

	public FileAssetDTO select(@Param("ownerType") String ownerType, @Param("ownerId") long ownerId);

	// 파일이 여러개가 넘어오면 foreach문으로 insert
	public int insertFileInfo(FileAssetDTO fileDTO);

	//게시물 넘긴 후 아이디 받아와서 업데이트
	public int insertFileOwner(@Param("ownerType") String ownerType, @Param("ownerId") long ownerId,
			@Param("fileId") long fileId);

	public int update(FileAssetDTO fileDTO);

	// 게시글이 삭제되면 같이 삭제
	public int deleteByOwner(@Param("ownerType") String ownerType, @Param("ownerId") long ownerId);

	// 사진 하나 삭제
	public int delete(long fileId);
}
