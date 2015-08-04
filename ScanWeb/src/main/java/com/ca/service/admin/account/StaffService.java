package com.ca.service.admin.account;

import com.ca.common.Constants;
import com.ca.entity.AdminMenuTree;
import com.ca.entity.Staff;
import com.ca.mapper.StaffMapper;
import com.ca.utils.pagination.model.Paging;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Service
public class StaffService {

	Logger logger = LoggerFactory.getLogger(StaffService.class);

	@Autowired
    StaffMapper staffMapper;

	private LoadingCache<Pair<String, String>, Pair<Long, List<AdminMenuTree>>> cache;

	@PostConstruct
	private void init() {
		cache = CacheBuilder
				.newBuilder()
				.expireAfterWrite(2, TimeUnit.MINUTES)
				.softValues()
				.build(new CacheLoader<Pair<String, String>, Pair<Long, List<AdminMenuTree>>>() {
					@Override
					public Pair<Long, List<AdminMenuTree>> load(
							Pair<String, String> pair) throws Exception {
						return Pair.of(Long.valueOf(new SimpleDateFormat(
								"yyyyMMddHHmmss").format(new Date())),
								initTree(findAdminMenu(pair.getLeft())));
					}
				});
	}

	/**
	 * 获取当前员工的菜单权限列表.
	 * 
	 * @param staffId
	 * @return
	 * @throws Exception
	 */
	public List<AdminMenuTree> getAdminMenu(String staffId, long staffUpdateTime) {
		Pair<String, String> cacheKey = Pair.of(staffId, new SimpleDateFormat(
				"yyyyMMddHHmm").format(new Date()));
		Pair<Long, List<AdminMenuTree>> pair = cache.getUnchecked(cacheKey);
		List<AdminMenuTree> retList = pair.getRight();
		if (staffUpdateTime > pair.getLeft()) {
			// Cookie中员工最后更新时间 大于 权限缓存创建时间，强制刷新缓存
			logger.info("Cookie中员工最后更新时间{} 大于 权限缓存创建时间{}，强制刷新缓存",
					staffUpdateTime, pair.getLeft());
			cache.refresh(cacheKey);
			retList = cache.getUnchecked(cacheKey).getRight();
		}
		return retList;
	}

	/**
	 * 刷新菜单权限缓存.
	 * 
	 * @param staffId
	 */
	public void refreshFuncrightMenu(String staffId) {
		cache.refresh(Pair.of(staffId,
				new SimpleDateFormat("yyyyMMdd").format(new Date())));
	}

	public List<Map<?, ?>> findAdminMenu(String staffId) {
		return staffMapper.findAdminMenu(staffId);
	}

	public List<AdminMenuTree> initTree(List<Map<?, ?>> menuList) {
		Map<String, AdminMenuTree> menuMap = new HashMap<String, AdminMenuTree>();
		// 根结点menu
		AdminMenuTree rmenu = new AdminMenuTree();
		String rmenuId = null;
		rmenu.setId(rmenuId);
		rmenu.setPid(rmenuId);
		rmenu.setName("管理中心");

		// 先初始化1级菜单
		for (int i = 0; i < menuList.size(); i++) {
			Map<?, ?> menu =  menuList.get(i);
			Object o = menu.get("PARENT_MENU_ID");
			if (o == null) {
				AdminMenuTree root = initMenu(menu);
				rmenu.getChildren().add(root);
				menuMap.put(String.valueOf(menu.get("MENU_ID")), root);
			}
		}

		// 再初始化2级菜单
		for (int i = 0; i < menuList.size(); i++) {

			Map<?, ?> menu =  menuList.get(i);
			AdminMenuTree cmenu = null;
			Object o = menu.get("PARENT_MENU_ID");
			if (o == null) {
				continue;
			} else {
				cmenu = initMenu(menu);
			}
			// 获取上面子结点的父结点
			String pid = cmenu.getPid();
			// 以上面的父结点作为菜单ID去寻找相应的记录
			AdminMenuTree pmenu;
			if (pid == null) {
				pmenu = rmenu;
			} else {
				pmenu = menuMap.get(pid);
			}
			if (pmenu == null) {
				pmenu = rmenu;
				logger.error("pid not found:{}", pid);
			}
			pmenu.getChildren().add(cmenu);
			menuMap.put(cmenu.getId(), cmenu);
		}
		return rmenu.getChildren();
	}

	private AdminMenuTree initMenu(Map<?, ?> menu) {
		AdminMenuTree cmenu = new AdminMenuTree();
		Object o = menu.get("PARENT_MENU_ID");
		if (o != null) {
			cmenu.setPid(String.valueOf(o));
		}
		cmenu.setId(String.valueOf(menu.get("MENU_ID")));
		cmenu.setName(String.valueOf(menu.get("MENU_NAME")));

		cmenu.setRightcode(String.valueOf(menu.get("MENU_CODE")));
		int lvid = menu.get("MENU_SORT") == null ? 0 : Integer.valueOf(menu
				.get("MENU_SORT").toString());
		cmenu.setLevelid(lvid);
		cmenu.setTypeid(String.valueOf(menu.get("PROJECT_TYPE")));
		cmenu.setUrl(String.valueOf(Constants.ODM.equals(menu.get("PROJECT_CODE"))
                ?Constants.ProjectCode.ODM.toString()+menu.get("MENU_URL")
                :menu.get("MENU_URL")));
		cmenu.setTarget(String.valueOf(menu.get("TARGET_ATTR")));

		return cmenu;
	}

    public Staff selectByStaffCode(String staffCode){
        return staffMapper.selectByStaffCode(staffCode);
    }

    public int insertSms(String phone,String content){return 0;};

    public int updateByPrimaryKeySelective(Staff staff){
        return staffMapper.updateByPrimaryKey(staff);
    }

    public List<Map<String,String>> queryStaffInitInfo(Map<String, Object> args,Paging<Map<String, String>> paging){
        return staffMapper.findAllStaffInitInfo(args, paging.getRowBounds());
    }

    public List<Map<String,String>> queryRoleInfoList(Map<String,Object> params){
        return staffMapper.queryRoleInfoList(params);
    }

    public String getStaffCode(){
        return staffMapper.getStaffCode();
    }

    public Integer queryStaffCode(Map<String,Object> params){
        return staffMapper.queryStaffCode(params);
    }

    public List<Map<String,String>> queryAllCityList(Map<String,Object> params){
        return staffMapper.queryAllCityList(params);
    }

    /**
     * 新增员工.
     *
     * @param inMap
     * @return
     * @throws Exception
     */
    @Transactional(readOnly = false)
    public void addStaff(Map<String,String> inMap){
        String busiArrayValue[] = ((String) inMap.get("busiListValue")).split(";");
        String appAllArrayValue[] = null;
        if (StringUtils.isNotEmpty(inMap.get("appListValue"))) {
            appAllArrayValue = ((String) inMap.get("appListValue")).split(";");
        }

        String busiCodeValue = "";
        String busiNameValue = "";
        String staffID = staffMapper.creatStaffId();
        inMap.put("staffID", staffID);
        staffMapper.addStaffInfo(inMap);
        addStaffRelation(inMap);
        // 新增员工业务区域关系
        if (StringUtils.isNotEmpty(inMap.get("busiListValue"))) {
            for (String element : busiArrayValue) {
                busiCodeValue = element.split(":")[0];
                busiNameValue = element.split(":")[1];
                inMap.put("busiareaCode", busiCodeValue);
                inMap.put("busiareaName", busiNameValue);
                staffMapper.addStaffBusiRes(inMap);
            }
        }
    }

    // 增加员工角色关系与员工分组关系
    private void addStaffRelation(Map inMap) {
        String roleListValue = (String) inMap.get("roleListValue");
        String groupListValue = (String) inMap.get("groupListValue");
        if (StringUtils.isNotEmpty(roleListValue)) {
            String temp[] = roleListValue.split(";");
            for (String roleValue : temp) {
                if (StringUtils.isNotEmpty(roleValue)) {
                    inMap.put("roleValue", roleValue);
                    staffMapper.addStaffRoleR(inMap);
                }
            }
        }
        if (StringUtils.isNotEmpty(groupListValue)) {
            String temp[] = groupListValue.split(";");
            for (String groupValue : temp) {
                if (StringUtils.isNotEmpty(groupValue)) {
                    inMap.put("groupValue", groupValue);
                    staffMapper.addStaffGroupR(inMap);
                }
            }
        }
    }

    /**
     * 根据员工标识查询员工角色与分组信息.
     *
     * @param inMap
     * @return
     * @throws Exception
     */
    public Map getStaffInfoById(Map inMap) throws Exception {
        Map returnMap = new HashMap();
        List<Map> groupList = new ArrayList();
        List<Map> roleList = staffMapper.queryRoleListByStaffID(inMap);
        if (!roleList.isEmpty()) {
            List tempList = new ArrayList();
            for (Map tempMap : roleList) {
                tempList.add(tempMap.get("SELECTROLEID"));
            }
            inMap.put("roleList", tempList);
//            groupList = staffMapper.queryGroupListByStaffID(inMap);
        }
        List<Map> staffBusiList = staffMapper.queryStaffBusiRes(inMap);
        returnMap.put("staffBusiList", staffBusiList);
        returnMap.put("roleInfoList", roleList);
        returnMap.put("groupInfoList", groupList);
        return returnMap;
    }


    /**
     * 编辑员工.
     *
     * @param inMap
     * @return
     * @throws Exception
     */
    @Transactional(readOnly = false)
    public void updateStaff(Map<String,String> inMap) {
        String busiArrayValue[] = ((String) inMap.get("busiListValue")).split(";");
        String appAllArrayValue[] = null;
        if (StringUtils.isNotEmpty(inMap.get("appListValue"))) {
            appAllArrayValue = ((String) inMap.get("appListValue")).split(";");
        }

        String busiCodeValue = "";
            String busiNameValue = "";
        staffMapper.updateStaffInfo(inMap);
        staffMapper.deleteStaffRoleR(inMap);
        staffMapper.deleteStaffGroupR(inMap);
        addStaffRelation(inMap);

        staffMapper.deleteStaffBusiRes(inMap);
        // 新增员工业务区域关系
        if (StringUtils.isNotEmpty(inMap.get("busiListValue"))) {
            for (String element : busiArrayValue) {
                busiCodeValue = element.split(":")[0];
                busiNameValue = element.split(":")[1];
                inMap.put("busiareaCode", busiCodeValue);
                inMap.put("busiareaName", busiNameValue);
                staffMapper.addStaffBusiRes(inMap);
            }
        }
    }

    /**
     * 删除员工.
     *
     * @param inMap
     * @return
     * @throws Exception
     */
    @Transactional(readOnly = false)
    public void deleteStaffById(Map inMap) {

        staffMapper.deleteStaffByID(inMap);
        staffMapper.deleteStaffRoleR(inMap);
        staffMapper.deleteStaffGroupR(inMap);

        staffMapper.deleteStaffBusiRes(inMap);

    }
}
