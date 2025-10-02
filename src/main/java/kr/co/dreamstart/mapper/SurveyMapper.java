package kr.co.dreamstart.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.SurveyAnswerDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;

@Mapper
public interface SurveyMapper {
	// 조회/유지보수
	// 고정템플릿4개
	public List<SurveyDTO> fixedTemplates();
	// 설문목록조회(이벤트필터 + 페이징) + field, keyword, anon
	public List<SurveyDTO> surveyPage(@Param("eventId") Long eventId, @Param("cri") Criteria cri,
			@Param("keyword") String keyword, @Param("field") String field, @Param("anon") Integer anon);
	// 카운트
	public int surveyCount(@Param("eventId") Long eventId, @Param("keyword") String keyword,
			@Param("field") String field, @Param("anon") Integer anon);

	// 상세헤더1건
	public SurveyDTO findSurvey(@Param("surveyId") Long surveyId);
	// 템플릿(문항)
	public List<SurveyQuestionDTO> questionList(@Param("surveyId") Long surveyId);
	// 보기
	public List<SurveyOptionDTO> optionList(@Param("questionId") Long questionId);
	// 응답이력(설문기존 + 페이징)
	public List<SurveyResponseDTO> responseList(@Param("surveyId") Long surveyId, @Param("cri") Criteria cri);

	// 응답카운트
	public int responseCount(@Param("surveyId") Long surveyId);

	// 개별응답flat
	public List<Map<String, Object>> responseDetailFlat(@Param("responseId") Long responseId);

	// 업데이트
	public int updateSurveyHeader(@Param("surveyId") Long surveyId, @Param("title") String title,
			@Param("description") String description, @Param("isAnonymous") Integer isAnonymous);
	// 설문 단위로 'type=scale_5' 문항들에 5점 옵션 보충
	public int ensureLikert5ForSurvey(@Param("surveyId") Long surveyId);
	
	// 사용자 응답 제출시
	// 응답헤더저장
	public int insertResponse(@Param("surveyId") Long surveyId, @Param("userId") Long userId);

	// 응답상세저장
	public int insertAnswer(@Param("responseId") Long responseId, @Param("questionId") Long questionId,
			@Param("optionId") Long optionId, @Param("answerText") String answerText);

	// 전체통계(문항별보기)
	public List<Map<String, Object>> surveyStatus(@Param("surveyId") Long surveyId);

	// 문항 다건의 보기 일괄 조회
	public List<SurveyOptionDTO> findOptionsByQuestionIds(@Param("list") List<Long> questionIds);

	// 특정 문항에 5점 기본옵션(1~5) 없으면 보충
	public int ensureLikert5ForQuestion(@Param("questionId") Long questionId);


	// 응닶상세 원본 (조인x)
//	public List<SurveyAnswerDTO> answerListByresponse(@Param("responseId") Long responseId);

	// 클론용
	// 템플릿을 특정 이벤트용 설문으로 클론(기본 규칙: 이벤트 종료 즉시 오픈, 7일 뒤 종료)
	public int cloneSurvey(@Param("templateId") Long templateId, @Param("eventId") Long eventId,
			@Param("userId") Long userId);

	// 오프셋용 (JSON)
//	public int cloneSurveyWithOffsets(Long templateId, Long eventId, Long userId, int openDelayHours,
//			int closeAfterDays);

	// 바로 전 insert의 auto_increment 값
	public Long lastInsertId();

	// 새 문항 insert (깊은 복제용) - 템플릿 클론시 문항이랑 같이 가져오기
	public int insertQuestion(SurveyQuestionDTO questionDTO);

	// 새 보기 insert (깊은 복제용) - 템플릿 클론시 보기랑 같이 가져오기
	public int insertOption(SurveyOptionDTO optionDTO);


//	테스트용
//	설문조회
	public List<SurveyDTO> surveyAll();

//	응답결과
	public List<SurveyAnswerDTO> answerAll();

//	설문보기
	public List<SurveyOptionDTO> optionAll();

//	설문문항
	public List<SurveyQuestionDTO> questionAll();

//	응답이력
	public List<SurveyResponseDTO> responseAll();
}
