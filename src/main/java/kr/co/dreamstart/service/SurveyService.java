package kr.co.dreamstart.service;

import java.util.List;
import java.util.Map;

import kr.co.dreamstart.dto.CloneInlineReqDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;

public interface SurveyService {

    /* ===== 기본 조회 ===== */
    public List<SurveyDTO> fixedTemplates();
    public List<SurveyDTO> surveyPage(Long eventId, Criteria cri, String keyword, String field, Integer anon);
    public int surveyCount(Long eventId, String keyword, String field, Integer anon);

    /* ===== 상세 조회 ===== */
    public SurveyDTO findSurvey(Long surveyId);
    public List<SurveyQuestionDTO> questionList(Long surveyId);
    public List<SurveyOptionDTO> optionsList(Long questionId);
    public Map<Long, List<SurveyOptionDTO>> optionsByQuestion(Long surveyId);
    public String findEventTitleBySurveyId(Long surveyId);

    /* ===== 응답 관리 ===== */
    public List<SurveyResponseDTO> responseList(Long surveyId, Criteria cri);
    public int responseCount(Long surveyId);
    public int responseCountByUser(Long surveyId, Long userId);
    public List<Map<String, Object>> responseDetailFlat(Long responseId);
    public boolean saveResponse(Long userId, Long eventId, Map<Long, Long> answers);

    /* ===== 통계 / 분석 ===== */
    public List<Map<String, Object>> surveyStatus(Long surveyId);
    public int applicantCountBySurvey(Long surveyId);
    public Map<String, Object> topRate(Long surveyId);
    public List<Map<String, Object>> surveyStatusAgainstApplicants(Long surveyId);

    /* ===== 수정 / 유지보수 ===== */
    public int updateSurveyHeader(Long surveyId, String title, String description, Integer isAnonymous);
    public int deleteCloneSurvey(Long surveyId);

    /* ===== 설문 복제 ===== */
    public Long cloneFromTemplate(Long templateId, Long eventId, Long userId, CloneInlineReqDTO.SurveyStatus status);
    public Long cloneInline(CloneInlineReqDTO req, Long userId);

    /* ===== 예약 및 상태 ===== */
    public List<Map<String, Object>> openSurveyReservations(Long userId);
    public List<Map<String, Object>> adminSurveyReservations(Long surveyId);
    public Long findSurveyIdByEvent(Long eventId);
    public String findLatestSurveyStatusByEvent(Long eventId);
    public List<Map<String, Object>> findUnansweredSurveysByUser(Long userId);

    /* ===== 기타 유틸 ===== */
    public String findUserNameById(Long userId);
    public Map<String, Object> cloneFormPrefill(Long templateId, Long eventId, Long surveyId);
    public boolean isTemplate(Long surveyId);
}
