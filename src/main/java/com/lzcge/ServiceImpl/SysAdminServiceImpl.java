package com.lzcge.ServiceImpl;

import com.lzcge.Entity.SysAdmin;
import com.lzcge.Mapper.SysAdminMapper;
import com.lzcge.Service.SysAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SysAdminServiceImpl implements SysAdminService{

	@Autowired
	SysAdminMapper sysAdminMapper;
	@Override
	public SysAdmin checkLogin(SysAdmin sysAdmin) {
		return sysAdminMapper.checkLogin(sysAdmin);
	}

	@Override
	public SysAdmin selectById(String adminId) {
		return sysAdminMapper.selectById(adminId);
	}


	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public void updateSysAdmain(SysAdmin sysAdmin) throws IllegalAccessException {
		try {
			sysAdminMapper.updateSysAdmain(sysAdmin);

		}catch (Exception e){
			throw new IllegalAccessException("更新异常");
		}
	}
}
