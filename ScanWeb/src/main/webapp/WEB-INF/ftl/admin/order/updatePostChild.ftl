<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>

<script>
var index = parent.layer.getFrameIndex(window.name);
var PCode="";
var CCode="";
var DCode="";
$(function(){
//alert(window.parent.getValue());
var k=window.parent;
if(k!=null) 
 { 
 $("#newOrderId").val(k.$("#orderId").val());
 $("#newReceiverName").val(k.$("#name").val()); 
 $("#newMobilePhone").val(k.$("#phone").val()); 
 $("#newPostAddr").val(k.$("#address").val()); 
 $("#newDTC").val(k.$("#deliverWay").val()); 
 $("#newDTimeC").val(k.$("#deliverTime").val()); 
 PCode=k.$("#provinceCode").val();
 CCode=k.$("#cityCode").val();
 DCode=k.$("#districtCode").val();
 } 
 
 qryProv(PCode);
});

function save(){
	var orderId = $("#newOrderId").val();
	var newReceiverName =$("#newReceiverName").val();
	var newMobilePhone=$("#newMobilePhone").val();
	var newPostAddr=$("#newPostAddr").val();
	var newDTC=$("#newDTC").val();
	var newDTimeC=$("#newDTimeC").val();
	var CSRFToken = $("input[name=CSRFToken]").val();
	var k=window.parent;
	$.ajax({
		url: "${rc.contextPath}/admin/am/order/updatePost",
		type: "POST",
		async: false,
		data: {"orderId":orderId,"newReceiverName":newReceiverName,"newMobilePhone":newMobilePhone,"newPostAddr":newPostAddr,"newDTC":newDTC,"newDTimeC":newDTimeC,"CSRFToken":CSRFToken},
		success: function(data) {
			if (data.result == "success") {
				alert(data.msg);
    			parent.layer.close(index);
			}
		}
	});
	
  
  function qryProv(var p){
   	$.ajax({
			url: "${rc.contextPath}/admin/am/order/qryProvince",
			type: "GET",
			dataType:"json",
			data:{},
			success: function(data) {
				var result = eval(data);
                if(result.status){
                	var str="";
                	result.list.each(function(idx,item){
                		var sel="";
                		if(item.ESS_PROVINCE_CODE==p){
                			sel="selected";
                		}
                		str+="<option value='"+item.ESS_PROVINCE_CODE+"' "+sel+">"+item.PROVINCE_NAME+"</option>";
                	});
                	$("select[name='provinceSel']").html(str);
                }else{
                    $.messager.show({
                        title: 'Error',
                        msg: result.msg
                    });
                }
			}
		});
   }

  function qryCity(var c){
   	$.ajax({
			url: "${rc.contextPath}/admin/am/order/qryCity",
			type: "GET",
			dataType:"json",
			data:{pcode:$("select[name='citySel']").val()},
			success: function(data) {
				var result = eval(data);
                if(result.status){
                	var str="";
                	result.list.each(function(idx,item){
                		var sel="";
                		if(item.ESS_CITY_CODE==c){
                			sel="selected";
                		}
                		str+="<option value='"+item.ESS_CITY_CODE+"' "+sel+">"+item.CITY_NAME+"</option>";
                	});
                	$("select[name='citySel']").html(str);
                }else{
                    $.messager.show({
                        title: 'Error',
                        msg: result.msg
                    });
                }
			}
		});
   }

 function qryDistrict(var d){
   	$.ajax({
			url: "${rc.contextPath}/admin/am/order/qryDistrict",
			type: "GET",
			dataType:"json",
			data:{ccode:$("select[name='districtSel']").val()},
			success: function(data) {
				var result = eval(data);
                if(result.status){
                	var str="";
                	result.list.each(function(idx,item){
                		var sel="";
                		if(item.DISTRICT_CODE==d){
                			sel="selected";
                		}
                		str+="<option value='"+item.DISTRICT_CODE+"' "+sel+">"+item.DISTRICT_NAME+"</option>";
                	});
                	$("select[name='districtSel']").html(str);
                }else{
                    $.messager.show({
                        title: 'Error',
                        msg: result.msg
                    });
                }
			}
		});
   }       
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

<@form.form>
<input id="newOrderId" type="hidden"/>
<div id="newPost">
<div>
<span>收件人姓名：</span>
<span>
<input id="newReceiverName" type="text">
</span>
</div>
<div>
<span>手机号码：</span><span>
<input id="newMobilePhone" type="text">
</span>
</div>
<div>
<span>详细地址：</span><span>
<select name="provinceSel" tabindex="1" style="margin-left:6px;">

</select>
<select name="citySel" tabindex="1" style="margin-left:6px;">

</select>
<select name="districtSel" tabindex="1" style="margin-left:6px;">

</select>
<input id="newPostAddr" type="text" style="width:60%">
</span>
</div>
<div>
<span>配送方式：</span><span>
 <select id="newDTC" tabindex="4" style="margin-left:6px;">
    <option value="00">不需要配置</option>
    <option value="01">送货</option>
    <option value="02">自提</option>
 </select> 
</span>
</div>
<div>
<span>配送时间：</span><span>
<select id="newDTimeC" tabindex="5" style="margin-left:6px;">
    <option value="00">工作日</option>
    <option value="01">周末</option>
    <option value="02">工作日、周末</option>
 </select> 
</span>
</div>
<div>
<span><a class="e-btn btn-9 save-btn" style="cursor:pointer;" onclick="save()">保存</a></span>
</div>
</div>
</@form.form>