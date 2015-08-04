package com.ca.web.controller.admin.account;

import com.ca.entity.Staff;
import com.ca.service.admin.account.StaffService;
import com.ca.utils.PasswordHelper;
import com.ca.utils.captcha.Captcha;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin/am/register/rest")
public class RestPasswordController {

	private static final Logger log = LoggerFactory
			.getLogger(RestPasswordController.class);

	@Autowired
	private StaffService staffService;
	
    @Resource
	PasswordHelper passwordHelper;
    

	@RequestMapping(method = RequestMethod.GET)
	public String index(HttpServletRequest req, Model model) {
		HttpSession sess = req.getSession(true);
		return "admin/account/rest1";
	}

	@RequestMapping(value = "/checkAccount", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> rest1(HttpServletRequest req, String username,
			String captchaCode, Model model) {
		Map<String, Object> json = new HashMap<String, Object>();
		HttpSession session = req.getSession(true);
		Object obj_captcha = session.getAttribute(Captcha.NAME);
		if (obj_captcha != null && obj_captcha instanceof Captcha) {
			Captcha c = (Captcha) obj_captcha;
			if (!c.getAnswer().equalsIgnoreCase(captchaCode)) {
				json.put("success", false);
				json.put("errorMsg", "验证码错误");
				session.setAttribute("restpwd", "0");
				return json;
			}
		} else {
			json.put("success", false);
			json.put("errorMsg", "验证码错误");
			session.setAttribute("restpwd", "0");
			return json;
		}
		// status=1 0=待审核 1=正常 2=注销 9=审核未通过

		Staff staff = staffService.selectByStaffCode(username);
		if (staff != null) {
			if ("1".equals(staff.getStaffStatus())) {
				int code = (int) (Math.random() * 899999) + 100000;
				staffService.insertSms(staff.getLinkPhone(), "重置验证码"
						+ code + ",切勿泄漏![贵州联通电子商务营销服务平台]");
				session.setAttribute("smsCheckCode", String.valueOf(code));
				session.setAttribute("restpwd", "1");
				session.setAttribute("staffCode", staff.getStaffCode());

				json.put("success", true);
				json.put("errorMsg", "帐号校验成功,验证码已经发送到您注册的手机号");
				return json;
			} else {
				json.put("success", false);
				json.put("errorMsg", "账号异常,请联系管理员");
				session.setAttribute("restpwd", "0");
				return json;
			}
		} else {
			json.put("success", false);
			json.put("errorMsg", "账号不存在");
			session.setAttribute("restpwd", "0");
			return json;
		}
	}

	@RequestMapping(value = "/inputCode", method = RequestMethod.GET)
	public String rest2(HttpServletRequest req, Model model) {
		HttpSession sess = req.getSession(true);
		Object o = sess.getAttribute("restpwd");
		Object smsCheckCode = sess.getAttribute("smsCheckCode");
		Object staffCode = sess.getAttribute("staffCode");
		if (o != null && "1".equals(String.valueOf(o)) && smsCheckCode != null) {
			model.addAttribute("staffCode", staffCode);
			sess.setAttribute("restpwd", "2");
			return "admin/account/rest2";
		}
		return "admin/account/rest1";
	}

	@RequestMapping(value = "/submitPwd", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> submitPwd(HttpServletRequest req,
			String checkCode, String password, String rpassword, Model model) {
		Map<String, Object> json = new HashMap<String, Object>();
		HttpSession session = req.getSession(true);
		Object o = session.getAttribute("restpwd");
		Object staffCode = session.getAttribute("staffCode");
		if (o == null || !"2".equals(String.valueOf(o)) || staffCode == null) {
			json.put("success", false);
			json.put("errorMsg", "非法链接,请返回上一步提交商户号");
			session.setAttribute("restpwd", "0");
			return json;
		}
		if (password == null || rpassword == null
				|| !password.equals(rpassword)) {
			json.put("success", false);
			json.put("errorMsg", "重置的密码输入不一致");
			session.setAttribute("restpwd", "0");
			return json;
		}
		Object smsCheckCode = session.getAttribute("smsCheckCode");
		if (smsCheckCode == null || checkCode == null
				|| !checkCode.equals(smsCheckCode)) {
			json.put("success", false);
			json.put("errorMsg", "验证码异常,请返回上一步提交账号");
			session.setAttribute("restpwd", "0");
			return json;
		} else if (checkCode.equals(smsCheckCode)) {
			Staff staff = staffService.selectByStaffCode(String
					.valueOf(staffCode));
			if (staff != null) {
				staff.setPasswd(password);
				passwordHelper.encryptPassword(staff);
				staffService.updateByPrimaryKeySelective(staff);
				json.put("success", true);
				json.put("errorMsg", "密码重置成功");
				session.setAttribute("restpwd", "3");
				return json;
			} else {
				json.put("success", false);
				json.put("errorMsg", "账号不存在");
				session.setAttribute("restpwd", "0");
				return json;
			}
		}else{
			json.put("success", false);
			json.put("errorMsg", "验证码不一致,请返回上一步提交账号");
			session.setAttribute("restpwd", "0");
			return json;
		}

	}

}
