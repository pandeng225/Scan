<#include "/admin/layout/common/layout.ftl">
<@layout title="查看商品">
<link rel="stylesheet" type="text/css" href="${e.res('/js/jquery.easyui/themes/metro/easyui.css')}">
<link rel="stylesheet" type="text/css" href="${e.res('/js/jquery.easyui/themes/icon.css')}">
<link rel="stylesheet" type="text/css" href="${e.res('/js/jquery.easyui/demo/demo.css')}">
<link href="${e.res('/js/jqueryui/css/ui-lightness/jquery-ui-1.10.4.custom.min.css')}" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="${e.res('/js/jquery/validate.css')}">
<script type="text/javascript" src="${e.res('/js/jqueryui/js/jquery-ui-1.10.4.custom.min.js')}"></script>
<script type="text/javascript" src="${e.res('/js/jquery/jquery.validate.min.js')}"></script>
<script type="text/javascript" src="${e.res('/js/jquery/jquery.form.js')}"></script>
<script type="text/javascript" src="${e.res('/js/ckeditor/ckeditor.js')}" ></script>
<script type="text/javascript" src="${e.res('/js/ckeditor/adapters/jquery.js')}" ></script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<style>
.addGoodArea dt{
 margin-bottom:5px;
}
.addGoodArea dd{
 margin-bottom:5px;
}
</style>
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">商品管理</span>
        </div>
    </div>

    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
          <@form.form method="post" id="addGoodForm" action="${rc.contextPath}/admin/am/goods/view">
          <input type="hidden" name="goodsId" value="${good.goodsId}"/>
        <dl class="addGoodArea">
                <dt>
                    <label class="cRed marginR4">*</label>商品分类：
                    	<#if (ctlgList?size>0) >
				        	<#list ctlgList as cc>
				               <#list cc.children as c><#if c.id=good.ctlgCode> ${c.text}</#if></#list>
			                </#list>
				        </#if>
                </dt>
                <dd>
                    <table cellspacing="0" cellpadding="0" border="0" class="listTop">
				        <tbody class="selectResources">
					        <tr>
					            <th scope="tFourth" style="width: 190px;">物品标识</th>
					            <th scope="tFourth" style="width: 180px;">物品名称</th>
					        </tr>
					        <#if (resList?size>0) >
				        		<#list resList as cc>
						        <tr class="selectResource">
							        <td scope="tFourth" style="width: 190px;">${cc.RES_ID}</td>
							        <td scope="tFourth" style="width: 180px;">${cc.RES_NAME}</td>
						        </tr>
						        </#list>
				        	</#if>
				        </tbody>
				    </table>
				                    
                </dd>
                <dt>
                    <label class="cRed marginR4">*</label>商品名称：${good.goodsName}</dt>
                <dd>
                    
                </dd>
                <dt>
                    <label class="cRed marginR4">*</label>原始价格：<#if price.originalPrice??>${price.originalPrice/1000}元</#if></dt>
                <dd>
                <dt>
                    <label class="cRed marginR4">*</label>销售价格：${price.addPrice/1000}元</dt>
                <dd>
                </dd>
                <dt><label class="cRed marginR4">*</label>可售数量：${amount.goodsAmount}</dt>
                <dt><label class="cRed marginR4">*</label>商品图片：</dt>
                <dd id="albumImg">
                <#if (albumList?size>0) >
				    <#list albumList as cc>
                			<img src="${e.res(cc.PHOTO_LINKS)}" alt="${cc.ALBUM_EXPLAIN}"/>
                	</#list>
				</#if>
                </dd>
                <dt><label class="cRed marginR4">*</label>简单描述：</dt>
                <dd>${good.simpDesc}</dd>
                
                <dt><label class="cRed marginR4">*</label>详细描述：</dt>
                <dd>${goodContent}</dd>
        </dl>
            </@form.form>
	</div>
    <!--end main content-->
</div>
<div class="clear"></div>
</@layout>