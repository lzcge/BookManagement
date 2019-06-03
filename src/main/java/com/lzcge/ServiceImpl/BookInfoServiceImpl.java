package com.lzcge.ServiceImpl;

import com.lzcge.Entity.BookInfo;
import com.lzcge.Mapper.BookInfoMapper;
import com.lzcge.Service.BookInfoService;
import com.lzcge.VO.BookInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class BookInfoServiceImpl implements BookInfoService {
	@Autowired
	BookInfoMapper bookInfoMapper;

	@Override
	public List<BookInfo> selectAllBook() {
		return bookInfoMapper.selectAllBook();
	}

	@Override
	public List<BookInfoVo> selectByBookName(String BookName) {
		List<BookInfo> bookInfoList = bookInfoMapper.selectByBookName(BookName);
		List<BookInfoVo> bookInfoVoList = new ArrayList<>();
		for (BookInfo book:bookInfoList ) {

			boolean flag = true;
			for (BookInfoVo bookinfovo:bookInfoVoList ) {
				if (book.getISBNCode().equals(bookinfovo.getBookInfo().getISBNCode())
						){
					if(book.getState()==0){
						bookinfovo.setCount(bookinfovo.getCount()+1);
						bookinfovo.setBookInfo(book);
					}
					bookinfovo.setTotalCount(bookinfovo.getTotalCount()+1);
					flag = false;
					break;

				}
			}
			if(flag){
				if(book.getState()==0){
					bookInfoVoList.add(new BookInfoVo(1,1,book));
				}else{
					bookInfoVoList.add(new BookInfoVo(1,0,book));
				}
			}

		}

		return bookInfoVoList;

	}

	@Override
	public List<BookInfo> wxselectByBookName(String BookName) {
		return bookInfoMapper.selectByBookName(BookName);
	}


	@Override
	public List<BookInfo> selectMoFuBookInfo(BookInfo bookInfo) {
		return bookInfoMapper.selectMoFuBookInfo(bookInfo);
	}


	@Override
	public List<BookInfo> borrowCheckByISBN(String bookISBN) {
		return bookInfoMapper.borrowCheckByISBN(bookISBN);
	}



	@Override
	public BookInfo selectByBookId(String bookId) {
		return bookInfoMapper.selectByBookId(bookId);
	}


	/**
	 * 查出图书表中的最后一本图书，来生成新的图书编码
	 * @return
	 */
	@Override
	public BookInfo selectEndBook() {
		return bookInfoMapper.selectEndBook();
	}


	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public Object updateBookInfo(BookInfo bookInfo) throws IllegalAccessException {
		Map<Integer,Object> resultMap = new HashMap<>();
		//判断当前图书是否存在
		BookInfo book = bookInfoMapper.selectByBookId(bookInfo.getBookId());
		if(book==null) resultMap.put(400,"图书不存在");
		else{
			try {
				bookInfoMapper.updateBookInfo(bookInfo);
				resultMap.put(200,"修改成功！");
			}catch (Exception e){
				e.printStackTrace();
				resultMap.put(500,"系统错误");
			}
		}
		return resultMap;

	}


	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public void insertBookInfo(BookInfo bookInfo) throws IllegalAccessException {
		try {
			bookInfoMapper.insertBookInfo(bookInfo);
		}catch (Exception e){
			throw new IllegalAccessException("图书插入出错");
		}
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public Object deleteBookInfo(BookInfo bookInfo)  {

		Map<Integer,Object> resultMap = new HashMap<>();
		//判断当前图书是否存在
		BookInfo book = bookInfoMapper.selectByBookId(bookInfo.getBookId());
		if(book==null){
			resultMap.put(400,"该图书不存在");
		}else if(book.getState()==0){
			resultMap.put(400,"图书已借出，不能删除!");
		}else{
			try {
				bookInfoMapper.deleteBookInfo(bookInfo);
				resultMap.put(200,"删除成功！");
			} catch (Exception e) {
				e.printStackTrace();
				resultMap.put(500,"系统错误");
			}
		}
		return resultMap;
	}
}
