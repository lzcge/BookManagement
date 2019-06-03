package com.lzcge.ServiceImpl;

import com.lzcge.Entity.Manager;
import com.lzcge.Mapper.ManagerMapper;
import com.lzcge.Service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ManagerServiceImpl implements ManagerService{
	@Autowired
	ManagerMapper managerMapper;


	@Override
	public Manager checkLogin(Manager manager) {
		return managerMapper.checkLogin(manager);
	}

	@Override
	public Manager selectById(String adId) {
		return managerMapper.selectById(adId);
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public void updateAdmain(Manager manager) throws IllegalAccessException {
		try {
			managerMapper.updateAdmain(manager);
		}catch (Exception e){
			throw new IllegalAccessException("更新异常");
		}
	}


	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public Object insertManager(Manager manager) {
		Manager mana = managerMapper.selectById(manager.getAdId());
		Map<Integer,Object> resultMap =  new HashMap<>();
		if(mana==null){
			try {
				managerMapper.insertManager(manager);
				resultMap.put(200,"添加成功");
			}catch (Exception e){
				e.printStackTrace();
				resultMap.put(500,"添加错误");
			}
		}else{
			resultMap.put(400,"此编号已存在重新输入");
		}
		return resultMap;
	}


	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public void deleteManagerById(String adId) throws IllegalAccessException {
		try {
			managerMapper.deleteManagerById(adId);
		}catch (Exception e){
			throw new IllegalAccessException("删除管路员错误");
		}
	}

	@Override
	public List<Manager> selectManagerMoFu(Manager manager) {
		String info = manager.getAdName();//将查询信息放在名字中传入
		manager.setAdId(info);
		manager.setAdPhone(info);
		manager.setAdEmail(info);
		return managerMapper.selectManagerMoFu(manager);
	}
}
