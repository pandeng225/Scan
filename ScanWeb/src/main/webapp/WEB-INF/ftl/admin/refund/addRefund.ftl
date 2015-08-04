<#include "/admin/layout/common/layout.ftl">
<@layout title="退货申请">
<style type="text/css">
    * {
        color: #333;
        font-family: Arial, Helvetica, sans-serif;
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

    .tableBody table td {
        width: 20%;
        word-break: break-all;
        word-wrap: break-word;
    }

    .tableBody table td.first {
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

    .tleft {
        text-align: left;
    }

</style>

<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/js/datePicker/WdatePicker.js')}"></script>
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">退单管理&nbsp;&gt;&nbsp;退单提交</span>
        </div>
    </div>
    <!--end curmb-->
    <!--begin main content-->
    <div class="listW">

        <!--begin right content-->
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/refund/queryAllOrders">
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
                <li>
                    <label>订单状态&nbsp;</label>
                    <select id="orderState" class="inputStyle w180" name="orderState" tabindex="1">
                        <option value="">选择状态</option>
                        <option value="00">待支付</option>
                        <option value="01">待分配</option>
                        <option value="02">待处理</option>
                        <option value="03">处理中</option>
                        <option value="04">待发货</option>
                        <option value="05">发货中</option>
                        <option value="06">物流在途</option>
                        <option value="07">待归档</option>
                        <option value="08">成功关闭（已归档）</option>
                        <option value="11">店主审核中</option>
                        <option value="12">管理员审核中</option>
                        <option value="13">审核通过未退款</option>
                        <option value="14">审核通过已退款</option>
                    </select>
                </li>
                <li></li>
                <li style="text-align:right;">
                    <input type="submit" value="查询" style="margin-right: 24px" id="submit"class="shortBtn  mrgL60"/>
                </li>
            </@form.form>
        </ul>
        <!--end right content-->

        <div class="listTopBox">
            <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                <tbody>
                <tr>
                    <th class="tFourth">订单信息</th>
                    <th class="tFourth">商品信息</th>
                    <th class="tFourth">订单费用</th>
                    <th class="tFourth">买家信息</th>
                    <th class="tFourth">操作</th>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="tableBody" cellpadding="0" cellspacing="0" border="0" width="100%" style="margin-bottom: 7px;">
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
                                        待支付
                                    <#elseif item.ORDER_STATE == "01">
                                        待分配
                                    <#elseif item.ORDER_STATE == "02">
                                        待处理
                                    <#elseif item.ORDER_STATE == "03">
                                        处理中
                                    <#elseif item.ORDER_STATE == "04">
                                        待发货
                                    <#elseif item.ORDER_STATE == "05">
                                        发货中
                                    <#elseif item.ORDER_STATE == "06">
                                        物流在途
                                    <#elseif item.ORDER_STATE == "07">
                                        待归档
                                    <#elseif item.ORDER_STATE == "08">
                                        成功关闭
                                    <#elseif item.ORDER_STATE == "11">
                                        店主审核中
                                    <#elseif item.ORDER_STATE == "12">
                                        管理员审核中
                                    <#elseif item.ORDER_STATE == "13">
                                        审核通过未退款
                                    <#elseif item.ORDER_STATE == "14">
                                        审核通过已退款
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

                                <p>地 址:${item.POST_ADDR?default('&nbsp;')}</p>

                                <p>配 送:${(item.EXPRESS_COMPNAY=='2')?string("宅急送","顺丰")}</p>
                            </td>
                            <td class="others">
                                <a class="cBlue" style="cursor:pointer;" onclick="javascript:openWindow(this)" orderId="${item.ORDER_ID}" orderState="${item.ORDER_STATE}" >
                                    提交申请
                                </a>
                            </td>
                        </tr>
                        </#list>
                    </tbody>
                </table>
            <#else>
                <tr>
                    <td colspan="8" style="color:red">没符合条件的记录</td>
                </tr>
            </#if>
        </div>
        <#import "/admin/layout/common/pager.ftl" as q>
        <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/refund/queryAllOrders"/>
    </div>
    <!--end main content-->
    <!--popup -->
    <div id="operate" class="popTips">
        <h3 class="tipsTitle">
            <label class="change">操作提示</label>
        </h3>
        <input id="orderId" type="hidden" />
        <input id="orderState" type="hidden" />

        <div class="topLine">
            <label style="height: auto;width: auto;margin-top: 15px"> <span style="vertical-align: top">退款原因</span>
                <textarea id="refundReason" class="mrgL10"></textarea>
            </label>
        </div>
        <div class="tipsBtnsW">
            <input type="button" onclick="addRefund()" class=" shortBtn mrgR10" value="确定"></input>
            <input
                    type="button" onclick="javascript:closeWindow()" class="shortBtn mrgL10" value="取消"></input>
        </div>
    </div>
    <!--popup end-->
</div>
<script type="text/javascript">
    var refresh = function () {
        $("#submit").trigger('click');
    };
    var success = function (result) {
        $.endLoading();
        if(result.result=='SUCCESS'){
            $.smile(result.mesg, refresh);
        }else{
            $.alert(result.mesg, refresh);
        }

    }
    var error = function (result) {
        $.endLoading();
        $.alert("申请失败", refresh);
    };
    function closeWindow() {
        $.overLayOff();
        $("#operate").hide();
    }
    function openWindow(element) {
        var orderId = $(element).attr('orderId');
        var orderState = $(element).attr('orderState');
        $("input[name='chooseStatus']").attr("checked",false);;
        $("#orderId").val(orderId);
        $("#orderState").val(orderState);
        $("#refundReason").val("");
        $("#operate").center().show();
        $.overLayOn();
    }
    function addRefund() {
        var  refundReason = $("#refundReason").val();
        closeWindow();
        var url = '${rc.contextPath}/admin/am/refund/addRefund';
        var data = {
            orderId: $("#orderId").val(),
            orderState:$("#orderState").val(),
            refundType: "09",
            refundReason: refundReason,
            CSRFToken: $("input[name='CSRFToken']").val()
        };
        $.phwAjax3(url, data, success, error);
    }
</script>
</@layout>