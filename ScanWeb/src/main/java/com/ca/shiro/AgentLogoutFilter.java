package com.ca.shiro;

import org.apache.shiro.session.SessionException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.LogoutFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AgentLogoutFilter extends LogoutFilter {
	private static final Logger log = LoggerFactory.getLogger(AgentLogoutFilter.class);
	
	private String userlogininfoCookieDomain;
	
	@Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        Subject subject = getSubject(request, response);
        String redirectUrl = getRedirectUrl(request, response, subject);
        //try/catch added for SHIRO-298:
        try {
        	if(request instanceof HttpServletRequest){
        	HttpServletRequest req=(HttpServletRequest)request;
        	HttpServletResponse rsp=(HttpServletResponse)response;
        	
        	Cookie[] cookie=req.getCookies();
	        	if(cookie!=null){
	        		for(Cookie c:cookie){
	        			if(!"JSESSIONID".equals(c.getName())){
	        			Cookie rc=new Cookie(c.getName(),null);
	        			rc.setDomain(userlogininfoCookieDomain);
	        			rc.setPath("/");
	        			rc.setMaxAge(0);
	        			
	        			rsp.addCookie(rc);
	        			log.info("remove cookie:{}",rc.getName());
	        			}
	        		}
	        	}
        	}
        	
            subject.logout();
        } catch (SessionException ise) {
        }
        issueRedirect(request, response, redirectUrl);
        return false;
    }

	public String getUserlogininfoCookieDomain() {
		return userlogininfoCookieDomain;
	}

	public void setUserlogininfoCookieDomain(String userlogininfoCookieDomain) {
		this.userlogininfoCookieDomain = userlogininfoCookieDomain;
	}
	
}
