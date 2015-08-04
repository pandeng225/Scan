package com.ca.shiro.realm;

import com.ca.entity.AdminMenuTree;
import com.ca.entity.Role;
import com.ca.entity.Staff;
import com.ca.service.admin.account.RoleService;
import com.ca.service.admin.account.StaffService;
import com.ca.shiro.UsernamePasswordCaptchaToken;
import com.ca.utils.captcha.Captcha;
import com.ca.utils.captcha.util.CaptchaException;
import com.google.common.collect.Sets;
import org.apache.commons.collections.MapUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.Set;


/**
 * 
 * @author jianglz
 *
 */
public class ShiroRealm extends AuthorizingRealm {
	private static final Logger log = LoggerFactory.getLogger(ShiroRealm.class);

    @Resource
    private StaffService staffService;

    @Resource
    private RoleService roleService;
	
	/**
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用.
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		AdminShiroUser user = (AdminShiroUser) principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		Set<String> roleSet = Sets.newLinkedHashSet(); // 角色集合
		Set<String> urlSet = Sets.newLinkedHashSet(); // url集合
//		Set<String> authoritySet = Sets.newLinkedHashSet(); // 权限集合
		log.info("用户{}赋权开始", user.getStaffCode());
        //二级代理商权限控制
//        String hierarchy = agentStaffInfoService.findByUsernameOnly(user.getLoginName()).getHierarchy();
//        if("00".equals(hierarchy)){
//            roleSet.add("admin");
//        }else{
//            roleSet.add("guest");
//        }
        /*
		if (null != user && !user.isDisabled) {
			List<AgentRole> roleList = agentRoleService.findRoleUserByStaffId(user.getLoginName());
			for (AgentRole r : roleList) {
				String roleId = r.getId().toString();
				roleSet.add("admin");
				log.info("给用户赋予{}角色", roleId);
				List<AgentRoleMenu> menuList = agentRoleMenuService.findMenuByRoleId(r.getId());
				for (AgentRoleMenu rm : menuList) {
					List<AgentStaffMenu> asmList = agentStaffMenuService.findStaffMenuById(rm.getMenuId());
					for(AgentStaffMenu sm : asmList){
						if (null != sm.getUrl()) {
							urlSet.add(sm.getUrl());
							log.info("给用户赋予{}权限", sm.getUrl());
						}
					}
					
					
				}
			}
		}*/
		info.setRoles(roleSet);
//		info.setStringPermissions(urlSet); // 设置权限
		return info;
	}

	/**
	 * 认证回调函数,登录时调用.
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		log.info("登录认证");
		UsernamePasswordCaptchaToken token = (UsernamePasswordCaptchaToken) authcToken;

		if(!token.isCookieAuth()){//非cookie方式验证的
			// 验证码校验
			Object obj_captcha = SecurityUtils.getSubject().getSession().getAttribute(Captcha.NAME);
			if (obj_captcha != null && obj_captcha instanceof Captcha) {
				Captcha c = (Captcha) obj_captcha;
				log.info("answser:"+c.getAnswer());
				if (!c.getAnswer().equalsIgnoreCase(token.getAnswer())) {
					log.error("验证码错误");
					throw new CaptchaException("验证码错误");
				}
			} else {
				log.error("验证码校验异常");
				throw new CaptchaException("验证码校验异常");
			}
		}

        Staff staff = staffService.selectByStaffCode(token.getUsername());
        if (staff == null) {
			log.error("用户名不存在或用户状态不正常！");
			throw new UnknownAccountException();// 没找到帐号
		}/*else if(!"1".equals(user.getStatus())){
			log.error("用户名状态不正常!,请联系管理员");
			throw new UnknownAccountException();// 没找到帐号
		}*/
        /*if(!token.isCookieAuth()&&staff.getSmsFlag().equals("1")){
            Object smsCode = SecurityUtils.getSubject().getSession().getAttribute("smsCode");
            if(smsCode!=null){
                if(!smsCode.equals(token.getSmsCode())){
                    log.error("短信动态码错误");
                    throw new SmsException("短信动态码错误");
                }
            }else{
                log.error("未获取短信动态验证码");
                throw new SmsException("请获取短信验证码");
            }
        }*/

		SimpleAuthenticationInfo authenticationInfo = null;
		
		List<Role> roleList = roleService.selectRoleByStaffId(staff.getStaffId());
		log.info("roleList.size():" + roleList.size());
		// 交给AuthenticatingRealm使用CredentialsMatcher进行密码匹配，如果觉得人家的不好可以自定义实现
		 authenticationInfo = new SimpleAuthenticationInfo(
				new AdminShiroUser(staff),
                 staff.getPasswd(),
//				ByteSource.Util.bytes(staff.getSalt()),// salt=username+salt
				getName());
		
		return authenticationInfo;
	}

	
	/**
	 * 更新用户授权信息缓存.
	 */
	public void clearCachedAuthorizationInfo(Object principal) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection(
				principal, getName());
		clearCachedAuthorizationInfo(principals);
	}

	
	/**
	 * 自定义Authentication对象，使得Subject除了携带用户的登录名外还可以携带更多信息.
	 */
    public static class AdminShiroUser extends Staff {

        public AdminShiroUser(){}

        public AdminShiroUser(Staff staff){
            this.setStaff(staff);
        }

        public List<AdminMenuTree> menu;

        public List<AdminMenuTree> getMenu() {
            return menu;
        }

        public void setMenu(List<AdminMenuTree> menu) {
            this.menu = menu;
        }

        public void setStaff(Staff staff){
            this.setStaffId(staff.getStaffId());
            this.setStaffCode(staff.getStaffCode());
            this.setMerchantId(staff.getMerchantId());
            this.setStaffName(staff.getStaffName());
            this.setPasswd(staff.getPasswd());
            this.setStaffStatus(staff.getStaffStatus());
            this.setLinkPhone(staff.getLinkPhone());
            this.setEmail(staff.getEmail());
            this.setProvinceCode(staff.getProvinceCode());
            this.setEssStaffId(staff.getEssStaffId());
            this.setChannelCode(staff.getChannelCode());
            this.setUpdateStaff(staff.getUpdateStaff());
            this.setUpdateTime(staff.getUpdateTime());
            this.setValues1(staff.getValues1());
            this.setValues2(staff.getValues2());
            this.setChannelType(staff.getChannelType());
            this.setChannelDesc(staff.getChannelDesc());
            this.setInitPasswordTag(staff.getInitPasswordTag());
            this.setSysCode(staff.getSysCode());
            this.setStaffBelongDesc(staff.getStaffBelongDesc());
            this.setAreaCode(staff.getAreaCode());
            this.setStaffType(staff.getStaffType());
            this.setSalt(staff.getSalt());
        }
        /**
         * 填充员工信息bean.
         *
         * @param staffInfo
         */
        public void padStaff(Map staffInfo) {
            setStaffId(MapUtils.getInteger(staffInfo, "STAFF_ID"));
            setStaffCode(MapUtils.getString(staffInfo,"STAFF_CODE"));
            setMerchantId(MapUtils.getInteger(staffInfo,"MERCHANT_ID"));
            setStaffName(MapUtils.getString(staffInfo,"STAFF_NAME"));
            setPasswd(MapUtils.getString(staffInfo,"PASSWD"));
            setLinkPhone(MapUtils.getString(staffInfo,"LINK_PHONE"));
            setEmail(MapUtils.getString(staffInfo,"EMAIL"));
            setProvinceCode(MapUtils.getString(staffInfo,"PROVINCE_CODE"));
//            setProvinceName(MapUtils.getString(staffInfo,"PROVINCE_NAME"));
//            setCityCode(MapUtils.getString(staffInfo,"CITY_CODE"));
//            setCityName(MapUtils.getString(staffInfo,"CITY_NAME"));
            setEssStaffId(MapUtils.getString(staffInfo,"ESS_STAFF_ID"));
//            setChannelId(MapUtils.getString(staffInfo,"CHANNEL_ID"));
            setChannelType(MapUtils.getString(staffInfo,"CHANNEL_TYPE"));
//            setMerchantName(MapUtils.getString(staffInfo,"MERCHANT_NAME"));
//            setMerchantType(MapUtils.getString(staffInfo,"MERCHANT_TYPE"));
//            setBusiAreaType(MapUtils.getString(staffInfo,"BUSIAREA_TYPE"));
//            if(staffInfo.get("BUSIAREA_LIST")!=null){
//                setBusiAreaList((List<Map>) staffInfo.get("BUSIAREA_LIST"));
//            }
//            setStaffIp(MapUtils.getString(staffInfo,"STAFF_IP"));
            setSysCode(MapUtils.getString(staffInfo, "SYS_CODE"));
            setStaffBelongDesc(MapUtils.getString(staffInfo, "STAFF_BELONG_DESC"));
//            setUpdateTime(MapUtils.getLongValue(staffInfo, "LAST_UPDATE_TIME"));
            setStaffType(MapUtils.getString(staffInfo, "STAFF_TYPE"));
        }
    }

}
