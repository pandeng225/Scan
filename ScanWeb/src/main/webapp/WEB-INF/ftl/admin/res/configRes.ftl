<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>

<script>

</script>

<style type="text/css">

</style>

<#list resinfo as item>
<input id="resId" type="hidden" value="${item.RES_ID}"/>
<div id="newPost" style="margin-bottom: 10px;">
	<div>
		<span>物品名称:</span><span>${item.RES_NAME}</span>&nbsp;&nbsp;&nbsp;&nbsp;
		<span><a class="e-btn btn-9 save-btn" style="cursor:pointer;margin-left: 40px;" onclick="save()">新增属性</a></span>
	</div>
	
</div>
</#list>

<div>
物品属性及属性值配置
</div>
<@form.form id="resform">
	<div id="resAttr">
		选择物品属性：
		<select name="resAttr">
	         <#list attrtype as item>
				<option value="${item.ATTR_CODE}">${item.ATTR_NAME}</option>
			 </#list>
		</select> 
		<a class="e-btn btn-9 save-btn" style="cursor:pointer;margin-left: 10px;" onclick="save()">新增属性值</a>
	</div>
	
	<div id="resAttrval">
		<div>
			<label>填写属性值：</label>
			<div>
			<input name="attrval" type="text"/>
			</div>
			<div>
			<input name="attrval" type="text" style="margin-left: 75px;"/>
			</div>
			<div>
			<input name="attrval" type="text" style="margin-left: 75px;"/>
			</div>
		</div>
	<div>
	
<div id="save">
	<a class="e-btn btn-9 save-btn" style="cursor:pointer;" onclick="save()">保存</a>
</div>

</@form.form>