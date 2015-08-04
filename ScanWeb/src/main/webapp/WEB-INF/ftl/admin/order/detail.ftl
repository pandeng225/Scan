<#include "/admin/layout/common/layout.ftl">
<@layout title="订单详情">
<link href="${e.res('/css/orderDetail.css')}" rel="stylesheet" type="text/css"/>
<style type="text/css">
    #orderstate{
        margin-top: 10px;
    }

    .ct{
        font-weight:bold
    }
    .setFont{
        font-size: 14px;
    }

    #orderinfo .mt h2 {
        height: 31px;
        position: relative;
    }
    .ddxx{
        font-family: Arial,Helvetica,sans-serif;
        font-size: 15px;
    }

    .section4{
        width:815px;
    }

    #process .node {
        width: 13px;
    }
    #process .proce {
        -moz-border-bottom-colors: none;
        -moz-border-left-colors: none;
        -moz-border-right-colors: none;
        -moz-border-top-colors: none;
        border-color: #fff;
        border-image: none;
        border-style: solid;
        border-width: 0 5px;
        width: 100px;
    }
    #process .tx1 {
        height: 36px;
        margin-bottom: 16px;
    }
    #process .tx3 {
        color: #999;
        line-height: 15px;
    }
    .node.wait {
        background-position: -92px -40px;
    }
    .node.ready {
        background-position: -92px 0;
    }
    .node.singular {
        background-position: -150px -60px;
    }
    .proce.wait {
        background-position: 8px -40px;
    }
    .proce.doing {
        background-position: 0 -20px;
        color: #360;
    }
    .proce.ready {
        background-position: 7px 0;
        /*background-position: -50px 0;*/
    }
    #process .wait .tx2 {
        color: #999;
    }
    #process ul {
        margin-top: -38px;
        position: absolute;
        text-align: center;
    }
    #process .proce ul {
        width: 120px;
        z-index: 5;
    }
    #process .node ul {
        margin-left: -152px;
        width: -138px;
        z-index: 1;
    }

</style>
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<script language="javascript" type="text/javascript">
function checkCustInfo(){
var img1=$("#img1").val();
var img2=$("#img2").val();
//alert(img1);alert(img2);
$.layer({
	offset:['150px','50%'],
    type: 2,
    shade: [0],
    fix: false,
    title: '查看订单客户身份证相片信息',
    maxmin: true,
    iframe: {src : '${rc.contextPath}/admin/am/order/checkCustInfo?img1='+img1+'&img2='+img2},
    area: ['600px' , '400px'],
    end: function(){
    }
}); 
}

    $(document).ready(function(){
    	var num = 0;
    	if("${orderDataBase.orderState}" == "未处理") {
	    	num = 0
	    }else if ("${orderDataBase.orderState}" == "待分配") {
	    	num = 1;
	    } else if ("${orderDataBase.orderState}" == "订单补录") {
	    	num = 2;
	    }else if ("${orderDataBase.orderState}" == "待发货") {
	    	num = 3;
	    }else if ("${orderDataBase.orderState}" == "发货中") {
	    	num = 4;
	    } else if ("${orderDataBase.orderState}" == "物流在途") {
	    	num = 5;
	    }else if ("${orderDataBase.orderState}" == "成功关闭") {
	    	num = 6;
	    }
	   // alert(num)
	    if(num > 0){
	    	$("#parttwo").removeClass("wait");
	    	$("#parttwo").addClass("ready");
	    	$("#partthree").removeClass("wait");
	    	$("#partthree").addClass("ready");
	    	 if(num > 1){
	    	 $("#partfour").removeClass("wait");
	    	 $("#partfour").addClass("ready");
	    	 $("#partfive").removeClass("wait");
		     $("#partfive").addClass("ready");
		    	  if(num > 2){
			    	 $("#partsix").removeClass("wait");
			    	 $("#partsix").addClass("ready");
			    	 $("#partseven").removeClass("wait");
			    	 $("#partseven").addClass("ready");
			    	  if(num > 3){
				    	 $("#parteight").removeClass("wait");
				    	 $("#parteight").addClass("ready");
				    	 $("#partnine").removeClass("wait");
				    	 $("#partnine").addClass("ready");
			    	 	 if(num > 4){
				    	 $("#partten").removeClass("wait");
				    	 $("#partten").addClass("ready");
				    	 $("#partenleven").removeClass("wait");
					     $("#partenleven").addClass("ready");
				    	 	if(num > 5){
					    	 $("#parttwelve").removeClass("wait");
					    	 $("#parttwelve").addClass("ready");
					    	 $("#partthirteen").removeClass("wait");
						     $("#partthirteen").addClass("ready");
				    		 }
			    		 }
			    	 }
		    	 }
	    	 }
	    }
	    
	    
	    
    });
    
    function qryPost(){
    	var CSRFToken = $("input[name=CSRFToken]").val();
    	$("#postTrackInfo").html("<li>正在查询中...</li>");
		$.ajax({
				url: "${rc.contextPath}/admin/am/order/qryPostTrack",
				type: "POST",
				async: true,
				data: {"eid":'${orderDataPost.EXPRESS_ID}',"ename":'${orderDataPost.EXPRESS_COMPNAY}',"CSRFToken":CSRFToken},
				success: function(data) {
					if(data.status){
						var v='<li><strong class="ct">物流信息</strong></li>';
						$(data.steps).each(function(idx,item){
	                		v=v+'<li><span>'+item.acceptTime+'</span>&nbsp;<span>'+item.remark+'【'+item.acceptAddress+'】</span></li>';
	                	});
						$("#postTrackInfo").html(v);
					}else{
						$("#postTrackInfo").html("<li>"+data.msg+"</li>");
					}
				}
			});
    }
</script>

<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">订单管理&nbsp;&gt;&nbsp;订单查询&nbsp;&gt;&nbsp;订单详情</span>
  </div>
</div>
<div id="orderstate" class="m">
	<div class="mt">
		<strong class="ct">订单号:${orderDataBase.orderId} &nbsp;&nbsp;&nbsp;状态:</strong> 
		<span class="ftx14 ct setFont">&nbsp;${orderDataBase.orderState}</span>
	</div>
	<div class="mc">
	物流单号：<span class="ftx14 ct setFont">${orderDataPost.EXPRESS_ID}</span>
	<a class="ct" href="javascript:void(0);" onclick="qryPost();">查询物流信息</a>
	</div>
	<ul class="mc" id="postTrackInfo">
	
	</ul>
</div>


<!-- 订单跟踪 -->
<div id="ordertrack" class="m">
	<ul class="tab">
		<li class="curr">
			<h2 style="height:31px;line-height:31px;overflow:hidden;" class="ct">订单跟踪</h2>
		</li>
	</ul>
	<div class="clr"></div>
	<div class="mc tabcon" style="display: block;">
		<table cellpadding="0" cellspacing="0" width="100%">
		  <tbody id="tbody_track">
		    <tr>
		      <th width="15%"><strong style="text-align:center;">处理时间</strong></th>
		      <th width="50%"><strong style="text-align:center;">处理信息</strong></th>
		      <th width="35%"><strong style="text-align:center;">操作人</strong></th>
		    </tr>
		  </tbody>
		  <tbody>
		  	<#list orderLogDeallogs as item>
	 			<tr>
				  	 <td style="text-align:center;">${item.OPERATE_TIME}</td>
				  	 <td style="text-align:center;">${item.DEAL_CONTENT}</td>
				  	 <td style="text-align:center;">${item.OPERATOR_NAME}</td>
			  	</tr>
			</#list>
		  </tbody>
		</table>
	</div>
	
</div>

<!-- 订单信息 -->
<div class="m" id="orderinfo">
    <div class="mt">
        <strong style="height:31px;line-height:31px;overflow:hidden;" class="ddxx ct">订单信息</strong>
    </div>
    <div class="mc">
    <!--客户信息信息-->
    <dl class="fore">
	    <dt>客户信息</dt>
		<dd>
	    	 <@form.form>
	    	<ul>
			   <li>姓&nbsp;&nbsp;名：${orderDataCust.custName}</li>
			   <li>身份证：${orderDataCust.psptNo}</li>
			  <input id="img1" value="${orderDataCust.psptImg1}" type="hidden"/>
			  <input id="img2" value="${orderDataCust.psptImg2}" type="hidden"/>
	      	   <li><a class="cBlue" style="cursor:pointer;" onclick="checkCustInfo()">点击查看身份证图片信息</a></li>
	        </ul>
	         </@form.form>
  		</dd>
	</dl>
	<!--收货人信息-->
    <dl>
	    <dt>收货人信息</dt>
		<dd>
	    	<ul>
			   <li>收&nbsp;货&nbsp;人：${orderDataPost.RECEIVER_NAME}</li>
			   <li>地&nbsp;&nbsp;址：${orderDataPost.PROVINCE_NAME}，${orderDataPost.CITY_NAME}，${orderDataPost.DISTRICT_NAME}，${orderDataPost.POST_ADDR}&nbsp;&nbsp;&nbsp;&nbsp;${orderDataPost.POST_CODE}</li>
	      	   <li>手机号码：${orderDataPost.MOBILE_PHONE}
          		 <#if orderDataPost.FIX_PHONE?if_exists>&nbsp;/&nbsp;${orderDataPost.FIX_PHONE}</#if></li>
           		<#if orderDataPost.POST_REMARK != null >
		      <li>买家备注：${orderDataPost.POST_REMARK}</li>
		      </#if>      
      			<li>配　　送：${(orderDataPost.EXPRESS_COMPNAY=='2')?string("宅急送","顺丰")}</li>
	        </ul>
  		</dd>
	</dl>    
    <!--配送、支付方式-->
    <dl>
	  	<dt>支付及配送方式</dt>
	  	<dd>
		    <ul>
		      <li>支付方式：${orderDataPaylog.payModeValue}</li>
		      <#--<li>运&nbsp;&nbsp;&nbsp;&nbsp;费：￥${orderDataPaylog.payMoney}</li>
		      <li>送货日期：${orderDataPaylog.notifyType}</li>-->
		    </ul>
	   </dd>
	</dl>
    <!--发票-->
    <dl>
  		<dt>发票信息</dt>
  		<dd> 
	  	  	<ul>
	            <li>发票类型：普通发票</li>
	            <li>发票抬头：${orderDataDeal.invoceTitle}</li>
	            <li>发票内容：${orderDataDeal.invoceContent}</li>
		    </ul>
		</dd>
	</dl>

<dl>
	<dd style="margin-bottom: 10px;">
		<span class="i-mt ct">商品清单</span>
	</dd>
	<dd class="p-list">
		<table width="100%" cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<th width="10%">商品名称 </th>
					<th width="12%">商品组成</th>
					<!--
					<th width="42%"> 商品名称 </th>
					<th width="10%"> 京东价 </th>
					<th width="8%"> 京豆数量 </th>
					<th width="7%"> 商品数量 </th>
					<th width="11%"> 库存状态 </th>-->
				</tr>
				
					<tr>
						<td>${orderDataProd.goodsName}</td>
						<td>
							<#list reses as item>
								<#list item?keys as i>
									物品名：${i}<br/>
									<#list item[i] as ii>
									<#list ii as iii>
										${iii.ATTR_NAME}&nbsp;${iii.RES_ATTR_VAL}&nbsp;<#if iii.RES_ATTR_CODE=='PACKRES'>(${iii.VALUES1})</#if><br/>
									</#list>
								</#list>
								</#list>
							</#list>
                            <#--<#if goodsContent != null>-->
                                <#--详细信息：${goodsContent}-->
                            <#--</#if>-->
						</td>

					</tr>
				
			</tbody>
		</table>
	</dd>
</dl>
</div>
<div class="total">
	<ul>
	<!--
    <li><span>总商品金额：</span>￥${orderDataProd.UNIT_PRICE}*${orderDataProd.SALE_NUM}</li>
    <li><span>- 减免费用：</span>￥${orderDataProd.DERATE_FEE}</li>
    <li><span>- 铺货押金：</span>￥${orderDataProd.DERATE_FEE}</li>
    <li><span>- 垫资费用：</span>￥${orderDataProd.DERATE_FEE}</li>
	<li><span>+ 运费：</span>￥0.00</li>
	-->
	<li class="extra ftx04"><span class="ct">应收总金额：</span>￥
		<#if orderDataBase.manMadeMoney != 0>
			${orderDataBase.manMadeMoney}
		<#else>
			${orderDataBase.topayMoney}
		</#if>
	</li>
	</ul>
	<!--
	<div class="extra">
		应付总额：
		<span class="ftx04">
			<b>￥139.00</b>
		</span>
	</div>-->
</div>

  
</@layout>