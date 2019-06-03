package com.lzcge.Mapper;

import com.lzcge.Entity.Manager;
import com.lzcge.Entity.SysAdmin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SysAdminMapper {

	public SysAdmin checkLogin(SysAdmin sysAdmin);

	public SysAdmin selectById(@Param("adminId") String adminId);

	public void updateSysAdmain(SysAdmin sysAdmin);
}
