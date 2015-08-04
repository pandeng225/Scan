package com.ca.shiro;

import org.apache.shiro.authc.UsernamePasswordToken;

/**
 * 
 * @author jianglz
 *
 */
public class UsernamePasswordCaptchaToken extends UsernamePasswordToken {
	private static final long serialVersionUID = -3334858867451124343L;

	private String usertype;
	private String answer;
    private String smsCode;
	private boolean rememberName;
	private boolean cookieAuth=false;
	
	public UsernamePasswordCaptchaToken() {
	}

	public UsernamePasswordCaptchaToken(String usertype) {
		this.usertype = usertype;
	}

	public UsernamePasswordCaptchaToken(final String username, final String password,
			final boolean rememberMe, final String host, final String usertype,
            final String answer,boolean rememberName,
            String smsCode) {
		super(username, password, rememberMe, host);
		this.usertype = usertype;
		this.answer = answer;
		this.rememberName = rememberName;
        this.smsCode = smsCode;
	}

	public String getUsertype() {
		return usertype;
	}

	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}


	public boolean isRememberName() {
		return rememberName;
	}

	public void setRememberName(boolean rememberName) {
		this.rememberName = rememberName;
	}

    public String getSmsCode() {
        return smsCode;
    }

    public void setSmsCode(String smsCode) {
        this.smsCode = smsCode;
    }

    public String toString() {
		return ", usertype="+this.usertype;
	}

	public boolean isCookieAuth() {
		return cookieAuth;
	}

	public void setCookieAuth(boolean cookieAuth) {
		this.cookieAuth = cookieAuth;
	}

//	@Override
//	public Object getPrincipal() {
//        return getUsername()+"|"+getUsertype();
//    }
}
