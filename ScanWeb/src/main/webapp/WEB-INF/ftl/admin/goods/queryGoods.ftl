<#include "/admin/layout/common/layout.ftl">
<@layout title="商品管理">
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">商品管理</span>
        </div>
    </div>

    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/goods/findAllGoods">
                <li>
                    <label>商品编码:</label>
                    <input type="number" min="1" class="inputStyle w180" name="goodsId" value="${goodsId}"/>
                </li>
                <li>
                    <label>商品类型:</label>
                    <select type="text" class="inputStyle w180" name="ctlgCode">
                        <option value="">—全部—</option>
                        <#if (ctlg?size>0) >
                            <#list ctlg as cc>
                                <optgroup label="${cc.text}">
                                    <#list cc.children as c>
                                        <option value="${c.id}" <#if params.ctlgCode == c.id>selected="selected"</#if>  >${c.text}</option>
                                    </#list>
                                </optgroup>
                            </#list>
                        </#if>
                    </select>
                </li>
                <li>
                    <label>商品名称:</label>
                    <input type="text" class="inputStyle w180" name="goodsName" value="${goodsName}"/>
                </li>
                <li><label>状&nbsp;&nbsp;态:</label>
                    <select class="inputStyle w180" name="goodsState">
                        <option value="">—全部—</option>
                        <option value="1" <#if params.goodsState=='1'>selected="selected"</#if>>可售</option>
                        <option value="2" <#if params.goodsState=='2'>selected="selected"</#if>>已下架</option>
                    </select>
                </li>
                <li></li>
                <li style="text-align: right">
                    <input type="submit" value="查 询" id="submit" style="margin-right: 30px"class="shortBtn  mrgL60"/>
                </li>
            </@form.form>
        </ul>

        <div class="listTopBox">
            <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                <tbody>
                <tr>
                    <th class="tFourth">商品编码</th>
                    <th class="tFourth">商品名称</th>
                    <th class="tFourth">商品类型</th>
                    <th class="tFourth">原价(元)</th>
                    <th class="tFourth">销售价(元)</th>
                    <th class="tFourth">库存数</th>
                    <th class="tFourth">创建时间</th>
                    <#--<th class="tFourth">商品描述</th>-->
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
                            <td class="tFourth">${trade.GOODS_ID}</td>
                            <td class="tFourth">${trade.GOODS_NAME}</td>
                            <td class="tFourth">${trade.GOODS_CTLG_NAME}</td>
                            <td class="tFourth">${trade.ORIGINAL_PRICE}</td>
                            <td class="tFourth">${trade.GOODS_PRICE}</td>
                            <td class="tFourth">${trade.GOODS_AMOUNT}</td>
                            <td class="tFourth">${trade.CREATE_TIME?date}</td>
                            <#--<td class="tFourth">${trade.SIMP_DESC}</td>-->
                            <td class="tFourth"><#if (trade.GOODS_STATE)=='1'>可售 <#elseif (trade.GOODS_STATE)=='2' >
                                已下架 </#if></td>
                            <td class="tFourth">
                                <#if (trade.GOODS_STATE)=='1' >
                                    <a class="cBlue" style="cursor: pointer"
                                       href="javascript:updateStatusByID(${trade.GOODS_ID},'2')">下架</a>
                                <#else>
                                    <a class="cBlue" style="cursor: pointer"
                                       href="javascript:updateStatusByID(${trade.GOODS_ID},'1')">上架</a>
                                    |
                                    <a class="cBlue" style="cursor: pointer"
                                       href="javascript:location.href='${rc.contextPath}/admin/am/goods/edit?goodsId=${trade.GOODS_ID}'">编辑</a>
                                    |
                                    <a class="cBlue" style="cursor: pointer"
                                       href="javascript:deleteGds(${trade.GOODS_ID})">删除</a>
                                </#if>
                                |
                                <a type="button" class="cBlue" style="cursor: pointer"
                                   href="javascript:location.href='${rc.contextPath}/admin/am/goods/view?goodsId=${trade.GOODS_ID}'"
                                        />查看</a>
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
        <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/goods/findAllGoods"/>
    </div>
    <!--end main content-->
</div>
<div class="clear"></div>
<script type="text/javascript">
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

    function updateStatusByID(goodsId, status) {
        var url = '${rc.contextPath}/admin/am/goods/updateStatusByID';
        var data = {
            goodsId: goodsId,
            goodsState: status,
            CSRFToken: $("input[name='CSRFToken']").val()
        };
        $.phwAjax3(url, data, success, error);
    }


    function deleteGds(id) {
        if (confirm("确认要删除吗？")) {
            $.ajax({
                url: "${rc.contextPath}/admin/am/goods/delete",
                data: {
                    goodsId: id,
                    CSRFToken: $(':input[name="CSRFToken"]').val()
                },
                dataType: "json",
                type: "POST",
                success: function (responseText) {
                    if (responseText.status) {
                        alert("删除成功");
                        window.location.reload();
                    } else {
                        alert("删除失败:" + responseText.msg);
                    }
                }
            });
        }
    }
</script>
</@layout>