package kr.co.dreamstart.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.dreamstart.dto.UserDTO;
import kr.co.dreamstart.mapper.UserMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
	private final UserMapper userMapper;
	
	@Override
	@Transactional
	public long register(UserDTO form) {
		// TODO Auto-generated method stub
		userMapper.join(form);
		userMapper.joinRole(form.getUserId());
		return form.getUserId();
	}

	@Override
	public UserDTO findByLogin(String login) {
		// TODO Auto-generated method stub
		return userMapper.findByLogin(login);
	}

	@Override
	public List<String> findRoleNames(Long userId) {
		// TODO Auto-generated method stub
		return userMapper.findRoleNameByUserId(userId);
	}

	@Override
	public void touchLastLogin(Long userId) {
		// TODO Auto-generated method stub
		userMapper.updateLastLoginAt(userId);
	}

}
