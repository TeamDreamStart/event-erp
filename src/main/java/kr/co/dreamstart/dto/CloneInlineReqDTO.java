package kr.co.dreamstart.dto;

import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class CloneInlineReqDTO {
	@NotNull private Long templateId;
	@NotNull private Long eventId;
	@NotNull private Long userId;
	
	// 질문 + 옵션 묶음
	@Valid
	private List<QuestionPayLoadDTO> questions; 
	
}
