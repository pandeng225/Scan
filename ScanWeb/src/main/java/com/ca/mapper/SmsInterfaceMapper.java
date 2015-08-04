package com.ca.mapper;

import com.ca.entity.SmsInterface;

public interface SmsInterfaceMapper {
    int deleteByPrimaryKey(Integer smsNoticeId);

    int insert(SmsInterface record);

    int insertSelective(SmsInterface record);

    SmsInterface selectByPrimaryKey(Integer smsNoticeId);

    int updateByPrimaryKeySelective(SmsInterface record);

    int updateByPrimaryKey(SmsInterface record);
}