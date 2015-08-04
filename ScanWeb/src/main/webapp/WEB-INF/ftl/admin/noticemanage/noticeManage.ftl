<#include "/admin/layout/common/layout.ftl">
<@layout title="公告管理">
<link href="${e.res('/css/conf_busiadv_list.css')}" rel="stylesheet" type="text/css" />
<link href="${e.res('/css/adminTipsLayer.css')}" rel="stylesheet" type="text/css" />
<script language="javascript" src="${e.res('/js/common/common_0.js')}"></script>
<script language="javascript" src="${e.res('/js/jquery/jquery.form.js')}"></script>
<script language="javascript" src="${e.res('/js/notice/notice.js')}"></script>
<script type="text/javascript">
    var Notice = {};
</script>
<div class="rightBar">
        <div class="navigation">
            <div class="navigationLeft">
                配置管理<span>&gt;</span>公告管理
            </div>
        </div>

        <div class="listW">
                <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/notice/getPagedNotice">
                    <li>
                        <label>公告标题：</label>
                        <input type="text" class="inputStyle w180" id="dataTitle" name="dataTitle" value="${sysNotice.dataTitle}">
                    </li>
                    <li>
                        <label>公告对象：</label>
                        <select class="selectStyle w185" name="noticeTarget">
                            <option value="">请选择</option>
                            <#list targetList as target>
                                <#if target.dataKey==sysNotice.noticeTarget>
                                    <option  value="${target.dataKey}" selected="selected">${target.dataValue}</option>
                                <#else>
                                    <option  value="${target.dataKey}">${target.dataValue}</option>
                                </#if>
                            </#list>
                        </select>
                    </li>

                    <li>
                        <label>公告类型：</label>
                        <select  class="selectStyle w185" name="noticeTypeId">
                            <option value="">请选择</option>
                            <#list typeList as type>
                                <option value="${type.dataKey}" <#if type.dataKey == sysNotice.noticeTypeId>selected="selected" </#if>>${type.dataValue}</option>
                            </#list>
                        </select>
                    </li>
                    <li></li><li></li>
                    <li style="text-align:right;">
                        <input type="submit" value="查&nbsp;&nbsp;询" class="shortBtn" style="shortBtn mrgR10 mrgL60" />
                    </li>

            </@form.form>
                </ul>
            <div class="listTopBox">
                <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                    <tbody>
                    <tr>
                        <th class="tFourth">标题</th>
                        <th class="tFourth">公告对象</th>
                        <th class="tFourth">公告类型</th>
                        <th class="tFourth">排序</th>
                        <th class="tFourth">更新时间</th>
                        <th class="tFourth">更新员工</th>
                        <th class="tFourth">操作</th>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="listContBox">
                <#if 0 == pager.total>
                    <p style="padding:20px;text-align:center;margin-bottom:10px;">暂无相关查询结果</p>
                <#else>
                    <#list pager.rows as notice>
                        <table cellspacing="0" cellpadding="0" border="0">
                            <tbody>
                            <tr>
                                <td class="tFourth">${notice.DATA_TITLE}</td>
                                <td class="tFourth">${notice.NOTICE_TARGET_VALUE}</td>
                                <td class="tFourth">${notice.NOTICE_TYPE_VALUE}</td>
                                <td class="tFourth">${notice.ORDER_SEQ}</td>
                                <td class="tFourth">${notice.UPDATE_TIME?string('yyyy-MM-dd HH:mm:ss')}</td>
                                <td class="tFourth">${notice.STAFF_NAME}</td>
                                <td class="tFourth">
                                    <a href="${rc.contextPath}/admin/am/notice/getNoticeById?noticeId=${notice.NOTICE_ID}" class="cBlue">查看明细</a>
                                    <a href="${rc.contextPath}/admin/am/notice/editInit?noticeId=${notice.NOTICE_ID}" class="cBlue">编辑</a>
                                    <a href="javascript:Notice.deleteNoticPrompt('${notice.NOTICE_ID}')" class="cBlue">删除</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </#list>
                </#if>
            </div>
            <#import "/admin/layout/common/pager.ftl" as q>
            <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/notice/getPagedNotice"/>
            <div class="createActivity">
                <a href="${rc.contextPath}/admin/am/notice/addInit" class="shortBlueSubmitBtn">添加公告</a>
            </div>
        </div>
</@layout>
