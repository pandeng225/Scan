<#include "/layout/admin/common/layoutForRegister.ftl">
<@layout title="选择渠道发展人">

<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">代理商加盟 &gt;关联渠道信息&gt;选择渠道发展人</span>
  </div>
</div>
<!--end curmb-->

<div class="listW">
     <!--begin right content-->
        	<ul class="sList">
                	<div class="prompt" style="margin-bottom: 10px;">
                	<label>销售范围：</label>${cityName} </br>
                	<label>网格名称：</label>${gridName}</br>
                	<label>渠道名称：</label>${channelName}
                	<!--<label>渠道名称：</label><input type="text" id="ttt"/>-->
                	</div>
                	
            	<@form.form method="post" action="${rc.contextPath}/agent/register/regisQueryDeveloper">
                	<input type="hidden" id="cityCode" name="cityCode" value="${cityCode}"/>
                    <input type="hidden" id="channelCode" name="channelCode" value="${channelCode}"/>
                	<div style="margin-left: 35px;">
                	<li>
                	<label>发展人名称：</label>
                	<input type="text" class="inputStyle w180" id="developerName" name="developerName" value="${developerName}"/>
                	</li>
                	<li>
                	<label>电话号码：</label>
                	<input type="text" class="inputStyle w180" id="developerPhone" name="developerPhone" value="${developerPhone}"/>
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
		          <th class="tFourth">发展人名称</th>
		          <th class="tFourth">电话号码</th>
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
                   <td class="tFourth">${item.DEVELOPER_NAME}</td>
                    <td class="tFourth">${item.DEVELOPER_PHONE}</td>
                    <td class="tFourth">
                    	<input type="hidden" class="radioChannelCode" name="radioChannelCode" value="${item.CHANNEL_CODE}"/>
                    	<input type="hidden" class="radioChannelName" name="radioChannelName" value="${item.CHANNEL_NAME}"/>
                    	<input type="hidden" class="radioDeveloperCode" name="radioDeveloperCode" value="${item.DEVELOPER_CODE}"/>
                    	<input type="hidden" class="radioDeveloperName" name="radioDeveloperName" value="${item.DEVELOPER_NAME}"/>
	                    <input type="radio" id="developerRaido" name="developerRaido" ondblclick="getReturnValue()" />
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
		
	<div align="center">
		<input type="button" value="确定" onclick="getReturnValue()"  class="mediumBtn"/>
		<a class="mediumBtn" href="${rc.contextPath}/agent/register/regisQueryChannel?cityCode=${cityCode}">取消</a>
		<!--<input type="button" value="取消" onclick="cancelWin()"  class="mediumBtn"/>-->
	</div>

</div>
<!--end main content-->  
<script language=javascript> 

$(function(){
//alert("2222");
var k=window.dialogArguments; 
if(k!=null) 
 { 
 $("#ttt").val(k.$("#areano").val()); 
 } 
});



function cancelWin() {
window.close();
}


//设置返回到父窗口的值 
function retrunValue() 
{ 
var s = $('input:radio[name=developerRaido]:checked');
var channelCode=s.parent().children(".radioChannelCode").val();
var channelName=s.parent().children(".radioChannelName").val();
var developerCode=s.parent().children(".radioDeveloperCode").val();
var developerName=s.parent().children(".radioDeveloperName").val();
k.$("#channelName").val(channelName);
k.$("#channelCode").val(channelCode);
k.$("#developCode").val(developerCode);
k.$("#developName").val(developerName);

window.close(); 
} 

function getReturnValue(){
var s = $('input:radio[name=developerRaido]:checked');
var channelCode=s.parent().children(".radioChannelCode").val();
var channelName=s.parent().children(".radioChannelName").val();
var developerCode=s.parent().children(".radioDeveloperCode").val();
var developerName=s.parent().children(".radioDeveloperName").val();
	if(window.ActiveXObject){ //IE
		window.returnValue = {
				ccode : channelCode,
				cname : channelName,
				dcode: developerCode,
				dname: developerName
				} ;
		window.close();
	}else{ //非IE
		if(window.opener) {
		window.opener.setValue(channelCode,channelName,developerCode,developerName) ;
		}
		window.close();
	}
}
</script>
</@layout>