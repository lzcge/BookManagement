package com.lzcge.Controller;

import com.lzcge.Entity.BookInfo;
import com.lzcge.Entity.BorrowRecord;
import com.lzcge.Entity.Manager;
import com.lzcge.Entity.UserInfo;
import com.lzcge.Service.BookInfoService;
import com.lzcge.Service.BorrowRecordService;
import com.lzcge.Service.ManagerService;
import com.lzcge.Service.UserInfoService;
import com.lzcge.VO.AdBorrowBookVo;
import com.lzcge.VO.AdCheckBookVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@RequestMapping("/Manager")
@Controller
public class ManagerController {

	@Autowired
	BookInfoService bookInfoService;

	@Autowired
	UserInfoService userInfoService;

	@Autowired
	BorrowRecordService borrowRecordService;

	@Autowired
	ManagerService managerService;

	/**
	 * 管理员登录认证
	 * @param manager
	 * @return
	 */
	@RequestMapping(value = "/managerLoginCheck",method = RequestMethod.POST)
	@ResponseBody
	public Object managerLoginCheck(Manager manager){
		//后台验证
		Map<Integer,Object> map = new HashMap<>();
		if(manager.getAdId().equals("")) map.put(400,"UserIdNone");
		else if(manager.getAdPassword().equals("")) map.put(400,"passwordNone");
		else{
			Manager mana = managerService.checkLogin(manager);
			if(mana!=null) map.put( 200,mana);
			else map.put(400, "用户不存在");
		}
		return map;
	}


	/**
	 * 借阅验证
	 * @return
	 */
	@RequestMapping(value = "/borrowCheck",method = RequestMethod.POST)
	@ResponseBody
	public Object borrowCheck(AdBorrowBookVo adBorrowBookVo){
		Map<Integer,Object> resultMap = new HashMap<>();
		//对当前图书是否还有可借库存进行验证
		BookInfo bookInfo =  bookInfoService.selectByBookId(adBorrowBookVo.getBookId());
		//查询当前用户
		UserInfo userInfo = userInfoService.selectById(adBorrowBookVo.getUserId());
		boolean flag = true;
		if(userInfo==null){
			resultMap.put(400,"借阅号不存在");
		}else if(bookInfo!=null){
			if (bookInfo.getState()==1){
				//如果可借验证当前用户是否还有借书的余量
				if(userInfo.getMax()-userInfo.getLendedNum()<1){
					resultMap.put(400,"用户借书数目超限");
				}else{
					resultMap.put(200,bookInfo);
				}
			}else{
				resultMap.put(400,"此书已被借");
			}
		}else{
			resultMap.put(400,"该图书不存在");
		}

		return resultMap;

	}



	/**
	 * 图书借阅
	 * @return
	 */
	@RequestMapping(value = "adBorrowBook",method = RequestMethod.GET)
	public String adBorrowBook(HttpServletRequest request,Model model){
		Manager manager = (Manager) request.getSession().getAttribute("manager");
		model.addAttribute("manager",manager);
		return "adBorrowBook";
	}

	/**
	 * 确认借阅，生成订单，更新数据库相关信息
	 * @param borrowRecord
	 * @return
	 */
	@RequestMapping(value = "/sureBorrow",method = RequestMethod.POST)
	@ResponseBody
	public Object insertBorrow(BorrowRecord borrowRecord){
		Map<Integer,Object> resultMap = new HashMap<>();
		try {
			borrowRecordService.addBorrowRecord(borrowRecord);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
			resultMap.put(500,"error");
		}
		BookInfo bookInfo = new BookInfo();
		bookInfo.setBookId(borrowRecord.getBookId());
		bookInfo.setState(0);
		try {
			bookInfoService.updateBookInfo(bookInfo);
			//获取插入的这个借阅记录（订单id通过插入获取自增主键）
			BorrowRecord borrowRecord1 = borrowRecordService.selBorrowById(borrowRecord.getBorrowID());
			resultMap.put(200,borrowRecord1);
		}catch (Exception e){
			e.printStackTrace();
			resultMap.put(500,"error");
		}
		return resultMap;
	}


	/**
	 * 还书
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/adReturnBook",method = RequestMethod.GET)
	public String AdReturnBook(HttpServletRequest request,Model model){
		Manager manager = (Manager) request.getSession().getAttribute("manager");
		model.addAttribute("manager",manager);
		return "adReturnBook";
	}

	@RequestMapping(value = "/adReturnBook",method = RequestMethod.POST)
	@ResponseBody
	public Object AdReturnBookData(BorrowRecord borrowRecord) throws IllegalAccessException {
		Map<Integer,Object> map = new HashMap<>();
		//查询出当前图书是否有在借记录
		borrowRecord.setState(0);
		BorrowRecord borrowRecord2 = borrowRecordService.selectBorrowByBookId(borrowRecord);
		if(borrowRecord2==null || borrowRecord2.getState()==1){
			map.put(400,"该图书没有被借阅，不能归还");
		}else{
			//判断是否超期
			Date date1 = new Date();
			int result = (int) ((date1.getTime() - borrowRecord2.getShouldTime().getTime() ) / (1000*3600*24));
			if(result>0) map.put(400,"图书超限");
			else{
				//还书操作
				BorrowRecord borr = new BorrowRecord();
				borr.setBookId(borrowRecord2.getBookId());
				borr.setReturnTime(date1);
				borr.setState(1);
				borrowRecordService.updateBorrowRecord(borr);
				BookInfo bookInfo = new BookInfo();
				bookInfo.setBookId(borrowRecord2.getBookId());
				bookInfo.setState(1);
				bookInfoService.updateBookInfo(bookInfo);
				map.put(200,"还书成功");
			}

		}

		return map;
	}


	/**
	 * 新书入库
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/adAddBook",method = RequestMethod.GET)
	public String adAddBook(HttpServletRequest request,Model model){
		Manager manager = (Manager) request.getSession().getAttribute("manager");
		model.addAttribute("manager",manager);
		return "adAddBook";
	}

	@RequestMapping(value = "/adAddBook",method = RequestMethod.POST)
	@ResponseBody
	public Object adAddBookData(BookInfo bookInfo) throws IllegalAccessException {
		//插入数据
		try {
			System.out.println(bookInfo.getBookId());
			bookInfo.setEnteringDate(new Date());
			bookInfoService.insertBookInfo(bookInfo);
			return 200;
		}catch (Exception e){
			e.printStackTrace();
			return "error";
		}
	}



	/**
	 * 验证管理员是否存在,并在前端回显
	 * @param bookInfo
	 * @return
	 */
	@RequestMapping(value = "/adOutBookDisplay",method = RequestMethod.POST)
	@ResponseBody
	public Object adOutBookDisplay(BookInfo bookInfo){
		Map<Integer,Object> resultMap =  new HashMap<>();
		BookInfo bookInfo1 = bookInfoService.selectByBookId(bookInfo.getBookId());
		if(bookInfo1!=null ){
			resultMap.put(200,bookInfo1);
		}else{
			resultMap.put(400,"此图书不存在!");
		}
		return resultMap;
	}

	/**
	 * 图书出库
	 * @return
	 */
	@RequestMapping(value = "/adOutBook",method = RequestMethod.GET)
	public String adOutBook(HttpServletRequest request,Model model){
		Manager manager = (Manager) request.getSession().getAttribute("manager");
		model.addAttribute("manager",manager);
		return "adOutBook";
	}


	@RequestMapping(value = "/adOutBook",method = RequestMethod.POST)
	@ResponseBody
	public Object adOutBookData(BookInfo bookInfo){
		return bookInfoService.deleteBookInfo(bookInfo);
	}

	/**
	 * 修改图书信息
	 * @return
	 */
	@RequestMapping(value = "/adAlterBook",method = RequestMethod.GET)
	public String adAlterBook(HttpServletRequest request,Model model){
		Manager manager = (Manager) request.getSession().getAttribute("manager");
		model.addAttribute("manager",manager);
		return "adAlterBook";
	}


	/**
	 * 图书管理员修改图书信息
	 * @param bookInfo
	 * @return
	 * @throws IllegalAccessException
	 */
	@RequestMapping(value = "/adAlterBook",method = RequestMethod.POST)
	@ResponseBody
	public Object adAlterBookData( BookInfo bookInfo) throws IllegalAccessException {
		return bookInfoService.updateBookInfo(bookInfo);
	}


	/**
	 * 管理员查询图书信息
	 * @return
	 */
	@RequestMapping(value = "/adSearchBook",method = RequestMethod.GET)
	public String adSearchBook(HttpServletRequest request,Model model){
		Manager manager = (Manager) request.getSession().getAttribute("manager");
		model.addAttribute("manager",manager);
		return "adSearchBook";
	}

	@RequestMapping(value = "/adSearchBook",method = RequestMethod.POST)
	@ResponseBody
	public Object adSearchBookData(BookInfo bookInfo){
		return bookInfoService.selectMoFuBookInfo(bookInfo);
	}


	/**
	 * 管理员查询借阅记录
	 * @return
	 */
	@RequestMapping(value = "/adCheckBook",method = RequestMethod.GET)
	public String adCheckBook(HttpServletRequest request,Model model){
		Manager manager = (Manager) request.getSession().getAttribute("manager");
		model.addAttribute("manager",manager);
		return "adCheckBook";
	}

	@RequestMapping(value = "/adCheckBook",method = RequestMethod.POST)
	@ResponseBody
	public Object adCheckBookData(BorrowRecord borrowRecord){
		//通过bookName作为媒介将查询的信息传过来并赋值给要查询的字段
		List<AdCheckBookVo> adCheckBookVoList = new ArrayList<>();
		borrowRecord.setUserId(borrowRecord.getBookName());
		borrowRecord.setBookId(borrowRecord.getBookName());
		List<BorrowRecord> borrowRecordList = borrowRecordService.selectAdBorrowMoFu(borrowRecord);
		for (BorrowRecord borrowRe:borrowRecordList ) {
			adCheckBookVoList.add(new AdCheckBookVo(borrowRe,bookInfoService.selectByBookId(borrowRe.getBookId())));
		}
		return adCheckBookVoList;
	}

	/**
	 * 管理员个人中心
	 * @return
	 */
	@RequestMapping(value = "/adPersonal",method = RequestMethod.GET)
	public String adPersonal(HttpServletRequest request,Model model){
		String adId = request.getParameter("id");
		Manager manager = managerService.selectById(adId);
		model.addAttribute("manager",manager);
		request.getSession().setAttribute("manager",manager);
		return "adPersonal";
	}

	@RequestMapping(value = "/updateAdmain",method = RequestMethod.POST)
	@ResponseBody
	public Object updateAdmain(Manager manager,HttpServletRequest request)  {
		Manager manager1 = (Manager) request.getSession().getAttribute("manager");
		manager.setAdId(manager1.getAdId());
		Map<Integer,Object> resultMap = new HashMap<>();
		try {
			managerService.updateAdmain(manager);
			Manager manager2 = managerService.selectById(manager.getAdId());
			resultMap.put(200,manager2);
		}catch (Exception e){
			e.printStackTrace();
			resultMap.put(500,"更新出现系统错误");
		}

		return resultMap;
	}

	@RequestMapping(value = "/wxupdateAdmain",method = RequestMethod.POST)
	@ResponseBody
	public Object wxupdateAdmain(Manager manager)  {
		try {
			managerService.updateAdmain(manager);
			return 200;
		}catch (Exception e){
			e.printStackTrace();
			return 500;
		}

	}







}
