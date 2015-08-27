package com.ai.am;

import com.ca.entity.ScanRecord;
import com.ca.service.admin.scan.ScanService;
import com.ca.web.controller.admin.scan.ScanController;
import org.apache.shiro.authc.Account;
import org.junit.BeforeClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Test {
	private  static ScanController service;

	@BeforeClass
	public static void init() {
		ApplicationContext
				context = new ClassPathXmlApplicationContext("spring/applicationContext.xml");
		service=(ScanController)context.getBean("ScanController");
	}

	@org.junit.Test
	public void testGetAcccountById() {

		List<ScanRecord> scanRecords=new ArrayList<ScanRecord>();
		for(int i=0;i<5;i++){
			ScanRecord scanRecord=new ScanRecord();
			scanRecord.setEmployeename("测试"+i);
			scanRecord.setDepartment("测试" + i);
			scanRecord.setExpressno(String.valueOf(i));
			scanRecord.setScantime(new Date());
			scanRecords.add(scanRecord);
		}
		service.add("","");
//		System.out.println(re);
	}

}
