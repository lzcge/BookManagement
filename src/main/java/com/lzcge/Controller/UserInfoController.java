package com.lzcge.Controller;

import com.lzcge.Entity.User;
import com.lzcge.Entity.UserInfo;
import com.lzcge.Service.UserInfoService;
import com.lzcge.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("/UserInfo")
@CrossOrigin
@Controller
//@SessionAttributes("userInfo")
public class UserInfoController {


	@Autowired
	UserService userService;
	@Autowired
	UserInfoService userInfoService;
	/**
	 * 到个人中心
	 * @return
	 */
	@RequestMapping(value = "/readerPerCenter",method = RequestMethod.GET)
	public String personalCenter(HttpServletRequest request,Model model){
		String uId = request.getParameter("id");
		//查出user
		User user = userService.selectByUId(uId);
		//查出这个读者的信息
		UserInfo userInfo = userInfoService.selectById(uId);
		userInfo.setUserName(user.getUserName());
		userInfo.setPassWord(user.getPassWord());
		request.getSession().setAttribute("userInfo",userInfo);
		model.addAttribute("userInfo",userInfo);
		return "readerPersonal";
	}

	/**
	 * 微信到个人中心
	 * @return
	 */
	@RequestMapping(value = "/wxreaderPerCenter",method = RequestMethod.GET)
	@ResponseBody
	public Object wxpersonalCenter(HttpServletRequest request){
		String uId = request.getParameter("id");
		//查出user
		User user = userService.selectByUId(uId);
		//查出这个读者的信息
		UserInfo userInfo = userInfoService.selectById(uId);
		userInfo.setUserName(user.getUserName());
		userInfo.setPassWord(user.getPassWord());
		return userInfo;
	}






	/**
	 * 读者修改资料
	 * @return
	 */
	@RequestMapping(value = "/updateReader",method = RequestMethod.GET)
	public String updateReader( HttpServletRequest request,Model model){
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("userInfo");
		model.addAttribute("userInfo",userInfo);
		return "readerAlterData";
	}

	@RequestMapping(value = "/updateReader",method = RequestMethod.POST)
	@ResponseBody
	public Object updateReaderData(UserInfo userInfo){
		Map<Integer,Object> resultMap = new HashMap<>();
		if(userInfo.getPhone().equals("") || userInfo.getEmail().equals("")) resultMap.put(400,"输入不合法");
		else{
			userInfoService.updateReader(userInfo);
			resultMap.put(200,"修改成功");
		}
		return resultMap;
	}



}
