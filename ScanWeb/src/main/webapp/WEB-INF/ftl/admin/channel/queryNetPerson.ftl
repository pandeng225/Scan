<#include "/admin/layout/common/layout.ftl">
<@layout title="能人管理">
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
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">能人管理</span>
        </div>
    </div>

    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/netperson/getBaseInfo">
                <li>
                    <label>能人编码：</label>
                    <input type="text" class="inputStyle w180" name="userId" value="${userId}"/>
                </li>
                <li>
                    <label>能人名称：</label>
                    <input type="text" class="inputStyle w180" name="userName" value="${userName}"/>
                </li>
                <li>
                    <label>地&nbsp;&nbsp;市：</label>
                    <select class="inputStyle w180" name="eparchyCode" value="${eparchyCode}">
                        <option value="">—全部—</option>
                        <#list cityList as cityList>
                            <option value="${cityList.CITY_CODE}">${cityList.CITY_NAME}</option>
                        </#list>
                    </select>
                </li>
                <li><label>状&nbsp;&nbsp;态：</label>
                    <select class="inputStyle w180" name="status">
                        <option value="">—全部—</option>
                        <option value="00">待审核</option>
                        <option value="01">正常</option>
                        <option value="02">暂停</option>
                        <option value="03">注销</option>
                        <option value="04">待激活</option>
                        <option value="09">审核未通过</option>
                    </select>
                </li>
                <li></li>
                <li style="text-align: right">
                    <input type="submit" value="查 询" id="submit" style="margin-right: 30px" class="shortBtn  mrgL60"/>
                </li>

            </@form.form>
        </ul>

        <div class="listTopBox">
            <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                <tbody>
                <tr>
                    <th class="tFourth">能人编码</th>
                    <th class="tFourth">能人名称</th>
                    <th class="tFourth">省份</th>
                    <th class="tFourth">地市</th>
                    <th class="tFourth">店铺名称</th>
                    <th class="tFourth">类型</th>
                    <th class="tFourth">联系方式</th>
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
                            <td class="tFourth">${trade.USER_ID}</td>
                            <td class="tFourth">${trade.USER_NAME}</td>
                            <td class="tFourth">${trade.PROVINCE_NAME}</td>
                            <td class="tFourth">${trade.CITY_NAME}</td>
                            <td class="tFourth">${trade.STORE_NAME}</td>
                            <td class="tFourth">
                                <#if (trade.CHANNEL_TYPE)=='04'>
                                    有成卡代客下单
                                <#elseif (trade.CHANNEL_TYPE)=='05' >
                                    无成卡代客下单
                                <#elseif (trade.CHANNEL_TYPE)=='06' >
                                    宣传链接
                                </#if></td>
                            <td class="tFourth">${trade.MOBILE}</td>
                            <td class="tFourth"><#if (trade.STATUS)=='00'>
                                待审核
                            <#elseif (trade.STATUS)=='01' >
                                正常
                            <#elseif (trade.STATUS)=='02' >
                                暂停
                            <#elseif (trade.STATUS)=='03' >
                                注销
                            <#elseif (trade.STATUS)=='04' >
                                待激活
                            <#elseif (trade.STATUS)=='09' >
                                审核未通过
                            </#if></td>
                            <td class="tFourth">
                                <#if ((trade.STATUS)=='00'||(trade.STATUS)=='01'||(trade.STATUS)=='02') >
                                    <a class="cBlue"
                                       style="cursor: pointer"
                                       onclick="javascript:openWindow(this)"
                                       userId='${trade.ID}'
                                       status='${trade.STATUS}'>操作</a>
                                </#if></td>
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
        <#import "/admin/layout/common/pager.ftl" as q>
        <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/netperson/getBaseInfo"/>
    </div>
    <!--end main content-->
    <!--popup -->
    <div class="pop" id="operate">
        <div class="head">
            <span style="float: left">选择操作</span><a class="close_btn" onclick="javascript:closeWindow()">X</a>
        </div>
        <div class="main" id="popMain">
        </div>
        <input type="hidden" id="userId"></input>

        <div class="foot">
            <input type="button" onclick="javascript:updateStatusByID()" class=" shortBtn mrgR10" value="确定"></input>
            <input
                    type="button" onclick="javascript:closeWindow()" class="shortBtn mrgL10" value="取消"></input>
        </div>
    </div>
</div>
<!--popup end-->
</div>
<div class="clear"></div>
<script type="text/javascript">
    var statusArray = ['待审核', '正常', '暂停', '注销', '待激活', '审核未通过'];
    var statusLabelArray = ['', '<label> <input type="radio" name="chooseStatus" value="01"></input><span>审核通过</span></label>',
        '<label> <input type="radio" name="chooseStatus" value="02"></input><span>暂停</span></label>',
        '<label> <input type="radio" name="chooseStatus" value="03"></input><span>注销</span></label>',
        '',
        '<label> <input type="radio" name="chooseStatus" value="09"></input><span>审核不通过</span></label>',
    ];
    var refresh = function () {
        $("#submit").trigger('click');
    };
    var success = function (result) {
        $.endLoading();
        $.smile(result.mesg, refresh);
    }
    var error = function (result) {
        $.endLoading();
        $.alert("失败", refresh);
    };
    function closeWindow() {
        $.overLayOff();
        $("#operate").hide();
    }
    function openWindow(element) {
        var userId = $(element).attr('userId');
        $("#userId").val(userId);
        var status = parseInt($(element).attr('status'));
        var main = $("#popMain");
        main.html("");
        if (status == 0) {
            main.append(statusLabelArray[1]);
            main.append(statusLabelArray[5]);
        } else if (status == 1) {
            main.append(statusLabelArray[2]);
            main.append(statusLabelArray[3]);
        } else if (status == 2) {
            main.append(statusLabelArray[1]);
            main.append(statusLabelArray[3]);
        } else if (status == 9) {
            main.append(statusLabelArray[1]);
        }
        $("#operate").center().show();
        $.overLayOn();
    }
    function updateStatusByID() {
        var status = $("input[name='chooseStatus']:checked").val();
        var userId = $("#userId").val();
        closeWindow();
        var url = '${rc.contextPath}/admin/am/netperson/updateStatusByID';
        var data = {
            id: userId,
            status: status,
            CSRFToken: $("input[name='CSRFToken']").val()
        };
        $.phwAjax3(url, data, success, error);
    }
</script>
</@layout>