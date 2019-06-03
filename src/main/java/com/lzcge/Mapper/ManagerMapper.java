package com.lzcge.Mapper;

import com.lzcge.Entity.Manager;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ManagerMapper {

	public Manager checkLogin(Manager manager);

	public Manager selectById(@Param("adId") String adId);

	public void updateAdmain(Manager manager);

	public void insertManager(Manager manager);

	public void deleteManagerById(@Param("adId") String adId);

	public List<Manager> selectManagerMoFu(Manager manager);
}
