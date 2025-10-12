package kr.co.dreamstart.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.Map;
import java.net.URLEncoder;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.BoardCommentDTO;
import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.FileAssetDTO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.service.BoardService;
import kr.co.dreamstart.service.FileService;
import kr.co.dreamstart.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private FileService fileService;

	@Autowired
	private UserService userService;

	// main
	@GetMapping("")
	public String adminMain() {

		return "/admin/adminMain";
	}

	// list
	@GetMapping("/{boardType}")
	public String boardList(@PathVariable("boardType") String boardType,
			@RequestParam(required = false) String searchType, @RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "PUBLIC") String visibility, Criteria cri, Model model) {
		String category = (boardType.equals("notices")) ? "NOTICE" : "QNA";
		Map<String, Object> map = boardService.postList(cri, category, visibility, searchType, keyword);
		model.addAttribute("boardType", boardType);
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
	@GetMapping("/{boardType}/{postId}")
	public String boardDetail(@PathVariable("boardType") String boardType, HttpServletRequest request,
			@PathVariable("postId") long postId, Model model) {
		model.addAttribute("boardType", boardType);
		String category = (boardType.equals("notices")) ? "NOTICE" : "QNA";
		Map<String, Object> map = boardService.postDetail(category, postId);
		model.addAttribute("postDTO", map.get("postDTO"));
		model.addAttribute("prevDTO", map.get("prevDTO"));
		model.addAttribute("nextDTO", map.get("nextDTO"));
		model.addAttribute("fileList", map.get("fileList"));
		// 댓글
		model.addAttribute("commentList", map.get("commentList"));
		return "/admin/boardDetail";
	}

	// 첨부파일 다운로드
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
	@GetMapping("/{boardType}/form")
	public String boardForm(@PathVariable("boardType") String boardType, Model model) {
		model.addAttribute("boardType", boardType);
		String formType = "INSERT";
		model.addAttribute("formType", formType);
		return "/admin/boardForm";
	}

	// insert
	@PostMapping("/{boardType}/form")
	public String boardFormPost(@PathVariable("boardType") String boardType, HttpServletRequest request,
			BoardPostDTO postDTO, MultipartFile[] uploadFile,
			/* MultipartHttpServletRequest request, */ RedirectAttributes rttr) {
		Map<String, Object> map = boardService.postInsert(request, postDTO, uploadFile);
		rttr.addFlashAttribute("result", map.get("result"));
		rttr.addFlashAttribute("resultType", "등록");
		return "redirect:/admin/{boardType}/" + map.get("postId");
	}

	// update
	@GetMapping("/{boardType}/{postId}/update")
	public String boardUpdate(@PathVariable("boardType") String boardType, @PathVariable("postId") long postId,
			Model model) {
		String category = (boardType.equals("notices")) ? "NOTICE" : "QNA";
		model.addAttribute("boardType", boardType);
		String formType = "UPDATE";
		model.addAttribute("formType", formType);
		// 수정할 게시물 정보
		Map<String, Object> map = boardService.postDetail(category, postId);
		model.addAttribute("postDTO", map.get("postDTO"));
		model.addAttribute("prevDTO", map.get("prevDTO"));
		model.addAttribute("nextDTO", map.get("nextDTO"));
		model.addAttribute("fileList", map.get("fileList"));

		return "/admin/boardForm";
	}

	// update
	@PostMapping("/{boardType}/{postId}/update")
	public String boardUpdatePost(@PathVariable("boardType") String boardType, @PathVariable long postId,
			BoardPostDTO postDTO, @RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile,
			@RequestParam(value = "deleteFileList", required = false) List<Long> deleteFileList,
			HttpServletRequest request, RedirectAttributes rttr) {

		Map<String, Object> map = boardService.postUpdate(request, postDTO, uploadFile);
		if (map.get("result").equals("success") && boardType.equals("notices")) {
			if (uploadFile != null & uploadFile.length > 0) {
				fileService.saveFiles(request, uploadFile, "board_post", postId);
			}
			if (deleteFileList != null && !deleteFileList.isEmpty()) {
				fileService.deleteFiles(deleteFileList);
			}
		}
		rttr.addFlashAttribute("result", map.get("result"));
		rttr.addFlashAttribute("resultType", "수정");
		return "redirect:/admin/" + boardType + "/" + postId;
	}

	// delete
	@GetMapping("/{boardType}/{postId}/delete")
	public String boardDelete(@PathVariable("boardType") String boardType, @PathVariable("postId") long postId,
			RedirectAttributes rttr) {
		// 게시글, 댓글
		Map<String, Object> map = boardService.postRealDelete(boardType, postId);
		// 파일 삭제
		if (boardType.equals("notices") && map.get("result").equals("success")) {
			fileService.deleteByOwner("board_post", postId);
		}

		rttr.addFlashAttribute("result", map.get("result"));
		rttr.addFlashAttribute("resultType", "삭제");

		return "redirect:/admin/" + boardType;
	}

	// comment insert
	@PostMapping("/qna/{postId}/comment")
	public String qnaAnswer(@PathVariable("postId") long postId, BoardCommentDTO commentDTO) {
		commentDTO.setPostId(postId); // jsp
		commentDTO.setUserId(1); // session
		boardService.commentInsert(commentDTO);
		return "redirect:/admin/qna/" + postId;
	}

	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	// userList
	@GetMapping("/customers")
	public String userManage(Criteria cri, @RequestParam(required = false) Integer role,
			@RequestParam(required = false) String searchType, @RequestParam(required = false) String keyword,
			@RequestParam(required = false) String startDate, @RequestParam(required = false) String endDate,
			Model model) {
		Map<String, Object> map = userService.userList(cri, role, searchType, keyword, startDate, endDate);
		model.addAttribute("userList", map.get("userList"));
		model.addAttribute("totalUserCount", map.get("totalUserCount"));
		model.addAttribute("pageVO", map.get("pageVO"));
		model.addAttribute("cri", map.get("cri"));

		// 검색조건
		model.addAttribute("role", role);
		model.addAttribute("searchType", searchType);
		model.addAttribute("keyword", keyword);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);

		return "/admin/customerManage";
	}

	@GetMapping("/customers/{userId}")
	public String userDetail(@PathVariable("userId") long userId, Model model) {
		UserDTO userDTO = userService.userDetail(userId);
		model.addAttribute("userDTO", userDTO);
		return "/admin/customerDetailForm";
	}

	// update
	@PostMapping("/customers/{userId}")
	public String userForm(@PathVariable("userId") long userId, UserDTO userDTO, RedirectAttributes rttr) {

		return "redirect:/user-manage/" + userId;
	}

}
