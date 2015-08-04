/**
 * 
 */
package com.ca.shiro.matcher;

import com.ca.mapper.CredentialsMatcherMapper;
import com.ca.service.admin.account.StaffService;
import com.ca.shiro.UsernamePasswordCaptchaToken;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.slf4j.LoggerFactory;

/**
 * @author Weiwy
 * 
 */
public class CredentialsMatcher extends HashedCredentialsMatcher {

	private static final org.slf4j.Logger logger = LoggerFactory
			.getLogger(CredentialsMatcher.class);

    public static final String ADMIN_USER = "ADMIN_USER";
    public static final String CURR_MENU = "CURR_MENU";

	private CredentialsMatcherMapper credentialsMatcherMapper;

    private StaffService staffService;

	/**
	 * 后台管理cookie信息
	 */
	private String adminCookieName;
	private String adminCookieDomain;
	private int adminCookieMaxAge;
	private String adminCookieKey;
    private String adminName;

	private boolean adminCookieEnable;

	/**
	 * 前台用户登录cookie信息
	 */
	private String userlogininfoCookieDomain;
	private int userlogininfoCookieMaxAge;
	private String userlogininfoCookieKey;
	private String userlogininfo3DESCookieName;
	private String userlogininfoMD5CookieName;
	private String userlogininfoMD5SSalt;
	private String userlogininfoMD5ESalt;
	private String userlogininfoCookieName;

	/**
	 * 代理商cookie信息
	 */
	private String agentCookieName;
	private String agentCookieDomain;
	private int agentCookieMaxAge;
	private String agentCookieKey;

	@Override
	public boolean doCredentialsMatch(AuthenticationToken token,
			AuthenticationInfo info) {

		UsernamePasswordCaptchaToken userinfo = (UsernamePasswordCaptchaToken) token;
		boolean f = false;
		if(userinfo.isCookieAuth()){//通过cookie认证了
			f=true;
		}else{
			String pwd = userlogininfoMD5SSalt+new String(userinfo.getPassword())+userlogininfoMD5ESalt;
			String enpwd = DigestUtils.shaHex(pwd.getBytes());
			f = info.getCredentials().toString().equals(enpwd);
		}
		return f;
	}

	public String getAdminCookieName() {
		return adminCookieName;
	}

	public void setAdminCookieName(String adminCookieName) {
		this.adminCookieName = adminCookieName;
	}

	public String getAdminCookieDomain() {
		return adminCookieDomain;
	}

	public void setAdminCookieDomain(String adminCookieDomain) {
		this.adminCookieDomain = adminCookieDomain;
	}

	public int getAdminCookieMaxAge() {
		return adminCookieMaxAge;
	}

	public void setAdminCookieMaxAge(int adminCookieMaxAge) {
		this.adminCookieMaxAge = adminCookieMaxAge;
	}

	public String getAdminCookieKey() {
		return adminCookieKey;
	}

	public void setAdminCookieKey(String adminCookieKey) {
		this.adminCookieKey = adminCookieKey;
	}

	public String getUserlogininfoCookieDomain() {
		return userlogininfoCookieDomain;
	}

	public void setUserlogininfoCookieDomain(String userlogininfoCookieDomain) {
		this.userlogininfoCookieDomain = userlogininfoCookieDomain;
	}

	public int getUserlogininfoCookieMaxAge() {
		return userlogininfoCookieMaxAge;
	}

	public void setUserlogininfoCookieMaxAge(int userlogininfoCookieMaxAge) {
		this.userlogininfoCookieMaxAge = userlogininfoCookieMaxAge;
	}

	public String getUserlogininfoCookieKey() {
		return userlogininfoCookieKey;
	}

	public void setUserlogininfoCookieKey(String userlogininfoCookieKey) {
		this.userlogininfoCookieKey = userlogininfoCookieKey;
	}

	public String getUserlogininfo3DESCookieName() {
		return userlogininfo3DESCookieName;
	}

	public void setUserlogininfo3DESCookieName(
			String userlogininfo3desCookieName) {
		userlogininfo3DESCookieName = userlogininfo3desCookieName;
	}

	public String getUserlogininfoMD5CookieName() {
		return userlogininfoMD5CookieName;
	}

	public void setUserlogininfoMD5CookieName(String userlogininfoMD5CookieName) {
		this.userlogininfoMD5CookieName = userlogininfoMD5CookieName;
	}

	public String getUserlogininfoMD5SSalt() {
		return userlogininfoMD5SSalt;
	}

	public void setUserlogininfoMD5SSalt(String userlogininfoMD5SSalt) {
		this.userlogininfoMD5SSalt = userlogininfoMD5SSalt;
	}

	public String getUserlogininfoMD5ESalt() {
		return userlogininfoMD5ESalt;
	}

	public void setUserlogininfoMD5ESalt(String userlogininfoMD5ESalt) {
		this.userlogininfoMD5ESalt = userlogininfoMD5ESalt;
	}

	public String getUserlogininfoCookieName() {
		return userlogininfoCookieName;
	}

	public void setUserlogininfoCookieName(String userlogininfoCookieName) {
		this.userlogininfoCookieName = userlogininfoCookieName;
	}

	public CredentialsMatcherMapper getCredentialsMatcherMapper() {
		return credentialsMatcherMapper;
	}

	public void setCredentialsMatcherMapper(
			CredentialsMatcherMapper credentialsMatcherMapper) {
		this.credentialsMatcherMapper = credentialsMatcherMapper;
	}

	public boolean isAdminCookieEnable() {
		return adminCookieEnable;
	}

	public void setAdminCookieEnable(boolean adminCookieEnable) {
		this.adminCookieEnable = adminCookieEnable;
	}

	public String getAgentCookieName() {
		return agentCookieName;
	}

	public void setAgentCookieName(String agentCookieName) {
		this.agentCookieName = agentCookieName;
	}

	public String getAgentCookieDomain() {
		return agentCookieDomain;
	}

	public void setAgentCookieDomain(String agentCookieDomain) {
		this.agentCookieDomain = agentCookieDomain;
	}

	public int getAgentCookieMaxAge() {
		return agentCookieMaxAge;
	}

	public void setAgentCookieMaxAge(int agentCookieMaxAge) {
		this.agentCookieMaxAge = agentCookieMaxAge;
	}

	public String getAgentCookieKey() {
		return agentCookieKey;
	}

	public void setAgentCookieKey(String agentCookieKey) {
		this.agentCookieKey = agentCookieKey;
	}

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

}
