<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>

<script>
var index = parent.layer.getFrameIndex(window.name);
$(function(){
var k=window.parent;

});

function save(){
	var CSRFToken = $("input[name=CSRFToken]").val();
	$.ajax({
		url: "${rc.contextPath}/admin/am/delivery/updateExpressId",
		type: "POST",
		async: false,
		data: {"orderId":'${post.ORDER_ID}',"expressId":$("input[name=expressId]").val(),"CSRFToken":CSRFToken},
		success: function(data) {
			if (data.status) {
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
${orderDataBase.orderState} | ${post.EXPRESS_TYPE}
<#if (orderDataBase)?? && orderDataBase.orderState=='物流在途' && (post)?? && post.EXPRESS_TYPE=='0'>
<input id="orderId" type="hidden" value="${post.ORDER_ID}"/>
<div>
<span>当前物流单号:</span><span>${post.EXPRESS_ID}</span>
</div>

<div>
<span>新的物流单号：</span><span>
<input name="expressId" type="text" value="${post.EXPRESS_ID}"/>
</span>
</div>
<div>
<span><a class="e-btn btn-9 save-btn" style="cursor:pointer;" onclick="save()">保存</a></span>
</div>
<#else>
	<div>不存在的订单或者属于电子物流单，不允许修改</div>
</#if>
</@form.form>