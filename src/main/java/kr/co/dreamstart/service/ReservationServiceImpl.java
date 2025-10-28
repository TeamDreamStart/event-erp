package kr.co.dreamstart.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import kr.co.dreamstart.dto.PaymentDTO;
import kr.co.dreamstart.dto.ReservationDTO;
import kr.co.dreamstart.dto.ReservationJoinDTO;
import kr.co.dreamstart.mapper.PaymentMapper;
import kr.co.dreamstart.mapper.ReservationMapper;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private ReservationMapper rMapper;
	@Autowired
	private PaymentMapper pMapper;

	@Transactional
	@Override
	public Map<String, Object> reservationWithPay(ReservationDTO rDTO, PaymentDTO pDTO) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = -1;
		result = rMapper.insert(rDTO);// 예약정보 넣기 성공하면
		if (result > 0) {
			if (result > 0) {
				pDTO.setReservationId(rDTO.getReservationId());
				result = pMapper.insert(pDTO); // 결제정보 넣기
				if (result > 0) {
					map.put("result", "success");
					map.put("resultType", "예약 및 결제");
				} else {
					map.put("result", "fail");
					map.put("resultType", "예약 및 결제");
				}
			}
		}
		return map;
	}

	@Override
	public int reservation(ReservationDTO rDTO) {
		return rMapper.insert(rDTO);
	}

	@Override
	public long makeId(long eventId) {
		// 현재 날짜
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
		String dateStr = today.format(formatter);

		// 랜덤 4자리 숫자
		int random = (int) (Math.random() * 9000) + 1000; // 1000~9999

		// 예약번호 = 날짜 + 이벤트ID + 유저ID + 랜덤
		String reservationIdStr = dateStr + eventId + random;

		return Long.parseLong(reservationIdStr);
	}

	@Override
	public ReservationDTO selectById(long reservationId) {
		return rMapper.select(reservationId);
	}

	// reservation으로 옯겨야함
	@Override
	public List<ReservationJoinDTO> selectJoinPayByUserId(long userId) {
		return rMapper.selectJoinPayByUserId(userId);
	}

	@Override
	public ReservationJoinDTO selectJoinPayById(long reservationId) {
		return rMapper.selectJoinPayById(reservationId);
	}

	@Override
	public Map<String, Object> reservationCancel(long reservationId, String cancelReason) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = -1;
		result = rMapper.cancel(cancelReason, reservationId);
		PaymentDTO pDTO = pMapper.selectByReservationId(reservationId);
		if (result > 0) {
			if (pDTO != null) {
				result = pMapper.cancel(reservationId);
			}
			map.put("result", "success");
		} else {
			map.put("result", "fail");
		}
		map.put("resultType", "예약취소");
		return map;
	}

	@Override
	public List<ReservationJoinDTO> adminJoinList() {
		return rMapper.adminJoinList();
	}

	@Override
	public ReservationJoinDTO adminJoinSelect(long reservationId) {
		return rMapper.adminJoinSelect(reservationId);
	}

	@Override
	public String makeQR(long reservationId) {
		//reservation 정보를 담은 QR코드 생성, DB에 경로 저장
		ReservationDTO rDTO = rMapper.select(reservationId);
		long eventId = rDTO.getEventId();
		int headCount = rDTO.getHeadCount();
		String status = rDTO.getStatus();
		//예약정보
		String info = "이벤트:"+eventId+", 예약번호: "+reservationId+", 상태:"+status+", 인원: "+headCount;
		String fileName = reservationId+".png";
		int width = 300;
		int height = 300;
		try {
			BitMatrix bitMatrix = new QRCodeWriter().encode(info,BarcodeFormat.QR_CODE,width,height);
			BufferedImage qrImage = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
			for (int x = 0; x < width; x++) {
                for (int y = 0; y < height; y++) {
                    qrImage.setRGB(x, y, bitMatrix.get(x, y) ? 0xFF000000 : 0xFFFFFFFF);
                }
			}
			File qrFile = new File("/resources/img/tmp/"+ fileName);
			ImageIO.write(qrImage, "png", qrFile);
		} catch (WriterException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return fileName;
	}

}
