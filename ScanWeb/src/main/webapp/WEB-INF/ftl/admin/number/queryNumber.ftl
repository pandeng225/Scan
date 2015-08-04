<#include "/admin/layout/common/layout.ftl">
<@layout title="号码查询">
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
            <span class="left">号码查询</span>
        </div>
    </div>

    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/number/findAllNum">
                <li>
                    <label>号&nbsp;&nbsp;码:</label>
                    <input type="text" class="inputStyle w180" name="serialNumber" value="${serialNumber}"/>
                </li>
                <li>
                    <label>网&nbsp;&nbsp;别:</label>
                    <select class="inputStyle w180" name="netTypeCode">
                        <option value="">—全部—</option>
                        <option value="03">4G</option>
                        <option value="01">3G</option>
                        <option value="02">2G</option>
                        <option value="04">上网卡</option>
                    </select>
                </li>
                <li>
                    <label>地&nbsp;&nbsp;市:</label>
                    <select class="inputStyle w180" name="eparchyCode" value="${eparchyCode}">
                        <option value="">—全部—</option>
                        <#list cityList as cityList>
                            <option value="${cityList.CITY_CODE}">${cityList.CITY_NAME}</option>
                        </#list>
                    </select>
                </li>
                <li><label>状&nbsp;&nbsp;态:</label>
                    <select class="inputStyle w180" name="codeState">
                        <option value="">—全部—</option>
                        <option value="0">入库</option>
                        <option value="1">上架</option>
                        <option value="2">预占</option>
                        <option value="4">已销售</option>
                        <option value="5">下架</option>
                        <option value="6">出库</option>
                    </select>
                </li>
                <li></li>
                <li style="text-align: right">
                    <a  class="cBlue" style="cursor: pointer;margin-right: 10px" href="${rc.contextPath}/admin/am/number/batchOut" >导出空闲号码</a>
                    <input type="submit" value="查 询" id="submit" style="margin-right: 30px" class="shortBtn  mrgL60"/>
                </li>

            </@form.form>
        </ul>

        <div class="listTopBox">
            <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                <tbody>
                <tr>
                    <th class="tFourth">号码</th>
                    <th class="tFourth">网别</th>
                    <th class="tFourth">地市</th>
                <#--<th class="tFourth">区县</th>-->
                    <th class="tFourth">号码分级</th>
                    <th class="tFourth">靓号规则</th>
                    <th class="tFourth">最低预存</th>
                    <th class="tFourth">入库员工</th>
                    <th class="tFourth">入库时间</th>
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
                            <td class="tFourth">${trade.SERIAL_NUMBER}</td>
                            <td class="tFourth">
                                <#if (trade.NET_TYPE_CODE)=='01'>
                                    3G
                                <#elseif (trade.NET_TYPE_CODE)=='02' >
                                    2G
                                <#elseif (trade.NET_TYPE_CODE)=='03' >
                                    4G
                                <#elseif (trade.NET_TYPE_CODE)=='04' >
                                    上网卡
                                </#if>
                            </td>
                            <td class="tFourth">${trade.EPARCHY_CODE}</td>
                        <#--<td class="tFourth">${trade.CITY_CODE}</td>-->
                            <td class="tFourth">  <#if (trade.CODE_GRADE)=='1'>
                                第一级
                            <#elseif (trade.CODE_GRADE)=='2' >
                                第二级
                            <#elseif (trade.CODE_GRADE)=='3' >
                                第三级
                            <#elseif (trade.CODE_GRADE)=='4' >
                                第四级
                            <#elseif (trade.CODE_GRADE)=='5' >
                                第五级
                            <#elseif (trade.CODE_GRADE)=='6' >
                                普通
                            </#if></td>
                            <td class="tFourth">${trade.NICE_RULE}</td>
                            <td class="tFourth">${trade.NICE_FEE/1000}</td>
                            <td class="tFourth">${trade.STAFF_IN}</td>
                            <td class="tFourth">${trade.TIME_IN?date}</td>
                            <td class="tFourth"><#if (trade.CODE_STATE)=='0'>
                                入库
                            <#elseif (trade.CODE_STATE)=='1' >
                                上架
                            <#elseif (trade.CODE_STATE)=='2' >
                                预占
                            <#elseif (trade.CODE_STATE)=='4' >
                                已售
                            <#elseif (trade.CODE_STATE)=='5' >
                                下架
                            <#elseif (trade.CODE_STATE)=='6' >
                                出库
                            </#if></td>
                            <td class="tFourth">
                                <#if  (trade.CODE_STATE)!='4' >
                                    <a class="cBlue" style="cursor: pointer;"
                                       onclick="javascript:openWindow(this)"
                                       provinceCode=${trade.PROVINCE_CODE}
                                               serialNumber=${trade.SERIAL_NUMBER}
                                       status=${trade.CODE_STATE}>操作</a>
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
        <#import "/admin/layout/common/pager.ftl" as q>
        <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/number/findAllNum"/>
    </div>
    <!--end main content-->
    <!--popup -->
    <div class="pop" id="operate">
        <div class="head">
            <span style="float: left">选择操作</span><a class="close_btn" onclick="javascript:closeWindow()">X</a>
        </div>
        <div class="main" id="popMain">
        </div>
        <input type="hidden" id="serialNumber"></input>
        <input type="hidden" id="provinceCode"></input>

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
    var statusArray = ['入库', '上架', '预占', '已售', '下架', '出库'];
    var statusLabelArray = ['<label> <input type="radio" name="chooseStatus" value="0"></input><span>入库</span></label>',
        '<label> <input type="radio" name="chooseStatus" value="1"></input><span>上架</span></label>',
        '<label> <input type="radio" name="chooseStatus" value="2"></input><span>预占</span></label>',
        '<label> <input type="radio" name="chooseStatus" value="4"></input><span>已售</span></label>',
        '<label> <input type="radio" name="chooseStatus" value="5"></input><span>下架</span></label>',
        '<label> <input type="radio" name="chooseStatus" value="6"></input><span>出库</span></label>',
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
        var serialNumber = $(element).attr('serialNumber');
        $("#serialNumber").val(serialNumber);
        var provinceCode = $(element).attr('provinceCode');
        $("#provinceCode").val(provinceCode);
        var status = parseInt($(element).attr('status'));
        var main = $("#popMain");
        main.html("");
        if (status == 0) {
            main.append(statusLabelArray[1]);
            main.append(statusLabelArray[2]);
            main.append(statusLabelArray[3]);
            main.append(statusLabelArray[4]);
            main.append(statusLabelArray[5]);
        } else if (status == 1) {
            main.append(statusLabelArray[2]);
            main.append(statusLabelArray[3]);
            main.append(statusLabelArray[4]);
            main.append(statusLabelArray[5]);
        } else if (status == 2) {
            main.append(statusLabelArray[3]);
        } else if (status == 4) {
//            main.append(statusLabelArray[1]);
        } else if (status == 5) {
            main.append(statusLabelArray[1]);
            main.append(statusLabelArray[6]);
        } else if (status == 6) {
            main.append(statusLabelArray[0]);
        }
        $("#operate").center().show();
        $.overLayOn();
    }
    function updateStatusByID() {
        var status = $("input[name='chooseStatus']:checked").val();
        var serialNumber = $("#serialNumber").val();
        var provinceCode = $("#provinceCode").val();
        $.overLayOff();
        $("#operate").hide();
        var url = '${rc.contextPath}/admin/am/number/updateStatusByID';
        var data = {
            provinceCode: provinceCode,
            codeState: status,
            serialNumber: serialNumber,
            CSRFToken: $("input[name='CSRFToken']").val()
        };
        $.phwAjax3(url, data, success, error);
    }
</script>
</@layout>