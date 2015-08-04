package com.ca.service.admin.decorater;

import com.ca.entity.SysDecorater;
import com.ca.mapper.SysDecoraterMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by wangxiang2 on 2015/3/17.
 */
@Service
public class DecoraterService {

    @Resource
    private SysDecoraterMapper decoraterMapper;

    public List<Map> getDecoraterByTypeId(String typeId){
        return decoraterMapper.findAllDecoraterByTypeId(typeId);
    }

    @Transactional
    public int batchInsert(List<SysDecorater> list){
        if(list != null && list.size()>0){
            SysDecorater sysDecorater = new SysDecorater();
                sysDecorater.setTypeId(list.get(0).getTypeId());
                sysDecorater.setDataKey(list.get(0).getDataKey());
                decoraterMapper.delete(sysDecorater);
            return decoraterMapper.batchInsert(list);
        }
        return 0;
    }



}
