package com.ai.am;

import com.alibaba.fastjson.JSONObject;
import com.ca.entity.ScanRecord;
import org.junit.Test;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by wangxiang2 on 2015/5/8.
 */
public class BaseTest {

    @Test
    public void test1(){
        List<ScanRecord> scanRecords=new ArrayList<ScanRecord>();
        for(int i=0;i<5;i++){
            ScanRecord scanRecord=new ScanRecord();
            scanRecord.setEmployeename("测试"+i);
            scanRecord.setDepartment("测试" + i);
            scanRecord.setExpressno(String.valueOf(i));
            scanRecord.setScantime(new Date());
            scanRecords.add(scanRecord);
        }
        String a=JSONObject.toJSONString(scanRecords,true);
        List<ScanRecord>  scanRecords2= JSONObject.parseArray(a, ScanRecord.class);
    }

}
