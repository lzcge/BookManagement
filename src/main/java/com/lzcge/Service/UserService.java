package com.lzcge.Service;

import com.lzcge.Entity.User;
import com.lzcge.Entity.UserInfo;

import java.util.List;

public interface UserService {

	public List<User> checkLogin(User user);

	public User selectByUId( String UserId);

	public void updatePassWord(UserInfo userInfo);

	public void insertUser(UserInfo userInfo) throws IllegalAccessException;

	public void deleteUser(UserInfo userInfo) throws IllegalAccessException;

	public List<User> selectUserMoFu(User user);
}
