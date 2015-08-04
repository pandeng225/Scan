<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/js/datePicker/WdatePicker.js')}"></script>

<script>
var index = parent.layer.getFrameIndex(window.name);

function save(){
	var orderId = $("#orderId").val();
	var userId =$("#userId").val();
	var orderNo=$("#orderNo").val();
	var partitionId=$("#partitionId").val();
	var connChannel=$("#connChannel").val();
	var orderFrom=$("#orderFrom").val();
	var goodsName=$("#goodsName").val();
	var goodsId=$("#goodsId").val();
	var goodsNumber=$("#goodsNumber").val();
	var computeDate=$("#computeDate").val();
	var incomeMoney=$("#incomeMoney").val();
	var createTime=$("#createTime").val();
	var status=$("#status").val();
	var commission=$("#commission").val();
	var cmsSumMoney=$("#cmsSumMoney").val();
	var cmsType=$("#cmsType").val();
	var CSRFToken = $("input[name=CSRFToken]").val();
	$.ajax({
		url: "${rc.contextPath}/admin/am/commission/updatecommission",
		type: "POST",
		async: false,
		data: {"cmsSumMoney":cmsSumMoney,"commission":commission,"partitionId":partitionId,"goodsId":goodsId,"computeDate":computeDate,"userId":userId,"orderId":orderId,"orderNo":orderNo,"connChannel":connChannel,"orderFrom":orderFrom,"goodsName":goodsName,"goodsNumber":goodsNumber,"incomeMoney":incomeMoney,"createTime":createTime,"status":status,"cmsType":cmsType,"CSRFToken":CSRFToken},
		success: function(data) {
			if (data.result == "success") {
				alert(data.msg);
    			//parent.layer.close(index);
    			parent.location.reload();
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

<#list orderInfo as item>
<input id="userId" type="hidden" value="${item.USERID}"/>
<input id="orderId" type="hidden" value="${item.ORDERID}"/>
<input id="goodsId" type="hidden" value="${item.GOODSID}"/>
<input id="cmsSumMoney" type="hidden" value="${item.SUMMONEY}"/>
<input id="goodsNumber" type="hidden" value="${item.GOODSNUMBER}"/>
<input id="incomeMoney" type="hidden" value="${item.INCOMEMONEY}"/>
<input id="orderNo" type="hidden" value="${item.ORDERNO}"/>
<input id="orderFrom" type="hidden" value="${item.ORDERFROM}"/>
<input id="goodsName" type="hidden" value="${item.GOODSNAME}"/>
<input id="partitionId" type="hidden" value="${item.PARTITIONID}"/>
<input id="createTime" type="hidden" value="${item.CREATETIME}"/>
<input id="cmsType" type="hidden" value="${item.CMSTYPE}"/> 
<div id="orderInfo" style="margin-bottom: 10px;">
	<div>
		<span style="margin-right:10px">订单编码:</span><span>${item.ORDERNO}</span>
	</div>
	<div>
		<span style="margin-right:10px">能人编码:</span><span>${item.USERID}</span>
	</div>
		<div>
		<span style="margin-right:10px">订单来源:</span><span>${item.ORDERFROM}</span>
	</div>
	<div>
		<span style="margin-right:10px">生成时间:</span><span>${item.STARTDATE}</span>
	</div>
		<div>
		<span style="margin-right:10px">商品名称:</span><span>${item.GOODSNAME}</span>
	</div>
	<div>
		<span style="margin-right:10px">佣金总金额(元):</span><span>${item.SUMMONEY}</span>
	</div>
</div>
</#list>

<@form.form>
<div id="newPost">
<div>
<span><label style="color:red">*</label>调整金额：</span>
<span>
<input id="commission" type="text" placeholder="0.00">
</span><span style="color:red">(单位：元)</span>
</span><span style="color:red">(调减时需在金额前加"-")</span>
</div>
<div>
<span><label style="color:red">*</label>计算日期：</span>
<span>
<!---<input id="computeDate" type="text">--!>
<input type="text" value="${computeDate}" id="computeDate" class="inputStyle w140" name="computeDate" onclick="WdatePicker({readOnly:true,minDate:'#F{$dp.$D(\'computeDate\')}',dateFmt:'yyyyMMdd',maxDate:'#F{$dp.$D(\'computeDate\',{y:1})}'})" />
</span>
</div>
<div>
<span><label style="color:red">*</label>状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</span>
<span>
<select style="margin-left: 0px; width: 80px; height: 23px;" class="inputStyle w180" id="status" name="status" style="margin-left:6px;">
                     <option value="">请选择</option>
                     <#list cmsStatus as item>
            			<option value="${item.dataKey}">${item.dataValue}</option>
            		 </#list>
</select> 
</span>
</div>


<div>
<span><a class="e-btn btn-9 save-btn" style="cursor:pointer;" onclick="save()">保存</a></span>
</div>
</@form.form>