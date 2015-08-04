<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<#include "/admin/layout/common/layout.ftl">
<@layout title="订单详情">
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<link href="${e.res('/css/orderDetail.css')}" rel="stylesheet" type="text/css"/>
<style type="text/css">
    #orderstate {
        margin-top: 10px;
    }

    .ct {
        font-weight: bold
    }

    .setFont {
        font-size: 14px;
    }

    #orderinfo .mt h2 {
        height: 31px;
        position: relative;
    }

    .ddxx {
        font-family: Arial, Helvetica, sans-serif;
        font-size: 15px;
    }

    .section4 {
        width: 815px;
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

    .longBlueSubmitBtn {
        background: url(${e.res('/images/backstageAllButton.png')}) no-repeat scroll -164px -175px rgba(0, 0, 0, 0);
        border: 0 none;
        color: #fff;
        cursor: pointer;
        display: inline-block;
        font-weight: bold;
        height: 30px;
        line-height: 30px;
        text-align: center;
        width: 112px;
    }
</style>
<script language="javascript" type="text/javascript">
    function checkCustInfo() {
        var img1 = $("#img1").val();
        var img2 = $("#img2").val();
//alert(img1);alert(img2);
        $.layer({
            offset: ['150px', '50%'],
            type: 2,
            shade: [0],
            fix: false,
            title: '查看订单客户身份证相片信息',
            maxmin: true,
            iframe: {src: '${rc.contextPath}/admin/am/order/checkCustInfo?img1=' + img1 + '&img2=' + img2},
            area: ['600px', '400px'],
            end: function () {
            }
        });
    }

    function oanewInfo() {
        var orderId = $("#orderId").val();
//alert(orderId);
        var desc = $("#descOpen").val();
        var oaNumberOld = "";
        var oanum = "";
        if (document.getElementById("oaNumber")) {
            oanum = $("#oaNumber").val();
            var typemsg = $("#numType").val();
            if (oanum == "") {
                alert(typemsg + "不能为空!");
                return
            }
            oaNumberOld = $("#oaNumberOld").val();
        }
        var expressId = $("input[name=expressId]").val();
        if (expressId == '') {
            alert("物流单号不能为空!");
            return;
        }
        var expressName = $("input[name=expressName]").val();
        var CSRFToken = $("input[name=CSRFToken]").val();
        if (document.getElementById("oaNumber") || document.getElementById("oaCard")) {
//alert(oanum);
            $.ajax({
                url: "${rc.contextPath}/admin/am/order/openAccountCommit",
                type: "POST",
                async: false,
                data: {
                    "expressId": expressId,
                    "expressName": expressName,
                    "orderId": orderId,
                    "oanum": oanum,
                    "desc":desc,
                    "oaNumberOld": oaNumberOld,
                    "CSRFToken": CSRFToken
                },
                success: function (data) {
                    if (data.result == "success") {
                        alert(data.msg);
                        window.location.href = "${rc.contextPath}/admin/am/order/openAccount";
                    } else {
                        alert(data.msg);
                    }
                }
            });
        } else {
//alert("不存在");
            var CSRFToken = $("input[name=CSRFToken]").val();
            $.ajax({
                url: "${rc.contextPath}/admin/am/order/openAccountCommit",
                type: "POST",
                async: false,
                data: {"expressId": expressId, "expressName": expressName,  "desc":desc,"orderId": orderId, "CSRFToken": CSRFToken},
                success: function (data) {
                    if (data.result == "success") {
                        alert(data.msg);
                        window.location.href = "${rc.contextPath}/admin/am/order/openAccount";
                    } else {
                        alert(data.msg);
                    }
                }
            });
        }
    }

    function oaPreDeal() {
        var orderId = $("#orderId").val();
        var CSRFToken = $("input[name=CSRFToken]").val();
//alert(orderId);alert(CSRFToken);
        var desc = $("#descPre").val();
        $.ajax({
            url: "${rc.contextPath}/admin/am/order/oaPre",
            type: "POST",
            async: false,
            data: {"orderId": orderId, "desc": desc, "CSRFToken": CSRFToken},
            success: function (data) {
                if (data.result == "success") {
                    alert(data.msg);
                    window.location.href = "${rc.contextPath}/admin/am/order/openAccount";
                } else {
                    alert(data.msg);
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
            <input id="orderId" value="${orderDataBase.orderId}" type="hidden"/>
            <span class="ftx14 ct setFont">&nbsp;${orderDataBase.orderState}</span>
        </div>
        <div class="mc">
            当前无物流信息
        </div>
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
            <!--顾客信息-->
            <dl class="fore">
                <dt>收货人信息</dt>
                <dd>
                    <ul>
                        <li>收&nbsp;货&nbsp;人：${orderDataPost.RECEIVER_NAME}</li>
                        <li>地&nbsp;&nbsp;址：${orderDataPost.PROVINCE_NAME}，${orderDataPost.CITY_NAME}
                            ，${orderDataPost.DISTRICT_NAME}，${orderDataPost.POST_ADDR}
                            &nbsp;&nbsp;&nbsp;&nbsp;${orderDataPost.POST_CODE}</li>
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
                            <th width="10%">商品名称</th>
                            <th width="12%">商品组成</th>
                        </tr>

                        <tr>
                            <td>${orderDataProd.goodsName}</td>
                            <td>
                                <#list reses as item>
                                    <#list item?keys as i>
                                        物品名：${i}<br/>
                                        <#list item[i] as ii>
                                            <#list ii as iii>
                                            ${iii.ATTR_NAME}&nbsp;${iii.RES_ATTR_VAL}
                                                &nbsp;<#if iii.RES_ATTR_CODE=='PACKRES'>(${iii.VALUES1})</#if><br/>
                                            </#list>
                                        </#list>
                                    </#list>
                                </#list>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </dd>
            </dl>

        </div>
        <div class="total">
            <ul>

                <li class="extra ftx04"><span class="ct">应收总金额：</span>￥
                    <#if orderDataBase.manMadeMoney != 0>
                    ${orderDataBase.manMadeMoney}
                    <#else>
                    ${orderDataBase.topayMoney}
                    </#if>
                </li>
            </ul>
        </div>
        <@form.form>
            <!-- 补录信息 -->
            <#if orderDataBase.orderState == "处理中">
                <div id="ordertrack" class="m">
                    <ul class="tab">
                        <li class="curr">
                            <h2 style="height:31px;line-height:31px;overflow:hidden;" class="ct">补录信息</h2>
                        </li>
                    </ul>
                    <div class="clr"></div>
                    <div class="mc tabcon" style="display: block;">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tbody id="tbody_track">
                            <tr>
                                <th width="10%"><strong style="text-align:center;">标题</strong></th>
                                <th width="40%"><strong style="text-align:center;">内容</strong></th>
                                <th width="50%"><strong style="text-align:center;">补录</strong></th>
                            </tr>
                            </tbody>
                            <tbody>
                            <tr>
                                <td style="text-align:left;">商品名称</td>
                                <td style="text-align:center;">${orderDataProd.goodsName}</td>
                                <td style="text-align:right;">
                                    <#if oaInfo??>
                                        <#list oaInfo as item>
                                        ${numType}:<input id="oaNumber" value="${item.RES_ATTR_VAL}"/>
                                            <input id="oaNumberOld" type="hidden" value="${item.RES_ATTR_VAL}"/>
                                            <input id="numType" type="hidden" value="${numType}"/>
                                        </#list>
                                    <#else>
                                        无补录信息!
                                    </#if>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:left;">物流信息</td>
                                <td style="text-align:center;">
                                    客户选择：${(orderDataPost.EXPRESS_COMPNAY=='2')?string("宅急送","顺丰")}</td>
                                <td style="text-align:right;">
                                    物流公司：
                                    <select name="expressName" value="${orderDataPost.EXPRESS_COMPNAY}">
                                        <option value="1">顺丰</option>
                                        <option value="2">宅急送</option>
                                    </select>
                                    物流单号：
                                    <input name="expressId" value="${orderDataPost.EXPRESS_ID}"/>

                                </td>
                            </tr>
                            <tr style=" padding-top: 10px;">
                                <td>
                                    备注：
                                </td>
                                <td>
                                    <input id="descOpen"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div style="margin-bottom: 15px; padding-top: 10px;text-align:center;">
                    <a class="longBlueSubmitBtn" href="javascript:oanewInfo();">开户</a>
                </div>
            <#elseif orderDataBase.orderState == "待处理">
                <div style="margin-bottom: 15px; padding-top: 10px;text-align:center;">
                    <div style="text-align: left"><span>备注：</span><input id="descPre"/></div>
                    <a class="longBlueSubmitBtn" href="javascript:oaPreDeal();">开户预处理</a>
                </div>
            </#if>
        </@form.form>
    </div>


</@layout>