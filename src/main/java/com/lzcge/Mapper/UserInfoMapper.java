package com.lzcge.Mapper;

import com.lzcge.Entity.User;
import com.lzcge.Entity.UserInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


@Mapper
public interface UserInfoMapper {

	public UserInfo selectById(@Param("UserId") String UserInfoId);

	public void updateReader(UserInfo userInfo);

	public void insertUserInfo(UserInfo userInfo);

	public void deleteUserInfo(UserInfo userInfo);

	public List<UserInfo> selectUserInfoMoFu(UserInfo userInfo);

}
