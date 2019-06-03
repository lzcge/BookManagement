package com.lzcge.Controller;

import com.lzcge.Entity.User;
import com.lzcge.Entity.UserInfo;
import com.lzcge.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/User")
@CrossOrigin
@Controller
public class UserController {

	@Autowired
	UserService userService;

	@RequestMapping(value = "/readerLoginCheck",method = RequestMethod.POST)
	@ResponseBody
	public Object readerLoginCheck( User user){
		System.out.println(user.getUserId()+ " ------- "+user.getPassWord());
		//后台验证
		Map<Integer,Object> map = new HashMap<>();
		if(user.getUserId().equals("")) map.put(400,"UserIdNone");
		else if(user.getPassWord().equals("")) map.put(400,"passwordNone");
		else{
			List<User> userList = userService.checkLogin(user);
			if(userList.size()!=0) map.put( 200,userList.get(0));
			else map.put(400, "用户不存在");
		}
		return map;

	}

	/**
	 * 读者修改密码
	 * @return
	 */
	@RequestMapping(value = "/updateReaderPassword",method = RequestMethod.GET)
	public String updateReaderPassword(HttpServletRequest request,Model model){
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("userInfo");
		model.addAttribute("userInfo",userInfo);
		return "readerAlterPaswd";
	}

	@RequestMapping(value = "/updateReaderPassword",method = RequestMethod.POST)
	@ResponseBody
	public Object updateReaderPasdData(UserInfo userInfo){
		Map<Integer,Object> resultMap = new HashMap<>();
		//更改密码
		userService.updatePassWord(userInfo);
		resultMap.put(200,"修改成功");
		return resultMap;
	}








}
