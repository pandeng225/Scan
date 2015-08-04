<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>

<script>
var index = parent.layer.getFrameIndex(window.name);

function save(){
	var orderId = $("#orderId").val();
	var resId = $("#resId").val();
	var resName =$("#resName").val();
	var resAttrCode =$("#resAttrCode").val();
	var attrvalCodeForNum="";
	var attrvalCode="";
    var values1 = "";
	if(document.getElementById("newNum")){
		if($("#newNum").val()!=""){
		attrvalCodeForNum=$("#newNum").val();
		}else{
		alert("新号码不能为空!");
		return;
		}
	}
	var newCardNum="";
	if(document.getElementById("newCardNum")){
		if($("#newCardNum").val()!=""){
		newCardNum=$("#newCardNum").val();
		}else{
		alert("新号卡不能为空!");
		return;
		}
	}
	
	if(document.getElementById("attrvalCodeN")){
		if($("#attrvalCodeN").length > 0){
		    var attrvalCodeN =$("#attrvalCodeN").val();
            if(attrvalCodeN && attrvalCodeN!=null && attrvalCodeN!=''){
                var attrs = attrvalCodeN.split("|");
                if(attrs && attrs.length>0)
                attrvalCode = attrs[0];
                values1 = attrs[1];
            }
		}
	}
	
	var oldAttrValT=$("#oldAttrVal").val();
	var CSRFToken = $("input[name=CSRFToken]").val();
	$.ajax({
		url: "${rc.contextPath}/admin/am/order/updateOrderAttrCommit",
		type: "POST",
		async: false,
		data: {"orderId":orderId,"resId":resId,"newCardNum":newCardNum,"resName":resName,"resAttrCode":resAttrCode,"attrvalCodeForNum":attrvalCodeForNum,"attrvalCode":attrvalCode,"oldAttrVal":oldAttrValT,"CSRFToken":CSRFToken,"values1":values1},
		success: function(data) {
			if (data.result == "success") {
				alert(data.msg);
    			parent.layer.close(index);
			}else{
			 	alert(data.msg);
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
.newPost{
padding: 10px;
border: 1px solid #eed97c;
}
.newPost div{
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
<#list orderRes as item>
<input id="resId" type="hidden" value="${item.RES_ID}"/>
<div class="newPost" style="margin-bottom: 10px;">
	<div>
		<span>原物品属性:</span><span>${item.ATTR_NAME}</span>
	</div>
	<div>
		<span>原物品属性值:</span><span>${item.RES_ATTR_VAL!'空'}</span>
		<input id="oldAttrVal" type="hidden" value="${item.RES_ATTR_VAL}"/>
	</div>
</div>
</#list>


<div class="newPost">
<#if attrval??>
	<div>
	<span>新物品属性值：</span>
	<span>
	<select style="margin-left: 0px; width: 180px; height: 23px;" class="inputStyle w180" id="attrvalCodeN" name="attrvalCodeN" style="margin-left:6px;">
	                     <#list attrval as item>
	            			<option value="${item.ATTR_VAL_CODE}|${item.VALUES1}">${item.ATTR_VAL_NAME}</option>
	            		 </#list>
	</select> 
	</span>
	</div>
<#else>
	<#if attrCodeType=="CARD">
		<div>
			<span>请填写新的上网卡号码：</span><input type="text" id="newCardNum"/>
		</div>
	<#else>
		 <div>
			<span>请填写新的号码：</span><input type="text" id="newNum"/>
		</div>
	</#if>
</#if>

<div>
<span><a class="e-btn btn-9 save-btn" style="cursor:pointer;" onclick="save()">保存</a></span>

<input id="resAttrCode" type="hidden" value="${resAttrCode}"/>
<input id="orderId" type="hidden" value="${orderId}"/>
</div>
</div>
</@form.form>