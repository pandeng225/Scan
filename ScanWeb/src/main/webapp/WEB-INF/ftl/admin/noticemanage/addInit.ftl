<#include "/admin/layout/common/layout.ftl">
<#include "/admin/component/Kindeditor.ftl">
<@layout title="公告管理">
<script language="javascript" src="${e.res('/js/common/jquery.base64.js')}"></script>
<script language="javascript" src="${e.res('/js/jquery/jquery.form.js')}"></script>
<script language="javascript" src="${e.res('/js/notice/notice.js')}"></script>
<div class="rightBar">
<link href="${e.res('/css/conf_busiadv_chf_list.css')}" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var Notice = {};
    </script>
<div class="layoutRight">
    <@form.form  id="NoticeForm" name="NoticeForm">
<div class="navigation">
    <div class="navigationLeft">
        配置管理<span>&gt;</span>公告管理
    </div>
</div>
    <div class="promotionInfor">
        <h2>新增公告</h2>
        <dl class="promotionCondition">
            <dt><label class="cRed">*</label> 公告标题</dt>
            <dd>
                <input type="text" class="inputWidth"  id="dataTitle" name="dataTitle" />
                <label class="cGray">不超过30个汉字</label>
            </dd>
        </dl>
        <div class="titleError marginTopBottom" id="noticeTitleError" style="display:none;">
            <div class="error marginLeft" id="noticeTitleError_Text" style="margin-left:90px;">不超过30个汉字</div>
        </div>

        <dl class="promotionCondition">
            <dt><label class="cRed">*</label> 公告对象</dt>
            <dd>
                <select id="businessType" class="selectWidthOne" name="noticeTarget">
                    <option value="0">系统管理员</option>
                    <option value="1">能人</option>
                </select>
                <label class="cGray">请选择公告对象</label>
            </dd>
        </dl>

        <dl class="promotionCondition">
            <dt><label class="cRed">*</label> 公告类型</dt>
            <dd>
                <select id="noticeTypeId" class="selectWidthOne" name="noticeTypeId">
                    <option value="0">公告资讯</option>
                    <option value="1">促销活动</option>
                </select>
            </dd>
        </dl>

        <dl class="promotionCondition">
            <dt><label class="cRed">*</label> 公告排序</dt>
            <dd>
                <input type="text" class="Wdate"  id="orderSeq" name="orderSeq" />
                <label class="cGray">纯数字，按从小到大升序排列</label>
            </dd>
        </dl>
        <div class="titleError marginTopBottom" id="orderSeqError" style="display:none;">
            <div class="error marginLeft" id="orderSeqError_Text" style="margin-left:90px;">公告排序不能为空</div>
        </div>

        <#--<dl class="promotionCondition">
            <dt><label class=""></label> 置顶标签</dt>
            <dd>
                <label class="set_up"><input type="checkbox" id="noticeTop" name="noticeTop" value="0" >设为置顶</label>
                <label class="cGray">置顶公告将优先显示，多个置顶公告按更新时间排序展示</label>
            </dd>
        </dl>-->

        <dl class="promotionCondition activityCon">
            <dt><label class="cRed">*</label> 公告内容</dt>
        </dl>

        <div id="editorNotice" class="promotionExplain">
            <@Kindeditor id="Notice" style="width:736px;height:418px;" editorWidth="737"/>
        </div>
        <div class="titleError marginTopBottom" id="noticeContentError" style="display:none;">
            <div class="error marginLeft" id="noticeContentError_Text" style="margin-left:90px;">公告内容不可为空</div>
        </div>
    </div>

    <div class="submitBtn">
        <a href="javascript: window.location.href = '${rc.contextPath}/admin/am/notice/getPagedNotice'" class="shortWhiteSubmitBtn">取 消</a>
        <a href="javascript:Notice.submit('add');" class="shortBlueSubmitBtn" id="saveBtn">保 存</a>
        <input type="hidden" id="content" name="content" />
        <input type="hidden" id="tag" name="tag" value="${tag}" />
    </div>

    </@form.form>
</div>


</@layout>