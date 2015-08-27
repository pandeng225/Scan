package com.ca.web.controller.admin.scan;

import com.alibaba.fastjson.JSONObject;
import com.ca.entity.ScanRecord;
import com.ca.service.admin.scan.ScanService;
import com.ca.utils.PasswordHelper;
import com.ca.utils.pagination.model.Paging;
import com.ca.utils.pagination.util.StringUtils;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/admin/am/scan")
public class ScanController {

    private static final Logger log = LoggerFactory
            .getLogger(ScanController.class);

    @Autowired
    private ScanService scanService;


    @RequestMapping(value = "/findAllRecord", method = {RequestMethod.GET,RequestMethod.POST})
    public String findAllRecord(Model model, ScanRecord record, String pageSize,
                       String pageNo) {
        if (StringUtils.isEmpty(pageNo)) {
            pageNo = "1";
        }

        if (StringUtils.isEmpty(pageSize)) {
            pageSize = "5";
        }
        List<ScanRecord> result = new ArrayList<ScanRecord>();
        Paging<ScanRecord> pager = new Paging<ScanRecord>(
                Integer.valueOf(pageNo), Integer.valueOf(pageSize));
        result = scanService.findAllRecord(record, pager);
        pager.result(result);
        model.addAttribute("pager", pager);
        model.addAttribute("record", record);
        return "admin/scan/queryRecord";
    }

    @ResponseBody
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(@RequestParam("recordList") String recordList,@RequestParam("listSize")String listSize) {
        int insertNum=0,trueNum=0;
        HashMap<String,Object> resultMap=new HashMap<>();
        resultMap.put("result",false);
        if(listSize!=null&&listSize!=""){
            trueNum=Integer.valueOf(listSize);
            if(Integer.valueOf(listSize)>0){
                List<ScanRecord> scanRecords= JSONObject.parseArray(recordList,ScanRecord.class);
                insertNum=scanService.add(scanRecords);
            }
            if(insertNum<trueNum){
                resultMap.put("message","部分未插入");
            }
            resultMap.put("result",true);
            resultMap.put("message","成功");
        }else{
            resultMap.put("message","错误的列表数");
        }

        return JSONObject.toJSONString(resultMap);
    }
    @ResponseBody
    @RequestMapping(value = "/batchOut", method = RequestMethod.GET)
    public void batchOut(HttpServletRequest req,HttpServletResponse response,ScanRecord params) throws IOException {
        StringBuffer numberList = new StringBuffer("");
        List<ScanRecord> freeRecord=scanService.selectRecords(params);
        if(freeRecord!=null&&freeRecord.size()>0){
            for(ScanRecord number:freeRecord){
                numberList.append(number+"\r\n");
            }
        }else{
            numberList.append("没有空闲号码");
        }
        response.setContentType("text/html");
        //EXCEL名字为“工单报表”
        SimpleDateFormat sp=new SimpleDateFormat("yyyyMMdd");
        response.setHeader("Content-Disposition","attachment; filename="+sp.format(new Date())+".txt");
        OutputStream os=response.getOutputStream();
        BufferedOutputStream buff = new BufferedOutputStream(os);
        buff.write(numberList.toString().getBytes("UTF-8"));
        buff.flush();
        buff.close();
    }

}
