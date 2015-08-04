package com.ca.web.controller.admin;

import com.ca.shiro.realm.ShiroRealm;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class IndexController {
	

	@RequestMapping(value = "/admin/am/index",method = RequestMethod.GET)
    public String index(HttpServletRequest req,Model model) {
        ShiroRealm.AdminShiroUser user = (ShiroRealm.AdminShiroUser)SecurityUtils.getSubject().getPrincipal();
        model.addAttribute("user", user);
        return "admin/index";
//        return "test/showMarginAccount";
    }
	
}
