<#include "/admin/layout/common/layout.ftl">
<@layout title="物品导入结果">
<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">物品导入结果&nbsp;&gt;&nbsp;excel导入结果界面</span>
  </div>
</div>
<#if msg??>
<div style="margin-top: 15px; margin-bottom: 15px;">
出现异常：<font style="color:red">${msg}</font>
</div>
<#else>
<div style="margin-top: 15px; margin-bottom: 15px;">
处理结果</br>
总条数：<font style="color:red">${totalnum}</font>&nbsp;&nbsp;
成功入库条数：<font style="color:red">${insertSuccess}</font>&nbsp;&nbsp;
失败入库条数：<font style="color:red">${insertFail}</font>&nbsp;&nbsp;
数据为空条数：<font style="color:red">${insertNull}</font>
</div>
</#if>
</@layout>