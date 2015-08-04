package com.ca.mapper;

import com.ca.entity.SmsInterfaceHistory;

public interface SmsInterfaceHistoryMapper {
    int deleteByPrimaryKey(Integer smsNoticeId);

    int insert(SmsInterfaceHistory record);

    int insertSelective(SmsInterfaceHistory record);

    SmsInterfaceHistory selectByPrimaryKey(Integer smsNoticeId);

    int updateByPrimaryKeySelective(SmsInterfaceHistory record);

    int updateByPrimaryKey(SmsInterfaceHistory record);
}