package kr.co.dreamstart.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.BoardPostDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.FileAssetDTO;
import kr.co.dreamstart.mapper.FileAssetMapper;
import kr.co.dreamstart.service.BoardService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private FileAssetMapper fileMapper;
	
	//main
	@GetMapping("")
	public String adminMain() {

		return "/admin/adminMain";
	}

	//list
	@GetMapping("/notices")
	public String noticeList(@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String keyword,@RequestParam(required = false,defaultValue = "PUBLIC") String visibility, Criteria cri, Model model) {
		Map<String, Object> map = service.postList(cri, "NOTICE",visibility, searchType, keyword);
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("postList", map.get("postList"));
		model.addAttribute("pageVO", map.get("pageVO"));
		model.addAttribute("cri", map.get("cri"));
		
		 // 검색 조건 별도 전달
	    model.addAttribute("visibility", visibility);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("keyword", keyword);


		return "/admin/adminNoticeList";
	}
	
	//detail
	@GetMapping("/notices/{postId}")
	public String noticeDetail(@PathVariable("postId")long postId,Model model) {
		Map<String, Object> map = service.postDetail("NOTICE", postId);
		BoardPostDTO postDTO = (BoardPostDTO) map.get("postDTO");
		BoardPostDTO prevDTO = (BoardPostDTO) map.get("prevDTO");
		BoardPostDTO nextDTO = (BoardPostDTO) map.get("nextDTO");
		model.addAttribute("postDTO", postDTO);
		model.addAttribute("prevDTO", prevDTO);
		model.addAttribute("nextDTO", nextDTO);
		
		List<FileAssetDTO> fileList = fileMapper.select("board_post", postId);
		model.addAttribute("fileList", fileList);
		return "/admin/adminNoticeDetail";
	}

	//insert
	@GetMapping("/notices/form")
	public String noticeForm(Model model) {
		String formType = "INSERT";
		model.addAttribute("formType", formType);
		return "/admin/boardForm";
	}
	
	//insert
	@PostMapping("/notices/form")
	public String noticeFormPost(BoardPostDTO postDTO,RedirectAttributes rttr) {
//		int result = service.insert();
//		rttr.addAttribute("", "");//result = success-> alert
		return "redirect:/admin/notices/"+postDTO.getPostId();
	}
	
	//update
	@GetMapping("/notices/{postId}/update")
	public String noticeUpdate(@PathVariable("postId")long postId,Model model) {
		String formType = "UPDATE";
		model.addAttribute("formType", formType);
		//파일@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		List<FileAssetDTO> fileList = fileMapper.select("board_post", postId);
		model.addAttribute("fileList", fileList);
		//수정할 게시물
		Map<String, Object> map = service.postDetail("NOTICE", postId);
		BoardPostDTO postDTO = (BoardPostDTO) map.get("postDTO");
		BoardPostDTO prevDTO = (BoardPostDTO) map.get("prevDTO");
		BoardPostDTO nextDTO = (BoardPostDTO) map.get("nextDTO");
		model.addAttribute("postDTO", postDTO);
		model.addAttribute("prevDTO", prevDTO);
		model.addAttribute("nextDTO", nextDTO);
		return "/admin/boardForm";
	}
	
	//update
	@PostMapping("/notices/{postId}/update")
	public String noticeUpdatePost(List<FileAssetDTO> fileList,BoardPostDTO postDTO) {
		
		return "redirect:/notices/"+postDTO.getPostId();
	}
	
	
	

}
