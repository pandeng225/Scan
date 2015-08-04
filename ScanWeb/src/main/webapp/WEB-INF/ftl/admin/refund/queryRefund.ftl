<#include "/admin/layout/common/layout.ftl">
<@layout title="退单审核">
<style>
    .close_btn {
        font-family: arial;
        font-size: 12px;
        _font-size: 12px;
        font-weight: 700;
        color: #fff;
        text-decoration: none;
        float: right;
        margin-right: 10px;
        cursor: pointer;
        line-height: 33px;
    }

    .pop {
        width: 450px;
        height: auto;
        color: #444;
        background: white;
        border: 3px solid;
        border-color: #e6f0f5;
        z-index: 99999999999;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
        -webkit-box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
        -moz-box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
        display: none;
        padding-bottom: 10px;
    }

    .pop .head {
        overflow: hidden;
        height: 33px;
        background: #e6f0f5;
        color: #fff;
        font-size: 13px;
        font-family: "宋体";
        line-height: 33px;
        font-weight: bold;
        padding-left: 4px;
    }

    .pop .head span {
        line-height: 33px;
        color: #666;
    }

    .pop .foot {
        _height: 3px;
        text-align: center;
    }

    .pop .main {
        position: relative;
        background: #fff;
        height: auto;
        padding: 10px;
    }

    .pop .main label {
        margin-top: 7px;
        margin-left: 5px;
        display: block;
        height: 13px;
        width: 33%;
    }

    .pop .main span {
        margin-left: 5px;
    }

</style>
<script language="javascript" type="text/javascript" src="${e.res('/js/datePicker/WdatePicker.js')}"></script>
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">退单查询</span>
        </div>
    </div>

    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
			<@form.form method="post" action="${rc.contextPath}/admin/am/refund/queryRefund">
                <li>
                    <label>订单标识&nbsp;</label>
                    <input type="text" class="inputStyle w180" name="orderId" value="${orderId}">
                </li>
                <li>
                    <label>开始时间&nbsp;</label>
                    <input type="text" value="${beginTime}" placeholder="开始时间" id="beginTime" class="inputStyle w180"
                           name="beginTime"
                           onclick="WdatePicker({readOnly:true,maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd'})"/>
                </li>
                <li>
                    <label>结束时间&nbsp;</label>
                    <input type="text" value="${endTime}" placeholder="结束时间" id="endTime" class="inputStyle w180"
                           name="endTime"
                           onclick="WdatePicker({readOnly:true,minDate:'#F{$dp.$D(\'beginTime\')}',dateFmt:'yyyy-MM-dd'})"/>
                </li>
                <li><label>状&nbsp;&nbsp;态&nbsp;</label>
                    <select class="inputStyle w180" name="refundState">
                        <option value="">—全部—</option>
                        <option value="11">店主审核中</option>
                        <option value="12">管理员审核中</option>
                        <option value="13">审核通过未退款</option>
                        <option value="14">审核通过已退款</option>
                    </select>
                </li>
                <li></li>
                <li style="text-align: right">
                    <a  class="cBlue" style="cursor: pointer;margin-right: 10px" onclick="beforeOut()" >导出待退款记录</a>
                    <input type="submit" value="查 询" id="submit" style="margin-right: 24px"class="shortBtn"/>
                </li>

			</@form.form>
        </ul>
        <div class="listTopBox">
            <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                <tbody>
                <tr>
                    <th class="tFourth">订单号</th>
                    <th class="tFourth">价格</th>
                    <#--<th class="tFourth">退单类型</th>-->
                    <th class="tFourth">退单原因</th>
                    <th class="tFourth">状态</th>
                    <th class="tFourth">操作</th>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="listContBox">
			<#if (pager.rows?size>0) >
                <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                    <tbody>
						<#list pager.rows as trade>
                        <tr>
                            <td class="tFourth">${trade.ORDER_ID}</td>
                            <td class="tFourth">${trade.TXN_AMT}</td>
                            <#--<td class="tFourth">-->
								<#--<#if (trade.REFUND_TYPE)=='09'>-->
                                    <#--订单处理退单-->
								<#--<#elseif (trade.REFUND_TYPE)=='10' >-->
                                	<#--客户拒收退单-->
								<#--</#if>-->
							<#--</td>-->
                            <td class="tFourth">${trade.REFUND_REASON}</td>
                            <td class="tFourth"><#if (trade.REFUND_STATE)=='11'>
                                店主审核中
							<#elseif (trade.REFUND_STATE)=='12' >
                                管理员审核中
							<#elseif (trade.REFUND_STATE)=='13' >
                                审核通过未退款
							<#elseif (trade.REFUND_STATE)=='14' >
                                审核通过已退款
                            <#elseif (trade.REFUND_STATE)=='15' >
                                店主审核不通过
                            <#elseif (trade.REFUND_STATE)=='16' >
                                管理员审核不通过
							</#if>
							</td>
                            <td class="tFourth">
								<#if  (trade.REFUND_STATE)=='12' >
                                    <a  class="cBlue" style="cursor: pointer;" onclick="beforeUpdate(${trade.ORDER_ID},'${trade.ORDER_STATE}','${trade.REFUND_TYPE}','13')">通过</a>
                                    |<a  class="cBlue" style="cursor: pointer;" onclick="beforeUpdate(${trade.ORDER_ID},'${trade.ORDER_STATE}','${trade.REFUND_TYPE}','16')">不通过</a>
								</#if>
								<#if  (trade.REFUND_STATE)=='13' >
                                    <a  class="cBlue" style="cursor: pointer;" onclick="beforeUpdate(${trade.ORDER_ID},'${trade.ORDER_STATE}','${trade.REFUND_TYPE}','14')">退款</a>
								</#if>
                            </td>
                        </tr>
						</#list>
                    </tbody>
                </table>
			<#else>
                <tr>
                    <td colspan="8" style="color:red">没有符合条件的记录</td>
                </tr>
			</#if>
        </div>
        <!--end right content-->
		<input type="hidden" id="hiddenOrderId">
        <input type="hidden" id="hiddenStatus">
        <input type="hidden" id="hiddenOrderState">
        <input type="hidden" id="hiddenRefundType">
		<#import "/admin/layout/common/pager.ftl" as q>
		<@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/refund/queryRefund"/>
    </div>
    <!--end main content-->
</div>
<div class="clear"></div>
    <@form.form method="get" id="reportOut">
    </@form.form>
<script type="text/javascript">
    var refresh = function () {
        $("#submit").trigger('click');
    };
    var success = function (result) {
        $.endLoading();
        $.smile(result.mesg, refresh);
    }
    var error = function (result) {
        $.endLoading();
        $.alert(result.mesg, refresh);
    };
    function beforeUpdate(orderId,orderState,refundType,refundState) {
		$("#hiddenOrderId").val(orderId);
        $("#hiddenOrderState").val(orderState);
        $("#hiddenStatus").val(refundState);
        $("#hiddenRefundType").val(refundType);
		$.prompt("","", updateStatusByID);
		$("#pop_comfirm").html("确定");
    }
    function updateStatusByID() {
        var url = '${rc.contextPath}/admin/am/refund/updateStatusByID';
        var data = {
            orderId: $("#hiddenOrderId").val(),
            refundState: $("#hiddenStatus").val(),
            orderState: $("#hiddenOrderState").val(),
            refundType: $("#hiddenRefundType").val(),
            CSRFToken: $("input[name='CSRFToken']").val()
        };
        $.phwAjax3(url, data, success, error);
    }

    function beforeOut() {
        var url = '${rc.contextPath}/admin/am/refund/batchOut';
        $("#reportOut").attr("action",url);
        $("#reportOut").submit();
//        window.location.href=url;
    }
</script>
</@layout>