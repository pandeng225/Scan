package com.ca.shiro;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class FormAuthenticationCaptchaFilter extends FormAuthenticationFilter {
	public static final String DEFAULT_ERROR_KEY_ATTRIBUTE_NAME = "shiroLoginFailure";

	public static final String DEFAULT_USERNAME_PARAM = "username";
	public static final String DEFAULT_PASSWORD_PARAM = "password";
	public static final String DEFAULT_USERTYPE_PARAM = "usertype";
	public static final String DEFAULT_ANSWER_PARAM = "answer";
    public static final String DEFAULT_SMSCODE_PARAM = "smsCode";
	public static final String DEFAULT_REMEMBER_ME_PARAM = "rememberMe";
	public static final String DEFAULT_REMEMBER_NAME_PARAM = "rememberName";

	private static final Logger log = LoggerFactory
			.getLogger(FormAuthenticationCaptchaFilter.class);

	private String usernameParam = DEFAULT_USERNAME_PARAM;
	private String passwordParam = DEFAULT_PASSWORD_PARAM;
	private String usertypeParam = DEFAULT_USERTYPE_PARAM;
	private String answerParam = DEFAULT_ANSWER_PARAM;
    private String smsCodeParam = DEFAULT_SMSCODE_PARAM;
	private String rememberMeParam = DEFAULT_REMEMBER_ME_PARAM;
	private String rememberNameParam = DEFAULT_REMEMBER_NAME_PARAM;

    public String getSmsCodeParam() {
        return smsCodeParam;
    }

    public void setSmsCodeParam(String smsCodeParam) {
        this.smsCodeParam = smsCodeParam;
    }

    private String failureKeyAttribute = DEFAULT_ERROR_KEY_ATTRIBUTE_NAME;

	public FormAuthenticationCaptchaFilter() {
		setLoginUrl(DEFAULT_LOGIN_URL);
	}

	@Override
	public void setLoginUrl(String loginUrl) {
		String previous = getLoginUrl();
		if (previous != null) {
			this.appliedPaths.remove(previous);
		}
		super.setLoginUrl(loginUrl);
		if (log.isTraceEnabled()) {
			log.trace("Adding login url to applied paths.");
		}
		this.appliedPaths.put(getLoginUrl(), null);
	}

	public String getUsernameParam() {
		return usernameParam;
	}

	/**
	 * Sets the request parameter name to look for when acquiring the username.
	 * Unless overridden by calling this method, the default is
	 * <code>username</code>.
	 * 
	 * @param usernameParam
	 *            the name of the request param to check for acquiring the
	 *            username.
	 */
	public void setUsernameParam(String usernameParam) {
		this.usernameParam = usernameParam;
	}

	public String getPasswordParam() {
		return passwordParam;
	}

	/**
	 * Sets the request parameter name to look for when acquiring the password.
	 * Unless overridden by calling this method, the default is
	 * <code>password</code>.
	 * 
	 * @param passwordParam
	 *            the name of the request param to check for acquiring the
	 *            password.
	 */
	public void setPasswordParam(String passwordParam) {
		this.passwordParam = passwordParam;
	}

	public String getRememberMeParam() {
		return rememberMeParam;
	}

	/**
	 * Sets the request parameter name to look for when acquiring the rememberMe
	 * boolean value. Unless overridden by calling this method, the default is
	 * <code>rememberMe</code>.
	 * <p/>
	 * RememberMe will be <code>true</code> if the parameter value equals any of
	 * those supported by
	 * {@link org.apache.shiro.web.util.WebUtils#isTrue(javax.servlet.ServletRequest, String)
	 * WebUtils.isTrue(request,value)}, <code>false</code> otherwise.
	 * 
	 * @param rememberMeParam
	 *            the name of the request param to check for acquiring the
	 *            rememberMe boolean value.
	 */
	public void setRememberMeParam(String rememberMeParam) {
		this.rememberMeParam = rememberMeParam;
	}

	public String getFailureKeyAttribute() {
		return failureKeyAttribute;
	}

	public void setFailureKeyAttribute(String failureKeyAttribute) {
		this.failureKeyAttribute = failureKeyAttribute;
	}

	protected boolean onAccessDenied(ServletRequest request,
			ServletResponse response) throws Exception {
		if (isLoginRequest(request, response)) {
			if (isLoginSubmission(request, response)) {
				if (log.isTraceEnabled()) {
					log.trace("Login submission detected.  Attempting to execute login.");
				}
				if ("XMLHttpRequest"
						.equalsIgnoreCase(((HttpServletRequest) request)
								.getHeader("X-Requested-With"))) {// 是ajax请求
					response.setCharacterEncoding("UTF-8");
					PrintWriter out = response.getWriter();
					out.println("{\"result\":\"false\",\"msg\":\"请登录\"}");
					out.flush();
					out.close();
					return false;
				}
				return executeLogin(request, response);
			} else {
				if (log.isTraceEnabled()) {
					log.trace("Login page view.");
				}
				// allow them to see the login page ;)
				return true;
			}
		} else {
			if (log.isTraceEnabled()) {
				log.trace("Attempting to access a path which requires authentication.  Forwarding to the "
						+ "Authentication url [" + getLoginUrl() + "]");
			}
			if (!"XMLHttpRequest"
					.equalsIgnoreCase(((HttpServletRequest) request)
							.getHeader("X-Requested-With"))) {// 不是ajax请求
				saveRequestAndRedirectToLogin(request, response);
			} else {
				response.setCharacterEncoding("UTF-8");
				PrintWriter out = response.getWriter();
				out.println("{\"result\":\"false\",\"msg\":\"请先登录\"}");
				out.flush();
				out.close();
			}
			return false;
		}

	}

	/**
	 * This default implementation merely returns <code>true</code> if the
	 * request is an HTTP <code>POST</code>, <code>false</code> otherwise. Can
	 * be overridden by subclasses for custom login submission detection
	 * behavior.
	 * 
	 * @param request
	 *            the incoming ServletRequest
	 * @param response
	 *            the outgoing ServletResponse.
	 * @return <code>true</code> if the request is an HTTP <code>POST</code>,
	 *         <code>false</code> otherwise.
	 */
	@SuppressWarnings({})
	protected boolean isLoginSubmission(ServletRequest request,
			ServletResponse response) {
		return (request instanceof HttpServletRequest)
				&& WebUtils.toHttp(request).getMethod()
						.equalsIgnoreCase(POST_METHOD);
	}

	protected AuthenticationToken createToken(ServletRequest request,
			ServletResponse response) {
		String username = getUsername(request);
		String password = getPassword(request);
		String usertype = getUsertype(request);
		String answer = getAnswer(request);
        String smsCode = getSmsCode(request);
		boolean rememberMe = isRememberMe(request);
		boolean rememberName = isRememberName(request);
		String host = getHost(request);

		return new UsernamePasswordCaptchaToken(username, password, rememberMe,
				host, usertype, answer, rememberName,smsCode);
	}

	protected boolean isRememberMe(ServletRequest request) {
		return WebUtils.isTrue(request, getRememberMeParam());
	}

	protected boolean isRememberName(ServletRequest request) {
		return WebUtils.isTrue(request, getRememberNameParam());
	}

	protected boolean onLoginSuccess(AuthenticationToken token,
			Subject subject, ServletRequest request, ServletResponse response)
			throws Exception {
		// we handled the success redirect directly, prevent the chain from
		// continuing:
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;

		if (!"XMLHttpRequest".equalsIgnoreCase(httpServletRequest
				.getHeader("X-Requested-With"))) {// 不是ajax请求
			issueSuccessRedirect(request, response);
		} else {
			httpServletResponse.setCharacterEncoding("UTF-8");
			PrintWriter out = httpServletResponse.getWriter();
			out.println("{\"result\":\"true\",\"msg\":\"登入成功\"}");
			out.flush();
			out.close();
		}
		return false;

	}

	protected boolean onLoginFailure(AuthenticationToken token,
			AuthenticationException e, ServletRequest request,
			ServletResponse response) {
		// login failed, let request continue back to the login page:
		if (!"XMLHttpRequest".equalsIgnoreCase(((HttpServletRequest) request)
				.getHeader("X-Requested-With"))) {// 不是ajax请求
			setFailureAttribute(request, e);
			return true;
		}
		try {
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String message = e.getClass().getSimpleName();
			if ("IncorrectCredentialsException".equals(message)) {
				out.println("{\"result\":\"false\",\"msg\":\"密码错误\"}");
			} else if ("UnknownAccountException".equals(message)) {
				out.println("{\"result\":\"false\",\"msg\":\"账号不存在\"}");
			} else if ("LockedAccountException".equals(message)) {
				out.println("{\"result\":\"false\",\"msg\":\"账号被锁定\"}");
			} else {
				out.println("{\"result\":\"false\",\"msg\":\"未知错误\"}");
			}
			out.flush();
			out.close();
		} catch (IOException e1) {
			e1.printStackTrace();
			log.error("shiro ajax登录校验失败异常");
		}
		return false;

	}

	protected void setFailureAttribute(ServletRequest request,
			AuthenticationException ae) {
		String className = ae.getClass().getName();
		request.setAttribute(getFailureKeyAttribute(), className);
	}

	protected String getUsername(ServletRequest request) {
		return WebUtils.getCleanParam(request, getUsernameParam());
	}

	protected String getPassword(ServletRequest request) {
		return WebUtils.getCleanParam(request, getPasswordParam());
	}

	protected String getUsertype(ServletRequest request) {
		return WebUtils.getCleanParam(request, getUsertypeParam());
	}

	protected String getAnswer(ServletRequest request) {
		return WebUtils.getCleanParam(request, getAnswerParam());
	}
    protected String getSmsCode(ServletRequest request) {
        return WebUtils.getCleanParam(request, getSmsCodeParam());
    }

	public String getUsertypeParam() {
		return usertypeParam;
	}

	public void setUsertypeParam(String usertypeParam) {
		this.usertypeParam = usertypeParam;
	}

	public String getAnswerParam() {
		return answerParam;
	}

	public void setAnswerParam(String answerParam) {
		this.answerParam = answerParam;
	}

	public String getRememberNameParam() {
		return rememberNameParam;
	}

	public void setRememberNameParam(String rememberNameParam) {
		this.rememberNameParam = rememberNameParam;
	}

}
