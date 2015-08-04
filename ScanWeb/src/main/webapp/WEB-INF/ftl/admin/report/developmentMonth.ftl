<#include "/admin/layout/common/layout.ftl">
<@layout title="财务月报表">
<script language="javascript" type="text/javascript" src="${e.res('/js/datePicker/WdatePicker.js')}"></script>
<style type="text/css">
    *{
        color: #333;
        font-family: Arial,Helvetica,sans-serif;
        font-size: 12px;
        font-weight: normal;
        line-height: 1.6em;
        list-style: outside none none;
        margin: 0;
        padding: 0;
        text-decoration: none;
    }
    .tableBody table p {
        z-index: 98;
        margin-left: 5px;
    }
    .tableBody table p.top {
        margin-top: 5px;
    }
    .tableBody table p.bottom {
        margin-bottom: 5px;
    }

    .tableBody table td{
        word-break: break-all;
        word-wrap: break-word;
    }
    .tableBody table td.first{
        border-left: 1px solid #e6f0f5;
        border-top:1px solid #e6f0f5;
        text-align:center;
    }
    .tableBody table td.others {
        border-collapse: collapse;
        border-left: 1px solid #e6f0f5;
        border-top: 1px solid #e6f0f5;
        border-right: 1px solid #e6f0f5;
        padding-bottom: 10px;
        padding-top: 10px;
        text-align: center;
        vertical-align: top;
    }
     .tableBody table td.third {
        border-top: 1px solid #e6f0f5;
    }

    .tleft{
        text-align: left;
    }

</style>
<script>
function exportXls(){
 window.open('${rc.contextPath}/admin/am/report/development/exportMonth?monthTime='+$("#monthTime").val());
}
</script>
<!--begin crumb-->
<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">报表管理&nbsp;&gt;&nbsp;财务月报表</span>
  </div>
</div>
    <!--end curmb-->
<!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
			<@form.form method="post" action="${rc.contextPath}/admin/am/report/development/queryMonth">
            		<li>
	            		<label>月份：&nbsp;</label>
	            		<input id="monthTime" type="text" class="inputStyle w75" name="monthTime" value="${monthTime}" style="width: 82px;" onclick="WdatePicker({readOnly:true,dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: true })" />
            		</li>
                    <li></li>
            		<li style="text-align:left;">
            		<input type="submit" value="查询" class="shortBtn mrgR10 mrgL60" />
            		<input onclick="exportXls()" type="button" value="导出" class="shortBtn" />
            		</li>
          </@form.form>
        </ul>
        <!--end right content-->
        
        <div class="listTopBox">
         <#if (stat??) >
    	<table cellspacing="0" cellpadding="0" border="0" class="listTop">
      	<tbody>
      		<tr>
      		<#list stat as item>
        		 <#if item_index==0>
        		 	<#list item as t>
                    <th class="first" width="60">${t}</th>
                    </#list>
                 </#if>
         	</#list>
         	</tr>
         </tbody>
     	</table>
     	</#if>
      </div>
      <div class="tableBody" cellpadding="0" cellspacing="0" border="0" width="100%"  style="margin-bottom: 7px;"> 
                  <#if (stat??) >
	                <table cellspacing="0" cellpadding="0" border="0" width="100%">
	      			   <tbody>
		                  <#list stat as item>
			                  <#if item_index gt 0>
			                  	<tr>
			        		 	<#list item as t>
			                    <td class="first" width="60">${t}</th>
			                    </#list>
			                    </tr>
			                 </#if>
		                  </#list>
	                   </tbody>
	                 </table>
	                 
                  <#else>
                  	<tr><td colspan="8" style="color:red">没记录</td></tr>
                  </#if>
     </div>
    </div>
    <!--end main content-->  
</div>

</@layout>