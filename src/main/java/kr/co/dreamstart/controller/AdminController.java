package kr.co.dreamstart.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.net.URLEncoder;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.FileAssetDTO;
import kr.co.dreamstart.mapper.FileAssetMapper;
import kr.co.dreamstart.service.BoardService;
import kr.co.dreamstart.service.FileService;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private FileService fileService;

	// main
	@GetMapping("")
	public String adminMain() {

		return "/admin/adminMain";
	}

	// list
	@GetMapping("/notices")
	public String noticeList(@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "PUBLIC") String visibility, Criteria cri, Model model) {
		String boardType = "notices";
		model.addAttribute("boardType", boardType);

		Map<String, Object> map = boardService.postList(cri, "NOTICE", visibility, searchType, keyword);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("postList", map.get("postList")); // 해당 게시물 commentCount 포함
		model.addAttribute("pageVO", map.get("pageVO"));
		model.addAttribute("cri", map.get("cri"));

		// 검색 조건 별도 전달
		model.addAttribute("visibility", visibility);
		model.addAttribute("searchType", searchType);
		model.addAttribute("keyword", keyword);

		return "/admin/boardList";
	}

	// detail
	@GetMapping("/notices/{postId}")
	public String noticeDetail(HttpServletRequest request, @PathVariable("postId") long postId, Model model) {
		String boardType = "notices";
		model.addAttribute("boardType", boardType);
		Map<String, Object> map = boardService.postDetail("NOTICE", postId);
		model.addAttribute("postDTO", map.get("postDTO"));
		model.addAttribute("prevDTO", map.get("prevDTO"));
		model.addAttribute("nextDTO", map.get("nextDTO"));
		model.addAttribute("fileList", map.get("fileList"));
		return "/admin/boardDetail";
	}

	//첨부파일 다운로드
	@GetMapping("/files/download/{fileId}")
	public void downloadFile(@PathVariable Long fileId, HttpServletResponse response, HttpServletRequest request)
			throws IOException {
		FileAssetDTO fileDTO = fileService.getFile(fileId);
		String uploadFolder = request.getServletContext().getRealPath("/resources/uploadTemp");
		File file = new File(uploadFolder + "/" + fileDTO.getStoredPath() + "/" + fileDTO.getUuid() + "_"
				+ fileDTO.getOriginalName());
		if (!file.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		response.setContentType(fileDTO.getMimeType());
		response.setHeader("Content-Disposition",
				"attachment; filename=\"" + URLEncoder.encode(fileDTO.getOriginalName(), "UTF-8") + "\"");
		Files.copy(file.toPath(), response.getOutputStream());
		response.getOutputStream().flush();
	}

	// insert
	@GetMapping("/notices/form")
	public String noticeForm(Model model) {
		String boardType = "notices";
		model.addAttribute("boardType", boardType);
		String formType = "INSERT";
		model.addAttribute("formType", formType);
		return "/admin/boardForm";
	}

	// insert
	@PostMapping("/notices/form")
	public String noticeFormPost(HttpServletRequest request, BoardPostDTO postDTO, MultipartFile[] uploadFile,
			/* MultipartHttpServletRequest request, */ RedirectAttributes rttr) {
//		MultipartFile file = request.getFile("uploadFile"); ajax로 변경시 사용
		postDTO.setCategory("NOTICE");
		Map<String, Object> map = boardService.postInsert(request, postDTO, uploadFile);
		// map.get("success")값을 받아야하나?
		return "redirect:/admin/notices/" + map.get("postId");
	}

// boardService - fileService 분리 작업 후 수정해야함 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	// update
	@GetMapping("/notices/{postId}/update")
	public String noticeUpdate(@PathVariable("postId") long postId, Model model) {
		String boardType = "notices";
		model.addAttribute("boardType", boardType);
		String formType = "UPDATE";
		model.addAttribute("formType", formType);
		// 수정할 게시물
		Map<String, Object> map = boardService.postDetail("NOTICE", postId);
		model.addAttribute("postDTO", map.get("postDTO"));
		model.addAttribute("prevDTO", map.get("prevDTO"));
		model.addAttribute("nextDTO", map.get("nextDTO"));
		model.addAttribute("fileList", map.get("fileList"));

		return "/admin/boardForm";
	}

	// update
	@PostMapping("/notices/{postId}/update")
	public String noticeUpdatePost(@PathVariable long postId, BoardPostDTO postDTO,
			@RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile,
			@RequestParam(value = "deleteFileList", required = false) List<Long> deleteFileList,
			HttpServletRequest request) {
		Map<String, Object> map = boardService.postUpdate(request, postDTO, uploadFile);
		if ((boolean) map.get("success")) {
	        fileService.saveFiles(request, uploadFile, "board_post", postId);
	        if (deleteFileList != null && !deleteFileList.isEmpty()) {
	            fileService.deleteFiles(deleteFileList);
	        }
	    }
		return "redirect:/admin/notices/" + postId;
	}

	//댓글
	@GetMapping("/qna")
	public String qnaList(@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "PUBLIC") String visibility, Criteria cri, Model model) {
		String boardType = "qna";
		model.addAttribute("boardType", boardType);// jsp를 위한거라 service에선 사용못함
		Map<String, Object> map = boardService.postList(cri, "QNA", visibility, searchType, keyword);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("postList", map.get("postList"));// commentCount 포함
		model.addAttribute("pageVO", map.get("pageVO"));
		model.addAttribute("cri", map.get("cri"));

		// 검색 조건 별도 전달
		model.addAttribute("visibility", visibility);
		model.addAttribute("searchType", searchType);
		model.addAttribute("keyword", keyword);

		return "/admin/boardList";
	}

	// detail
	@GetMapping("/qna/{postId}")
	public String qnaDetail(HttpServletRequest request, @PathVariable("postId") long postId, Model model) {
		String boardType = "qna";
		model.addAttribute("boardType", boardType);
		Map<String, Object> map = boardService.postDetail("QNA", postId);
		model.addAttribute("postDTO", map.get("postDTO"));
		model.addAttribute("prevDTO", map.get("prevDTO"));
		model.addAttribute("nextDTO", map.get("nextDTO"));
		model.addAttribute("fileList", map.get("fileList"));
		model.addAttribute("commentList", map.get("commentList"));
		System.out.println(map.get("postDTO"));
		return "/admin/boardDetail";
	}
	
	@PostMapping("/qna/{postId}/comment")
	public String qnaAnswer(@PathVariable("postId")long postId,BoardCommentDTO commentDTO) {
		commentDTO.setPostId(postId);
		commentDTO.setUserId(1);
		boardService.commentInsert(commentDTO);
		return "redirect:/admin/qna/"+postId;
	}
	

	// insert
	@GetMapping("/qna/form")
	public String qnaForm(Model model) {
		String boardType = "qna";
		model.addAttribute("boardType", boardType);
		String formType = "INSERT";
		model.addAttribute("formType", formType);
		return "/admin/boardForm";
	}

	// insert
	@PostMapping("/qna/form")
	public String qnaFormPost(HttpServletRequest request, BoardPostDTO postDTO, MultipartFile[] uploadFile,
			/* MultipartHttpServletRequest request, */ RedirectAttributes rttr) {
//		MultipartFile file = request.getFile("uploadFile"); ajax로 변경시 사용
		Map<String, Object> map = boardService.postInsert(request, postDTO, uploadFile);
		// map.get("success")값을 받아야하나?
		return "redirect:/admin/notices/" + map.get("postId");
	}
	
	// update
	@GetMapping("/qna/{postId}/update")
	public String qnaUpdate(@PathVariable("postId")long postId,Model model) {
		String boardType = "qna";
		model.addAttribute("boardType", boardType);
		String formType = "UPDATE";
		model.addAttribute("formType", formType);
		Map<String, Object> map = boardService.postDetail("QNA",postId);
		model.addAttribute("postDTO", map.get("postDTO"));
		model.addAttribute("prevDTO", map.get("prevDTO"));
		model.addAttribute("nextDTO", map.get("nextDTO"));
		model.addAttribute("fileList", map.get("fileList"));
		
		return "/admin/boardForm";
	}

}
