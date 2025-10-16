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
		String text = 
			    "<div style='font-family:Arial, sans-serif; background-color:#f9f9f9; padding:30px;'>"
			  + "  <div style='max-width:600px; margin:0 auto; background:#fff; border:1px solid #e0e0e0; border-radius:8px; padding:30px;'>"
			  + "    <h2 style='color:#0066cc; text-align:center;'>TeamDS 이메일 인증</h2>"
			  + "    <p style='font-size:15px; color:#333;'>안녕하세요.<br>요청하신 <b>인증번호</b>입니다.</p>"
			  + "    <div style='margin:25px 0; text-align:center;'>"
			  + "      <div style='display:inline-block; background:#f2f8ff; border:2px solid #0066cc; border-radius:6px; padding:15px 25px;'>"
			  + "        <span style='font-size:22px; font-weight:bold; color:#0066cc; letter-spacing:2px;'>"
			  +            uuid
			  + "        </span>"
			  + "      </div>"
			  + "    </div>"
			  + "    <p style='font-size:14px; color:#666;'>"
			  + "      타인에게 인증번호를 절대 공유하지 마세요."
			  + "    </p>"
			  + "	 <p>"
			  + 		"인증번호를 정확히 입력해 주세요."
			  + "	 </p>"
			  + "    <hr style='margin:30px 0; border:none; border-top:1px solid #eee;'>"
			  + "    <p style='font-size:12px; color:#999; text-align:center;'>"
			  + "      본 메일은 발신 전용입니다. 문의사항은 TeamDS 고객센터를 이용해주세요.<br>"
			  + "      &copy; 2025 TeamDS. All rights reserved."
			  + "    </p>"
			  + "  </div>"
			  + "</div>";

		try {
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(msg, false, "UTF-8");
			helper.setTo(email); // 수신 이메일 - 인증번호 받을 이메일
			helper.setFrom("teamDS@dreamstart.com","DreamStart"); // 발신 이메일
			helper.setSubject("[TeamDS] 인증번호 발급");
			helper.setText(text, true);
			mailSender.send(msg);
			
			log.info("[EMAILSENDERSERVICE] SEND SUCCESS");
		} catch (Exception e) {
			e.printStackTrace();
			log.warn("[EMAILSENDERSERVICE] SEND FAIL");
		}
		return uuid;
	}
}
