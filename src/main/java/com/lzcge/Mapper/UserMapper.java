package com.lzcge.Mapper;

import com.lzcge.Entity.User;
import com.lzcge.Entity.UserInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


@Mapper
public interface UserMapper {

	public List<User> checkLogin( User user);

	public User selectByUId(@Param("UserId") String UserId);

	public void updatePassWord(UserInfo userInfo);

	public void insertUser(UserInfo userInfo);

	public void deleteUser(UserInfo userInfo);

	public List<User> selectUserMoFu(User user);
}
