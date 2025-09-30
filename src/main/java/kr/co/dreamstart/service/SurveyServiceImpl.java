package kr.co.dreamstart.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.EventDTO;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;
import kr.co.dreamstart.mapper.SurveyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SurveyServiceImpl implements SurveyService {
	private SurveyMapper surveyMapper;
	
	// 조회
	@Override
	public List<SurveyDTO> fixedTemplates() {
		// TODO Auto-generated method stub
		return surveyMapper.fixedTemplates();
	}

	@Override
	public List<SurveyDTO> surveyPage(Long eventId, Criteria cri, String keyword, String field, Integer anon) {
		// TODO Auto-generated method stub
		return surveyMapper.surveyPage(eventId, cri, keyword, field, anon);
	}

	@Override
	public int surveyCount(Long eventId, String keyword, String field, Integer anon) {
		// TODO Auto-generated method stub
		return surveyMapper.surveyCount(eventId, keyword, field, anon);
	}

	@Override
	public SurveyDTO findSurvey(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.findSurvey(surveyId);
	}

	@Override
	public List<SurveyQuestionDTO> questionList(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.questionList(surveyId);
	}

	@Override
	public List<SurveyOptionDTO> optionList(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.optionList(surveyId);
	}

	@Override
	public Map<Long, List<SurveyOptionDTO>> optionsByQuestion(Long surveyId) {
		// TODO Auto-generated method stub
		Map<Long, List<SurveyOptionDTO>> map = new LinkedHashMap<>();
		
		for (SurveyQuestionDTO q : questionList(surveyId)) {
			map.put(q.getQuestionId(), optionList(q.getQuestionId()));
		}
		return map;
	}

	// 응답
	@Override
	public List<SurveyResponseDTO> responseList(Long surveyId, Criteria cri) {
		// TODO Auto-generated method stub
		return surveyMapper.responseList(surveyId, cri);
	}

	@Override
	public int responseCount(Long surveyId) {
		// TODO Auto-generated method stub
		return surveyMapper.responseCount(surveyId);
	}

	@Override
	public List<Map<String, Object>> responseDetailFlat(Long responseId) {
		// TODO Auto-generated method stub
		return surveyMapper.responseDetailFlat(responseId);
	}

	// 유지보수
	@Override
	public int updateSurveyHeader(Long surveyId, String title, String description, Integer isAnonymous) {
		// TODO Auto-generated method stub
		return surveyMapper.updateSurveyHeader(surveyId, title, description, isAnonymous);
	}

	// 클론 (헤더 + 문항 + 보기)
	@Override
	@Transactional(rollbackFor = Exception.class) // 정상 종료 = 커밋, 예외 = 롤백
	public Long cloneFromTemplate(Long templateId, Long eventId, Long userId) {
		// TODO Auto-generated method stub
		int header = surveyMapper.cloneSurvey(templateId, eventId, userId);
		if (header != 1) throw new IllegalStateException("설문 헤더 클론 실패 !");
		return null;
	}

	@Override
	public Long cloneInline(Long tmplateId, Long eventId, Long userId, List<SurveyQuestionDTO> questions,
			Map<Long, List<SurveyOptionDTO>> optionsByOldQid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int ensureLikert5ForSurvey(Long surveyId) {
		// TODO Auto-generated method stub
		return 0;
	}
}
