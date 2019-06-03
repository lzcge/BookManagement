package com.lzcge.ServiceImpl;


import com.lzcge.Entity.User;
import com.lzcge.Entity.UserInfo;
import com.lzcge.Mapper.UserInfoMapper;
import com.lzcge.Mapper.UserMapper;
import com.lzcge.Service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.regex.Pattern;

@Service
public class UserInfoServiceImpl implements UserInfoService {

	@Autowired
	UserInfoMapper userInfoMapper;
	@Autowired
	UserMapper userMapper;


	@Override
	public UserInfo selectById(String UserInfoId) {
		return userInfoMapper.selectById(UserInfoId);
	}

	@Override
	public void updateReader(UserInfo userInfo) {
		userInfoMapper.updateReader(userInfo);
	}


	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public void insertUserInfo(UserInfo userInfo) throws IllegalAccessException {
		try {
			userInfoMapper.insertUserInfo(userInfo);
		}catch (Exception e){
			throw new IllegalAccessException("插入异常");
		}
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public void deleteUserInfo(UserInfo userInfo) throws IllegalAccessException {
		try {
			userInfoMapper.deleteUserInfo(userInfo);
		}catch (Exception e){
			throw new IllegalAccessException("error");
		}
	}

	@Override
	public List<UserInfo> selectUserInfoMoFu(UserInfo userInfo) {
		String info = userInfo.getUserName();//输入的查询信息,放在userName中传到后台
		UserInfo userInfo1;
		Pattern pattern = Pattern.compile("[0-9]*");
		if(info.length()<=7 && pattern.matcher(info).matches()){
			userInfo1 = new UserInfo(info,info,info,info,info,Integer.valueOf(info),Integer.valueOf(info),Integer.valueOf(info));
		}else{
			userInfo1 = new UserInfo(info,info,info,info,info,Integer.MIN_VALUE,Integer.MIN_VALUE,Integer.MIN_VALUE);
		}
		userInfo1.setUserName(info);
		return userInfoMapper.selectUserInfoMoFu(userInfo1);
	}
}
