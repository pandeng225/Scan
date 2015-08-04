package com.ca.utils;

import com.ca.shiro.realm.ShiroRealm;
import org.apache.shiro.SecurityUtils;

/**
 * Created by wangxiang2 on 2015/3/11.
 */
public class AdminUtil {

    public static ShiroRealm.AdminShiroUser getAdminStaff(){
        ShiroRealm.AdminShiroUser adminShiroUser = (ShiroRealm.AdminShiroUser) SecurityUtils.getSubject().getPrincipal();
        return adminShiroUser;
    }

}
