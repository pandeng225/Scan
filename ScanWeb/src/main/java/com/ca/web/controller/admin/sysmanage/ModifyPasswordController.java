package com.ca.web.controller.admin.sysmanage;

import com.ca.service.admin.sysmanage.ModifyPasswordService;
import com.ca.utils.AdminUtil;
import com.ca.utils.PasswordHelper;
import com.google.common.collect.ImmutableMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangxiang2 on 2015/4/16.
 */
@Controller
@RequestMapping("/admin/am/modifyPassword")
public class ModifyPasswordController {

    @Resource
    private ModifyPasswordService modifyPasswordService;

    @Resource
    private PasswordHelper passwordHelper;

    @RequestMapping("/init")
    public String modifyInit(){
        return "admin/sysmanage/modifypassword/modifyPassword";
    }

    @RequestMapping("checkOldPassWd")
    @ResponseBody
    public Map checkOldPassWd(String oldPassword){
        if(StringUtils.isBlank(oldPassword)){
            return ImmutableMap.of("result",false,"msg","原密码不能为空");
        }
        oldPassword = passwordHelper.encryptPassword(oldPassword);
        Map map = new HashMap();
        map.put("staffID", AdminUtil.getAdminStaff().getStaffId());
        map.put("oldPassword",oldPassword);
        map = modifyPasswordService.checkOldPassWd(map);
        return map;
    }

    @RequestMapping("modifyPassword")
    @ResponseBody
    public Map modifyPassword(String newPassword,String oldPassword){

        if(StringUtils.isBlank(newPassword)){
            return ImmutableMap.of("result",false,"msg","新密码不能为空");
        }
        if(StringUtils.isBlank(oldPassword)){
            return ImmutableMap.of("result",false,"msg","原密码不能为空");
        }

        newPassword = passwordHelper.encryptPassword(newPassword);
        oldPassword = passwordHelper.encryptPassword(oldPassword);

        Map map = new HashMap();
        map.put("staffID",AdminUtil.getAdminStaff().getStaffId());
        map.put("newPassword",newPassword);
        map.put("oldPassword",oldPassword);
        map = modifyPasswordService.modifyPassword(map);

        return map;
    }

}
