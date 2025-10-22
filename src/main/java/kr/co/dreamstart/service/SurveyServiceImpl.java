package kr.co.dreamstart.service;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.dreamstart.dto.CloneInlineReqDTO;
import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.QuestionPayLoadDTO;
import kr.co.dreamstart.dto.SurveyDTO;
import kr.co.dreamstart.dto.SurveyOptionDTO;
import kr.co.dreamstart.dto.SurveyQuestionDTO;
import kr.co.dreamstart.dto.SurveyResponseDTO;
import kr.co.dreamstart.mapper.EventMapper;
import kr.co.dreamstart.mapper.SurveyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SurveyServiceImpl implements SurveyService {

    private final SurveyMapper surveyMapper;
    private final EventMapper eventMapper;

    /* ===== 기본 조회 ===== */
    @Override
    public List<SurveyDTO> fixedTemplates() {
        return surveyMapper.fixedTemplates();
    }

    @Override
    public List<SurveyDTO> surveyPage(Long eventId, Criteria cri, String keyword, String field, Integer anon) {
        return surveyMapper.surveyPage(eventId, cri, keyword, field, anon);
    }

    @Override
    public int surveyCount(Long eventId, String keyword, String field, Integer anon) {
        return surveyMapper.surveyCount(eventId, keyword, field, anon);
    }

    @Override
    public SurveyDTO findSurvey(Long surveyId) {
        return surveyMapper.findSurvey(surveyId);
    }

    @Override
    public List<SurveyQuestionDTO> questionList(Long surveyId) {
        return surveyMapper.questionList(surveyId);
    }

    @Override
    public List<SurveyOptionDTO> optionsList(Long questionId) {
        return surveyMapper.optionList(questionId);
    }

    @Override
    public Map<Long, List<SurveyOptionDTO>> optionsByQuestion(Long surveyId) {
        Map<Long, List<SurveyOptionDTO>> map = new LinkedHashMap<>();
        for (SurveyQuestionDTO q : questionList(surveyId)) {
            map.put(q.getQuestionId(), surveyMapper.optionList(q.getQuestionId()));
        }
        return map;
    }

    /* ===== 응답 ===== */
    @Override
    public List<SurveyResponseDTO> responseList(Long surveyId, Criteria cri) {
        return surveyMapper.responseList(surveyId, cri);
    }

    @Override
    public int responseCount(Long surveyId) {
        return surveyMapper.responseCount(surveyId);
    }

    @Override
    public int responseCountByUser(Long surveyId, Long userId) {
        return surveyMapper.responseCountByUser(surveyId, userId);
    }

    @Override
    public List<Map<String, Object>> responseDetailFlat(Long responseId) {
        return surveyMapper.responseDetailFlat(responseId);
    }

    /* ===== 수정 / 유지보수 ===== */
    @Override
    public int updateSurveyHeader(Long surveyId, String title, String description, Integer isAnonymous) {
        return surveyMapper.updateSurveyHeader(surveyId, title, description, isAnonymous);
    }

    /* ===== 설문 복제 ===== */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long cloneFromTemplate(Long templateId, Long eventId, Long userId, CloneInlineReqDTO.SurveyStatus status) {
        CloneInlineReqDTO req = new CloneInlineReqDTO();
        req.setTemplateId(templateId);
        req.setEventId(eventId);
        req.setUserId(userId);
        req.setStatus(status == null ? CloneInlineReqDTO.SurveyStatus.OPEN : status);

        int header = surveyMapper.cloneSurvey(req);
        if (header != 1) throw new IllegalStateException("설문 헤더 클론 실패!");

        Long newSurveyId = req.getNewSurveyId();
        if (newSurveyId == null || newSurveyId <= 0)
            throw new IllegalStateException("신규 설문 ID 조회 실패!");
        log.info("[cloneFromTemplate] newSurveyId={}", newSurveyId);

        List<SurveyQuestionDTO> questionDTO = surveyMapper.questionList(templateId);
        for (SurveyQuestionDTO q : questionDTO) {
            SurveyQuestionDTO nq = new SurveyQuestionDTO();
            nq.setSurveyId(newSurveyId);
            nq.setQuestion(q.getQuestion());
            nq.setType(q.getType());
            surveyMapper.insertQuestion(nq);
            Long newQuestionId = nq.getQuestionId();

            List<SurveyOptionDTO> options = surveyMapper.optionList(q.getQuestionId());
            for (SurveyOptionDTO o : options) {
                SurveyOptionDTO nop = new SurveyOptionDTO();
                nop.setQuestionId(newQuestionId);
                nop.setLabel(o.getLabel());
                nop.setOptValue(o.getOptValue());
                surveyMapper.insertOption(nop);
            }
        }
        return newSurveyId;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long cloneInline(CloneInlineReqDTO req, Long userId) {
        req.setUserId(userId != null ? userId : 1L);
        LocalDateTime eventEnd = eventMapper.findEndDateByEventId(req.getEventId());
        if (eventEnd == null) throw new IllegalStateException("이벤트 종료시각이 없습니다.");

        if ("offset".equalsIgnoreCase(req.getScheduleMode())) {
            int h = (req.getOpenDelayHours() == null ? 0 : req.getOpenDelayHours());
            int d = (req.getCloseAfterDays() == null ? 7 : req.getCloseAfterDays());
            req.setOpenAt(eventEnd.plusHours(h));
            req.setCloseAt(req.getOpenAt().plusDays(d));
        } else {
            req.setOpenAt(eventEnd);
            req.setCloseAt(eventEnd.plusDays(7));
        }

        if (req.getStatus() == null)
            req.setStatus(CloneInlineReqDTO.SurveyStatus.DRAFT);

        int header = surveyMapper.insertSurveyHeaderFromInline(req);
        if (header != 1) throw new IllegalStateException("설문 헤더 클론 실패");

        Long newSurveyId = req.getNewSurveyId();
        if (newSurveyId == null || newSurveyId <= 0)
            throw new IllegalStateException("신규 설문 ID 조회 실패");
        log.info("[cloneInline] newSurveyId={}", newSurveyId);

        if (req.getQuestions() != null) {
            for (QuestionPayLoadDTO q : req.getQuestions()) {
                SurveyQuestionDTO nq = new SurveyQuestionDTO();
                nq.setSurveyId(newSurveyId);
                nq.setQuestion(q.getQuestion());
                SurveyQuestionDTO.QuestionType type =
                        (q.getType() == null ? SurveyQuestionDTO.QuestionType.SCALE_5 : q.getType());
                nq.setType(type);
                nq.setRequired(type != SurveyQuestionDTO.QuestionType.TEXT);
                surveyMapper.insertQuestion(nq);
                Long newQuestionId = nq.getQuestionId();

                if (q.getOptions() != null) {
                    for (SurveyOptionDTO o : q.getOptions()) {
                        SurveyOptionDTO nop = new SurveyOptionDTO();
                        nop.setQuestionId(newQuestionId);
                        nop.setLabel(o.getLabel());
                        nop.setOptValue(o.getOptValue());
                        surveyMapper.insertOption(nop);
                    }
                }
            }
        }
        return newSurveyId;
    }

    /* ===== 삭제 ===== */
    @Override
    public int deleteCloneSurvey(Long surveyId) {
        int d1 = surveyMapper.deleteCloneOptions(surveyId);
        int d2 = surveyMapper.deleteCloneQuestions(surveyId);
        int d3 = surveyMapper.deleteCloneSurvey(surveyId);
        return d1 + d2 + d3;
    }

    /* ===== 통계 / 조회 ===== */
    @Override
    public String findEventTitleBySurveyId(Long surveyId) {
        return surveyMapper.findEventTitleBySurveyId(surveyId);
    }

    @Override
    public List<Map<String, Object>> surveyStatus(Long surveyId) {
        return surveyMapper.surveyStatus(surveyId);
    }

    @Override
    public String findUserNameById(Long userId) {
        return surveyMapper.findUserNameById(userId);
    }

    @Override
    public int applicantCountBySurvey(Long surveyId) {
        return surveyMapper.applicantCountBySurvey(surveyId);
    }

    @Override
    public Map<String, Object> topRate(Long surveyId) {
        return surveyMapper.topRate(surveyId);
    }

    @Override
    public List<Map<String, Object>> surveyStatusAgainstApplicants(Long surveyId) {
        return surveyMapper.surveyStatusAgainstApplicants(surveyId);
    }

    /* ===== 프리필 ===== */
    @Override
    public Map<String, Object> cloneFormPrefill(Long templateId, Long eventId, Long surveyId) {
        Long selectedTemplateId = templateId;
        Long selectedEventId = eventId;
        String prefillTitle = "";
        String prefillDesc = "";

        if (surveyId != null) {
            SurveyDTO s = findSurvey(surveyId);
            if (s != null) {
                if (s.getEventId() != null) selectedEventId = s.getEventId();
                if (s.getCloneFromSurveyId() != null) selectedTemplateId = s.getCloneFromSurveyId();
                prefillTitle = s.getTitle();
                prefillDesc = s.getDescription();
            }
        }

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("selectedTemplateId", selectedTemplateId);
        out.put("selectedEventId", selectedEventId);
        out.put("prefillTitle", prefillTitle);
        out.put("prefillDesc", prefillDesc);
        return out;
    }

    @Override
    public boolean isTemplate(Long surveyId) {
        if (surveyId == null) return false;
        if (surveyId >= 1 && surveyId <= 4) return true;

        SurveyDTO s = findSurvey(surveyId);
        if (s == null) return false;
        if (s.getIsTemplate() != null && s.getIsTemplate() == 1) return true;

        return (s.getTemplateKey() != null && !s.getTemplateKey().isBlank());
    }

    /* ===== 설문 예약 ===== */
    @Override
    public List<Map<String, Object>> openSurveyReservations(Long userId) {
        return surveyMapper.openSurveyReservations(userId);
    }

    @Override
    public List<Map<String, Object>> adminSurveyReservations(Long surveyId) {
        return surveyMapper.adminSurveyReservations(surveyId);
    }

    /* ===== 응답 저장 ===== */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean saveResponse(Long userId, Long eventId, Map<Long, Long> answers) {
        Long surveyId = surveyMapper.findSurveyIdByEvent(eventId);
        if (surveyId == null) {
            log.warn("설문이 존재하지 않습니다. eventId={}", eventId);
            return false;
        }

        int existing = surveyMapper.responseCountByUser(surveyId, userId);
        if (existing > 0) {
            log.info("이미 응답한 유저입니다: userId={}, surveyId={}", userId, surveyId);
            return false;
        }

        SurveyResponseDTO dto = new SurveyResponseDTO();
        dto.setSurveyId(surveyId);
        dto.setUserId(userId);
        surveyMapper.insertResponse(dto);

        Long responseId = dto.getResponseId();
        if (responseId == null)
            throw new IllegalStateException("responseId 생성 실패 (MyBatis useGeneratedKeys 확인)");

        log.info("[SURVEY] 신규 응답 등록 완료 - responseId={}", responseId);

        if (answers != null && !answers.isEmpty()) {
            for (Map.Entry<Long, Long> entry : answers.entrySet()) {
                surveyMapper.insertAnswer(responseId, entry.getKey(), entry.getValue(), null);
            }
        }

        log.info("[SURVEY] 응답 저장 완료 - userId={}, eventId={}, surveyId={}, responseId={}",
                userId, eventId, surveyId, responseId);
        return true;
    }

    /* ===== 기타 ===== */
    @Override
    public Long findSurveyIdByEvent(Long eventId) {
        return surveyMapper.findSurveyIdByEvent(eventId);
    }

    @Override
    public List<Map<String, Object>> findUnansweredSurveysByUser(Long userId) {
        List<Map<String, Object>> unanswered = surveyMapper.findUnansweredSurveysByUser(userId);
        log.info("[UNANSWERED] userId={} 미응답 설문 {}건", userId, unanswered.size());
        return unanswered;
    }

    @Override
    public String findLatestSurveyStatusByEvent(Long eventId) {
        return surveyMapper.findLatestSurveyStatusByEvent(eventId);
    }
}
