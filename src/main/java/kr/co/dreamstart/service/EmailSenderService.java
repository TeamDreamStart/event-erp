package kr.co.dreamstart.service;

import java.util.UUID;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmailSenderService {
	
	@Autowired
    private JavaMailSender mailSender;
	
	public String sendEmail(String email) {
		String uuid = UUID.randomUUID().toString();
		try {
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(msg, false, "UTF-8");
			helper.setFrom("teamDS@dreamstart.com"); // 발신 이메일
			helper.setTo(email); //인증번호 받을 이메일
			helper.setSubject("[TeamDS] 이메일 인증번호입니다.");
			helper.setText("인증번호는 [" + uuid + "]입니다.", false);
			mailSender.send(msg);
			
			log.info("[EMAILSENDERSERVICE] SEND SUCCESS");
		} catch (Exception e) {
			e.printStackTrace();
			log.warn("[EMAILSENDERSERVICE] SEND FAIL");
		}
		return uuid;
	}
}
