<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>

<script>
var index = parent.layer.getFrameIndex(window.name);

function save(){
	var resId = $("#resId").val();
	var resName =$("#resName").val();
	var restypeCode=$("#restypeCode").val();
	var CSRFToken = $("input[name=CSRFToken]").val();
	$.ajax({
		url: "${rc.contextPath}/admin/am/res/updateCommit",
		type: "POST",
		async: false,
		data: {"resId":resId,"resName":resName,"restypeCode":restypeCode,"CSRFToken":CSRFToken},
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
#newPost div{
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

<#list resinfo as item>
<input id="resId" type="hidden" value="${item.RES_ID}"/>
<div id="newPost" style="margin-bottom: 10px;">
	<div>
		<span>原物品名称:</span><span>${item.RES_NAME}</span>
	</div>
	<div>
		<span>原物品类型:</span><span>${item.RESTYPE_NAME}</span>
	</div>
</div>
</#list>

<@form.form>
<div id="newPost">
<div>
<span>新物品名称：</span>
<span>
<input id="resName" type="text" style="width: 180px;" >
</span>
</div>
<div>
<span>新物品类型：</span>
<span>
<select style="margin-left: 0px; width: 180px; height: 23px;" class="inputStyle w180" id="restypeCode" name="restypeCode" style="margin-left:6px;">
                     <#list restype as item>
            			<option value="${item.RESTYPE_CODE}">${item.RESTYPE_NAME}</option>
            		 </#list>
</select> 
</span>
</div>

<div>
<span><a class="e-btn btn-9 save-btn" style="cursor:pointer;" onclick="save()">保存</a></span>
</div>
</div>
</@form.form>