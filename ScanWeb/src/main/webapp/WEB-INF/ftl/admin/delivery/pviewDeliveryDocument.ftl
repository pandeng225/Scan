<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>打印面单</title>
<link href="${e.res('/css/delivery/print_document.css')}" rel="stylesheet" type="text/css" />
</head>
<body>
<#if result??>
    <div class="box">
        <div class="logoImg"></div>
        <div class="sec">
            <p class="company">
                <label>物流公司：</label><span>${result.postMap.EXPRESS_COMPNAY}</span>
            </p>
            <p class="orderNo">
                <label>订&nbsp;单&nbsp;&nbsp;号：</label><span>${form.orderId}</span>
            </p>
            <p id="">
                <label>打印时间：</label><span>${.now?string("yyyy/MM/dd")}</span>
            </p>
        </div>
        <#if result.postMap??>
        <div class="sec">
            <dl>
                <dt>客户信息：</dt>
                <dd>
                    <p class="wFull">
                        <label>姓 名：</label><span><#if result.OrderDataCust.custName??>${result.OrderDataCust.custName}<#else>${result.postMap.RECEIVER_NAME}</#if></span>
                    </p>
                    <p class="wFull">
                        <label>证 件：</label><span>${result.OrderDataCust.psptNo}</span>
                    </p>
                    <p class="twoLeft">
                        <label>联&nbsp;系&nbsp;&nbsp;人：</label><span>${result.postMap.RECEIVER_NAME}</span>
                    </p>
                    <p class="twoRightLong">
                        <label>联系电话：</label><span>${result.postMap.MOBILE_PHONE}</span>
                    </p>
                    <p class="twoLeftLong">
                        <label>配送地址：</label><span>${result.postMap.PROVINCE_NAME} ${result.postMap.CITY_NAME} ${result.postMap.DISTRICT_NAME} ${result.postMap.POST_ADDR}</span>
                    </p>
                    <p class="twoRight">
                        <label>邮 编：</label><span>${result.postMap.POST_CODE}</span>
                    </p>
                </dd>
            </dl>
        </div>
        </#if>
        <div class="sec">
            <dl>
                <dt>订单信息：</dt>
                <dd>
                     <p class="threeMid">
                        <label>应付金额：</label><span><b>￥${result.OrderDataBase.incomeMoney}元</b></span>
                    </p>
                    <#list resList as res>
                    <p class="wFull">
                        <label>${res.ATTR_NAME}：</label><span>${res.RES_ATTR_VAL}</span>
                    </p>
                    </#list>
                </dd>
            </dl>
        </div>
        <#if result.OrderDataCust.psptNo??>
        <div class="receiveKnow">
           <label class="know">
            <font>收货须知：</font>
            <span>必须提供机主证件原件、复印件并配合审核。代收需同时提供代收人证件原件、复印件。</span>
          </label>
        </div>
        </#if>
        <div class="sec">
            <dl>
                <dt>备 注：</dt>
                <dd>
                    <p>${result.postMap.POST_REMARK} ${result.postMap.VALUE1}</p>
                </dd>
            </dl>
        </div>
        <div class="sec">
            <dl class="custCommit">
                <dt>客户确认：</dt>
                <dd>
                <p>
                        <label>手机外观：</label><span></span>
                    </p>
                     <p>
                        <label>试机正常：</label><span></span>
                    </p>
                     <p>
                        <label>配件齐全：</label><span></span>
                    </p>
                    <p>
                        <label>发票齐全：</label><span></span>
                    </p>
                </dd>
            </dl>
            <dl class="custSign">
                <dt>客户签字：</dt>
                <dd>
                    <p class="signDate">
                        <label>签收日期：</label>
                    </p>
                </dd>
            </dl>
        </div>
    </div>
</#if>
<script language="javascript" type="text/javascript">
    var loadComplete = '1';
</script>
</body>
</html>
