package com.ca.web.controller.admin.file;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

/**
 * 文件上传导入时一些辅助功能
 * @author wanghong
 *
 */
public class FileUploadUtil {

	static final Logger logger = LoggerFactory
			.getLogger(FileUploadUtil.class);

	public static boolean checktype(String filename, HttpServletRequest request, Model model) {

		if(!(filename.substring(filename.length()-4)).equals(".xls")  &&!(filename.substring(filename.length()-5)).equals(".xlsx")){
			String msg = "选择文件格式不正确，不是Excel，请重新选择!";
			model.addAttribute("msg", msg);
			return false;
		}else{
			return true;
		}
	}

	//判断单元格cell的类型并且做出相应的转换
	public static String getCellValue (FormulaEvaluator evaluator,Cell cell) 
	{
		String strCell = "";
		DecimalFormat df = new DecimalFormat("#.##");
		if(cell!=null){
			try{
				CellValue cellValue =evaluator.evaluate(cell);
				switch(cellValue.getCellType()){
				case Cell.CELL_TYPE_STRING:
					strCell = cellValue.getStringValue();
					break;
				case Cell.CELL_TYPE_NUMERIC:
	                if(HSSFDateUtil.isCellDateFormatted(cell)){
	                    strCell = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(cell.getDateCellValue());
	                }else {
	                    strCell = df.format(cell.getNumericCellValue());
	                }
					break;
				case Cell.CELL_TYPE_BLANK:
					strCell = "";
					break;
				case Cell.CELL_TYPE_BOOLEAN:
					strCell = String.valueOf(cellValue.getBooleanValue());
					break;
				default:
				    strCell = "";
			        break;
				}
			}catch(Exception ex){
				return "";
			}
		}
	return strCell;
	}

    /**
     * 元转厘
     * @param m
     * @return
     */
    public static Long getLongValue(String m){
        return Long.valueOf(new BigDecimal(m).multiply(new BigDecimal(1000)).longValue());
    }

}
