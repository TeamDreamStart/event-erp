package kr.co.dreamstart.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.CloneInlineReqDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.SurveyAnswerDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;

@Mapper
public interface SurveyMapper {

    /* ===== surveys(설문목록용) ===== */
    public List<SurveyDTO> fixedTemplates();
    public List<SurveyDTO> surveyPage(@Param("eventId") Long eventId,
                                      @Param("cri") Criteria cri,
                                      @Param("keyword") String keyword,
                                      @Param("field") String field,
                                      @Param("anon") Integer anon);
    public int surveyCount(@Param("eventId") Long eventId,
                           @Param("keyword") String keyword,
                           @Param("field") String field,
                           @Param("anon") Integer anon);

    /* ===== surveyDetail(설문상세용) ===== */
    public String findEventTitleBySurveyId(@Param("surveyId") Long surveyId);
    public SurveyDTO findSurvey(@Param("surveyId") Long surveyId);
    public List<SurveyQuestionDTO> questionList(@Param("surveyId") Long surveyId);
    public List<SurveyOptionDTO> optionList(@Param("questionId") Long questionId);

    /* ==== 유저 응답 / 통계 ==== */
    public int responseCount(@Param("surveyId") Long surveyId);
    public int responseCountByUser(@Param("surveyId") Long surveyId, @Param("userId") Long userId);
    public List<SurveyResponseDTO> responseList(@Param("surveyId") Long surveyId, @Param("cri") Criteria cri);
    public List<Map<String, Object>> responseDetailFlat(@Param("responseId") Long responseId);

    /* ==== 응답 저장 ==== */
    public int insertResponse(SurveyResponseDTO response);
    public int insertAnswer(@Param("responseId") Long responseId,
                            @Param("questionId") Long questionId,
                            @Param("optionId") Long optionId,
                            @Param("answerText") String answerText);
    public Long findSurveyIdByEvent(@Param("eventId") Long eventId);
    public String findLatestSurveyStatusByEvent(@Param("eventId") Long eventId);

    /* ==== 통계 / 비율 ==== */
    public List<Map<String, Object>> surveyStatus(@Param("surveyId") Long surveyId);
    public int applicantCountBySurvey(@Param("surveyId") Long surveyId);
    public Map<String, Object> topRate(@Param("surveyId") Long surveyId);
    public List<Map<String, Object>> surveyStatusAgainstApplicants(@Param("surveyId") Long surveyId);

    /* ==== 설문예약뷰 ==== */
    public List<Map<String, Object>> openSurveyReservations(@Param("userId") Long userId);
    public List<Map<String, Object>> adminSurveyReservations(@Param("surveyId") Long surveyId);

    /* ==== 생성자 ==== */
    public String findUserNameById(@Param("userId") Long userId);

    /* ===== 수정/삭제(복제본만가능) ===== */
    public int updateSurveyHeader(@Param("surveyId") Long surveyId,
                                  @Param("title") String title,
                                  @Param("description") String description,
                                  @Param("isAnonymous") Integer isAnonymous);
    public int deleteCloneOptions(Long surveyId);
    public int deleteCloneQuestions(Long surveyId);
    public int deleteCloneSurvey(Long surveyId);

    /* ===== surveyCloneForm(설문복제하기폼) ===== */
    public int ensureLikert5ForSurvey(@Param("surveyId") Long surveyId);
    public int ensureLikert5ForQuestion(@Param("questionId") Long questionId);
    public int cloneSurvey(CloneInlineReqDTO req);
    public int insertSurveyHeaderFromInline(CloneInlineReqDTO req);
    public int insertQuestion(SurveyQuestionDTO questionDTO);
    public int insertOption(SurveyOptionDTO optionDTO);

    /* ===== 보조 쿼리 ===== */
    public List<SurveyOptionDTO> findOptionsByQuestionIds(@Param("list") List<Long> questionIds);
    public Map<String, Object> cloneFormPrefill(@Param("templateId") Long templateId,
                                                @Param("eventId") Long eventId,
                                                @Param("surveyId") Long surveyId);
    public Long findLastResponseId(@Param("surveyId") Long surveyId,
                                   @Param("userId") Long userId);
    public List<Map<String, Object>> findUnansweredSurveysByUser(@Param("userId") Long userId);

    /* ===== 테스트용 ===== */
    public List<SurveyDTO> surveyAll();
    public List<SurveyAnswerDTO> answerAll();
    public List<SurveyOptionDTO> optionAll();
    public List<SurveyQuestionDTO> questionAll();
    public List<SurveyResponseDTO> responseAll();
}