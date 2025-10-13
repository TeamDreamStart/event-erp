package kr.co.dreamstart.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.dreamstart.dto.Criteria;
import kr.co.dreamstart.dto.PageVO;
import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.dto.UserRoleDTO;
import kr.co.dreamstart.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Override
	public Map<String, Object> userList(Criteria cri, Integer role, String searchType, String keyword, String startDate,
			String endDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<UserDTO> userList = null;
		int totalUserCount = userMapper.count();
		// 검색X
		if (searchType == null || searchType.isEmpty()) {
			userList = userMapper.list(cri);
			// 검색O
		} else {
			// 검색어 공백 제거 처리
			keyword = keyword.replaceAll("\\s", "");
			userList = userMapper.search(cri, role, searchType, keyword, startDate, endDate);
			totalUserCount = userMapper.searchCount(role, searchType, keyword, startDate, endDate);
		}
		// 페이징 처리를 위한 객체
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(totalUserCount);
		// 현재 페이지가 총 페이지보다 크면 마지막 페이지로 보정
		if (cri.getPage() > pageVO.getTotalPage()) {
			cri.setPage(pageVO.getTotalPage() > 0 ? pageVO.getTotalPage() : 1);
		}
		map.put("userList", userList);
		map.put("totalUserCount", totalUserCount);
		map.put("pageVO", pageVO);
		map.put("cri", cri);

		return map;
	}

	public UserDTO userDetail(long userId) {
		return userMapper.findByUserId(userId);
	}

	// NAVER API 1. access token으로 네이버 API 호출
	public Map<String, String> getNaverUser(String accessToken) {
		String header = "Bearer " + accessToken;
		String apiURL = "https://openapi.naver.com/v1/nid/me";
		try {
			URI uri = new URI(apiURL);
			URL url = uri.toURL(); // URI → URL 변환
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);

			BufferedReader br;
			if (con.getResponseCode() == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();

			// JSON 파싱 (Jackson 또는 Gson)
			ObjectMapper mapper = new ObjectMapper();
			System.out.println("네이버 API 응답 : " + response.toString());
			JsonNode root = mapper.readTree(response.toString());
			JsonNode user = root.path("response");

			Map<String, String> result = new HashMap<>();
			result.put("snsId", user.path("id").asText());
			result.put("email", user.path("email").asText());
			result.put("name", user.path("name").asText());
			result.put("gender", user.path("gender").asText()); // F or M or U(unknown)
			result.put("birthyear", user.path("birthyear").asText()); // "1996"
			result.put("birthday", user.path("birthday").asText()); // "02-27"
			result.put("mobile", user.path("mobile").asText()); // "010-1234-5678"

			return result;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// Naver API 2. DB 처리
	@Transactional
	public UserDTO saveOrUpdateNaverUser(Map<String, String> naverUser) {
		UserDTO user = userMapper.findBySnsId(naverUser.get("snsId"));
		if (user == null) {
			user = userMapper.findByEmail(naverUser.get("email"));
		}

		if (user == null) {
			// 신규 회원
			UserDTO newUser = new UserDTO();
			newUser.setSnsId(naverUser.get("snsId"));
			newUser.setName(naverUser.get("name"));
			newUser.setEmail(naverUser.get("email"));

			String gender = naverUser.get("gender");
			if ("F".equals(gender))
				newUser.setGender(0);
			else if ("M".equals(gender))
				newUser.setGender(1);
			else
				newUser.setGender(2);

			String birthDate = naverUser.get("birthyear") + "-" + naverUser.get("birthday");
			newUser.setBirthDate(birthDate);
			newUser.setPhone(naverUser.get("mobile"));

			userMapper.joinNaver(newUser);
			userMapper.joinRole(newUser.getUserId());
			log.info("[USERSERVICE] 신규 회원 USER INFO : " + newUser);
			return newUser;
		} else {
			// 기존회원
			user.setSnsId(naverUser.get("snsId"));
			user.setName(naverUser.get("name"));
			user.setEmail(naverUser.get("email"));
			String gender = naverUser.get("gender");
			if ("F".equals(gender)) {
				user.setGender(0);
			} else if ("M".equals(gender)) {
				user.setGender(1);
			} else {
				user.setGender(2);
			}

			String birthyear = naverUser.get("birthyear");
			String birthday = naverUser.get("birthday");
			if (birthyear != null && birthday != null)
				user.setBirthDate(birthyear + "-" + birthday);

			user.setPhone(naverUser.get("mobile"));
			userMapper.updateNaver(user);
			log.info("[USERSERVICE] 기존 회원 USER INFO : " + user);
			return user;
		}
	}

	@Override
	public String getAccessToken(String code, String state) {
		String clientId = "9CN0AyXIHmflebLIalgz";
		String clientSecret = "3Hs13ybfZB";
		String redirectURI = null;
		try {
			redirectURI = URLEncoder.encode("http://localhost:8080/naver/callback", "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&client_id=" + clientId
				+ "&client_secret=" + clientSecret + "&redirect_uri=" + redirectURI + "&code=" + code + "&state="
				+ state;

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line, result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			br.close();

			ObjectMapper mapper = new ObjectMapper();
			JsonNode node = mapper.readTree(result);
			return node.get("access_token").asText();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Map<String, Object> adminUserUpdate(UserDTO userDTO, int roleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = -1;
		result = userMapper.adminUserUpdate(userDTO);
		if (result > 0) {
			log.info("[USERSERVICE] ADMIN - USER UPDATE SUCCESS / USERID : "+userDTO.getUserId());
			result = userMapper.adminUserRoleUpdate(roleId, userDTO.getUserId());
			if (result > 0) {
				log.info("[USERSERVICE] ADMIN - USER ROLE UPDATE SUCCESS / USERID : "+userDTO.getUserId());
				map.put("result", "success");
			} else {
				log.warn("[USERSERVICE] ADMIN - USER ROLE UPDATE FAIL / USERID : "+userDTO.getUserId());
				map.put("result", "fail");
			}
		} else {
			log.warn("[USERSERVICE] ADMIN - USER UPDATE FAIL / USERID : "+userDTO.getUserId());
			map.put("result", "fail");
		}
		return map;
	}

}
