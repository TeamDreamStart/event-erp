// src/main/java/.../controller/LogTestController.java

package kr.co.dreamstart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LogTestController {

    @GetMapping("/log-test")
    public String logTest() {
        log.info("INFO 파일 생성 테스트");
        log.warn("WARN 파일 생성 테스트");
        log.error("ERROR 파일 생성 테스트");
        System.out.println("CATALINA_BASE=" + System.getProperty("catalina.base"));
        return "home"; // 혹은 "forward:/", 아무 view나
    }
}
