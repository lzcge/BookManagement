package com.lzcge.Controller;

import com.lzcge.Entity.BookInfo;
import com.lzcge.Entity.BorrowRecord;
import com.lzcge.Entity.UserInfo;
import com.lzcge.Service.BookInfoService;
import com.lzcge.Service.BorrowRecordService;
import com.lzcge.Service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/BorrowRecord")
@CrossOrigin
public class BorrowRecordController {

	@Autowired
	BorrowRecordService borrowRecordService;
	@Autowired
	BookInfoService bookInfoService;
	@Autowired
	UserInfoService userInfoService;

	/**
	 * 查询读者在借图书
	 * @return
	 */
	@RequestMapping(value = "/selReaderBorrowing",method = RequestMethod.GET)
	public Object selReaderBorrowing(HttpServletRequest request, Model model){
		Map<String,Object> resultMap = new HashMap<>();
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("userInfo");
		BorrowRecord borrowRecord = new BorrowRecord();
		borrowRecord.setUserId(userInfo.getUserId());
		List<BorrowRecord> ReaderBorrowingList =  borrowRecordService.selReaderBorrowing(borrowRecord);
		resultMap.put("borrowedNumber",ReaderBorrowingList.size());
		resultMap.put("residualNumber",userInfo.getMax()-ReaderBorrowingList.size());
		resultMap.put("ReaderBorrowingList",ReaderBorrowingList);
		model.addAttribute("resultMap",resultMap);
		return new ModelAndView("readerBorrowing","ReaderBorrowingModel",model);

	}


	/**
	 * 查询读者在借图书
	 * @return
	 */
	@RequestMapping(value = "/wxselReaderBorrowing",method = RequestMethod.GET)
	@ResponseBody
	public Object wxselReaderBorrowing(HttpServletRequest request){
		Map<String,Object> resultMap = new HashMap<>();
		String userId = request.getParameter("id");
		UserInfo userInfo = userInfoService.selectById(userId);
		BorrowRecord borrowRecord = new BorrowRecord();
		borrowRecord.setUserId(userId);
		List<BorrowRecord> ReaderBorrowingList =  borrowRecordService.selReaderBorrowing(borrowRecord);
		resultMap.put("borrowedNumber",ReaderBorrowingList.size());
		resultMap.put("residualNumber",userInfo.getMax()-ReaderBorrowingList.size());
		resultMap.put("ReaderBorrowingList",ReaderBorrowingList);
		return resultMap;

	}

	/**
	 * 查询读者借过图书
	 * @return
	 */
	@RequestMapping(value = "/selReaderBorrowed",method = RequestMethod.GET)
	public Object selReaderBorrowed(HttpServletRequest request, Model model){
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("userInfo");
		BorrowRecord borrowRecord = new BorrowRecord();
		borrowRecord.setUserId(userInfo.getUserId());
		List<BorrowRecord> ReaderBorrowedList =  borrowRecordService.selReaderBorrowed(borrowRecord);
		model.addAttribute("ReaderBorrowedList",ReaderBorrowedList);
		return new ModelAndView("readerBorrowed","ReaderBorrowedModel",model);

	}

	/**
	 * 微信端查询读者借过图书
	 * @return
	 */
	@RequestMapping(value = "/wxselReaderBorrowed",method = RequestMethod.GET)
	@ResponseBody
	public Object wxselReaderBorrowed(HttpServletRequest request){
		Map<String,Object> resultMap = new HashMap<>();
		String userId = request.getParameter("id");
		BorrowRecord borrowRecord = new BorrowRecord();
		borrowRecord.setUserId(userId);
		List<BorrowRecord> ReaderBorrowedList =  borrowRecordService.selReaderBorrowed(borrowRecord);
		resultMap.put("readerBorrowed",ReaderBorrowedList);
		return resultMap;

	}






}
