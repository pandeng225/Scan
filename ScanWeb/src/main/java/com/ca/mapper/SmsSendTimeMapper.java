package com.ca.mapper;

import com.ca.entity.SmsSendTime;
import com.ca.entity.SmsSendTimeKey;

public interface SmsSendTimeMapper {
    int deleteByPrimaryKey(SmsSendTimeKey key);

    int insert(SmsSendTime record);

    int insertSelective(SmsSendTime record);

    SmsSendTime selectByPrimaryKey(SmsSendTimeKey key);

    int updateByPrimaryKeySelective(SmsSendTime record);

    int updateByPrimaryKey(SmsSendTime record);
}