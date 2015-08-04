package com.ca.service.admin.account;

import com.ca.entity.Role;
import com.ca.mapper.RoleMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wangxiang2 on 2015/3/7.
 */
@Service
public class RoleService {

    @Resource
    private RoleMapper roleMapper;

    public List<Role> selectRoleByStaffId(Integer staffId){
        return roleMapper.selectRoleByStaffId(staffId);
    }

}
