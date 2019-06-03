package com.lzcge.Controller;


import com.lzcge.Entity.Manager;
import com.lzcge.Entity.SysAdmin;
import com.lzcge.Entity.User;
import com.lzcge.Entity.UserInfo;
import com.lzcge.Service.ManagerService;
import com.lzcge.Service.SysAdminService;
import com.lzcge.Service.UserInfoService;
import com.lzcge.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("/SysAdmin")
@Controller
public class SysAdminController {

	@Autowired
	SysAdminService sysAdminService;
	@Autowired
	UserInfoService userInfoService;
	@Autowired
	UserService userService;
	@Autowired
	ManagerService managerService;

	/**
	 * 系统管理员登录认证
	 * @return
	 */
	@RequestMapping(value = "/SysAdminLoginCheck",method = RequestMethod.POST)
	@ResponseBody
	public Object SysAdminLoginCheck(SysAdmin sysAdmin){

		//后台验证
		Map<Integer,Object> map = new HashMap<>();
		if(sysAdmin.getAdminId().equals("")) map.put(400,"UserIdNone");
		else if(sysAdmin.getAdminPassword().equals("")) map.put(400,"passwordNone");
		else{
			SysAdmin sysAd = sysAdminService.checkLogin(sysAdmin);
			if(sysAd!=null) map.put( 200,sysAd);
			else map.put(400, "用户不存在");
		}
		return map;
	}


	/**
	 * 系统管理员个人中心
	 * @return
	 */
	@RequestMapping(value = "/adminPersonal",method = RequestMethod.GET)
	public String adminPersonal(HttpServletRequest request, Model model){
		String adId = request.getParameter("id");
		SysAdmin sysAdmin = sysAdminService.selectById(adId);
		model.addAttribute("sysAdmin",sysAdmin);
		request.getSession().setAttribute("sysAdmin",sysAdmin);
		return "adminPersonal";
	}

	/**
	 * 更新数据
	 * @param sysAdmin
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/updateSysAdmain",method = RequestMethod.POST)
	@ResponseBody
	public Object updateSysAdmain(SysAdmin sysAdmin,HttpServletRequest request)  {
		SysAdmin sysAdmin1 = (SysAdmin) request.getSession().getAttribute("sysAdmin");
		sysAdmin.setAdminId(sysAdmin1.getAdminId());
		Map<Integer,Object> resultMap = new HashMap<>();
		try {
			sysAdminService.updateSysAdmain(sysAdmin);
			SysAdmin sysAdmin2 = sysAdminService.selectById(sysAdmin.getAdminId());
			resultMap.put(200,sysAdmin2);
		}catch (Exception e){
			e.printStackTrace();
			resultMap.put(500,"更新出现系统错误");
		}

		return resultMap;
	}


	/**
	 * 微信端更新数据前的验证
	 * @param sysAdmin
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/wxupdateDisplay",method = RequestMethod.POST)
	@ResponseBody
	public Object wxupdateDisplay(SysAdmin sysAdmin)  {
		Map<Integer,Object> resultMap = new HashMap<>();
		try {
			SysAdmin sysAdmin2 = sysAdminService.selectById(sysAdmin.getAdminId());
			resultMap.put(200,sysAdmin2);
		}catch (Exception e){
			e.printStackTrace();
			resultMap.put(500,"更新出现系统错误");
		}

		return resultMap;
	}


	/**
	 * 微信端更新数据
	 * @param sysAdmin
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/wxupdateSysAdmain",method = RequestMethod.POST)
	@ResponseBody
	public Object wxupdateSysAdmain(SysAdmin sysAdmin)  {
		Map<Integer,Object> resultMap = new HashMap<>();
		try {
			sysAdminService.updateSysAdmain(sysAdmin);
			SysAdmin sysAdmin2 = sysAdminService.selectById(sysAdmin.getAdminId());
			resultMap.put(200,sysAdmin2);
		}catch (Exception e){
			e.printStackTrace();
			resultMap.put(500,"更新出现系统错误");
		}

		return resultMap;
	}


	/**
	 * 添加新读者
	 *
	 */
	@RequestMapping(value = "/adminAddReader",method = RequestMethod.GET)
	public String adminAddReader(HttpServletRequest request,Model model){
		model.addAttribute("sysAdmin",request.getSession().getAttribute("sysAdmin"));
		return "adminAddReader";
	}


	@RequestMapping(value = "/adminAddReader",method = RequestMethod.POST)
	@ResponseBody
	public Object adminAddReaderData(UserInfo userInfo)  {
		Map<Integer,Object> resultMap = new HashMap<>();
		if(userInfoService.selectById(userInfo.getUserId())==null){
			try {
				userInfoService.insertUserInfo(userInfo);
				userService.insertUser(userInfo);
				resultMap.put(200,"插入成功");
			}catch (Exception e){
				e.printStackTrace();
				resultMap.put(500,"插入错误");
			}
		}else{
			resultMap.put(500,"此用户已存在");
		}

		return resultMap;
	}


	/**
	 * 验证读者是否存在并在前端回显
	 * @param userInfo
	 * @return
	 */
	@RequestMapping(value = "/adminOutReaderDisplay",method = RequestMethod.POST)
	@ResponseBody
	public Object adminOutReaderDisplay(UserInfo userInfo){
		Map<Integer,Object> resultMap =  new HashMap<>();
		UserInfo userInfo1 = userInfoService.selectById(userInfo.getUserId());
		User user = userService.selectByUId(userInfo.getUserId());
		if(userInfo1!=null && user!=null){
			userInfo1.setUserName(user.getUserName());
			userInfo1.setPassWord(user.getPassWord());
			resultMap.put(200,userInfo1);
		}else{
			resultMap.put(400,"没有该用户");
		}
		return resultMap;
	}


	/**
	 * 删除读者
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/adminOutReader",method = RequestMethod.GET)
	public String adminOutReader(HttpServletRequest request,Model model){
		model.addAttribute("sysAdmin",request.getSession().getAttribute("sysAdmin"));
		return "adminOutReader";
	}


	/**
	 * 删除用户
	 * @param userInfo
	 * @return
	 */
	@RequestMapping(value = "/adminOutReader",method = RequestMethod.POST)
	@ResponseBody
	public Object adminOutReaderData(UserInfo userInfo){
		Map<Integer,Object> resultMap =  new HashMap<>();
		try {
			userInfoService.deleteUserInfo(userInfo);
			userService.deleteUser(userInfo);
			resultMap.put(200,"删除成功");
		}catch (Exception e){
			resultMap.put(500,"删除错误");
		}
		return resultMap;
	}



	/**
	 * 修改读者
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/adminAlterReader",method = RequestMethod.GET)
	public String adminAlterReader(HttpServletRequest request,Model model){
		model.addAttribute("sysAdmin",request.getSession().getAttribute("sysAdmin"));
		return "adminAlterReader";
	}


	@RequestMapping(value = "/adminAlterReader",method = RequestMethod.POST)
	@ResponseBody
	public Object adminAlterReader(UserInfo userInfo){
		Map<Integer,Object> resultMap =  new HashMap<>();
		try {
			userInfoService.updateReader(userInfo);
			userService.updatePassWord(userInfo);
			resultMap.put(200,"删除成功");
		}catch (Exception e){
			resultMap.put(500,"删除错误");
		}
		return resultMap;
	}



	/**
	 * 添加管理员
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/adminAddAd",method = RequestMethod.GET)
	public String adminAddAd(HttpServletRequest request,Model model){
		model.addAttribute("sysAdmin",request.getSession().getAttribute("sysAdmin"));
		return "adminAddAd";
	}

	@RequestMapping(value = "/adminAddAd",method = RequestMethod.POST)
	@ResponseBody
	public Object adminAddAd(Manager manager){
		return managerService.insertManager(manager);
	}


	/**
	 * 验证管理员是否存在,并在前端回显
	 * @param manager
	 * @return
	 */
	@RequestMapping(value = "/adminOutAdDisplay",method = RequestMethod.POST)
	@ResponseBody
	public Object adminOutAdDisplay(Manager manager){
		Map<Integer,Object> resultMap =  new HashMap<>();
		Manager mana = managerService.selectById(manager.getAdId());
		if(mana!=null ){
			resultMap.put(200,mana);
		}else{
			resultMap.put(400,"此管理员不存在!");
		}
		return resultMap;
	}


	/**
	 * 删除管理员
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/adminOutAd",method = RequestMethod.GET)
	public String adminOutAd(HttpServletRequest request,Model model){
		model.addAttribute("sysAdmin",request.getSession().getAttribute("sysAdmin"));
		return "adminOutAd";
	}

	@RequestMapping(value = "/adminOutAd",method = RequestMethod.POST)
	@ResponseBody
	public Object adminOutAd(Manager manager){
		Map<Integer,Object> resultMap = new HashMap<>();
		try {
			managerService.deleteManagerById(manager.getAdId());
			resultMap.put(200,"删除成功");
		} catch (IllegalAccessException e) {
			e.printStackTrace();
			resultMap.put(500,"删除失败");
		}
		return resultMap;
	}


	/**
	 * 修改管理员信息
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/adminAlterAd",method = RequestMethod.GET)
	public String adminAlterAd(HttpServletRequest request,Model model){
		model.addAttribute("sysAdmin",request.getSession().getAttribute("sysAdmin"));
		return "adminAlterAd";
	}

	@RequestMapping(value = "/adminAlterAd",method = RequestMethod.POST)
	@ResponseBody
	public Object adminAlterAd(Manager manager){
		Map<Integer,Object> resultMap = new HashMap<>();
		try {
			managerService.updateAdmain(manager);
			resultMap.put(200,"修改成功");
		} catch (IllegalAccessException e) {
			e.printStackTrace();
			resultMap.put(500,"修改失败");
		}
		return resultMap;
	}


	/**
	 * 查询读者信息（根据借阅号或者用户名模糊查询）
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/adminSearchReader",method = RequestMethod.GET)
	public String adminSearchReader(HttpServletRequest request,Model model){
		model.addAttribute("sysAdmin",request.getSession().getAttribute("sysAdmin"));
		return "adminSearchReader";
	}

	@RequestMapping(value = "/adminSearchReader",method = RequestMethod.POST)
	@ResponseBody
	public Object adminSearchReader(UserInfo userInfo){
		return userInfoService.selectUserInfoMoFu(userInfo);
	}



	/**
	 * 查询读者信息（根据借阅号或者用户名模糊查询）
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/adminSearchAd",method = RequestMethod.GET)
	public String adminSearchAd(HttpServletRequest request,Model model){
		model.addAttribute("sysAdmin",request.getSession().getAttribute("sysAdmin"));
		return "adminSearchAd";
	}

	@RequestMapping(value = "/adminSearchAd",method = RequestMethod.POST)
	@ResponseBody
	public Object adminSearchAd(Manager manager){
		return managerService.selectManagerMoFu(manager);
	}




}
