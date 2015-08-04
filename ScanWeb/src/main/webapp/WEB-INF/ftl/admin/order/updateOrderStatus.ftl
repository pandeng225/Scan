<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>

<script>
var index = parent.layer.getFrameIndex(window.name);
$(function(){
var k=window.parent;
if(k!=null) 
 { 
 $("#orderId").val(k.$("#orderIdForS").val());
 var msg='';
 var statue =k.$("#updateOrderStatus").val();
 if(statue =="00"){
 msg="未处理";
 }else if(statue =="01"){
 msg="待分配";
 }else if(statue =="02"){
 msg="订单补录";
 }else if(statue =="03"){
 msg="待发货";
 }else if(statue =="04"){
 msg="发货中";
 }else if(statue =="05"){
 msg="物流在途";
 }else if(statue =="06"){
 msg="成功关闭";
 }
 $("#oldOrderStatus").text(msg);
 } 
});

function save(){
	var orderId = $("#orderId").val();
	var newOrderStatus =$("#newOrderStatus").val();
	var CSRFToken = $("input[name=CSRFToken]").val();
	$.ajax({
		url: "${rc.contextPath}/admin/am/order/updateOrderStatus",
		type: "POST",
		async: false,
		data: {"orderId":orderId,"newOrderStatus":newOrderStatus,"CSRFToken":CSRFToken},
		success: function(data) {
			if (data.result == "success") {
				alert(data.msg);
    			parent.layer.close(index);
			}
		}
	});
}
</script>

<style type="text/css">
* {
    color: #333;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 12px;
    font-weight: normal;
    line-height: 1.6em;
    list-style: outside none none;
    text-decoration: none;
}
#newPost{
padding: 10px;
border: 1px solid #eed97c;
}
div{
margin-top: 5px; 
margin-bottom: 5px;
}

a.save-btn {
    font-size: 14px;
    height: 28px;
    line-height: 28px;
    padding: 0 14px;
}
.btn-9{
    background-color: #f7f7f7;
    background-image: linear-gradient(to top, #f7f7f7 0px, #f3f2f2 100%);
    border: 1px solid #ddd;
    border-radius: 2px;
    color: #323333;
    display: inline-block;
    height: 18px;
    line-height: 18px;
    padding: 2px 14px 3px;
}
a {
    color: #666;
    text-decoration: none;
}

a.e-btn:link, a.e-btn:visited, a.e-btn:hover, a.e-btn:active {
    color: #333;
    text-decoration: none;
}
</style>

<@form.form>
<input id="orderId" type="hidden"/>
<div>
<span>当前订单状态:</span><span id="oldOrderStatus"></span>
</div>

<div>
<span>请选择新的订单状态：</span><span>
<select id="newOrderStatus" tabindex="1" style="margin-left:6px;">
    <option value="00">未处理</option>
    <option value="01">待分配</option>
    <option value="02">订单补录</option>
    <option value="03">待发货</option>
    <option value="04">发货中</option>
    <option value="05">物流在途</option>
    <option value="06">成功关闭</option>
 </select> 
</span>
</div>
<div>
<span><a class="e-btn btn-9 save-btn" style="cursor:pointer;" onclick="save()">保存</a></span>
</div>
</@form.form>