package com.ca.service.admin.sysmanage;

import com.ca.mapper.StaffMapper;
import com.google.common.collect.ImmutableMap;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Map;

/**
 * Created by wangxiang2 on 2015/4/16.
 */
@Service
public class ModifyPasswordService {

    @Resource
    private StaffMapper staffMapper;

    public Map checkOldPassWd(Map param){
        Map map = staffMapper.checkOldPassWd(param);
        if(map != null){
            BigDecimal amount = (BigDecimal) map.get("AMOUNT");
            if(amount.intValue()==1){
                return ImmutableMap.of("result",true);
            }
        }
        return ImmutableMap.of("result",false);
    }

    public Map modifyPassword(Map param){
        Integer r = staffMapper.modifyPassword(param);
        if(r==1){
            return ImmutableMap.of("result",true);
        }else{
            return ImmutableMap.of("result",false);
        }
    }

}
