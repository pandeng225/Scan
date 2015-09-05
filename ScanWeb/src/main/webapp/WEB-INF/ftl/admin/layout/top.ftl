<#if Session["ADMIN_USER"]?exists>
<#assign staffInfo = Session["ADMIN_USER"]>
</#if>
<div class="topBar w">
    <span>你好！${staffInfo.staffName}( ${staffInfo.staffCode} ) 　|　<a href="/admin/am/logout" class="fontC36cS12">退出</a></span>
    <a href="#" class="help fontC36cS12" style="width:50px;height:30px;">帮助中心</a>
</div>
<#--<div class="header w">-->
    <#--<label class="area">-->
    <#--<#if staffInfo.sysCode == 'B2C'>${staffInfo.merchantName}<#else>-->
    <#--<#if staffInfo.staffBelongDesc != null && staffInfo.staffBelongDesc != ''>${staffInfo.staffBelongDesc}</#if>-->
    <#--</#if>-->
    <#--</label>-->
    <#--<a href="/admin/am/index" class="returnToHome fontC36cS12"></a>-->
<#--</div>-->