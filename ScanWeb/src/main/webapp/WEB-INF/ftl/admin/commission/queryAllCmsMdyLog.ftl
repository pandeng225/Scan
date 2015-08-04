<#include "/admin/layout/common/layout.ftl">
<@layout title="佣金管理">
<div class="rightBar">
<link href="${e.res('/css/merchant_staff.css')}" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>

<script>
function load(orderNo) {
$.layer({
    type: 2,
    shade: [0],
    fix: false,
    title: '订单佣金调整',
    maxmin: true,
    iframe: {src : '/admin/am/commission/modifycommission?orderNo='+orderNo},
    area: ['800px' , '440px']
    
}); 
}

</script>


<div class="layoutRight">
      <div class="navigation">
        <div class="navigationLeft">
          佣金管理<span>&gt;</span>佣金调整
        </div>
      </div>
    <@form.form method="post" action="${rc.contextPath}/admin/am/commission/queryAllCmsMdyLog">
      <div class="staffSelect">
        <dl>
          <dt><label>能人编码：</label></dt><dd><input type="text" id="userId" name="userId" value="${userId}" class="inputW144H23"/></dd>
          <dt><label>订单编号：</label></dt><dd><input type="text" id="orderNo" name="orderNo" value="${orderNo}" class="inputW144H23"/></dd>
          <dt><label>商品号码：</label></dt><dd><input type="text" id="goodsNumber" name="goodsNumber" value="${goodsNumber}" class="inputW144H23"/></dd>
          <dt><input type="submit" value="查&nbsp;&nbsp;询" class="btnStyle" /></dt>
        </dl>
      </div>
    </@form.form>
      <ul class="staffListName">
        <li class="staffNumber">能人编码</li>
        <li class="staffNumber">订单编号</li>
        <li class="staffNumber">订单来源</li>
        <li class="staffNumber">商品名称</li>
        <li class="staffNumber">佣金总金额(元)</li>
        <li class= "staffNumber">号码</li>
        <li class="staffNumber">操作</li>
      </ul>
      <div class="staffListBox">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="table_model">
        <#list pager.rows as orderInfo>
          <tr class="staffList">
              <td class="staffNumber">${orderInfo.USERID}</td>
              <td class="staffNumber">${orderInfo.ORDERNO}</td>
              <td class="staffNumber">${orderInfo.ORDERFROM}</td>
              <td class="staffNumber">${orderInfo.GOODSNAME}</td>
              <td class="staffNumber">${orderInfo.SUMMONEY}</td>
              <td class="staffNumber">${orderInfo.GOODSNUMBER}</td>
              <td class="staffNumber">
                <!----<a id="modify" href="${rc.contextPath}/admin/am/commission/modifycommission?orderNo=${orderInfo.ORDERNO}"  class="blue-link" style="color:blue;">调整</a>-->
                   <a id="modify" onClick= "load(${orderInfo.ORDERNO})"  class="blue-link" style="color:blue;">调整</a>
                   | <a class="blue-link" style="color:blue;" href="${rc.contextPath}/admin/am/order/detail?orderIdStr=${orderInfo.ORDERID}")">订单详情</a>
              </td>
          </tr>
      </#list>
      </table>
          <#import "/admin/layout/common/pager.ftl" as q>
          <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/commission/queryAllCmsMdyLog"/>
      </div>
      
</@layout>