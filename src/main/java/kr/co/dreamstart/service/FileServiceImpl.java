package kr.co.dreamstart.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.FileAssetDTO;
import kr.co.dreamstart.mapper.FileAssetMapper;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Service
public class FileServiceImpl implements FileService {

	private final String uploadFolder = "C:\\upload";

	@Autowired
	private FileAssetMapper mapper;

	@Override
	public List<FileAssetDTO> list(String ownerType, long ownerId) {
		return mapper.list(ownerType, ownerId);
	}


	@Override
	public void saveFiles(HttpServletRequest request ,MultipartFile[] uploadFile, String ownerType, Long ownerId) {
		// 파일 받을 리스트
		List<FileAssetDTO> fileList = new ArrayList<>();

		// 업로드된 파일을 저장할 폴더 경로
		String uploadFolder = request.getServletContext().getRealPath("/resources/uploadTemp");


		// 현재 날짜를 기준으로 업로드된 파일을 저장할 서브 폴더 경로를 생성하여 반환
		String uploadFolderPath = getFolder();

		// 현재 날짜를 기준으로 업로드된 파일을 저장할 서브 폴더 경로 생성
		File uploadPath = new File(uploadFolder, getFolder()); // C:\\upload\2025\10 getFolder 메서드에서 날짜 포멧 설정
		log.info("upload path : " + uploadPath);

		// 업로드할 서브 폴더가 없는 경우 생성
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		// 입력받은 여러개의 첨부파일 전부 순회
		for (MultipartFile multipartFile : uploadFile) {
			if (multipartFile == null || multipartFile.isEmpty()) {
				log.warn("[FileService] EMPTY UPLOAD FILE...");
				continue;
			}
			String originalName = multipartFile.getOriginalFilename();
			if (originalName == null || originalName.trim().isEmpty()) {
				log.warn("[FileService] NO FILENAME...");
				continue;
			}
			log.info("---------------------------------");
			log.info("upload File Name : " + multipartFile.getOriginalFilename());
			log.info("upload File Size : " + multipartFile.getSize());

			// 업로드된 파일 정보를 담을 객체 생성 ->DB
			FileAssetDTO fileDTO = new FileAssetDTO();
			// 업로드된 파일의 이름만 추출하여 저장
			String uploadFileName = multipartFile.getOriginalFilename();
			// @@ DB에 넣을 이름 객체에 저장
			fileDTO.setOriginalName(uploadFileName);
			// Internet Explorer의 경우 파일 경로가 포함되므로 파일 이름만 추출
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			// UUID를 이용하여 파일명 중복을 방지하기 위해 파일명 변경
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName; // 파일명 : uuid + '_' + originalFilename -> ex)
																		// uuid_oil.jpg
			log.info("upload File -------------------->" + uploadFileName);
			// 실제로 파일을 저장하기 위한 File 객체 생성
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				// 파일을 지정된 경로에 저장
				multipartFile.transferTo(saveFile);

				// 저장한 파일이 이미지인 경우 썸네일 생성
				if (checkImageType(saveFile)) {
					// 이미지 불린 처리
					fileDTO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName)); // ex)
																													// s_uuid_oil.jpg
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100); // 썸네일 생성 사이즈
					thumbnail.close(); // 파일 출력 스트림을 닫음
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

			// @@ UUID, 파일 경로 객체에 저장
			fileDTO.setOwnerType(ownerType);
			fileDTO.setOwnerId(ownerId);
			fileDTO.setUuid(uuid.toString());
			fileDTO.setStoredPath(uploadFolderPath.replace("\\","/"));
			fileDTO.setMimeType(multipartFile.getContentType());
			fileDTO.setSizeBytes(multipartFile.getSize());
			log.info("DB INFO ---------------------------");
			log.info("ORIGINALNAME : " + fileDTO.getOriginalName());
			log.info("UUID : " + fileDTO.getUuid());
			log.info("STOREDPATH : " + fileDTO.getStoredPath());
			log.info("MIMETYPE : " + fileDTO.getMimeType());
			log.info("SIZEBYTES : " + fileDTO.getSizeBytes());

			fileList.add(fileDTO);
		}
		// @@@@@@@@@@@@@List DB에 넣기
		int result = -1;
		int index = 1;
		for(FileAssetDTO fileDTO : fileList) {
			result = mapper.insert(fileDTO);
			if(result>0) {
				log.info(index+".file save success");
			}else {
				log.info(index+". file save fail");
			}
			index++;
		}
	}

	// 현재 날짜를 기준으로 업로드된 파일을 저장할 서브 폴더 경로를 생성하는 메서드
	private String getFolder() {
		// 현재 날짜 정보를 포함한 경로 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		Date date = new Date();
		String str = sdf.format(date); // 2024-02-12
		// 현재 날짜를 기준으로 생성된 서브 폴더 경로 문자열
		return str.replace("-", File.separator);
	}

	// 이미지 파일 유무 체크. 마임타입 확인
	private boolean checkImageType(File file) {
		try {
			// 파일의 마임 타입을 확인하여 이미지인지 여부를 판단
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 마임 타입을 확인할 수 없는 경우 이미지가 아닌 것으로 간주
		return false;
	}
	
	public void deleteFiles(List<Long> deleteFileList) {
		if (deleteFileList.size() > 0 && !deleteFileList.isEmpty()) {
			int result = -1;
			for (long deleteFileId : deleteFileList) {
				result = -1;
				result = mapper.delete(deleteFileId);
				if (result > 0) {
					log.info("[FileService] DELETED SUCCESS ID : " + deleteFileId);
				} else {
					log.warn("[FileService] DELETED FAIL ID : " + deleteFileId);
				}
			}
		}else {
			log.info("[FileService] EMPTY DELETE FILE LIST...");
		}
	}

	//다운로드용
	@Override
	public FileAssetDTO getFile(long fileId) {
		// TODO Auto-generated method stub
		return null;
	}

}


