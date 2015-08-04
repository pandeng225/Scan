<#include "/admin/layout/common/layout.ftl">
<@layout title="发货退货地址管理">
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>

<style type="text/css">
#oldPost{
padding: 10px;
border: 1px solid #eed97c;
margin-bottom: 20px;"
}
#deliveryAddr{
margin-top: 5px;
padding: 10px;
border: 1px solid #eed97c;
}
#deliveryAddr div{
margin-top: 5px; 
margin-bottom: 5px;
}
#returnAddr div{
margin-top: 5px; 
margin-bottom: 5px;
}

.inputda{
border: 1px solid #bbbbbb;
    height: 23px;
    line-height: 23px;
    padding: 0 2px;
}

#returnAddr{
margin-top: 5px;
padding: 10px;
border: 1px solid #eed97c;
}
#returnAddr{
margin-top: 5px;
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

#daTitle div{
display:inline;
}
#returnTitle div{
display:inline;
}

.w230{
width:230px;
}
.w72{
width:100px;
}
.divnoline{
display:inline;
}
</style>
<script>

$(function(){
if(deliveryAddr != null){
	//alert("有值");
	$("#newDeliveryAddr").hide();
} else {
	$("#newDeliveryAddr").show();
}
});

function editDeliveryAddr(id) {
var tt=""
if(id == 'A'){
tt = "编辑发货地址";
}else{
tt = "编辑退货地址";
}
$.layer({
    type: 2,
    shade: [0],
    fix: false,
    title: tt,
    maxmin: true,
    iframe: {src : '/admin/am/delivery/editDeliveryAddrInit?addrType='+id},
    area: ['850px' , '550px'],
    end: function(){
    	location.reload(true);
    }
}); 
}

function newAddr(id){
var addrType=id;
var tt=""
if(addrType == 'A'){
tt = "新增发货地址";
}else{
tt = "新增退货地址";
}
$.layer({
    type: 2,
    shade: [0],
    fix: false,
    title: tt,
    maxmin: true,
    iframe: {src : '/admin/am/delivery/newAddrInit?addrType='+addrType},
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
    <span class="left">发货退货地址管理</span>
  </div>
</div>
<!--end curmb-->

<div id="deliveryAddr">
	<div id="daTitle">
		<div>发货地址信息</div>
		<#if deliveryAddr??>
			<div><a class="cBlue" style="cursor:pointer;" onclick="editDeliveryAddr('A')">编辑</a> </div>
		<#else>
			<br/>
			<div>您当前没有发货地址。</div>
			<div>
				<a class="cBlue" style="cursor:pointer;" onclick="newAddr('A')">新增</a>
			</div>
		</#if>
	</div>
	
	<#if deliveryAddr??>
		<#list deliveryAddr as item>
		<div>
		<label>省份:</label><input id="provinceName" name="provinceName" type="text" value="${item.PROVINCE_NAME}" class="inputda" readonly/> &nbsp;
		<label>地市:</label><input id="cityName" name="cityName" type="text" value="${item.CITY_NAME}" class="inputda" readonly/>	&nbsp;
		<label>区县:</label><input id="districtName" name="districtName" type="text" value="${item.DISTRICT_NAME}" class="inputda" readonly/>	
		</div>
		<div>
		<div class="w72 divnoline">邮&nbsp;政&nbsp;编&nbsp;码:&nbsp;</div><input id="postCode" name="postCode" type="text" value="${item.POST_CODE}" class="inputda" readonly/></div>
		<div>
		<div class="w72 divnoline">详&nbsp;细&nbsp;地&nbsp;址:&nbsp;</div><input id="postAddr" name="postAddr" type="text" value="${item.POST_ADDR}" class="inputda w230" readonly/></div>
		<div><div class="w72 divnoline">联系人姓名:</div><input id="linkman" name="linkman" type="text" value="${item.LINKMAN}" class="inputda" readonly/>	</div>
		<div><div class="w72 divnoline">联&nbsp;系&nbsp;电&nbsp;话:&nbsp;</div><input id="linkPhone" name="linkPhone" type="text" value="${item.LINK_PHONE}" class="inputda" readonly/>	</div>
		</#list>
	</#if>
</div>

<div id="returnAddr">
	<div id="returnTitle">
		<div class="divnoline">退货地址信息</div>
		<#if returnAddr??>
			<div><a class="cBlue" style="cursor:pointer;" onclick="editDeliveryAddr('B')">编辑</a> </div>
		<#else>
			<br/>
			<div>您当前没有退货地址。</div>
			<div>
				<a class="cBlue" style="cursor:pointer;" onclick="newAddr('B')">新增</a>
			</div>
		</#if>
	</div>
	<#if returnAddr??>
		<#list returnAddr as item>
		<div>
		<label>省份：</label><input id="returnProvinceName" name="provinceName" type="text" value="${item.PROVINCE_NAME}" class="inputda" readonly/> 
		<label>地市：</label><input id="returnCityName" name="cityName" type="text" value="${item.CITY_NAME}" class="inputda" readonly/>	
		<label>区县：</label><input id="returnDistrictName" name="districtName" type="text" value="${item.DISTRICT_NAME}" class="inputda" readonly/>	
		</div>
		<div><div class="w72 divnoline">邮&nbsp;政&nbsp;编&nbsp;码:&nbsp;</div><input id="returnPostCode" name="postCode" type="text" value="${item.POST_CODE}" class="inputda" readonly/>	</div>
		<div><div class="w72 divnoline">详&nbsp;细&nbsp;地&nbsp;址:&nbsp;</div><input id="returnPostAddr" name="postAddr" type="text" value="${item.POST_ADDR}" class="inputda w230" readonly/>	</div>
		<div><div class="w72 divnoline">联系人姓名:</div><input id="returnLinkman" name="linkman" type="text" value="${item.LINKMAN}" class="inputda" readonly/>	</div>
		<div><div class="w72 divnoline">联&nbsp;系&nbsp;电&nbsp;话:&nbsp;</div><input id="returnLinkPhone" name="linkPhone" type="text" value="${item.LINK_PHONE}" class="inputda" readonly/>	</div>
		</#list>
	</#if>
</div>

</@layout>