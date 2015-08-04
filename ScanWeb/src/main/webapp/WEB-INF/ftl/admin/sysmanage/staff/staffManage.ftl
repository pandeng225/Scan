<#include "/admin/layout/common/layout.ftl">
<@layout title="员工管理">
<div class="rightBar">
<link href="${e.res('/css/merchant_staff.css')}" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="${e.res("/js/sysmanage/staff/staffManage.js")}"></script>

<div class="layoutRight">
      <div class="navigation">
        <div class="navigationLeft">
          系统管理<span>&gt;</span>员工管理
        </div>
      </div>
      <h4 class="listTitle">员工列表</h4>
    <@form.form method="post" action="${rc.contextPath}/admin/am/staffManage/init">
      <div class="staffSelect">
        <dl>
          <dt><label>工号：</label></dt><dd><input type="text" id="staffID" name="staffID" value="${staffID}" class="inputW144H23"/></dd>
          <dt><label>姓名：</label></dt><dd><input type="text" id="staffName" name="staffName" value="${staffName}" class="inputW144H23"/></dd>
          <dt><label>角色：</label></dt><dd><input type="text" id="roleName" name="roleName" value="${roleName}" class="inputW144H23"/></dd>
          <dt><input type="submit" value="查&nbsp;&nbsp;询" class="btnStyle" /></dt>
        </dl>
      </div>
    </@form.form>
      <ul class="staffListName">
        <li class="staffNumber">员工号</li>
        <li class="staffName">姓名</li>
        <li class="tel">电话</li>
        <li class="role">角色</li>
        <li class="city">归属区域</li>
        <li class="operation">操作</li>
      </ul>
      <div class="staffListBox">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="table_model">
        <#list pager.rows as staffInfoBean>
          <tr class="staffList">
              <td class="staffNumber">${staffInfoBean.STAFFCODE}</td>
              <td class="staffName">${staffInfoBean.STAFFNAME}</td>
              <td class="tel">${staffInfoBean.LINKPHONE}</td>
              <td class="role" title="${staffInfoBean.ROLENAMESTR}">
                  <#if staffInfoBean.ROLENAMESTR?length gt 16>
                    ${staffInfoBean.ROLENAMESTR[0..16]}....
                  <#else>
                    ${staffInfoBean.ROLENAMESTR}
                  </#if>
              </td>
              <td class="city">${staffInfoBean.CITYNAME}</td>
              <td class="operation">
                <a href="javascript:" class="fontC36cS12 editStaff" onclick="editStaff('${staffInfoBean.STAFFID}','${staffInfoBean.STAFFCODE}','${staffInfoBean.STAFFNAME}','${staffInfoBean.LINKPHONE}','${staffInfoBean.EMAIL}','${staffInfoBean.AREACODE}')">编辑</a>
                <a href="javascript:" class="fontC36cS12 deleteStaff" onclick="deleteStaff('${staffInfoBean.STAFFID}','${staffInfoBean.STAFFCODE}','${staffInfoBean.STAFFNAME}')">删除</a>
                <span class="staffInfoImg" id ="staffDiv${staffInfoBean.STAFFID}" onmousemove="showStaffInfo('${staffInfoBean.STAFFID}')" onmouseleave="hideStaffInfo('${staffInfoBean.STAFFID}')"></span>

              <div id="employeeDetails${staffInfoBean.STAFFID}" class="employeeDetailsLayer" style="display:none;">
                <h4 class="detailsTitle">员工详情</h4>
                  <h5 class="subTitle">工作信息</h5>
                  <dl class="employeeInfor">
                    <dt>登录名：</dt><dd>${staffInfoBean.STAFFCODE}</dd>
                  </dl>
                  <!--
                  <dl class="employeeInfor">
                    <dt>员工号：</dt><dd>${staffInfoBean.ESSSTAFFID}</dd>
                  </dl>
                  -->
                  <dl class="employeeInfor">
                    <dt>角　色：</dt><dd>${staffInfoBean.ROLENAMELIST}</dd>
                  </dl>
                  <#--<dl class="employeeInfor">-->
                    <#--<dt>分　组：</dt><dd>${staffInfoBean.GROUPNAMELIST}</dd>-->
                  <#--</dl>-->
                  <div class="septalLine"></div>
                  <h5 class="subTitle">个人信息</h5>
                  <dl class="employeeInfor">
                    <dt>姓　名：</dt><dd>${staffInfoBean.STAFFNAME}</dd>
                  </dl>
                  <dl class="employeeInfor">
                    <dt>电　话：</dt><dd>${staffInfoBean.LINKPHONE}</dd>
                  </dl>
                  <dl class="employeeInfor">
                    <dt>E-MAIL：</dt><dd>${staffInfoBean.EMAIL}</dd>
                  </dl>
              </div>
              </td>
          </tr>
      </#list>
      </table>
          <#import "/admin/layout/common/pager.ftl" as q>
          <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/staffManage/init"/>
      </div>


      <h4 id="addStaffInfo" class="listTitle">新增员工信息<span style="color:red">(新建员工初始密码为123456)</span></h4>
      <input type="hidden" id="editStaffIdHide"/>
      <h5 class="primInfo bot10">员工基本信息：</h5>
  <div class="telPosition">
    <div class="oderDelTwo" id="shortMessageP">
      <p>您要重置密码吗？</p>
      <p><a class="font3366cc delSureTwo" href="javascript:">确认</a><a class="font3366cc delCloseTwo" href="javascript:">关闭</a></p>
    </div>

      <dl class="staffInfoArea">
        <dt><label class="cRed marginR4">*</label> 登&nbsp;&nbsp;录&nbsp;&nbsp;名：</dt>
        <dd class="staffLoginName" id="staffCodeDiv">
          <input type="text" class="inputW168H23" id="staffLoginName" onblur="staffLoginNameValue();" maxlength="10"/>
          <input type="hidden" id="merchantType" name="merchantType" value="${merchantType}"/>
          <input type="hidden" id="merchantProvinceCode" name="merchantProvinceCode" value="${merchantProvinceCode}"/>
          <a href="javascript:" class="autoDistribution">自动分配</a>
          <span class="correct" id="autoDistributionCorrect" style="display:none;"></span>
          <span class="error" id="staffLoginNameError" style="display:none;"></span>
        </dd>
        <dd class="staffLoginName" id="editStaffCodeDiv" style="display:none;">
        </dd>

        <dt><label class="cRed marginR4">*</label> 员工姓名：</dt>
        <dd>
          <input type="text" class="inputW168H23" id="staffNameValue" onblur="checkName();" maxlength="10"/>
          <span class="correct" id="nameCorrect" style="display:none;"></span>
          <span class="error" id="staffNameValueError" style="display:none;"></span>
        </dd>

        <dt><label class="cRed marginR4">*</label> 联系电话：</dt>
        <dd>
          <input type="text" class="inputW168H23" id="mobile" onblur="checkMobile();" maxlength="11"/>
          <#--<a href="javascript:" id="smsNotif" onclick="smsNotif();">短信通知密码</a> -->
          <input type ="hidden" id="smsPassword"/>
          <span class="correct" id="mobelCorrect" style="display:none;"></span>
          <span class="error" id="mobileError" style="display:none;"></span>
        </dd>
        <dt><label class="cRed marginR4">*</label> E - MAIL：</dt>
        <dd>
          <input type="text" class="inputW168H23" id="emailValue" onblur="checkEmail();" maxlength="50"/>
          <span class="correct" id="emailCorrect" style="display:none;"></span>
          <span class="error" id="emailValueError" style="display:none;"></span>
        </dd>
        <dt><label class="cRed marginR4">*</label> 归属区域：</dt>
            <dd>
              <select id="areaCode" name="areaCode" onchange="checkAreaCode(true);">
                    <option value="">请选择</option>
                    <#list areaInfoList as areaInfo>
                        <option value="${areaInfo.AREA_CODE}">${areaInfo.AREA_NAME}</option>
                    </#list>
              </select>
                <span class="correct" id="areaCodeCorrect" style="display:none;"></span>
                <span class="error" id="areaCodeValueError" style="display:none;"></span>
            </dd>
        </dl>

      <!-- --------------------------------------------------------------------------------------------------------------------- -->
      <#--<dl class="staffInfoArea">
        <dt><label class="cRed marginR4"></label> 应用区域：</dt>
        <dd class='busiArea'>
        <div class="selectAll" style="height:30px;"><label >
            <ul><li><input type="checkbox" id="allBusiArea" onclick="checkAllBusiArea();"  /><span>全选</span></label></li></ul>
        </div>
        <ul class="listSelect">
        <#list busiAreaList as busiAreaInfo>

            <#if busiAreaInfo.BUSIAREA_SELECTED == busiAreaInfo.AREA_CODE>
                <li><input type="checkbox" onclick="checkOneBusiArea()" id="${busiAreaInfo.AREA_CODE}:${busiAreaInfo.AREA_NAME}" checked/><span>${busiAreaInfo.AREA_NAME}</span></li>
            <#else>
                <li><input type="checkbox" onclick="checkOneBusiArea()" id="${busiAreaInfo.AREA_CODE}:${busiAreaInfo.AREA_NAME}"/><span>${busiAreaInfo.AREA_NAME}</span></li>
            </#if>
        </#list>
        </ul>
        </dd><span id='busiListDivFlag'></span>
        </dl>
      <dl class="staffInfoArea"  id="busiAreaRemind" style="display:none;">
        <dt></dt>
        <dd>
        <span class="error" id="busiAreaError"></span>
        </dd>
      </dl>-->
  </div>
      <div class="clear"></div>
      </div>

      <div class="divide"></div>
      <!-- --------------------------------------------------------------------------------------------------------------------- -->
      <div class="staffInfoOperation">
        <h4 class="titleStyle">为此员工设定角色：</h4>
        <div class="roleList listBox">
          <dl class="listBoxTitle">
            <dt></dt>
            <dd class="width100">角色</dd>
            <dd style="padding-left:10px;">角色说明</dd>
          </dl>
          <div id='roleListDiv' class='listContent'>
            <#list roleInfoList as roleInfoBean>
            <dl>
              <#if roleInfoBean.ROLEID == roleInfoBean.SELECTROLEID>
               <dt class="verticalLine"><input type="checkbox" id="roleCheckbox" name="roleCheckbox" value="${roleInfoBean.ROLEID}" checked/></dt>
              <#else>
              <dt class="verticalLine"><input type="checkbox" id="roleCheckbox" name="roleCheckbox" value="${roleInfoBean.ROLEID}" /></dt>
              </#if>
              <dd class="width100 verticalLine">${roleInfoBean.ROLENAME}</dd>
              <dd class="width586" title="${roleInfoBean.ROLEDESC}">
              <#if roleInfoBean.ROLEDESC?length gt 40>
              ${roleInfoBean.ROLEDESC[0..40]}....
              <#else>${roleInfoBean.ROLEDESC}</#if>
              </dd>
            </dl>
            </#list>
          </div><span id='roleListDivFlag'></span>
        </div>
        <#--<h4 class="titleStyle">为此员工设定分组：</h4>
        <div class="groupList listBox">
          <dl class="listBoxTitle">
            <dt></dt>
            <dd class="width100">组别</dd>
            <dd style="padding-left:10px;">组别说明</dd>
          </dl>
          <div id='groupListDiv' class='listContent'>
            <#list groupInfoList as groupInfoBean>
            <dl>
              <#if groupInfoBean.STFGRPID == groupInfoBean.SELECTSTFGRPID>
              <dt class="verticalLine"><input type="checkbox" id="groupCheckbox" name="groupCheckbox" value="${groupInfoBean.STFGRPID}" checked/></dt>
              <#else>
              <dt class="verticalLine"><input type="checkbox" id="groupCheckbox" name="groupCheckbox" value="${groupInfoBean.STFGRPID}"/></dt>
              </#if>
              <dd class="width100 verticalLine">${groupInfoBean.STFGRPNAME}</dd>
              <dd class="width586" title="${groupInfoBean.STFGRPDESC}">
              <#if groupInfoBean.STFGRPDESC?length gt 40>
              ${groupInfoBean.STFGRPDESC[0..40]}....
              <#else>${groupInfoBean.STFGRPDESC}</#if>
              </dd>
            </dl>
            </#list>
          </div><span id='groupListDivFlag'></span>
        </div>-->
      </div>
      <div id="addBtnArea" class="submitArea">
        <input type="button" onclick="clearStaffInfo()" class="shortWhiteSubmitBtn" value="重 填">
        <input id="increase" class="shortBlueSubmitBtn" type="button" onclick="checkIncrease()" value="增 加">
        <!--<input id="increase" type="button" class="submitBtn" value="增 加" onclick="checkIncrease()"/>
        <input type="button" onclick="clearStaffInfo()" class="submitBtn" value="重 填"/>-->
      </div>
      <div id="editBtnArea" class="submitArea" style="display:none;">
        <input type="button" onclick="backToInit()" class="shortWhiteSubmitBtn" value="恢 复">
        <input id="editDetermine" class="shortBlueSubmitBtn" type="button" onclick="editCommit()" value="确 定">
        <!--<input id="editDetermine" type="button" class="submitBtn" value="确 定" onclick="editCommit();"/>
        <input type="button" class="submitBtn" value="恢 复" onclick="backToInit()"/>-->
      </div>
    </div>
  <!--============right end==============-->
</div>
<!--删除弹出层-->
<div id="deleteLayer" class="deleteLayer" style="display:none;">
  <input type="hidden" id="deleteStaffIdHide"/>
  <h3 class="change"></h3>
  <p>
    您确认要删除<span class="deleteStaffId cRed"></span>，姓名：<span class="deleteStaffName cRed"></span>的员工?
  </p>
  <p>
    <input value="确&nbsp;定" type="button" class="choiceSubmit" id="deleteSure" onclick="deleteSure()">
    <input value="取&nbsp;消" type="button" class="choiceSubmit" id="deleteCancel">
  </p>
</div>
<!--删除弹出层 end-->
<!--保存成功弹出层-->
<div class="deleteLayer" id="newSuccess" style="display:none;">
  <h3 class="successT">新增成功</h3>
  <p>
    <input value="关&nbsp;闭" type="button" class="choiceSubmit" id="newSuccessClose" onclick="successClose()">
  </p>
</div>
<!--保存成功弹出层 end-->
<!--修改成功弹出层-->
<div class="deleteLayer" id="modifySuccess" style="display:none;">
  <h3 class="successT">修改完成</h3>
  <p>
    <input value="关&nbsp;闭" type="button" class="choiceSubmit" id="modifySuccessClose" onclick="modifySuccessClose()">
  </p>
</div>
<#--<#include "/component/Message.ftl">-->
<#--<@Message/>-->
<!--修改成功弹出层 end-->
</div>
</@layout>
