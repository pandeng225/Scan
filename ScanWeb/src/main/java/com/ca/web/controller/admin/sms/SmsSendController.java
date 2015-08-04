package com.ca.web.controller.admin.sms;

import com.ca.service.admin.sms.SmsSendService;
import com.ca.utils.PasswordHelper;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/am/sms")
public class SmsSendController {

	private static final Logger log = LoggerFactory
			.getLogger(SmsSendController.class);

	@Autowired
	private SmsSendService staffService;
	
    @Resource
	PasswordHelper passwordHelper;
    

	@RequestMapping(value = "/init",method = RequestMethod.GET)
	public String init(HttpServletRequest req, Model model) {
		return "admin/sms/smsSend";
	}


	@RequestMapping(value = "/batchIO", method = RequestMethod.POST)
	public String batchIO(@RequestParam("upload") CommonsMultipartFile file, @RequestParam("IOType") String IOType, HttpServletRequest req, Model model) {
		StringBuffer errorMsg = new StringBuffer("");
		String filename = file.getOriginalFilename();
		String suffix = filename.substring(filename.lastIndexOf("."));  // 文件后辍.
		List<String> excelSheets = null;
		if (file != null) {
			try {
				Workbook workBook = null;
				InputStream is = file.getInputStream();
				try {
					if (".xls".equals(suffix)) { //97-03
						workBook = new HSSFWorkbook(is);
					} else if (".xlsx".equals(suffix)) { //2007
						workBook = new XSSFWorkbook(is);
					} else {
						System.out.println("不支持的文件类型！");
						model.addAttribute("errorMsg", errorMsg.toString());
						return "admin/sms/smsSend";
					}
				} catch (Exception e) {
					System.out.println("解析xls文件出错！");
					e.printStackTrace();
				} finally {
					try {
						is.close();
					} catch (Exception e2) {
					}
				}
				int sheets = null != workBook ? workBook.getNumberOfSheets() : 0;
				if (sheets > 0) {
					excelSheets = new ArrayList<String>();
					Sheet sheet = workBook.getSheetAt(0); //读取第一个sheet
					int rows = sheet.getPhysicalNumberOfRows(); // 获得行数
					if (rows > 1) { //第一行默认为标题
						for (int j = 1; j < rows; j++) {
							Row row = sheet.getRow(j);
							int cells = row.getLastCellNum();// 获得列数

							excelSheets.add("");
						}
					} else {
						errorMsg.append("没有数据\n");
					}
				} else {
					errorMsg.append("没有数据\n");
				}

			} catch (IOException ex) {
				ex.printStackTrace();
			}
		} else {
			errorMsg.append("文件不存在！请重新上传\n");
		}
		if(excelSheets==null||excelSheets.size()<=0){
			model.addAttribute("errorMsg", errorMsg.toString());
			return "admin/sms/smsSend";
		}else{

		}
		model.addAttribute("errorMsg", errorMsg.toString());
		return "admin/sms/smsSend";
	}


}
