<#include "/admin/layout/common/layout.ftl">
<@layout title="佣金规则配置">
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">已有佣金规则</span>
        </div>
    </div>

    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <@form.form id="form">
        <ul class="sList">
            <#list ruleList as rule>
                <li class="mrgT10" style="height: 100px;">
                    <span class="mrgL10" style="width: 60px;display: block">${rule.title}</span>
                    <span class="mrgL10" style="width: 200px;display: block">说明：${rule.ruleDesc}</span>
                    <#if rule.status=='0'><a class="cBlue mrgL10" style="cursor: pointer" value="1" ruleId="${rule.id}" onclick="beforeSubmit(this)">设置为生效</a>
                    <#elseif  rule.status=='1'>
                        <a class="cBlue mrgL10" style="cursor: pointer" value="0" ruleId="${rule.id}"onclick="beforeSubmit(this)">设置为失效</a>
                    </#if>
                </li>
            </#list>
        </ul>
        </@form.form>
        <input type="hidden" id="hiddenRuleId"/>
        <input type="hidden" id="hiddenStatus"/>
        <!--end right content-->
    </div>
    <!--end main content-->
</div>
<div class="clear"></div>
<script type="text/javascript">
    var refresh = function () {
        location.reload();
    };
    var success = function (result) {
        $.endLoading();
        $.smile(result.mesg, refresh);
    }
    var error = function (result) {
        $.endLoading();
        $.alert(result.mesg, refresh);
    };
   function beforeSubmit(element){
       $("#hiddenRuleId").val($(element).attr("ruleId"));
       $("#hiddenStatus").val($(element).attr("value"));
       if($(element).attr("value")=='0'){
           $.prompt("","该操作会删除已配置的商品关联，确定要继续进行？", updateStatusByID);
           $("#pop_comfirm").html("确定");
       }else{
           updateStatusByID();
       }
   }
    function updateStatusByID() {
        var url = '${rc.contextPath}/admin/am/commissionrule/setAvailable';
        var data = {
            id: $("#hiddenRuleId").val(),
            status: $("#hiddenStatus").val(),
            CSRFToken: $("input[name='CSRFToken']").val()
        };
        $.phwAjax3(url, data, success, error);
    }
</script>
</@layout>