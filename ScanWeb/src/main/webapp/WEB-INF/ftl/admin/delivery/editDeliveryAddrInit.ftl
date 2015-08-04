<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
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
#oldAddr{
padding: 10px;
margin-top: 5px;
border: 1px solid #eed97c;
}

#newAddr{
padding: 10px;
margin-top: 5px;
border: 1px solid #eed97c;
}
#oldAddr div{
margin-top: 5px; 
margin-bottom: 5px;
}
#newAddr div{
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

.w230{
width:230px;
}

.inputda{
border: 1px solid #bbbbbb;
    height: 23px;
    line-height: 23px;
    padding: 0 2px;
}
.divnoline{
display:inline;
}
</style>

<script>
var index = parent.layer.getFrameIndex(window.name);

function queryCity(){
	var CSRFToken = $("input[name=CSRFToken]").val();
	var newProvince = $("#newProvince").val();
	//alert(newProvince);
	if(newProvince == "aa") {
		$("#newCity").val("bb");
		$("#newDistrict").val("cc");
	} else {
		document.getElementById("newCity").options.length=0
		document.getElementById("newCity").options.add(new Option("-----请选择地市------","bb"));
		document.getElementById("newDistrict").options.length=0
		document.getElementById("newDistrict").options.add(new Option("-----请选择区域------","bb"));
		$.ajax({
			url: "${rc.contextPath}/admin/am/delivery/queryProvCityDist",
			type: "POST",
			async: false,
			data: {"provinceCode":newProvince,"CSRFToken":CSRFToken},
			success: function(data) {
				//alert(data);
				for(var key in data){
					//alert(key);
					//alert(data[key])
					if(key == "allCity") {
					for(var ii in data[key]){
						 var cityCode=(data[key])[ii].ESS_CITY_CODE;
						 var cityName=(data[key])[ii].CITY_NAME;
						 //alert(cityCode+"|"+cityName);
						 document.getElementById("newCity").options.add(new Option(cityName,cityCode));
						}
						
					}
				}
			}
		});
	}
}

function queryDistrict(){
	var CSRFToken = $("input[name=CSRFToken]").val();
	var newProvince = $("#newProvince").val();
	var newCity = $("#newCity").val();
	//alert(newProvince);alert(newCity);
	if(newProvince == "aa") {
		alert("请选择省份!");
	} else {
		if(newCity == "bb"){
		}else {
		document.getElementById("newDistrict").options.length=0
		document.getElementById("newDistrict").options.add(new Option("-----请选择区域------","cc"));
			$.ajax({
			url: "${rc.contextPath}/admin/am/delivery/queryProvCityDist",
			type: "POST",
			async: false,
			data: {"provinceCode":newProvince,"cityCode":newCity,"CSRFToken":CSRFToken},
			success: function(data) {
				for(var key in data){
					//alert(key);
					//alert(data[key])
					if(key == "allDistrict") {
					for(var ii in data[key]){
						 var districtCode=(data[key])[ii].DISTRICT_CODE;
						 var districtName=(data[key])[ii].DISTRICT_NAME;
						// alert(districtCode+"|"+districtName);
						 document.getElementById("newDistrict").options.add(new Option(districtName,districtCode));
						}
						
					}
				}
			}
		});
		}
	}
}

function save(id){
	//alert(id);
	var CSRFToken = $("input[name=CSRFToken]").val();
	var addrType = id;
	var provinceCode = $("#newProvince").val();
	var cityCode = $("#newCity").val();
	var districtCode = $("#newDistrict").val();
	var postCode = $("#newPostCode").val();
	var postAddr = $("#newPostAddr").val();
	var linkman = $("#newLinkman").val();
	var linkPhone = $("#newLinkPhone").val();
		$.ajax({
			url: "${rc.contextPath}/admin/am/delivery/editAddrCommit",
			type: "POST",
			async: false,
			data: {"provinceCode":provinceCode,"cityCode":cityCode,"districtCode":districtCode,"postCode":postCode,"postAddr":postAddr,"linkman":linkman,"linkPhone":linkPhone,"addrType":addrType,"CSRFToken":CSRFToken},
			success: function(data) {
				if (data.result == "success") {
					alert(data.msg);
					parent.layer.close(index);
				}
			}
		});
 }

</script>


<div id="oldAddr">
	<div id="daTitle">
		<div>原${addrTypeInfo}地址信息</div>
	</div>
	<#if deliveryAddr??>
		<#list deliveryAddr as item>
		<input id="deliveryAddrType" type="hidden" value="${item.ADDR_TYPE}"/>
		<div>
		<label>省份：</label><input id="provinceName" name="provinceName" type="text" value="${item.PROVINCE_NAME}" readonly/> &nbsp;
		<label>地市：</label><input id="cityName" name="cityName" type="text" value="${item.CITY_NAME}" readonly/>	
		<label>区县：</label><input id="districtName" name="districtName" type="text" value="${item.DISTRICT_NAME}" readonly/>
		</div>
		<div><div class="divnoline">邮&nbsp;政&nbsp;编&nbsp;码:&nbsp;</div><input id="postCode" name="postCode" type="text" value="${item.POST_CODE}" readonly/>	</div>
		<div><div class="divnoline">详&nbsp;细&nbsp;地&nbsp;址:&nbsp;</div><input id="postAddr" name="postAddr" type="text" value="${item.POST_ADDR}" class="inputda w230" readonly/>	</div>
		<div><div class="divnoline">联系人姓名:</div><input id="linkman" name="linkman" type="text" value="${item.LINKMAN}" readonly/>	</div>
		<div><div class="divnoline">联&nbsp;系&nbsp;电&nbsp;话:&nbsp;</div><input id="linkPhone" name="linkPhone" type="text" value="${item.LINK_PHONE}" readonly/>	</div>
		</#list>
	</#if>
</div>

<@form.form>
<div id="newAddr">
	<div id="newdaTitle">
		<div>新${addrTypeInfo}地址信息</div>
	</div>
<div>
	<span>
		<label>省份：</label>
		<select id="newProvince" tabindex="1" style="margin-left:6px;" onchange="queryCity();" class="inputda">
           	  <option value="aa">-----请选择省份------</option>
           	<#list allProvince as item>
            	<option value="${item.ESS_PROVINCE_CODE}">${item.PROVINCE_NAME}</option>
            </#list>
		</select>
	</span>
	<span>
		<label>地市：</label>
		<select id="newCity" tabindex="1" style="margin-left:6px;" onchange="queryDistrict();" class="inputda">
           	  <div id="bb"><option value="bb">-----请选择地市------</option></div>
		</select>
	</span>
	<span>
		<label>区域：</label>
		<select id="newDistrict" tabindex="1" style="margin-left:6px;" class="inputda"> 
           	  <option value="cc">-----请选择区域------</option>
           	  <#if allCity??>
       	    	<#list allProvince as item>
            	<option value="${item.PROVINCE_CODE}">${item.PROVINCE_NAME}</option>
            	</#list>
           	  </#if>
		</select>
	</span>
</div>
<div><div class="divnoline">邮&nbsp;政&nbsp;编&nbsp;码:&nbsp;</div><input id="newPostCode" name="postCode" type="text" class="inputda"/></div>
<div><div class="divnoline">详&nbsp;细&nbsp;地&nbsp;址:&nbsp;</div><input id="newPostAddr" name="postAddr" type="text" class="inputda w230"/></div>
<div><div class="divnoline">联系人姓名:</div><input id="newLinkman" name="linkman" type="text" class="inputda"/></div>
<div><div class="divnoline">联&nbsp;系&nbsp;电&nbsp;话:&nbsp;</div><input id="newLinkPhone" name="linkPhone" type="text" class="inputda"/></div>
<span><a class="e-btn btn-9 save-btn" style="cursor:pointer;" onclick="save('${addrType}')">保存</a></span>
</div>

</@form.form>