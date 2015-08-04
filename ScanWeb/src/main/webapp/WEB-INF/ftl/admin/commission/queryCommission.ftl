<#include "/admin/layout/common/layout.ftl">
<@layout title="查询佣金">
<script language="javascript" type="text/javascript" src="${e.res('/js/datePicker/WdatePicker.js')}"></script>
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">查询佣金</span>
        </div>
    </div>

    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/commissionrule/findAllCommission">
                <li>
                    <label>订单号：</label>
                    <input type="text" class="inputStyle w180" name="goodsId" value="${goodsId}"/>
                </li>
                <li>
                    <label>商品名称：</label>
                    <input type="text" class="inputStyle w180" name="goodsName" value="${goodsName}"/>
                </li>
                <li>
                    <label>佣金日期：</label>
                    <input name="cmsDay" type="text" class="inputStyle w180" readonly="readonly"
                           onclick="WdatePicker({dateFmt:'yyyyMMdd'})"/>
                </li>

                <li><label>状&nbsp;态：</label>
                    <select class="inputStyle w180" name="status">
                        <option value="">—全部—</option>
                        <#--<option value="00">未激活</option>-->
                        <option value="01">结算中</option>
                        <option value="02">已到帐</option>
                        <option value="03">已退货</option>
                        <option value="04">已失效</option>
                    </select>
                </li>
                <li>
                    <#--<label>能人名称：</label>-->
                    <#--<input type="text" class="inputStyle w180" name="goodsName" value="${goodsName}"/>-->
                </li>
                <li style="text-align: right">
                    <input type="submit" value="查 询" id="submit" class="shortBtn  mrgL60" style="margin-right: 30px"/>
                </li>
            </@form.form>
        </ul>

        <div class="listTopBox">
            <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                <tbody>
                <tr>
                    <th class="tFourth">订单号</th>
                    <th class="tFourth">能人名称</th>
                    <th class="tFourth">渠道</th>
                    <th class="tFourth">计算金额</th>
                    <th class="tFourth">商品名</th>
                    <th class="tFourth">佣金总金额</th>
                    <th class="tFourth">佣金金额</th>
                    <th class="tFourth">佣金日期</th>
                    <th class="tFourth">计算日期</th>
                    <th class="tFourth">佣金类别</th>
                    <th class="tFourth">状态</th>
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
                            <td class="tFourth">${trade.USER_NAME}</td>
                            <td class="tFourth">
                                <#if (trade.CONN_CHANNEL)=='10'>
                                    商城渠道
                                <#elseif  (trade.CONN_CHANNEL)=='11'>
                                    微信渠道
                                </#if>
                            </td>
                            <td class="tFourth">${trade.INCOME_MONEY/1000}</td>
                            <td class="tFourth">${trade.GOODS_NAME}</td>
                            <td class="tFourth">${trade.CMS_SUM_MONEY/1000}</td>
                            <td class="tFourth">${trade.CMS_MONEY/1000}</td>
                            <td class="tFourth">${trade.CMS_DAY}</td>
                            <td class="tFourth">${trade.CAL_DATE?date}</td>
                              <td class="tFourth">
                                <#if (trade.CMS_TYPE)=='0'>
                                    比例
                                <#elseif  (trade.CMS_TYPE)=='1'>
                                    奖励
                                </#if>
                            </td>
                            <td class="tFourth">
                                <#if (trade.TRUE_STATE)=='00'>
                                    未激活
                                <#elseif  (trade.TRUE_STATE)=='01'>
                                    结算中
                                <#elseif  (trade.TRUE_STATE)=='02'>
                                    已到帐
                                <#elseif  (trade.TRUE_STATE)=='03'>
                                    已退货
                                <#elseif  (trade.TRUE_STATE)=='04'>
                                    已失效
                                </#if>
                            </td>
                        </tr>
                        </#list>
                    </tbody>
                </table>
            <#else>
                没有符合条件的记录
            </#if>
        </div>
        <!--end right content-->
        <#import "/admin/layout/common/pager.ftl" as q>
        <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/commissionrule/findAllCommission"/>


        <!--end right content-->
    </div>
    <!--end main content-->
</div>
<div class="clear"></div>

</@layout>