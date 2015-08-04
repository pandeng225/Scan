<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<link rel="stylesheet" type="text/css" href="${e.res('/css/global.css')}">
<link href="${e.res('/css/goods_edit_list.css')}" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<script>
var index = parent.layer.getFrameIndex(window.name);
var ParentWin;
$(function(){
ParentWin=window.parent;
});
function selectRes(ck,resId,resName){
	if(ck.checked == true) {
		ParentWin.addRes(resId,resName);
	}	
}
</script>

<style type="text/css">
</style>
<div class="listW" style="margin-left:10px;">
     <!--begin right content-->
	<ul class="sList" style="padding-top:10px;">
    	<@form.form method="post" action="${rc.contextPath}/admin/am/goods/queryRes">
        	<li>
        	<label>物品名称：</label>
        	<input type="text" class="inputStyle" name="resName" value=""/>
        	</li>
        	<li>
        	<label>物品分类：</label>
        	<select type="text" id="restypeCode" style="width:150px;" name="restypeCode" value="">
        	<option value="">全部</option>
                    	<#if (resTypeList?size>0) >
				        		<#list resTypeList as cc>
							        <option value="${cc.restypeCode}">${cc.restypeName}</option>
			                  </#list>
				        </#if>
                    </select>
        	</li>
        	<li><input type="submit" name="searchRes" value="搜索" class="shortBtn mrgR10 mrgL10"/></li>
        	<input type="hidden" name="pageSize" value="${pager.pageSize}">
        </@form.form>
	</ul> 

 	<div class="listTopBox">
        <table cellspacing="0" cellpadding="0" border="0" class="listTop">
            <tbody>
            <tr>
                <th class="tTrd">选择</th>
                <th class="tSeventh">物品描述</th>
                <th class="tTrd">查看详细属性</th>
            </tr>
            </tbody>
        </table>
    </div>
	<div class="listContBox">
        <#if (pager.rows?size>0) >
              <#list pager.rows as res>
                <table cellspacing="0" cellpadding="0" border="0">
                    <tbody>
                    <tr>
                        <td class="tTrd"><input type="checkbox" name="resId" value="${res.RES_ID}" onclick="selectRes(this,${res.RES_ID},'${res.RES_NAME}')"/></td>
                        <td class="tSeventh">${res.RES_NAME}</td>
                        <td class="tSnd">                                
                                <a href="/admin/am/res/selectResConf?resId=${res.RES_ID}" class="cBlue" target="_blank">查看物品属性</a>
                        </td>
                    </tr>
                    </tbody>
                </table>
              </#list>
              <#else>
              	没有符合条件的记录
         </#if>
</div>
     <!--end right content-->
     <div style="clear:both;"></div>
     <#import "/admin/layout/common/pager.ftl" as q>
	 <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/goods/queryRes"/>