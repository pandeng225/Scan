<#include "/admin/layout/common/layout.ftl">
<@layout title="物流信息更新">
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<style type="text/css">
#oldPost{
padding: 10px;
border: 1px solid #eed97c;
margin-bottom: 20px;"
}
#newPost{
padding: 10px;
border: 1px solid #eed97c;
}
#afterPost{
padding: 10px;
border: 1px solid #eed97c;
}
#oi{
margin-top: 15px; 
margin-bottom: 15px; 
margin-left: 10px;
}
#oldPost div,#newPost div,#afterPost div{
margin-top: 5px; 
margin-bottom: 5px;
}
</style>
<script>
function load() {
$.layer({
    type: 2,
    shade: [0],
    fix: false,
    title: '编辑物流地址',
    maxmin: true,
    iframe: {src : '/admin/am/order/trans'},
    area: ['800px' , '440px'],
    end: function(){
    	location.reload(true);
    }
});

}

</script>
<!--begin crumb-->
<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">订单管理&nbsp;&gt;&nbsp;物流信息更新</span>
  </div>
</div>
<!--end curmb-->

<!-- context -->
<div id="oi">
订单标识：${orderId}
<input id="orderId" type="hidden" value="${orderId}"/>
<input id="name" type="hidden" value="${orderDataPost.RECEIVER_NAME}"/>
<input id="phone" type="hidden" value="${orderDataPost.MOBILE_PHONE}"/>
<input id="address" type="hidden" value="${orderDataPost.POST_ADDR}"/>
<input id="deliverWay" type="hidden" value="${orderDataPost.DELIVER_TYPE_CODE}"/>
<input id="deliverTime" type="hidden" value="${orderDataPost.DELIVER_TIME_CODE}"/>
<input id="provinceCode" type="hidden" value="${orderDataPost.PROVINCE_CODE}"/>
<input id="cityCode" type="hidden" value="${orderDataPost.CITY_CODE}"/>
<input id="districtCode" type="hidden" value="${orderDataPost.DISTRICT_CODE}"/>
</div>
<div id="oldPost">

	<div>
	<span>收件人姓名：</span><span id="newName">${orderDataPost.RECEIVER_NAME}</span>
	&nbsp;&nbsp;&nbsp;<span><a class="cBlue" style="cursor:pointer;" onclick="load()">更新</a></span>
	</div>
	<div>
	<span>手机号码：</span><span id="newPhone">${orderDataPost.MOBILE_PHONE}
          		 <#if orderDataPost.FIX_PHONE?if_exists>&nbsp;/&nbsp;${orderDataPost.FIX_PHONE}</#if></span>
	</div>
	<div>
	<span>详细地址：</span><span id="newAddr">${orderDataPost.PROVINCE_NAME}，${orderDataPost.CITY_NAME}，${orderDataPost.DISTRICT_NAME}，${orderDataPost.POST_ADDR}</span>
	</div>
	<div>
	<span>配送方式：</span><span id="newWay">
		<#if orderDataPost.DELIVER_TYPE_CODE == "00">
			不需要配送
		<#elseif orderDataPost.DELIVER_TYPE_CODE == "01">
			 送货
		<#elseif orderDataPost.DELIVER_TYPE_CODE == "02">
			自提
		</#if>
	</span>
	</div>
	<div>
	<span>配送时间：</span><span id="newTime">
		<#if orderDataPost.DELIVER_TIME_CODE == "00">
			工作日
		<#elseif orderDataPost.DELIVER_TIME_CODE == "01">
			 周末
		<#elseif orderDataPost.DELIVER_TIME_CODE == "02">
			工作日、周末
		</#if>
	</span>
	</div>
</div>

</@layout>