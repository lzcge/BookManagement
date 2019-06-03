package com.lzcge.Service;

import com.lzcge.Entity.SysAdmin;

public interface SysAdminService {

	public SysAdmin checkLogin(SysAdmin sysAdmin);

	public SysAdmin selectById( String adminId);

	public void updateSysAdmain(SysAdmin sysAdmin) throws IllegalAccessException;
}
