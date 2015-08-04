<#include "/admin/layout/common/layout.ftl">
<@layout title="更新订单商品信息">
<link href="${e.res('/css/orderDetail.css')}" rel="stylesheet" type="text/css"/>
<style type="text/css">
    * {
        color: #333;
        font-family: Arial,Helvetica,sans-serif;
        font-size: 12px;
        font-weight: normal;
        line-height: 1.6em;
        list-style: outside none none;
        text-decoration: none;
    }
    .resitem{
        border: 1px solid #eed97c;
        margin-bottom: 5px;
    }
    .newPost{
        padding: 5px;
    }
    .newPost div{
        margin-top: 5px;
        margin-bottom: 5px;
    }

    .aa{
        margin-left: 5px;
        margin-top: 5px;
        margin-bottom: 5px;
    }

    .cBlue, .cBlue:visited, .cBlue a {
        color: #36c;
    }
    a {
        color: #333333;
        text-decoration: none;
    }

    .bb{
        text-align:center;
        margin-right: 30px;
        display: inline;
        margin-left: 10px;
    }
</style>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<script language="javascript" type="text/javascript">
function editAttrval(id){
var orderId = $(id).next().val();
var resId = $(id).next().next().val();
var resAttrCode = $(id).next().next().next().val();
var resAttrval = $(id).next().next().next().next().val();
//var attrName = $(id).nextAll("input[name='attrName']").val();
//alert(orderId);alert(resId);alert(resAttrCode);
	$.layer({
	    type: 2,
	    shade: [0],
	    fix: false,
	    title: '更新订单物品属性值',
	    maxmin: true,
	    iframe: {src : '/admin/am/order/updateAttrval?orderId='+orderId+'&resId='+resId+'&resAttrCode='+resAttrCode+'&resAttrval='+resAttrval},
	    area: ['800px' , '440px'],
	    end: function(){
	    	location.reload(true);
	    }
	}); 
}
 
</script>

<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">订单管理&nbsp;&gt;&nbsp;订单商品信息细节</span>
  </div>
</div>

<div class="aa">
	订单商品名称:${goods.goodsName}
</div>
<div>
	<div class="aa">
		订单物品信息
	</div>
	<#if orderResInfo??>
	<#list orderResInfo as i>
			<#list i?keys as ii>
				<div class="resitem">
					<div class="newPost">
						物品名：${ii}
					</div> 
					<div class="aa">
					物品细节：
					</div>
					<div class="newPost">
						<#list i[ii] as iii>
							<#list iii as iiii>
								<#if (iiii.RES_ATTR_CODE!="NETTYPE")&&(iiii.RES_ATTR_CODE!="NUMBERS")>
									<div>
										<div class="bb">${iiii.ATTR_NAME}</div>
										<div class="bb">${iiii.RES_ATTR_VAL}</div>
										<div class="bb">
										<a class="cBlue" style="cursor:pointer;" onclick="editAttrval(this)">编辑属性值</a>
										<input name="orderId" type="hidden" value="${iiii.ORDER_ID}"/>
										<input name="resId" type="hidden" value="${iiii.RES_ID}"/>
										<input name="resAttrCode" type="hidden" value="${iiii.RES_ATTR_CODE}"/>
										<input name="resAttrval" type="hidden" value="${iiii.RES_ATTR_VAL}"/>
										<input name="attrName" type="hidden" value="${iiii.ATTR_NAME}"/>
										</div>
									</div>
									<!--展示手机号码或者号卡-->
								<#elseif iiii.RES_ATTR_CODE=="NUMBERS">
									<div>
										<div class="bb">${numType}</div>
										<div class="bb">${iiii.RES_ATTR_VAL!'空'}</div>
										<div class="bb">
										<a class="cBlue" style="cursor:pointer;" onclick="editAttrval(this)">编辑属性值</a>
										<input name="orderId" type="hidden" value="${iiii.ORDER_ID}"/>
										<input name="resId" type="hidden" value="${iiii.RES_ID}"/>
										<input name="resAttrCode" type="hidden" value="${iiii.RES_ATTR_CODE}"/>
										<input name="resAttrval" type="hidden" value="${iiii.RES_ATTR_VAL}"/>
										<input name="attrName" type="hidden" value="${iiii.ATTR_NAME}"/>
										</div>
									</div>
								</#if>
							</#list>
						</#list>
					</div>
				</div>
			</#list>
		</#list>
	 <#else>
	 	<div id="newPost">
			当前商品没有物品信息!
		</div> 
	 </#if>
</div>
  
</@layout>