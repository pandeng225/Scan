package com.ca.service.admin.sms;

import com.ca.mapper.StaffMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by pandeng on 2015/7/20.
 */
@Service
public class SmsSendService {
    Logger logger = LoggerFactory.getLogger(SmsSendService.class);

    @Autowired
    StaffMapper staffMapper;
}
