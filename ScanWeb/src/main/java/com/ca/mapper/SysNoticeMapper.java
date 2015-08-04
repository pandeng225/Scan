package com.ca.mapper;

import com.ca.entity.SysNotice;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

public interface SysNoticeMapper {
    int deleteByPrimaryKey(Long noticeId);

    int insert(SysNotice record);

    int insertSelective(SysNotice record);

    SysNotice selectByPrimaryKey(Long noticeId);

    int updateByPrimaryKeySelective(SysNotice record);

    int updateByPrimaryKey(SysNotice record);

    List<Map> findAllNotice(SysNotice notice,RowBounds rowBounds);
}