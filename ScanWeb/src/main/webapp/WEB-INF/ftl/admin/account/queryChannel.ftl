<#include "/layout/admin/common/layoutForRegister.ftl">

<@layout title="关联渠道信息">

<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">代理商加盟  &gt; 关联渠道信息</span>
  </div>
</div>
<!--end curmb-->

<div class="listW">
     <!--begin right content-->
        	<ul class="sList">
        		<div class="prompt" style="margin-bottom: 10px;">
        		<label>销售范围：</label>${cityName}
        		
        		</div>
            	<@form.form method="post" action="${rc.contextPath}/agent/register/regisQueryChannel">
            	<div style="margin-left: 35px;">
                	<li>
                	<label>网格名称：</label>
                	<input type="text" class="inputStyle w180" id="gridName" name="gridName" value="${gridName}"/>
                	<input type="hidden" id="cityCode" name="cityCode" value="${cityCode}"/>
                	</li>
                	<li>
                	<label>渠道名称：</label>
                	<input type="text" class="inputStyle w180" id="channelName" name="channelName" value="${channelName}"/>
                	</li>
                	<li>
                	<input type="submit" value="查 询" class="shortBtn mrgR10 mrgL60" />
                	</li>
                	</div>
                </@form.form>
        	</ul> 
<div class="listTopBox">
    	<table cellspacing="0" cellpadding="0" border="0" class="listTop">
	      	<tbody>
		        <tr>
		          <th class="tFourth">网格名称</th>
		          <th class="tFourth">渠道名称</th>
		          <th class="tFourth">操作</th>
		        </tr>
	         </tbody>
     	</table>
</div>

<div class="listContBox">
        <#if (pager.rows?size>0) >
        		<table cellspacing="0" cellpadding="0" border="0" class="listTop">
      				<tbody>
                  <#list pager.rows as item>
                   <tr>
                    <td class="tFourth">${item.GRID_NAME}</td>
                    <td class="tFourth">${item.CHANNEL_NAME}</td>
                    <td class="tFourth">
	                  <a  style="color:blue;" href="${rc.contextPath}/agent/register/regisQueryDeveloper?cityCode=${item.CITY_CODE}&channelCode=${item.CHANNEL_CODE}">选择发展人</a>
        			</td>
        			</tr>
                  </#list>
                   	</tbody>
     		   </table>
        <#else>
                  	<tr><td colspan="6">没有符合条件的记录</td></tr>
         </#if>
     </div>
     <!--end right content-->
     <#import "/admin/agentstaffinfo/pagerwithbatch.ftl" as q>
	 <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/agent/register/regisQueryChannel"/>
</div>
<!--end main content-->  

</@layout>