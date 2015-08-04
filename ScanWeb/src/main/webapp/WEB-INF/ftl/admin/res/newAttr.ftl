<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>

<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<link href="${e.res('/css/global.css')}" rel="stylesheet" type="text/css" />
<link href="${e.res('/css/backstageLayout.css')}" rel="stylesheet" type="text/css" />
<link href="${e.res('/css/layer.css')}" rel="stylesheet" type="text/css" />
<link href="${e.res('/css/goods_edit_list.css')}" rel="stylesheet" type="text/css" />
<style type="text/css">
* {
    color: #333;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 12px;
    font-weight: normal;
    text-decoration: none;
}
.btna{
cursor:pointer;
margin-left: 40px;
color:blue;
}
#attrvals{
padding: 10px;
border: 1px solid #eed97c;
margin-bottom: 5px;
margin-top: 5px;
}

.tpartone{
width: 15%;
}
.tparttwo{
width: 60%;
}
.tpartthree{
width: 70%;
}

#newAttr{
margin-top: 20px;
margin-left: 10px;
}

.titlea{
   border-left: 0;
   border-right: 0;
   border-top: 0;
   border-bottom: 0;
   text-align:center;
}

.cssdes{
width: 350px;
}
</style>
<script>
var index = parent.layer.getFrameIndex(window.name);
function newAttrval(){
var start = $("#attrvalStart");

start.before("<div>"+
                "<input type='text' name='attrval' class='inputStyle'/>&nbsp;"+
                "<input type='text' name='attrvalDes' class='cssdes inputStyle'/>&nbsp;"+
                "<input type='button' value='删除' onclick='delAttrval(this)' class='mediumBtn'/>"+
		     "</div>");
}

function delAttrval(inputobj) 
{
    var parentli = $(inputobj).parent(); 
    parentli.remove(); 
}

function saveAttr(id){
var attrtypeCode = $("#attrtypeCode").val();
var attrvals = $("#attrvals").find("input[name='attrval']");
var CSRFToken = $("input[name=CSRFToken]").val();
//alert($(attrvals[0]).val());
//alert($(attrvals[1]).val());

var status=0;
$.each(attrvals,function(key,val){
	if($(attrvals[key]).val() ==""){
	alert("属性值不能为空!");
	status=1;
	}
});

if(status==1){

}else{
	var vals=[];
	$.each(attrvals,function(key,val){
	var attrval = [];
	attrval[0]=$(attrvals[key]).val();
	attrval[1]=$(attrvals[key]).val();
	attrval[2]=$(attrvals[key]).next().val();
	vals[key]=attrval;
	});

	$.ajax({
		url: "${rc.contextPath}/admin/am/res/addAttr",
		type: "POST",
		async: false,
		dataType: "json",
		traditional: true,
		data: {"resId":id,"attrtypeCode":attrtypeCode,"attrvals":vals,"CSRFToken":CSRFToken},
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
}

</script>

<!-- context -->
<@form.form>
<div id="newAttr">
<input id="resId" type="hidden" value="${resId}"/>
物品属性：
	<select style="margin-left: 0px; width: 180px; height: 23px;" class="inputStyle w180" id="attrtypeCode" name="attrtypeCode" style="margin-left:6px;">
		 <#list resAttrtype as item>
			<option value="${item.ATTR_CODE}">${item.ATTR_NAME}</option>
		 </#list>
	</select> 
	<a class="btna" onclick="newAttrval()">新增属性值</a>
</div>

<div id="attrvals">
	
	<div class="attrvalContext">
			<div style="margin-bottom: 5px;">
                <input type='text' value='属性值' class="titlea"/>
                <input type='text' value='属性值描述' class="titlea cssdes"/>
                <input type='text' value='操作' class="titlea"/>
		     </div>
			 <div>
                <input type='text' name='attrval' class='inputStyle'/>
                <input type='text' name='attrvalDes' class='cssdes inputStyle'/>
		     </div>
	     <div id="attrvalStart"> </div>
	</div>  	
	
</div>

<div>
	<input type='button' value='保存' onclick='saveAttr(${resId})' class='mediumBtn'/>
</div>
</@form.form>
