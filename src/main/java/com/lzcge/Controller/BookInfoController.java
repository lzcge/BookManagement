package com.lzcge.Controller;

import com.lzcge.Entity.BookInfo;
import com.lzcge.Service.BookInfoService;
import com.lzcge.VO.BookInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/BookInfo")
@CrossOrigin
@Controller
public class BookInfoController {
	@Autowired
	BookInfoService bookInfoService;

	@RequestMapping(value = "/wxBookList",method = RequestMethod.GET)
	@ResponseBody
	public Object wxGetAllBookInfo(){
		return bookInfoService.selectAllBook();
	}

	@RequestMapping(value = "/BookList",method = RequestMethod.GET)
	public ModelAndView GetAllBookInfo(Model model){
		List<BookInfo> bookInfoList = bookInfoService.selectAllBook();
		model.addAttribute("bookInfoList",bookInfoList);
		return new ModelAndView("/bookList","BookInfoModel",model);
	}

	@RequestMapping(value = "/searchByName",method = RequestMethod.POST)
	@ResponseBody
	public Object SearchByName( BookInfo bookInfo){
		System.out.println("bookInfo"+bookInfo);
		String BookName = bookInfo.getBookName();
		System.out.println(BookName);
		List<BookInfoVo> bookInfoVoList = bookInfoService.selectByBookName(BookName);
		return bookInfoVoList;
	}

	/**
	 * 微信端按书名模糊检索
	 * @param bookInfo
	 * @return
	 */
	@RequestMapping(value = "/wxsearchByName",method = RequestMethod.POST)
	@ResponseBody
	public Object wxsearchByName( BookInfo bookInfo){
		System.out.println("bookInfo"+bookInfo);
		String BookName = bookInfo.getBookName();
		System.out.println(BookName);
		return bookInfoService.wxselectByBookName(BookName);
	}


	/**
	 * 获取最后一条图书信息，以得到插入的新的图书id
	 * @return
	 */
	@RequestMapping(value = "/getNewBookId",method = RequestMethod.POST)
	@ResponseBody
	public Object getNewBookId(){
		return bookInfoService.selectEndBook();
	}

	/**
	 * 根据图书的编号id查询一本图书
	 * @return
	 */
	@RequestMapping(value = "/getBookInfoByBookId",method = RequestMethod.POST)
	@ResponseBody
	public Object getBookInfoByBookId(BookInfo bookInfo){
		Map<Integer,Object> resultMap = new HashMap<>();
		BookInfo book = bookInfoService.selectByBookId(bookInfo.getBookId());
		if(book==null)
			resultMap.put(400,"图书不存在");
		else resultMap.put(200,book);
		return resultMap;
	}






}
