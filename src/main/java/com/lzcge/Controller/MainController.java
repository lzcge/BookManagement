package com.lzcge.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@RequestMapping("/Main")
@Controller
public class MainController {

	/**
	 * 图书检索界面
	 * @return
	 */
	@RequestMapping(value = "/searchBook",method = RequestMethod.GET)
	public String searchBook(){
		return "searchResult";
	}

	/**
	 * 登录界面
	 * @return
	 */
	@RequestMapping(value = "/login",method = RequestMethod.GET)
	public String login(){
		return "login";
	}

	/**
	 * 退出登录
	 * @return
	 */
	@RequestMapping(value = "/logout",method = RequestMethod.GET)
	public String logout(HttpServletRequest request){
		request.getSession().invalidate();
		return "index";
	}

	/**
	 * 到首页
	 * @return
	 */
	@RequestMapping(value = "/index",method = RequestMethod.GET)
	public String index(){
		return "index";
	}


	/**
	 * 首页检索调到检索页面
	 * @return
	 */
	@RequestMapping(value = "/indexSearch",method = RequestMethod.GET)
	public String indexSearch(){
		return "searchResult";
	}






}
