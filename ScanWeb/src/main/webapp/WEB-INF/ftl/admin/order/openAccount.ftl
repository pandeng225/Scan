<#include "/admin/layout/common/layout.ftl">
<@layout title="开户">
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
        width:20%;
        word-break: break-all;
        word-wrap: break-word;
    }
    .tableBody table td.first{
        border: 1px solid #e6f0f5;
    }
    .tableBody table td.others {
        border-collapse: collapse;
        border-top: 1px solid #e6f0f5;
        border-right: 1px solid #e6f0f5;
        border-bottom: 1px solid #e6f0f5;
        padding-bottom: 10px;
        padding-top: 10px;
        text-align: center;
        vertical-align: top;
    }

    .tleft{
        text-align: left;
    }

</style>

<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/js/datePicker/WdatePicker.js')}"></script>
<script>
function updateOrderStatus(){
$.layer({
    type: 2,
    shade: [0],
    fix: false,
    title: '更新订单状态',
    maxmin: true,
    iframe: {src : '${rc.contextPath}/admin/am/order/selectOrderStatus'},
    area: ['400px' , '220px'],
    end: function(){
    	location.reload(true);
    }
});
}

$(function(){
var cc="${cityCode}";
if(cc!=""){
$("#cityCode").val(cc);
}
});

    $(function(){

        $("#queryOrders").click(function(){
            var orderState=$("#orderState").val();
            if(orderState=='02'){
                $("form").attr("action","${rc.contextPath}/admin/am/order/openAccountPre");
            }else{
                $("form").attr("action","${rc.contextPath}/admin/am/order/openAccount");
            }

            $("#orderForm").submit();
        });

        $("#exportOrders").click(function(){
            $("form").attr("action","${rc.contextPath}/admin/am/order/exportOpenAccountOrders");
            $("#orderForm").submit();
        });
    });

</script>
<!--begin crumb-->
<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
      <span class="left">订单管理&nbsp;&gt;&nbsp;开户<#if orderState=='02'>预处理</#if></span>
  </div>
</div>
    <!--end curmb-->
<!--begin main content-->
    <div class="listW">

        <!--begin right content-->
        <ul class="sList">
			<@form.form method="post" id="orderForm" >
            		<li>
	            		<label>订单标识&nbsp;</label>
	            		<input type="text" class="inputStyle w180" name="orderId" value="${orderId}">
            		</li>
            		<li>
	            		<label>开始时间&nbsp;</label>
	            		<input type="text" value="${beginTime}" placeholder="开始时间" id="beginTime" class="inputStyle w180" name="beginTime" onclick="WdatePicker({readOnly:true,maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd'})"/>
            		</li>
            		<li>
	            		<label>结束时间&nbsp;</label>
	            		<input type="text" value="${endTime}" placeholder="结束时间" id="endTime" class="inputStyle w180" name="endTime" onclick="WdatePicker({readOnly:true,minDate:'#F{$dp.$D(\'beginTime\')}',dateFmt:'yyyy-MM-dd'})" />
            		</li>
            		<#--<li>-->
	            		<#--<label>订单状态</label>-->
	            		<#--<select id="orderState" class="inputStyle w180" name="orderState" tabindex="1" style="margin-left:6px;">   	-->
			            	<#--<option value="">选择状态</option>-->
			            	<#--<option value="02" <#if orderState=='02'>selected=selected</#if> >待处理</option>-->
			            	<#--<option value="03" <#if orderState=='03'>selected=selected</#if> >处理中</option>-->
						<#--</select>-->
            		<#--</li>-->
                    <input name="orderState"  id="orderState" value="${orderState}" type="hidden">
            		<li>
            			<label>归属地市&nbsp;</label>
	            		<select id="cityCode" class="inputStyle w180" name="cityCode" tabindex="1">
	            			<option value="">选择地市</option>
	            			<#list city as item>
	            			<option value="${item.CITY_CODE}">${item.CITY_NAME}</option>
	            			</#list>
	            		</select>
            		</li>
                    <li></li>
            		<li style="text-align:right;">
            		<input type="button" id="queryOrders" value="查询" class="shortBtn mrgR10 mrgL60" />
                    <input type="button" id="exportOrders" value="导出" class="shortBtn mrgR10 " />
            		</li>
          </@form.form>
        </ul>
        <!--end right content-->

         <div class="listTopBox">
    	<table cellspacing="0" cellpadding="0" border="0" class="listTop">
      	<tbody>
        		 <tr>
                    <th class="tFourth">订单基本信息</th>
                    <th class="tFourth">商品信息</th>
                    <th class="tFourth">订单支付信息</th>
                    <th class="tFourth">买家信息</th>
                    <th class="tFourth">操作</th>
                  </tr>
         </tbody>
     	</table>
      </div>
      <div class="tableBody" cellpadding="0" cellspacing="0" border="0" width="100%"  style="margin-bottom: 7px;">
                  <#if (pager.rows?size>0) >
	                <table cellspacing="0" cellpadding="0" border="0" width="100%">
	      			   <tbody>
		                  <#list pager.rows as item>
		                   <tr>
		                  	<td class="first">
		                  		<p class="top">订单标识：${item.ORDER_ID?default('&nbsp;')}</p>
		                  		<p>成交时间：${item.CREATE_TIME?default('&nbsp;')}</p>
		                  		<p>订单状态：
		                  			<#if item.ORDER_STATE=="02">
		                  				待处理
		                  			<#elseif item.ORDER_STATE=="03">
		                  				处理中
		                  			<#else>
		                  			   $nbsp;
		                  			</#if>
		                  		</p>
		                  		<p class="bottom">订单来源：${item.ORDER_FROM?default('&nbsp;')}</p>
		                  		<p class="bottom">地市：${item.CITY_NAME?default('&nbsp;')}</p>
		                  	</td>
		                    <td class="others">
		                    	<p>${item.GOODS_NAME?default('&nbsp;')}</p>
		                    </td>
		                    <td class="others">
		                    	￥<#if item.MAN_MADE_MONEY != 0>
										${item.MAN_MADE_MONEY}
									<#else>
										${item.TOPAY_MONEY?default('0.00')}
									</#if></br>
		                    	${item.PAY_STATE?default('&nbsp;')}
		                    </td>
		                    <td style="text-align:left;" class="others">
		                    	<p>
		                    		买家信息:${item.RECEIVER_NAME?default('&nbsp;')} ${item.MOBILE_PHONE?default('&nbsp;')}
		                    	</p>
		                    	<p>地        址:${item.POST_ADDR?default('&nbsp;')}</p>
		                    	<p>配        送:${(item.EXPRESS_COMPNAY=='2')?string("宅急送","顺丰")}</p>
		                    </td>
		                    <td class="others">
		                    	<#if item.ORDER_STATE =="02">
		                    	<a class="cBlue" style="cursor:pointer;" href="${rc.contextPath}/admin/am/order/openAccountDetail?orderIdStr=${item.ORDER_ID}")">开户预处理</a>
		                    	<#else>
		                    	<a class="cBlue" style="cursor:pointer;" href="${rc.contextPath}/admin/am/order/openAccountDetail?orderIdStr=${item.ORDER_ID}")">开户</a>
		                    	</#if>
		                    </td>
		                   </tr>
		                  </#list>
	                   </tbody>
	                 </table>
                  <#else>
                  	<tr><td colspan="8" style="color:red">没符合条件的记录</td></tr>
                  </#if>
     </div>
                <#import "/admin/layout/common/pager.ftl" as q>
                <#if orderState=='03'><@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/order/openAccount"/></#if>
                <#if orderState=='02'><@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/order/openAccountPre"/></#if>



    </div>
    <!--end main content-->
</div>

</@layout>