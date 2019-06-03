package com.lzcge.ServiceImpl;


import com.lzcge.Entity.User;
import com.lzcge.Entity.UserInfo;
import com.lzcge.Mapper.UserMapper;
import com.lzcge.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper userMapper;


	@Override
	public List<User> checkLogin(User user) {
		return userMapper.checkLogin(user);
	}

	@Override
	public User selectByUId(String UserId) {
		return userMapper.selectByUId(UserId);
	}

	@Override
	public void updatePassWord(UserInfo userInfo) {
		userMapper.updatePassWord(userInfo);
	}


	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public void insertUser(UserInfo userInfo) throws IllegalAccessException {
		try {
			userMapper.insertUser(userInfo);
		}catch (Exception e){
			throw new IllegalAccessException("插入异常");
		}
	}


	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public void deleteUser(UserInfo userInfo) throws IllegalAccessException {
		try {
			userMapper.deleteUser(userInfo);
		}catch (Exception e){
			throw  new IllegalAccessException("删除异常");
		}
	}

	@Override
	public List<User> selectUserMoFu(User user) {
		return userMapper.selectUserMoFu(user);
	}
}
