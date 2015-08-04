<#include "/admin/layout/common/layout.ftl">

<@layout title="物品管理">
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<style>
.showSpan{
display:-moz-inline-box;
display:inline-block;
width:84px;
text-align:right;
}

.showDiv
{
padding-bottom: 10px;
}

.listTitleSecond {
    color: #369;
    font-weight: 600;
}


</style>

<script>
$(function(){
	var restypeCode='${restypeCode}';
	if( restypeCode!= "") {
	$("#restypeCode").val("${restypeCode}");
	}
});
function createRes(){
	var resName =$("#newResName").val();
	var restypeCode=$("#newRestypeCode").val();
	var CSRFToken = $("input[name=CSRFToken]").val();

	$.ajax({
		url: "${rc.contextPath}/admin/am/res/create",
		type: "POST",
		async: false,
		data: {"resName":resName,"restypeCode":restypeCode,"CSRFToken":CSRFToken},
		success: function(data) {
			if (data.result == "success") {
				alert(data.msg);
				window.location.href="${rc.contextPath}/admin/am/res/entryResManage";
			}else{
				alert(data.msg);
			}
		}
	});
}

function updateRes(id) {
$.layer({
    type: 2,
    shade: [0],
    fix: false,
    title: '更新物品信息',
    maxmin: true,
    iframe: {src : '/admin/am/res/updateRes?resId='+id},
    area: ['800px' , '440px'],
    end: function(){
    	location.reload(true);
    }
}); 
}

function configRes(id) {
$.layer({
    type: 2,
    shade: [0],
    fix: false,
    title: '物品信息配置',
    maxmin: true,
    iframe: {src : '/admin/am/res/confRes?resId='+id},
    area: ['800px' , '440px'],
    end: function(){
    	location.reload(true);
    }
}); 
}
function deleteRes(id){
		var CSRFToken = $("input[name=CSRFToken]").val();
		$.layer({
	    shade: [0],
	    area: ['auto','auto'],
	    dialog: {
	        msg: '确定删除该物品？',
	        btns: 2, 
	        title: '删除',                   
	        type: 4,
	        btn: ['删除','取消'],
	        yes: function() {
		        $.ajax({
						url: "${rc.contextPath}/admin/am/res/deleteRes",
						type: "POST",
						async: false,
						data: {"resId":id,"CSRFToken":CSRFToken},
						success: function(data) {
							if (data.result == "success") {
								alert(data.msg);
								//layer.alert(data.msg, 11, !1);
								window.location.href="${rc.contextPath}/admin/am/res/entryResManage";
							}else{
								alert(data.msg);
							}
						}
					});
	        	}
	        }
		});
}


</script>

<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">物品管理</span>
  </div>
</div>

<div class="listW">
		
		<ul class="sList">
		<@form.form method="post" action="${rc.contextPath}/admin/am/res/entryResManage">
	              <li style="margin-top: 10px; margin-bottom: 3px;">	
	                <label style="padding-left: 10px;">物品标识&nbsp;</label>
	            	<input type="text" class="inputStyle w180" id="resId" name="resId" value="${resId}"/>
	            	<input type="hidden" name="queryState" value="queryState"/>
	             </li>
	             <li style="margin-top: 10px; margin-bottom: 3px;">	
	                <label style="padding-left: 10px;">物品名称&nbsp;</label>
	            	<input type="text" class="inputStyle w180" id="resName" name="resName" value="${resName}"/>
	             </li>
	             
	             
	             <li style="margin-top: 10px; margin-bottom: 3px;">
	             	<label>物品类别&nbsp;</label>
	        	 	<select style="margin-left: 0px; width: 180px; height: 23px;" class="inputStyle w180" id="restypeCode" name="restypeCode" style="margin-left:6px;">
            				<option value="" selected>请选择类别</option>
            			<#list restype as item>
            				<option value="${item.RESTYPE_CODE}">${item.RESTYPE_NAME}</option>
            		 	</#list>
					</select> 
				 </li>
				 <li>
				 </li> <li></li>
	              <li style="margin-top: 10px; margin-bottom: 3px;text-align:right;">
	            	<input type="submit" value="查询" style="margin-left: 0px;" class="shortBtn mrgR10 mrgL60"/>
	              </li>
	           </@form.form>
         </ul> 
       
	       <div class="listTopBox">
	    	<table cellspacing="0" cellpadding="0" border="0" class="listTop">
	      	<tbody>
	        		 <tr>
	                    <th class="tFourth">物品标识</th>
	                    <th class="tFourth">物品名称</th>
	                    <th class="tFourth">物品类别</th>
	                    <th class="tFourth">创建时间</th>
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
	                    <td class="tFourth">${item.RES_ID}</td>
	                    <td class="tFourth">${item.RES_NAME}</td>
	                    <td class="tFourth">${item.RESTYPE_NAME}</td>
	                    <td class="tFourth">${item.CREATE_TIME}</td>
	                    <td class="tFourth">
	                   		<a class="cBlue" style="cursor:pointer;" onclick="updateRes(${item.RES_ID})">更新</a> |
	                   		<a class="cBlue" style="cursor:pointer;" onclick="deleteRes(${item.RES_ID})">删除</a> |
	                   		<a class="cBlue" style="cursor:pointer;" href="${rc.contextPath}/admin/am/res/selectResConf?resId=${item.RES_ID}">配置</a>
	                    </td>
	                   </tr>
	                  </#list>
	                   </tbody>
	                 </table>
	                  <#else>
	                  	<tr><td colspan="8" style="color:red">没有符合条件的记录</td></tr>
	                  </#if>
	     		</div>
          <#import "/admin/layout/common/pager.ftl" as q>
		  <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/res/entryResManage"/>
      
	</div>
	
	
	<div class="listTitle">
		<label class="listTitleSecond">新增物品</label>
	</div>
	
	<div style="margin-bottom: 15px; margin-top: 15px;">
	<ul class="sList">
                	
             <div class="showDiv">
            	<span class="showSpan">物品名称</span>
            	<input type="text" class="inputStyle w180" id="newResName" name="newResName" value="${resName}"/>
             </div>
             
             <div class="showDiv">
            	<span class="showSpan">物品类别</span>
        	 	<select style="width: 187px; height: 23px;" class="inputStyle w180" id="newRestypeCode" name="newRestypeCode">
                     <#list restype as item>
            			<option value="${item.RESTYPE_CODE}">${item.RESTYPE_NAME}</option>
            		 </#list>
				</select> 
              </div>
                	
              <div>
              	<span class="showSpan"></span>
            	<input type="button" value="保 存" style="margin-left: 0px;" class="shortBlueSubmitBtn" onclick="createRes()"/>
              </div>
              
          </ul>
      </div>
</div>
<div class="clear"></div>
</@layout>