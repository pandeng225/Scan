package com.ca.service.admin.staticconstant;

import com.ca.entity.StaticConstant;
import com.ca.mapper.StaticConstantMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StaticConstantService {

    @Resource
    private StaticConstantMapper constantMapper;

    public List<StaticConstant> queryByTypeId(String typeId) {
        return constantMapper.queryByTypeId(typeId);
    }

    @Transactional(timeout = 50,isolation = Isolation.DEFAULT,propagation = Propagation.SUPPORTS,readOnly = false)
    public String queryByDataKey(String typeId, String dataKey) {
        return constantMapper.queryByDataKey(typeId, dataKey);
    }

	public StaticConstant queryBylevel(String typeId, String dataKey) {
		return constantMapper.queryBylevel(typeId, dataKey);
	}

	public List<StaticConstant> queryInTypeId(String typeId) {
		return constantMapper.queryInTypeId(typeId);
	}

}
