<#include "/admin/layout/common/layout.ftl">
<@layout title="新增规则">
<script language="javascript" type="text/javascript" src="${e.res('/js/datePicker/WdatePicker.js')}"></script>
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">新增规则</span>
        </div>
    </div>

    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/commissionrule/findAllGoodsRuleRel">
                <li>
                    <label>商品编码：</label>
                    <input type="text" class="inputStyle w180" name="goodsId" value="${goodsId}"/>
                </li>
                <li>
                    <label>商品类型：</label>
                    <select type="text" class="inputStyle w180" name="ctlgCode">
                        <option value="">—全部—</option>
                        <#if (ctlg?size>0) >
                            <#list ctlg as cc>
                                <optgroup label="${cc.text}">
                                    <#list cc.children as c>
                                        <option value="${c.id}">${c.text}</option>
                                    </#list>
                                </optgroup>
                            </#list>
                        </#if>
                    </select>
                </li>
                <li>
                    <label>商品名称：</label>
                    <input type="text" class="inputStyle w180" name="goodsName" value="${goodsName}"/>
                </li>
                <li>
                <#--<label>状&nbsp;&nbsp;态：</label>-->
                    <#--<select class="inputStyle w180" name="goodsState">-->
                        <#--<option value="">—全部—</option>-->
                        <#--<option value="1">可售</option>-->
                        <#--<option value="2">已下架</option>-->
                    <#--</select>-->
                </li>
                <li></li>
                <li style="text-align: right">
                    <input type="submit" value="查 询" id="submit" class="mediumBtn mrgR10 mrgL10"/>
                    <input type="button" operateType="batchAdd" onclick="openWindow(this)" value="批量添加" id="submit"
                           style="margin-right: 30px;"
                           class="mediumBtn  mrgL10"/>
                </li>
            </@form.form>
        </ul>

        <div class="listTopBox">
            <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                <tbody>
                <tr>
                    <th class="tFourth"><input type="checkbox" name="allcheck"/></th>
                    <th class="tFourth">商品编码</th>
                    <th class="tFourth">商品名称</th>
                    <th class="tFourth">商品类型</th>
                    <th class="tFourth">已匹配规则</th>
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
                            <td class="tFourth"><input type="checkbox" value="${trade.GOODS_ID}"></td>
                            <td class="tFourth">${trade.GOODS_ID}</td>
                            <td class="tFourth">${trade.GOODS_NAME}</td>
                            <td class="tFourth">${trade.GOODS_CTLG_NAME}</td>
                            <td class="tFourth">${trade.ALLTITLE?replace(",","</br>")}  </td>
                            <td class="tFourth">
                                <a class="cBlue" style="cursor: pointer" operateType="add"
                                   onclick="openWindow(this)"
                                   allId="${trade.ALLID}"
                                   good_id="${trade.GOODS_ID}">绑定</a>
                                <#if trade.ALLID!=null>
                                    | <a class="cBlue" style="cursor: pointer" operateType="delete"
                                         onclick="openWindow(this)"
                                         ALLID="${trade.ALLID}"
                                         good_id="${trade.GOODS_ID}">解绑</a>
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
        <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/commissionrule/findAllGoodsRuleRel"/>

    </div>
    <!--end main content-->
</div>
<div class="clear"></div>
<!--pop-->
<div id="operate" class="popTips" style="width:300px;right:500px">
    <h3 class="tipsTitle">
        <label class="change">操作提示</label>
    </h3>
    <input type="hidden" id="hiddenGoodsId">
    <input type="hidden" id="operateType">

    <div class="topLine">
        <span style="font:15px;font-weight: bold;width: 100%" id="title"></span>
        <ul class="sList">
            <li class="mrgT5 cRed">请谨慎选择</li>
            <#list ruleList as rule>
                <li class="add ${'rule'+rule.id}">
                    <input type="radio" name="dynamic" value="${rule.id}"
                        <#if "${rule.status}"=="0">
                           disabled="disabled"
                        </#if>>
                    <span class="mrgL10">${rule.title}</span>
                    <#if rule.status=='0'><span class="cRed">失效规则不能配置，如需配置请先生效</span>
                    </#if>
                    </input>
                </li>
            </#list>
            <li class="add">
                <label>开始时间&nbsp;</label>
                <input type="text" value="${beginTime}" placeholder="开始时间" id="beginTime" class="inputStyle w180" name="beginTime" onclick="WdatePicker({readOnly:true,minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd'})"/>
            </li>
            <li class="add">
                <label>结束时间&nbsp;</label>
                <input type="text" value="${endTime}" placeholder="结束时间" id="endTime" class="inputStyle w180" name="endTime" onclick="WdatePicker({readOnly:true,minDate:'#F{$dp.$D(\'beginTime\')||\'%y-%M-%d\'}',dateFmt:'yyyy-MM-dd'})" />
            </li>
            <#list ruleList as rule>
                <li class="mrgT10 delete ${'rule'+rule.id}">
                    <input type="checkbox" name="dynamic" value="${rule.id}">
                    <span class="mrgL10 ">${rule.title}</span>
                    </input>
                </li>
            </#list>
        </ul>
    </div>
    <div class="tipsBtnsW">
        <input type="button" onclick="operate()" class=" shortBtn mrgR10" value="确定"></input>
        <input
                type="button" onclick="javascript:closeWindow()" class="shortBtn mrgL10" value="取消"></input>
    </div>
</div>
<!--pop end-->
<script>
    var refresh = function () {
        $("#submit").trigger('click');
    };
    var success = function (result) {
        $.endLoading();
        $("#operate").hide();
        if(result.result=='FAIL'){
            $.alert(result.mesg, refresh);
        }else{
            $.smile(result.mesg, refresh);
        }

    }
    var error = function (result) {
        $.endLoading();
        $("#operate").hide();
        $.alert("失败", refresh);
    };
    $().ready(function () {
        $(":checkbox[name='allcheck']").click(function () {
            $(".listContBox :checkbox").prop("checked", $(this).prop("checked"));
        });
        $(".listContBox :checkbox").click(function () {
            $(":checkbox[name='allcheck']").prop("checked", $(".listContBox :checkbox:checked").length == $(".listContBox :checkbox").length);
        });
    })

    function openWindow(element) {
        var operateType = $(element).attr("operateType");
        $("#hiddenGoodsId").val($(element).attr("good_id"));
        $("#operateType").val(operateType);
        var allId = $(element).attr("allId");
        var allIdArray=[];
        if(allId!=null){
            allIdArray=allId.split(",");
        }
        if (operateType == 'add' || operateType == 'batchAdd') {

            $("#title").html("可匹配规则");
            $(".add").show();
            $(".delete").hide();
            if(allIdArray!=null){
                for(var i= 0;i<allIdArray.length;i++){
                    $(".add.rule"+allIdArray[i]).hide();
                }
            }
        } else {
            $("#title").html("已匹配规则");
            $(".add").hide();
            $(".delete").hide();
            if(allIdArray!=null){
                for(var i= 0;i<allIdArray.length;i++){
                    $(".delete.rule"+allIdArray[i]).show();
                }
            }
        }
        $("#operate").show();
        $.overLayOn();
    }
    function operate() {
        var url = '';
        var data = '';
        var ruleId = '';
        var operateType = $("#operateType").val();
        if (operateType == 'add') {
            url = '${rc.contextPath}/admin/am/commissionrule/addGoodRuleRel';
            ruleId = $(":radio[name='dynamic']:checked").val();
            data = {
                goodsId: $("#hiddenGoodsId").val(),
                ruleId: ruleId,
                BeginDateString:$("#beginTime").val(),
                EndDateString:$("#endTime").val(),
                CSRFToken: $("input[name='CSRFToken']").val()
            };
        } else if (operateType == 'delete') {
            url = '${rc.contextPath}/admin/am/commissionrule/deleteGoodRuleRel';
            ruleId = '';
            $(".delete :checkbox:checked").each(
                    function () {
                        ruleId += $(this).val() + ',';
                    }
            );
            data = {
                goodsId: $("#hiddenGoodsId").val(),
                ruleId: ruleId.substring(0, ruleId.length - 1),
                CSRFToken: $("input[name='CSRFToken']").val()
            };
        } else if (operateType == 'batchAdd') {
            url = '${rc.contextPath}/admin/am/commissionrule/addGoodRuleRel';
            ruleId = $(":radio[name='dynamic']:checked").val();
            var goodsId = '';
            $(".listContBox :checkbox:checked").each(
                    function () {
                        goodsId += $(this).val() + ',';
                    }
            );
            data = {
                goodsId: goodsId.substring(0, goodsId.length - 1),
                ruleId: ruleId,
                BeginDateString:$("#beginTime").val(),
                EndDateString:$("#endTime").val(),
                CSRFToken: $("input[name='CSRFToken']").val()
            };
        }
        $.phwAjax3(url, data, success, error);
    }
    function closeWindow() {
        $("#operate").hide();
        $.overLayOff();
    }

</script>
</@layout>