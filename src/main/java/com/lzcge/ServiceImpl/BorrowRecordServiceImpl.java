package com.lzcge.ServiceImpl;

import com.lzcge.Entity.BookInfo;
import com.lzcge.Entity.BorrowRecord;
import com.lzcge.Mapper.BookInfoMapper;
import com.lzcge.Mapper.BorrowRecordMapper;
import com.lzcge.Service.BorrowRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class BorrowRecordServiceImpl implements BorrowRecordService{

	@Autowired
	BorrowRecordMapper borrowRecordMapper;


	@Override
	public List<BorrowRecord> selReaderBorrowing(BorrowRecord borrowRecord) {
		return borrowRecordMapper.selReaderBorrowing(borrowRecord);
	}

	@Override
	public List<BorrowRecord> selReaderBorrowed(BorrowRecord borrowRecord) {
		return borrowRecordMapper.selReaderBorrowed(borrowRecord);
	}




	/**
	 * 根据图书的id编号查询借阅单号
	 * @param
	 * @return
	 */
	@Override
	public BorrowRecord selectBorrowByBookId(BorrowRecord borrowRecord) {
		return borrowRecordMapper.selectBorrowByBookId(borrowRecord);
	}


	/**
	 * 新添加订单
	 * @param borrowRecord
	 * @throws IllegalAccessException
	 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public void addBorrowRecord(BorrowRecord borrowRecord) throws IllegalAccessException {
		//获取当前时间
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date borrowTime = new Date();
		borrowRecord.setBorrowTime(borrowTime);
		Calendar rightNow = Calendar.getInstance();
		rightNow.setTime(borrowTime);
		rightNow.add(Calendar.MONTH, 1);   //应还时间为一个月后
		Date shouldTime = rightNow.getTime();
		borrowRecord.setShouldTime(shouldTime);
		try {
			borrowRecordMapper.addBorrowRecord(borrowRecord);
		}catch (Exception e){
			throw new IllegalAccessException("添加借阅记录失败");
		}


	}

	/**
	 * 根据借阅表id查询借阅记录
	 * @param borrowID
	 * @return
	 */
	@Override
	public BorrowRecord selBorrowById(Integer borrowID) {
		return borrowRecordMapper.selBorrowById(borrowID);
	}

	/**
	 * 更新借阅记录
	 * @param borrowRecord
	 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
	@Override
	public void updateBorrowRecord(BorrowRecord borrowRecord) throws IllegalAccessException {
		try {
			borrowRecordMapper.updateBorrowRecord(borrowRecord);
		}catch (Exception e){
			throw  new IllegalAccessException("更新借阅记录失败");
		}

	}


	/**
	 * 管理员查询借阅记录
	 * @param borrowRecord
	 * @return
	 */
	@Override
	public List<BorrowRecord> selectAdBorrowMoFu(BorrowRecord borrowRecord) {
		return borrowRecordMapper.selectAdBorrowMoFu(borrowRecord);
	}


}
