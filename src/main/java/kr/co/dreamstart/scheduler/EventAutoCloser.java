package kr.co.dreamstart.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.co.dreamstart.service.EventService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component // 스프링 빈으로 등록
@RequiredArgsConstructor // 셍성자 주입 자동연결
@Slf4j
public class EventAutoCloser {
	private final EventService eventService;
	
	// 30분마다 자동 마감 전환
	@Scheduled(cron = "0 */30 * * * *")
	public void run() {
		// 종료시각 지난 open 이벤트들을 closed로 일괄 변경
		int n = eventService.closeExpiredEvents();
		if (n > 0) {
			// 로그에 건수 찍어 모니터링
			log.info("[Evnt] 자동 상태 전환(CLOSED) {}건", n);
		}
		
	}
}
