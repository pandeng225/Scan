<#include "/admin/layout/common/layout.ftl">
<@layout title="沃掌柜渠道报表">
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/js/datePicker/WdatePicker.js')}"></script>
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">报表管理&nbsp;&gt;&nbsp;沃掌柜渠道报表</span>
        </div>
    </div>
    <!--end curmb-->
    <!--begin main content-->
    <div class="listW">

        <!--begin right content-->
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/report/channelReport">
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
                <li style="text-align:right;">
                    <input type="button" value="导出" style="margin-right: 24px" onclick="beforeOut()"class="shortBtn  "/>
                    <#--<a href="${rc.contextPath}/admin/am/report/channelReportOut" value="" style="margin-right: 24px" class="cBlue">导出</a>-->
                    <input type="submit" value="查询" style="margin-right: 24px" id="submit"class="shortBtn  "/>
                </li>
            </@form.form>
        </ul>
        <!--end right content-->

        <div class="listTopBox">
            <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                <tbody>
                <tr>
                    <th class="tFourth">地区</th>
                    <th class="tFourth">掌柜总数</th>
                    <th class="tFourth">掌柜注册数</th>
                    <th class="tFourth">当月有效掌柜数</th>
                    <th class="tFourth">平均单店产能</th>
                    <th class="tFourth">店铺访问量</th>
                    <th class="tFourth">平均单店访问量</th>
                    <th class="tFourth">总转化率</th>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="listContBox" cellpadding="0" cellspacing="0" border="0" width="100%" style="margin-bottom: 7px;">
            <#if (channelReport?size>0) >
                <table cellspacing="0" cellpadding="0" border="0" width="100%">
                    <tbody>
                        <#list channelReport as item>
                        <tr>
                            <td class="tFourth">${item.CITY_NAME}</td>
                            <td class="tFourth">${item.NET_NUM}</td>
                            <td class="tFourth">${item.RECENT_NUM}</td>
                            <td class="tFourth">${item.ACTIVITIVE_NUM}</td>
                            <td class="tFourth">${item.CM}</td>
                            <td class="tFourth">${item.VISIT_NUM}</td>
                            <td class="tFourth">${item.FWL}</td>
                            <td class="tFourth">${item.ZHL}%</td>
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
         </div>
    <!--end main content-->
</div>
    <@form.form method="get" id="reportOut">
    </@form.form>
<script type="text/javascript">
    function beforeOut() {
        var url = '${rc.contextPath}/admin/am/report/channelReportOut?beginTime='+$("#beginTime").val()+'&endTime='+$("#endTime").val();
        $("#reportOut").attr("action",url);
        $("#reportOut").submit();
//        window.location.href=url;
    }
</script>
</@layout>