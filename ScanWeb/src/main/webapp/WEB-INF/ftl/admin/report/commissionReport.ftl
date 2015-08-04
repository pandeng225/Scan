<#include "/admin/layout/common/layout.ftl">
<@layout title="沃掌柜佣金统计表">
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
<!--begin crumb-->
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">报表管理&nbsp;&gt;&nbsp;沃掌柜佣金统计表</span>
        </div>
    </div>
    <!--end curmb-->
    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/report/commissionReport">
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

                <li><label>佣金类型&nbsp;</label>
                    <select class="inputStyle w180"id="searchType" name="searchType"">
                        <option value="0">常规</option>
                        <option value="1">奖励</option>
                        </select>
                </li>
                <li>

                </li>
                <li>

                </li>
                <li >
                    <input type="submit" value="查询" class="shortBtn mrgR10 mrgL60"/>
                    <input onclick="beforeOut()" type="button" value="导出" class="shortBtn"/>
                </li>
            </@form.form>
        </ul>
        <!--end right content-->

        <div class="listTopBox">
            <#if (stat??) >
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
            </#if>
        </div>
        <div class="tableBody" cellpadding="0" cellspacing="0" border="0" width="100%" style="margin-bottom: 7px;">
            <#if (stat??) >
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

            <#else>
                <tr>
                    <td colspan="8" style="color:red">没记录</td>
                </tr>
            </#if>
        </div>
    </div>
    <!--end main content-->
</div>
    <@form.form method="get" id="reportOut">
    </@form.form>
<script type="text/javascript">
    $().ready(function () {
        var u="0";
        if('${searchType}'!=''){
            u='${searchType}';
        }
        $("#searchType").find("option[value="+u+"]").attr("selected",true);

    })
    function beforeOut() {

        var url = '${rc.contextPath}/admin/am/report/commissionReportOut?beginTime=' + $("#beginTime").val() + '&endTime=' + $("#endTime").val() + '&searchType=' + $("#searchType").val();
        $("#reportOut").attr("action",url);
        $("#reportOut").submit();
//        window.location.href = url;
    }
</script>
</@layout>