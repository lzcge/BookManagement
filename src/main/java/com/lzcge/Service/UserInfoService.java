package com.lzcge.Service;

import com.lzcge.Entity.User;
import com.lzcge.Entity.UserInfo;

import java.util.List;

public interface UserInfoService {

	public UserInfo selectById(String UserInfoId);

	public void updateReader(UserInfo userInfo);

	public void insertUserInfo(UserInfo userInfo) throws IllegalAccessException;

	public void deleteUserInfo(UserInfo userInfo) throws IllegalAccessException;

	public List<UserInfo> selectUserInfoMoFu(UserInfo userInfo);
}
