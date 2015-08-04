<#include "/admin/layout/common/layout.ftl">
<@layout title="公告管理">
<div class="rightBar">
    <link href="${e.res('/css/conf_busiadv_chf_list.css')}" rel="stylesheet" type="text/css" />

    <div class="layoutRight">
        <div class="navigation">
            <div class="navigationLeft">
                配置管理<span>&gt;</span>公告管理
            </div>
        </div>

        <div class="promotionInfor">
            <h2>公告信息</h2>
            <dl class="promotionCondition">
                <dt><label class="cRed">*</label> 公告标题</dt>
                <dd>
                    ${notice.dataTitle}
                </dd>
            </dl>

            <dl class="promotionCondition">
                <dt><label class="cRed">*</label> 公告对象</dt>
                <dd>
                <#if notice.noticeTarget=='0'>
                    系统管理员
                <#elseif notice.noticeTarget=='1'>
                    能人
                </#if>
                </dd>
            </dl>

            <dl class="promotionCondition">
                <dt><label class="cRed">*</label> 公告类型</dt>
                <dd>
                <#if notice.noticeTypeId=='0'>
                    公告资讯
                <#elseif notice.noticeTypeId=='1'>
                    促销活动
                </#if>
                </dd>
            </dl>

            <dl class="promotionCondition">
                <dt><label class="cRed">*</label> 公告排序</dt>
                <dd>
                    ${notice.orderSeq}
                </dd>
            </dl>

            <dl class="promotionCondition activityCon">
                <dt><label class="cRed">*</label> 公告内容</dt>
            </dl>

            ${notice.content}
        </div>

        <div class="submitBtn">
            <a href="javascript: window.location.href = '${rc.contextPath}/admin/am/notice/getPagedNotice'" class="shortWhiteSubmitBtn">返 回</a>
        </div>
        </div>
    </div>
</div>

</@layout>