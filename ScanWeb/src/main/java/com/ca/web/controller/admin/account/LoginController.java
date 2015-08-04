package com.ca.web.controller.admin.account;

import com.ca.entity.Staff;
import com.ca.service.admin.account.StaffService;
import com.ca.utils.captcha.util.CaptchaException;
import com.ca.utils.exception.SmsException;
import com.google.common.collect.ImmutableMap;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping(value = "/admin/am/login")
public class LoginController {
    private static final Logger log = LoggerFactory.getLogger(LoginController.class);
    @Autowired
    private StaffService staffService;
    
    @RequestMapping(method = RequestMethod.GET)
    public String showLoginForm(HttpServletRequest req, Model model) {
    	HttpSession session = req.getSession(true);
        if (SecurityUtils.getSubject().isAuthenticated()) {
            return "redirect:/admin/am/index";
        }
        model.addAttribute("error", "");
        return "admin/account/login";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String login(HttpServletRequest req, Model model) {
        log.info("login post 登录校验");
        HttpSession session = req.getSession(true);
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String captchaCode = req.getParameter("captchaCode");
        String smsCode = req.getParameter("smsCode");
        log.debug("username:" + username);
        log.debug("password:" + password);
        log.debug("captchaCode:" + captchaCode);
        log.debug("smsCode:" + smsCode);

//        if (this.getSmsFlag().equals("true")){
//            model.addAttribute("smsCodeFlag", "true");
//        }else{
//            model.addAttribute("smsCodeFlag", "false");
//        }

        String result = "admin/account/login";
        try {
        	String error = null;
        	 Staff staff = staffService.selectByStaffCode(username);
      		if (staff != null) {
      			if (staff.getStaffStatus().equals("0")) {
      				error = "3333";
      				model.addAttribute("error", error);
      				log.error("该用户已经停用，请联系管理员重新启用!");
      				return result;
      			} 
      		}
        	
            String exceptionClassName = (String) req.getAttribute("shiroLoginFailure");
            
            if (captchaCode.equals("") ||
                    captchaCode == null) {
                error = "9999";
                model.addAttribute("error", error);
                log.error("验证码为空");
                return result;
            }
            	
            log.error("exceptionClassName=" + exceptionClassName);

            if (exceptionClassName != null) {
                if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
                    error = "6666";//用户名不存在
                } else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
                    error = "7777";//用户名/密码错误
                } else if (CaptchaException.class.getName().equals(exceptionClassName)) {
                    error = "8888";//验证码错误

                } else if (SmsException.class.getName().equals(exceptionClassName)) {
                    error = "9997";//动态码错误
                    model.addAttribute("error", error);
                    session.removeAttribute("smsCode");
                    log.error("验证码输入不正确！");
                } else {
                    error = "5555";//其他错误
                    model.addAttribute("errorMsg", "其他错误");
                }

                model.addAttribute("error", error);
                result = "admin/account/login";
            } else {
                result = "admin/index";
            }
            log.info("error=" + error);
        } catch (Exception e) {
            log.error("异常=" + e.getMessage());
            e.printStackTrace();
            result = "admin/account/login";
        }
        log.info("登录后最终跳转页面面" + result);
        model.addAttribute("currentCommission", 1234);
        return result;

    }

    @ResponseBody
    @RequestMapping(value="/getSmsCode",method = RequestMethod.GET)
    public Map<String,Object> getSmsCode(String username,HttpServletRequest req){
        Map<String,Object> json = new HashMap<String, Object>();
        HttpSession session = req.getSession(true);
        if("".equals(username) || username == null){
            json.put("status",false);
            json.put("errorMsg","商户名不能为空");
            return json;
        }
        Staff staff = staffService.selectByStaffCode(username);
        if (staff != null) {
            int code = (int) (Math.random() * 899999) + 100000;
//            staffService.insertSms(staff.getMobile(), "商户动态短信验证码"
//                    + code + ",切勿泄漏![互联网云平台]");
            session.setAttribute("smsCode", String.valueOf(code));
            json.put("status",true);
            json.put("checkphone", staff.getLinkPhone());
            //json.put("smsCode",String.valueOf(code));
//            session.setAttribute("smsCode", "123456");
        }else {
            json.put("success", false);
            json.put("errorMsg", "商户号不存在");
            return json;
        }

        return json;
    }

    @ResponseBody
    @RequestMapping(value="/setSmsFlag",method = RequestMethod.GET)
    public Map<String,Object> setSmsFlag(String username,HttpServletRequest req){
        Map<String,Object> json = new HashMap<String, Object>();
        Staff staff = staffService.selectByStaffCode(username);
        if(staff !=null){
            String smsFlag = "";
            if(smsFlag.equals("1")){
                json.put("smsFlag",true);
//                this.setSmsFlag("true");
            }else{
                json.put("smsFlag",false);
//                this.setSmsFlag("false");
            }
            json.put("status",true);
        }else{
            json.put("status", false);
            json.put("errorMsg", "商户号不存在");
            return json;
        }

        return json;
    }
    
    @RequestMapping(value="checkUserName")
	@ResponseBody
	public Map<String,String> checkUsername(String username, HttpServletRequest request, Model model) {
		String msg ="";
		String result ="";
		String error = "";
		Staff sfi = staffService.selectByStaffCode(username);
		if (sfi != null) {
			if (sfi.getStaffStatus().equals("0")) {
				msg= "该用户已经停用，请联系管理员重新启用!";
				error = "3333";
				result = "success";
			} else {
				result = "failure";
			}
		} else {
			result = "failure";
		}
	
		return ImmutableMap.<String, String>of("result",result,"msg",msg,"error",error);
	}

}
