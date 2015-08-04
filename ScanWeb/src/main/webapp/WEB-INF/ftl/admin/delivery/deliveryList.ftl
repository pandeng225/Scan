<#include "/admin/layout/common/layout.ftl">
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
<@layout title="订单查询">
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
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

</script>
<!--begin crumb-->
<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">订单管理&nbsp;&gt;&nbsp;发货处理</span>
  </div>
</div>
    <!--end curmb-->
<!--begin main content-->
    <div class="listW">
        
        <!--begin right content-->
        <ul class="sList">
			<@form.form method="post" action="${rc.contextPath}/admin/am/order/queryAllOrders">
            	<li>
            		<span>订单标识</span>
            		<input type="text" name="orderId" value="${orderId}">
            		</li>
            		<li>
            		<input type="submit" value="查询" class="shortBtn mrgR10 mrgL60" />
            		</li>
          </@form.form>
        </ul>
        <!--end right content-->
        
         <div class="listTopBox">
    	<table cellspacing="0" cellpadding="0" border="0" class="listTop">
      	<tbody>
        		 <tr>
                    <th class="tFourth">订单标识</th>
                    <th class="tFourth">商品信息</th>
                    <th class="tFourth">订单费用</th>
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
                                    <#if item.ORDER_STATE == "00">
                                        未处理
                                    <#elseif item.ORDER_STATE == "01">
                                        待分配
                                    <#elseif item.ORDER_STATE == "02">
                                        订单补录
                                    <#elseif item.ORDER_STATE == "03">
                                        待发货
                                    <#elseif item.ORDER_STATE == "04">
                                        发货中
                                    <#elseif item.ORDER_STATE == "05">
                                        物流在途
                                    <#elseif item.ORDER_STATE == "06">
                                        成功关闭
                                    <#elseif item.ORDER_STATE == "99">
                                        取消
                                    </#if>
                                </p>
		                  		<p class="bottom">订单来源：${item.ORDER_FROM?default('&nbsp;')}</p>
		                  	</td>
		                    <td class="others">
		                    	<p>${item.GOODS_NAME?default('&nbsp;')}</p>
		                    </td>
		                    <td class="others">
		                    	￥<#if item.MAN_MADE_MONEY != 0>
										${item.MAN_MADE_MONEY/1000}
									<#else>
										${item.TOPAY_MONEY?default('0.00')/1000}
									</#if></br>
		                    	${item.PAY_STATE?default('&nbsp;')}
		                    </td>
		                    <td style="text-align:left;" class="others">
		                    	<p>
		                    		买家信息:${item.RECEIVER_NAME?default('&nbsp;')} ${item.MOBILE_PHONE?default('&nbsp;')} 
		                    	</p>
		                    	<p>地        址:${item.POST_ADDR?default('&nbsp;')}</p>
		                    	<p>配        送:${item.EXPRESS_COMPNAY?default('无物流公司信息')}</p>
		                    </td>
		                    <td class="others">
		                    	<a class="cBlue" style="cursor:pointer;" href="${rc.contextPath}/admin/am/order/detail?orderIdStr=${item.ORDER_ID}")">详情</a>
                                <#if  item.ORDER_STATE == "03"> | <a class="cBlue" style="cursor:pointer;" href="${rc.contextPath}/admin/am/delivery/sendInit?orderId=${item.ORDER_ID}")">发货</a></#if>
		                    	<input id="orderIdForS" type="hidden" value="${item.ORDER_ID}"/>
		                    	<input id="updateOrderStatus" type="hidden" value="${item.ORDER_STATE}"/>
		                    </td>
		                   </tr>
		                  </#list>
	                   </tbody>
	                 </table>
                  <#else>
                  	<tr><td colspan="8" style="color:red">没有待发货的订单</td></tr>
                  </#if>
     </div>
                <#import "/admin/layout/common/pager.ftl" as q>
		  		<@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/agent/workerOrder/newConfig"/>
      
        
    </div>
    <!--end main content-->  
</div>

</@layout>