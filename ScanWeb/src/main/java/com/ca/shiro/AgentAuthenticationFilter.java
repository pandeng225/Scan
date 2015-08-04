package com.ca.shiro;

import com.alibaba.fastjson.JSON;
import com.ca.security.Security;
import com.ca.service.admin.account.StaffService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.servlet.AdviceFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@Service
public class AgentAuthenticationFilter extends AdviceFilter {

	private static final Logger logger = LoggerFactory
			.getLogger(AgentAuthenticationFilter.class);

	/**
	 * Simple default login URL equal to <code>/agent/login</code>, which can be
	 * overridden by calling the {@link #setLoginUrl(String) setLoginUrl}
	 * method.
	 */
	public static final String DEFAULT_LOGIN_URL = "/agent/login";

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
		// 检查是否包含cookie
		Cookie matchCookie = getCookie(req, cookieName);
		if (matchCookie == null) {
			this.redirectToLogin(request, response);
			return false;
		}
		// 解密cookie
		String matchCookieValue = matchCookie.getValue();
		if (matchCookieValue == null) {
			this.redirectToLogin(request, response);
			return false;
		}
		String value = Security.getDecryptString(key, matchCookieValue);
		if (value == null) {
			this.redirectToLogin(request, response);
			return false;
		}
		// 更新cookie时间戳
		Map map = (Map) JSON.parse(value);
		logger.info("解密后用户信息：" + map);
		// 校验cookie
		if (map == null || map.get("AGENT_ID") == null) {
			this.redirectToLogin(request, response);
			return false;
		}
		map.put("CURRENT_TIME", System.currentTimeMillis());
		boolean auth=SecurityUtils.getSubject().isAuthenticated();
		if(!auth){//认证的时候会写cookie
			UsernamePasswordCaptchaToken token = new UsernamePasswordCaptchaToken();
			token.setUsername(String.valueOf(map.get("USERNAME")));
			token.setCookieAuth(true);

	        try {
	            Subject subject = SecurityUtils.getSubject();
	            subject.login(token);
	        } catch (AuthenticationException e) {
	        	this.redirectToLogin(request, response);
				return false;
	        }
		}else{//
		// cookie写回
		String newValue = Security
				.getEncryptString(key, JSON.toJSONString(map));
		Cookie newCookie = new Cookie(cookieName, newValue);
		newCookie.setDomain(domain);
		newCookie.setPath("/");
		newCookie.setMaxAge(maxAge);
		rsp.addCookie(newCookie);
		}


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

	
}
