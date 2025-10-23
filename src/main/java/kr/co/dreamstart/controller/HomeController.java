package kr.co.dreamstart.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.scripting.xmltags.ForEachSqlNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.FileAssetDTO;
import kr.co.dreamstart.service.BoardService;
import kr.co.dreamstart.service.EventService;
import kr.co.dreamstart.service.FileService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {
	
	@Autowired
	private EventService eventService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private FileService fileService;
	@GetMapping("/")
	public String home(Model model) {
		//이벤트 리스트 전달\
		List<EventDTO> events = eventService.all();
		model.addAttribute("events", eventService.all());
		// 이벤트 리스트에 있는 이벤트의 파일리스트..우우..
		List<List<FileAssetDTO>> eventsFileList =  new ArrayList<>();
		for(EventDTO event : events) {
			eventsFileList.add(fileService.list("event",event.getEventId()));
		}
		for(List<FileAssetDTO> list :eventsFileList ) {
			for(FileAssetDTO file : list) {
				
				System.out.println(file);
			}
		}
		model.addAttribute("eventsFileList", eventsFileList);
		Map<String,Object> map = boardService.postList(new Criteria(),"NOTICE","PUBLIC", "ALL", "");
		model.addAttribute("noticeList",map.get("postList"));
		log.info("GET / home - 메인 호출");
		return "home";
	}
	

}
