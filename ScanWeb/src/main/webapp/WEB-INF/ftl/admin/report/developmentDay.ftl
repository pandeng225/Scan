<#include "/admin/layout/common/layout.ftl">
<@layout title="发展日报表">
<script language="javascript" type="text/javascript" src="${e.res('/js/datePicker/WdatePicker.js')}"></script>
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
        word-break: break-all;
        word-wrap: break-word;
    }

    .tableBody table td.first {
        border-left: 1px solid #e6f0f5;
        border-top: 1px solid #e6f0f5;
        text-align: center;
    }

    .tableBody table td.others {
        border-collapse: collapse;
        border-left: 1px solid #e6f0f5;
        border-top: 1px solid #e6f0f5;
        border-right: 1px solid #e6f0f5;
        padding-bottom: 10px;
        padding-top: 10px;
        text-align: center;
        vertical-align: top;
    }

    .tableBody table td.third {
        border-top: 1px solid #e6f0f5;
    }

    .tleft {
        text-align: left;
    }

</style>
<script>
    function exportXls() {
        var isDetail="";
        if(  $("#isDetail").attr("checked")){
            isDetail="1";
        }
        window.open('${rc.contextPath}/admin/am/report/development/exportDay?beginTime=' + $("#beginTime").val() + '&endTime=' + $("#endTime").val()+'&actChannel=' + $("#actChannel").val()+'&isDetail=' +isDetail);
    }
</script>
<!--begin crumb-->
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">报表管理&nbsp;&gt;&nbsp;发展日报表</span>
        </div>
    </div>
    <!--end curmb-->
    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/report/development/queryDay">
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
                <li></li>
                <li>
                    <label>统计口径&nbsp;</label>
                    <select class="inputStyle w180" id="actChannel" name="actChannel">
                        <option value="0">订单已支付</option>
                        <option value="1">号码已激活</option>
                    </select>
                </li>
                <li><input type="checkbox" id="isDetail" name="isDetail" value="1" style="vertical-align:middle;"><span
                        class="mrgL10 mrgB5"
                        style="vertical-align:middle;">明细</span></li>
                <li>
                    <input type="submit" value="查询" class="shortBtn mrgR10 mrgL60"/>
                    <input onclick="exportXls()" type="button" value="导出" class="shortBtn"/>
                </li>
            </@form.form>
        </ul>
        <!--统计-->
        <#if (stat??) >
            <div class="listTopBox">
                <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                    <tbody>
                    <tr>
                        <#list stat as item>
                            <#if item_index==0>
                                <#list item as t>
                                    <th class="first" width="60">${t}</th>
                                </#list>
                            </#if>
                        </#list>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="tableBody" cellpadding="0" cellspacing="0" border="0" width="100%"
                 style="margin-bottom: 7px;">
                <table cellspacing="0" cellpadding="0" border="0" width="100%">
                    <tbody>
                        <#list stat as item>
                            <#if item_index gt 0>
                            <tr>
                                <#list item as t>
                                    <td class="first" width="60">
                                    ${t}</th>
                                </#list>
                            </tr>
                            </#if>
                        </#list>
                    </tbody>
                </table>
            </div>
        </#if>
        <!--明细-->
        <#if (pager??)>
            <div class="listTopBox">
                <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                    <tbody>
                    <tr>
                        <th class="tFourth">订单号</th>
                        <th class="tFourth">地市</th>
                        <th class="tFourth">商品类别</th>
                        <th class="tFourth">商品名</th>
                        <th class="tFourth">价格</th>
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
                                <td class="tFourth">${trade.CITY_NAME}</td>
                                <td class="tFourth">${trade.GOODS_CTLG_NAME}</td>
                                <td class="tFourth">${trade.GOODS_NAME}</td>
                                <td class="tFourth">${trade.TOPAY_MONEY}</td>
                            </tr>
                            </#list>
                        </tbody>
                    </table>
                <#else>
                    没有符合条件的记录
                </#if>
            </div>
        </#if>
    </div>
<#if (pager??)>
    <#import "/admin/layout/common/pager.ftl" as q>
    <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/report/development/queryDay"/>
</#if>
    <!--end main content-->
</div>
<div class="clear"></div>
<script type="text/javascript">
    $().ready(function () {
        var u="0";
        if('${actChannel}'!=''){
            u='${actChannel}';
        }
        $("#actChannel").find("option[value="+u+"]").attr("selected",true);
        if('${isDetail}'!=''){
            $("#isDetail").attr("checked",true);
        }

    })
</script>
</@layout>