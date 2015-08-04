package com.ca.mapper;

import com.ca.entity.SmsSendObject;
import com.ca.entity.SmsSendObjectKey;

public interface SmsSendObjectMapper {
    int deleteByPrimaryKey(SmsSendObjectKey key);

    int insert(SmsSendObject record);

    int insertSelective(SmsSendObject record);

    SmsSendObject selectByPrimaryKey(SmsSendObjectKey key);

    int updateByPrimaryKeySelective(SmsSendObject record);

    int updateByPrimaryKey(SmsSendObject record);
}