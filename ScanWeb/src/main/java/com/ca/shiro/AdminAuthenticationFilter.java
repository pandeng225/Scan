package com.ca.shiro;

import com.ca.entity.AdminMenuTree;
import com.ca.mapper.CredentialsMatcherMapper;
import com.ca.service.admin.account.StaffService;
import com.ca.shiro.realm.ShiroRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.servlet.AdviceFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

@Service
public class AdminAuthenticationFilter extends AdviceFilter {

	private static final Logger logger = LoggerFactory
			.getLogger(AdminAuthenticationFilter.class);

	@Resource
	private CredentialsMatcherMapper credentialsMatcherMapper;

	/**
	 * Simple default login URL equal to <code>/admin/login</code>, which can be
	 * overridden by calling the {@link #setLoginUrl(String) setLoginUrl}
	 * method.
	 */
	public static final String DEFAULT_LOGIN_URL = "/admin/am/login";
	public static final String ADMIN_USER = "ADMIN_USER";
	public static final String CURR_MENU = "CURR_MENU";

	private String loginUrl = DEFAULT_LOGIN_URL;

	private String cookieName;
	private String domain;
	private String key;
	private int maxAge;
	@Autowired
	private StaffService staffService;

	protected boolean preHandle(ServletRequest request, ServletResponse response)
			throws Exception {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse rsp = (HttpServletResponse) response;
        if(!SecurityUtils.getSubject().isAuthenticated()){
            this.redirectToLogin(request, response);
			return false;
        }
        ShiroRealm.AdminShiroUser adminShiroUser = (ShiroRealm.AdminShiroUser) SecurityUtils.getSubject().getPrincipal();
		// 左侧菜单处理
		initSession(req, rsp, adminShiroUser);

		return true;
	}

	private Cookie getCookie(HttpServletRequest req, String name) {
		Cookie[] cookies = req.getCookies();

		Cookie matchCookie = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookieName.equals(cookie.getName())) {
					matchCookie = cookie;
					break;
				}
			}
		}
		return matchCookie;
	}

	/**
	 * 获取用户菜单信息
	 * 
	 * @param req
	 * @param rsp
	 * @param adminShiroUser
	 */
	private void initSession(HttpServletRequest req, HttpServletResponse rsp,
			ShiroRealm.AdminShiroUser adminShiroUser) throws Exception {
        ShiroRealm.AdminShiroUser user = (ShiroRealm.AdminShiroUser) req.getSession(true)
                .getAttribute(ADMIN_USER);
//		String staffId = MapUtils.getString(staffMap, "STAFF_ID");
        String staffId = String.valueOf(adminShiroUser.getStaffId());

		if (user == null||(user!=null&&!staffId.equals(user.getStaffId()))) {
			user = adminShiroUser;

			List<AdminMenuTree> menulist = staffService.getAdminMenu(staffId,
					System.currentTimeMillis());
			user.setMenu(menulist);// 获取用户菜单

			req.getSession(true).setAttribute(ADMIN_USER, user);
		}

		// 设置当前url
		AdminMenuTree currMenu = (AdminMenuTree) req.getSession(true)
				.getAttribute(CURR_MENU);
		if (currMenu != null)
			logger.info("*********当前菜单id：" + currMenu.getId() + ","
					+ currMenu.getName());
		String url = req.getRequestURI();
		boolean match = false;
		if (currMenu != null) {
			match = isMatchMenu(url, currMenu);
		}
		user = (ShiroRealm.AdminShiroUser) req.getSession(true)
				.getAttribute(ADMIN_USER);
		if (!match) {
			for (AdminMenuTree m : user.getMenu()) {
				for (AdminMenuTree c : m.getChildren()) {
					if (match = isMatchMenu(url, c)) {
						req.getSession(true).setAttribute(CURR_MENU, c);
						return;
					}
				}
			}
		}
		if(!match){
		// 都没找到匹配的
			if(currMenu!=null){
				//直接使用前面的菜单做为当前菜单
			}else if (user.getMenu().size() > 0) {
                AdminMenuTree defaultMenu = user.getMenu().get(0).getChildren().get(0);
				req.getSession(true).setAttribute(CURR_MENU, defaultMenu);
                WebUtils.issueRedirect(req,rsp,defaultMenu.getUrl());
			}
		}
		
	}

	private boolean isMatchMenu(String reqUrl, AdminMenuTree menu) {
		if (menu == null)
			return false;
		String curUrl = menu.getUrl();
		boolean match = false;
		if (curUrl != null) {
			if (curUrl.startsWith("http")) {
				try {
					curUrl = new URL(curUrl).getPath();
				} catch (MalformedURLException e) {
					return false;
				}
			}
			if (reqUrl.equals(curUrl)) {
				match = true; // 如果请求的和当前session的菜单一样,则不用从菜单树查询
			}
		}
		return match;
	}

	protected void redirectToLogin(ServletRequest request,
			ServletResponse response) throws IOException {
		if ("XMLHttpRequest"
				.equalsIgnoreCase(((HttpServletRequest) request)
						.getHeader("X-Requested-With"))) {// 是ajax请求
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.println("{\"success\":\"false\",\"result\":\"false\",\"msg\":\"请登录\"}");
			out.flush();
			out.close();
		}else{
			String loginUrl = getLoginUrl();
			WebUtils.issueRedirect(request, response, loginUrl);
		}
	}

	public String getLoginUrl() {
		return loginUrl;
	}

	public void setLoginUrl(String loginUrl) {
		this.loginUrl = loginUrl;
	}

	public String getCookieName() {
		return cookieName;
	}

	public void setCookieName(String cookieName) {
		this.cookieName = cookieName;
	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public int getMaxAge() {
		return maxAge;
	}

	public void setMaxAge(int maxAge) {
		this.maxAge = maxAge;
	}

    public CredentialsMatcherMapper getCredentialsMatcherMapper() {
        return credentialsMatcherMapper;
    }

    public void setCredentialsMatcherMapper(CredentialsMatcherMapper credentialsMatcherMapper) {
        this.credentialsMatcherMapper = credentialsMatcherMapper;
    }

}
