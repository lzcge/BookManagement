package com.lzcge.Service;

import com.lzcge.Entity.Manager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ManagerService {

	public Manager checkLogin(Manager manager);

	public Manager selectById( String adId);

	public void updateAdmain(Manager manager) throws IllegalAccessException;

	public Object insertManager(Manager manager) ;

	public void deleteManagerById( String adId) throws IllegalAccessException;

	public List<Manager> selectManagerMoFu(Manager manager);
}
