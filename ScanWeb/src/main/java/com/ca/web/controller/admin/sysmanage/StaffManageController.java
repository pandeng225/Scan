package com.ca.web.controller.admin.sysmanage;

import com.ca.service.admin.account.StaffService;
import com.ca.shiro.realm.ShiroRealm;
import com.ca.utils.AdminUtil;
import com.ca.utils.PasswordHelper;
import com.ca.utils.pagination.model.Paging;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wangxiang2 on 2015/3/8.
 */
@Controller
@RequestMapping("/admin/am")
public class StaffManageController {

    @Resource
    private StaffService staffService;

    @Value("${admin.defaultPwd}")
    private String defaultPwd;

    @Resource
    private PasswordHelper passwordHelper;

    @RequestMapping("/staffManage/init")
    public String Init(String staffID, String staffName,
                       String roleName, String pageSize,
                       String pageNo, Model model, HttpServletRequest request){

        if (StringUtils.isEmpty(pageNo)) {
            pageNo = "1";
        }

        if (StringUtils.isEmpty(pageSize)) {
            pageSize = "5";
        }

        Map<String, Object> params = new HashMap<String, Object>();

        if (staffID != null && staffID.length() > 0) {
            params.put("staffCode", staffID);
            model.addAttribute("staffID", staffID);
        }

        if (staffName != null && staffName.length() > 0) {
            params.put("staffName", staffName);
            model.addAttribute("staffName", staffName);
        }

        if (roleName != null && roleName.length() > 0) {
            params.put("roleName", roleName);
            model.addAttribute("roleName", roleName);
        }

        Paging<Map<String, String>> pager = new Paging<Map<String, String>>(
                Integer.valueOf(pageNo), Integer.valueOf(pageSize));
        List<Map<String, String>> staffList = staffService
                .queryStaffInitInfo(params, pager);
        pager.result(staffList);
        model.addAttribute("pager", pager);

        List<Map<String,String>> roleInfoList = staffService.queryRoleInfoList(params);
        model.addAttribute("roleInfoList",roleInfoList);

        List<Map<String,String>> areaInfoList = staffService.queryAllCityList(params);
        model.addAttribute("areaInfoList",areaInfoList);

        return "admin/sysmanage/staff/staffManage";
    }

    /**
     * 自动获取登录名
     */
    @RequestMapping("/staffManage/getStaffCode")
    @ResponseBody
    public String getStaffCode() {
        Map inMap = new HashMap();
        String staffCode = staffService.getStaffCode();
        return staffCode;
    }

    /**
     * 登录名校验
     */
    @RequestMapping("/staffManage/checkStaffCode")
    @ResponseBody
    public Map CheckStaffCode(String staffCode) throws Exception {
        Map inMap = new HashMap();
        inMap.put("staffCode", staffCode);
        int count = staffService.queryStaffCode(inMap);
        Map retMap = new HashMap();
        if (count > 0) {
            retMap.put("isOk", "false");
        } else {
            retMap.put("isOk", "true");
        }
        return retMap;
    }

    /**
     * 新增员工
     */
    @RequestMapping("/staffManage/addStaff")
    public String AddStaff(String staffCode,String staffName,String linkPhone,
               String email,String areaCode,String roleListValue,String groupListValue,
               String busiListValue,String appListValue,String merchantTypeCode,String smsPassword) {
        ShiroRealm.AdminShiroUser adminStaff = (ShiroRealm.AdminShiroUser)SecurityUtils.getSubject().getPrincipal();
        Map<String,String> inMap = new HashMap<String,String>();
        inMap.put("staffCode", staffCode);
        inMap.put("staffName", staffName);
        inMap.put("linkPhone", linkPhone);
        inMap.put("email", email);
        inMap.put("areaCode", areaCode);
        inMap.put("roleListValue", roleListValue);
        inMap.put("groupListValue", groupListValue);
        inMap.put("busiListValue", busiListValue);
        inMap.put("appListValue", appListValue);
        inMap.put("passWord", passwordHelper.encryptPassword(defaultPwd));
//		inMap.put("passWord", smsPassword);
//        inMap.put("merchantID", super.getStaffInfo().getMerchantId());
        inMap.put("nowStaffId", String.valueOf(adminStaff.getStaffId()));
//        inMap.put("marchentProCode", super.getStaffInfo().getProvinceCode());
//        if ("1".equals(merchantTypeCode) || "2".equals(merchantTypeCode)) {
//            inMap.put("busiareaType", "1");
//        } else if ("0".equals(merchantTypeCode)) {
//            inMap.put("busiareaType", "2");
//        } else {
//            inMap.put("busiareaType", "3");
//        }
        staffService.addStaff(inMap);
        return "admin/sysmanage/staff/staffManage";
    }

    /**
     * 根据员工标识查询员工角色、分组和区域信息
     *
     * @return String
     */
    @RequestMapping("/staffManage/queryStaffInfoByID")
    public String queryStaffInfoByID(String staffID,Model model) throws Exception {
        Map inMap = new HashMap();
        inMap.put("staffID", staffID);
        Map returnMap = staffService.getStaffInfoById(inMap);

        List<Map> roleInfoList = (List) returnMap.get("roleInfoList");
        List<Map> groupInfoList = (List) returnMap.get("groupInfoList");

        model.addAttribute("roleInfoList",roleInfoList);

        return "admin/sysmanage/staff/staffManage";
    }

    /**
     * 编辑员工
     *
     * @return String
     */
    @RequestMapping("/staffManage/updateStaff")
    public String updateStaff(String staffID,String staffName,String linkPhone,String smsPassword,String email,
                              String areaCode,String roleListValue,String groupListValue,String busiListValue,
                              String appListValue) {
        ShiroRealm.AdminShiroUser adminShiroUser = AdminUtil.getAdminStaff();
        Map inMap = new HashMap();
        inMap.put("staffID", staffID);
        inMap.put("editStaffName", staffName);
        inMap.put("linkPhone", linkPhone);
        inMap.put("smsPassword", smsPassword);
        inMap.put("email", email);
        inMap.put("areaCode", areaCode);
        inMap.put("roleListValue", roleListValue);
        inMap.put("groupListValue", groupListValue);
        inMap.put("busiListValue", busiListValue);
        inMap.put("appListValue", appListValue);
        inMap.put("nowStaffId", adminShiroUser.getStaffId());
        staffService.updateStaff(inMap);
        return "admin/sysmanage/staff/staffManage";
    }

    /**
     * 根据员工标识删除员工
     *
     * @return String
     */
    @RequestMapping("/staffManage/delStaffByID")
    public String deleteStaffByID(String delStaffId) {
        String staffId = delStaffId;
        Map inMap = new HashMap();
        inMap.put("staffID", staffId);

        staffService.deleteStaffById(inMap);
        return "admin/sysmanage/staff/staffManage";
    }

}
