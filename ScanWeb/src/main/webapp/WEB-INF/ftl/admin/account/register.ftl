<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<!DOCTYPE html>
<html>
<head>
    <title>代理商加盟</title>
    <link rel="stylesheet" type="text/css" href="${e.res('/js/jquery.easyui/themes/metro/easyui.css')}">
	<link rel="stylesheet" type="text/css" href="${e.res('/js/jquery.easyui/themes/icon.css')}">
	<link rel="stylesheet" type="text/css" href="${e.res('/js/jquery.easyui/demo/demo.css')}">
    <link href="${e.res('/images/favicon.ico')}" type="image/x-icon" rel="shortcut icon">
    <link rel="stylesheet" type="text/css" href="${e.res('/css/login.css')}"/>
    <link rel="stylesheet" type="text/css"  href="${e.res('/js/jquery/validate.css')}" />
    <link href="${e.res('/js/fineuploader/fineuploader-4.4.0.min.css')}" rel="stylesheet" type="text/css" />
    <link href="${e.res('/js/jqueryui/css/ui-lightness/jquery-ui-1.10.4.custom.min.css')}" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
	<script type="text/javascript" src="${e.res('/js/jquery/jquery.validate.min.js')}" ></script>
	<script type="text/javascript" src="${e.res('/js/jquery/messages_bs_zh.js')}" ></script>
    <script type="text/javascript" src="${e.res('/js/jquery/jquery.form.js')}"></script>
    <script type="text/javascript" src="${e.res('/js/card.js')}"></script>
	<script type="text/javascript" src="${e.res('/js/fineuploader/all.fineuploader-4.4.0.min.js')}"></script>
    <script type="text/javascript" src="${e.res('/js/jqueryui/js/jquery-ui-1.10.4.custom.min.js')}"></script>
    <!-- Include wTooltip -->
    <link rel="Stylesheet" type="text/css" href="${e.res('/js/wTooltip/wTooltip.css')}" />
    <script type="text/javascript" src="${e.res('/js/wTooltip/wTooltip.js')}"></script>

	<style>

     .errmsg{
         font-size: 11px;
         font-family: 微软雅黑;
         font-weight: bold;
         color:red;
         margin-left: 5px;
     }
     
     #thumbnail-fine-uploader{
     	margin-left: 100px;
     }
     .divshow {
    border-top: 1px dotted #dbdbdb;
    margin-left: 10px;
    width: 770px;
    margin-left: 50px; 
    padding-top: 10px;
    }
    
    .grayfont {
    color: #a5a5a5;
	}
	
	.clsPic{
	 width:432px;
	 height:272px;
	}
	.clsPic1{
		width:214px;
		height:135px;
		border:1px dashed #B2A6D2;
		text-align:center;
		line-height:220px;
		font-size:40px;
		float:left;
	}
	.clsPic2{
		width:214px;
		height:135px;
		border:1px dashed #B2A6D2; 
		text-align:center;
		line-height:220px;
		font-size:40px;
		float:left;
	}
	
	.usererruncheck {
	    background: url(${e.res('/js/jquery/images/unchecked.gif')}) no-repeat scroll 0 0 rgba(0, 0, 0, 0);
	    color: #ea5200;
	    font-family: 微软雅黑;
	    font-size: 9pt;
	    margin-left: 1em;
	    padding-bottom: 2px;
	    padding-left: 16px;
	}
	.usererrsuccess {
	    background: url(${e.res('/js/jquery/images/success.gif')}) no-repeat scroll 0 0 rgba(0, 0, 0, 0);
	    color: green;
	    font-family: 微软雅黑;
	    font-size: 9pt;
	    margin-left: 1em;
	    padding-bottom: 2px;
	    padding-left: 16px;
	}
	</style>
	<script>
	  $(function(){	

		
          
          jQuery.validator.addMethod("isMobile", function(value,element) {
              var length = value.length;
              var mobile = /^0?(13[0-9]|15[012356789]|18[0-9]|14[57]|17[0-9])[0-9]{8}$/;
              return this.optional(element) || (length == 11 && mobile.test(value));

          }, "手机号码格式不正确");

		  jQuery.validator.addMethod("idCard", function(value,element) {
          	  if(this.optional(element)){
          	  	return true;
          	  }else{
          	     if($("#identityType").val() == "1"){
              	  	if(!idCardNoUtil.checkIdCardNo(value)){
              	  		return false;
              	  	}
              	  }
          	  }
              return true;

          }, "身份证格式不正确");
          
          jQuery.validator.addMethod("noCh", function(value,element) {
              var length = value.length;
              var name = /^([a-zA-Z]|\d|_)*$/;
              return this.optional(element) || (name.test(value) );

          }, "字母、数字或下划线");

          jQuery.validator.addMethod("psCk", function(value,element) {
              var length = value.length;
              var reg = /^(?:(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])|(?=.*[A-Z])(?=.*[a-z])(?=.*[^A-Za-z0-9])|(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])|(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9])).{6,20}$/;
              return this.optional(element) || (reg.test(value) );

          }, "6-20位数字、大小写字母或特殊字符(4选3)");
		
		var validator = $('#registerForm').validate({
            rules:{
                identityNum:{
                    required: true,
                    maxlength:18
                },
                accountHolder: {
                    required: true,
                    maxlength:20
                },
                accountNumber: {
                    required: true,
                    maxlength:100
                },
                password: {
                    required: true,
                    minlength: 6,
                    maxlength:20
                },
                confirmpwd: {
                    required: true,
                    minlength: 6,
                    maxlength:20,
                    equalTo: "#password"
                }
            }
        });
		//重置 
        $('#reset').click(function(){ 
               validator.resetForm();
        });

      });
</script>

<script language="javascript" type="text/javascript">

		  $(document).ready(function(){
			  $('#userLevel').change(function(){
			   	var value = $('#userLevel').val();
			   	if(value == '0'){
			   		$('#areano').prop("disabled", true);
                    $('#areano').val("*");
			   	}else{
			   		$('#areano').prop("disabled", false);
			   	}
			  });

 			$('#areano').change(function(){
			   		var value = $('#areano').val();
                    $('#belongArea').val(value);
			  		});
			  		
          $('#registerForm').ajaxForm({
          
          	  target:        '#output1',
              beforeSubmit:  function(formData, jqForm, options){
	              	if($("#identityType").val() == "1"){
		              	 if($("#identityPic1").val()==""||$("#identityPic2").val()==""){
				 			alert("请上传身份证正反面2张图片！");
				 			return false;
			 			}
	              	}
                  if($("#userLevel").val() == "*"){
                      $("#errLevel").text("请选择代理商级别！");
                      $("#errLevel").show();
                      return false;
                  }
                  if($("#identityType").val() == "*"){
                      $("#errIdtype").text("请选择证件类型!");
                      $("#errIdtype").show();
                      return false;
                  }
                  if($("#openBank").val() == "*"){
                      $("#errBank").text("请选择佣金账户类型!");
                      $("#errBank").show();
                      return false;
                  }
                  if($("#userLevel").val() == "1" && $("#areano").val() == "*"){
                      $("#errArea").text("请选择销售范围!");
                      $("#errArea").show();
                      return false;
                  }
                  return true;
              },
              success: function(json){
                  var result = eval(json);
                  if(result.status){
                      window.location.href="${rc.contextPath}/agent/register/registerSuccess";
                  }else{
                      if(result.error == "1001"){
                          $("#errLevel").text(result.errorMsg);
                          $("#errLevel").show();
                      }
                      if(result.error == "1002"){
                          $("#errIdtype").text(result.errorMsg);
                          $("#errIdtype").show();
                      }
                      if(result.error == "1003"){
                          $("#errArea").text(result.errorMsg);
                          $("#errArea").show();
                      }
                      if(result.error == "1004"){
                          $("#errBank").text(result.errorMsg);
                          $("#errBank").show();
                      }
                      if(result.error == "1005"){
                          $("#errIdnum").text(result.errorMsg);
                          $("#errIdnum").show();
                      }
                      if(result.error == "1006"){
                          $("#errChannelType").text(result.errorMsg);
                          $("#errChannelType").show();
                      }
                      if(result.error == "1007"){
                      	  $("#errUser").text("");
                          $("#errUser").text(result.errorMsg);
                          $("#errUser").show();
                      }
                      if(result.error == "1008"){
                          $("#errMobile").text(result.errorMsg);
                          $("#errMobile").show();
                      }
                       if(result.error == "1009"){
                          $("#errAccountHolder").text(result.errorMsg);
                          $("#errAccountHolder").show();
                      }
                       if(result.error == "1010"){
                          $("#errAccountNumber").text(result.errorMsg);
                          $("#errAccountNumber").show();
                      }
                      if(result.error == "1011"){
                          $("#errDevelopCode").text(result.errorMsg);
                          $("#errDevelopCode").show();
                      }
                      if(result.error == "1012"){
                          $("#errDevelopCode").text(result.errorMsg);
                          $("#errDevelopCode").show();
                      }
                      if(result.error == "9999"){
                          alert(result.errorMsg);
                      }

                  }
              }
          });


           $("#userLevel").change(function(){
               if($("#userLevel").val() != "*"){
                   $("#errLevel").hide();
               }
           });
              $("#identityType").change(function(){
                  if($("#identityType").val() != "*"){
                      $("#errIdtype").hide();
                  }
              });
              $("#openBank").change(function(){
                  if($("#openBank").val() != "*"){
                      $("#errBank").hide();
                  }
              });

              $("#areano").change(function(){
                  if($("#areano").val() != "*"){
                      $("#errArea").hide();
                  }
              });

              $("#mobile").focus(function(){
                  $("#errMobile").hide();
              });

              $("#identityNum").focus(function(){
                  $("#errIdnum").hide();
              });
        });


         var pre = function(el)
          {
              el.style.color = "black";
          }
        var cls = function(){
            $("#username").val("");
        }
</script>

<script>
    function inputTipText(){
        $("input[tipMsg]").each(function(){
            if($(this).val() == ""){
                var oldVal=$(this).attr("tipMsg");
                if($(this).val()==""){$(this).attr("value",oldVal).css({"color":"#888"});}
                $(this)
                        .css({"color":"#888","font-size":"13px"})     //灰色
                        .focus(function(){
                            if($(this).val()!=oldVal){$(this).css({"color":"#000"})}else{$(this).val("").css({"color":"#888"})}
                        })
                        .blur(function(){
                            if($(this).val()==""){$(this).val(oldVal).css({"color":"#888"})}
                        })
                        .keydown(function(){$(this).css({"color":"#000"})});
            }
        });
    }
</script>
    <script type="text/javascript">
        $(function(){
            inputTipText();  //初始化Input的灰色提示信息
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
        //商户号提醒
         	$("#username").blur(function(){
         		if(this.value !=this.defaultValue && this.value != "") {
         			if (this.value.length >= 6 && this.value.length <= 30) {
         			var CSRFToken = $("input[name=CSRFToken]").val();
	         				$.ajax({
								url: "${rc.contextPath}/agent/register/checkusername",
								type: "POST",
								async: false,
								data: {"username":this.value,"CSRFToken":CSRFToken},
								success: function(data) {
									if (data.result == "success") {
											$("#errUser").text(data.msg);
	                          				$("#errUser").show();
											if(data.colorSwitch == "0") {
												$("#errUser").removeClass("usererruncheck");
												$("#errUser").addClass("usererrsuccess");
												//$("#errUser").css("color","green");
											}
										}
									}
								});
         			}else if(this.value.length < 6 && this.value.length > 0){
         				$("#errUser").removeClass("usererrsuccess");
						$("#errUser").addClass("usererruncheck");
         				$("#errUser").text("长度小于6");
	                    $("#errUser").show();
         			}else if(this.value.length > 30 ){
         				$("#errUser").removeClass("usererrsuccess");
						$("#errUser").addClass("usererruncheck");
         				$("#errUser").text("长度大于30");
	                    $("#errUser").show();
         			}
         			}else if(this.value ==this.defaultValue){
         				$("#errUser").removeClass("usererrsuccess");
						$("#errUser").addClass("usererruncheck");
         				$("#errUser").text("必填字段");
	                    $("#errUser").show();
         			}
         			
				});
            
            $("#username").wTooltip({
                title: "字母、数字或下划线"
            });
            $("#password").wTooltip({
                title: "6-20位数字、大小写字母或特殊字符(4选3)"
            });
            $("#mobile").wTooltip({
                title: "仅限联通手机号码"
            });
        });
        
      
    </script>
<!--上传身份证 -->
<script type="text/javascript">
function changeIdentityType(value){
var aa=$("#identityType").val();
if(aa != "1") {
$("#checkFormDiv").toggle();
$("#idforchangeiden tr:eq(1)").children("td").eq(0).height(0);
$("#idforchangeiden tr:eq(1)").height(0);
}else{
$("#checkFormDiv").toggle();
$("#idforchangeiden tr:eq(1)").children("td").eq(0).height(323);
$("#idforchangeiden tr:eq(1)").height(50);
}


}

$(document).ready(function(){
	var uploadFiles=[];
	var uploadImgIdx=0;
	var uploader = $('#thumbnail-fine-uploader').fineUploader({
					template: "qq-template",
					request : {
						endpoint : '${e.hostFile}/agent/file/upload/addIdentity.do'
					},
					editFilename: {
				        enabled: true
				    },
				    autoUpload: true,
					params:{
						termId:'',
						idx:'0'
					},
					validation : {
						allowedExtensions : [ 'jpeg',
								'jpg', 'gif', 'png' ],
						sizeLimit: 1153152,//5M
						itemLimit : 2
					},
					text : {
						uploadButton : '上传图片',
						dropProcessing : ''
					},
					deleteFile : {
						enabled : false
					},
					retry : {
						enabled : false
					},
					
					callbacks: {
						onSubmit:function(id,fileName){
							finalParams={};
							finalParams.idx=uploadImgIdx;
							uploader.fineUploader('setParams', finalParams);
						},
						onComplete:function(id, fileName,rsp) {
							var json=rsp;
							if (json.success) {
								uploadImgIdx++;
								if(uploadImgIdx==1) {
								$("#identityPic1").val(json.picUrl);
								$("#id_pic1").html("<img src='"+json.host+json.picUrl+"' style='width: 299px; height: 240px;'/>");
								}
								if(uploadImgIdx==2) {
								$("#identityPic2").val(json.picUrl);
								$("#id_pic2").html("<img src='"+json.host+json.picUrl+"' style='width: 299px; height: 240px;'/>");
								}
							} else {
								alert(fileName+"上传失败."+json.error);
							}
						}
					}
					
				});
				
});
</script>
<script type="text/template" id="qq-template">
    <div class="qq-uploader-selector qq-uploader" >
        <div class="qq-upload-drop-area-selector qq-upload-drop-area" qq-hide-dropzone>
            <span>Drop files here to upload</span>
        </div>
        <div id="uploadselector">
            <div class="qq-upload-button-selector qq-upload-button">上传</div>
        </div>
        
        <ul class="qq-upload-list-selector qq-upload-list" style="display:none;">
            <li style="margin-left: 75px;width: 600px;">
                <div class="qq-progress-bar-container-selector">
                    <div class="qq-progress-bar-selector qq-progress-bar"></div>
                </div>
                <span class="qq-upload-spinner-selector qq-upload-spinner"></span>
                <span class="qq-upload-file-selector qq-upload-file"></span>
                <span class="qq-upload-size-selector qq-upload-size"></span>
                <a class="qq-upload-cancel-selector qq-upload-cancel" href="#">取消</a>
                <span class="qq-upload-status-text-selector qq-upload-status-text"></span>
            </li>
        </ul>
    </div>
</script>

<!--协议代理商渠道选择 -->
<script language="javascript" type="text/javascript">
	function channelTypeChange(value) 
	{
		var areano=$("#areano").val()
	   if(value == "4") {
	   	if(areano == "*"){
	   	alert("请确认销售范围！");
	   	$("#channelType").val("3");
	   	}else {
	   	$('#channelName').prop("disabled", false);
	   	$('#channelName').prop("placeholder", "输入渠道编码或渠道名查询");
	   	$('#developName').prop("disabled", false);
	   	$('#developName').prop("placeholder", "输入发展人名称查询");
	   	$("#tcquery").css("display","inline-block");
	   	}
	   } else {
	   	$('#channelName').val("");
	   	$('#channelName').prop("disabled", true);
	   	$('#channelName').removeAttr("placeholder");
	   	$('#developName').val("");
	   	$('#developName').prop("disabled", true);
	   	$('#developName').removeAttr("placeholder");
	   	$("#tcquery").css("display","none");
	   }
	}
	
</script>

<!--渠道弹窗查询 -->
<script  language="javascript" type="text/javascript">
function openChild(){
if(window.ActiveXObject){ //IE
		var cityCode=$("#areano").val();
		var iWidth=1050; 
		var iHeight=1000; 
		var iTop = (window.screen.availHeight-30-iHeight)/2; 
		var iLeft = (window.screen.availWidth-10-iWidth)/2; 
		var returnValue = window.open("${rc.contextPath}/agent/register/regisQueryChannel?cityCode="+cityCode+"&xxx=" + Math.random(), 'newwindow','height=1000,width=1050,top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		
		if(returnValue != null ){
			setValue(returnValue.ccode,returnValue.cname,returnValue.dcode,returnValue.dname);
			}

	}else{  //非IE
		var cityCode=$("#areano").val();
		var iWidth=1050; 
		var iHeight=1000; 
		var iTop = (window.screen.availHeight-30-iHeight)/2; 
		var iLeft = (window.screen.availWidth-10-iWidth)/2; 
		window.open("${rc.contextPath}/agent/register/regisQueryChannel?cityCode="+cityCode+"&xxx=" + Math.random(), 'newwindow','height=1000,width=1050,top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
}
}

function setValue(ccode,cname,dcode,dname){
$("#channelCode").val(ccode);
$("#channelName").val(cname);
$("#developCode").val(dcode);
$("#developName").val(dname);
}

</script>
</head>
<body>
	<div class="logobox"><div class="logo"><span>互联网云平台</span></div></div>
		
		  <div class="signup-cont">
			<div id="output1" style="display:none"></div>
    	<@form.form action="${rc.contextPath}/agent/register/signup"  method="post"  id="registerForm">
        	<h3 class="subtitle">代理商加盟</h3>
			
			
            <table border="0" align="center" class="f-line" style="padding:15px 15px 15px 15px;" >
            	
            
                <tr>
                    <td colspan="2">
                        <label style="color:red;font-size: 13px;margin-left:60px;width: 800px;text-align:left;">请填写加盟信息。注意： * 为必填字段</label>
                    </td>
                </tr>

                <tr >
                    <td >
                        <label><span class="star">*</span>代理商级别:</label>
                       <select class="m-sel required" id="userLevel" name="userLevel" tabindex="1" style="margin-left:6px;">
                            <option value="1" selected>市级</option>
                           <#-- <option value="*">请选择</option>
                            <option value="0">省级</option>-->
                        </select> 
                          <#-- <span id="errLevel" class="errmsg" style="display: none;"></span> -->
                         
                         
                    </td>
                    <td >
                        <label><span class="star">*</span>商户号<span style="color: #E26E18">(登录帐号)</span>:</label>
                        <input type="text" class="m-txt noCh" maxlength = "30" id="username" name="username"
                                                                                   tabindex="10" tipMsg = "字母、数字、下划线"/>
                        <span id="errUser" class="usererruncheck" style="display: none;"></span>

                    </td>


                </tr>

                <tr >
                    <td >
                        <label><span class="star">*</span>销售范围:</label>
                        <select class="m-sel required" id="areano" name="areano" tabindex="2" style="margin-left:6px;">
                            <option value="*">请选择</option>
                            <#list citys as city>
                                <option id="cityCode" value="${city.cityCode}">${city.cityName}</option>
                            </#list>
                        </select>
                        <span id="errArea" class="errmsg" style="display: none;"></span>
                    </td>
                    <td style="width: 574px;">
                        <label><span class="star">*</span>登录密码:</label><input type="password" maxlength = "20" class="m-txt required psCk" id="password" name="password" tabindex="11" />
                    </td>
                </tr>
                
                <tr >
                    <td >
                        <label><span class="star">*</span>归属地市:</label>
                        <select class="m-sel required" id="belongArea" name="belongArea" tabindex="2" style="margin-left:6px;">
                            <option value="*">请选择</option>
                            <#list citys as city>
                                <option value="${city.cityCode}">${city.cityName}</option>
                            </#list>
                        </select>
                        <span id="errArea" class="errmsg" style="display: none;"></span>
                    </td>
                    <td style="width: 574px;">
                        <label><span class="star">*</span>确认密码:</label><input type="password"  maxlength = "20" class="m-txt required psCk" id="confirmpwd" name="confirmpwd" tabindex="12"/>
                    </td>
                    
                </tr>
				
				

                <tr >
                   <td >
                    <label><span class="star">*</span>代理商名称:</label><input type="text" class="m-txt required" id="agentname" name="agentname"  tabindex="5"/>
                    </td> 
					<td >
                        <label><span class="star">*</span>手机号码<span style="color: #E26E18">(限联通)</span>:</label><input type="text" maxlength = "11" class="m-txt required isMobile" id="mobile" name="mobile" tabindex="16" tipMsg = "仅限联通手机号码"/>
                        <span id="errMobile" class="errmsg" style="display: none;"></span>
                    </td>
                </tr>

                
                
                <tr>
                 <td >
                        <label><span class="star">*</span>渠道类型:</label>
                        <select class="m-sel required" id="channelType" name="channelType" tabindex="15" style="margin-left:6px;" onchange="channelTypeChange(this.value)">
                            <#--<option value="*">请选择</option>-->

                            <#list channelTypes as channelType>
                                <option value="${channelType.dataKey}"  <#if "3" == "${channelType.dataKey}">selected</#if> >${channelType.dataValue}</option>
                            </#list>

                        </select>
                        <span id="errChannelType" class="errmsg" style="display: none;"></span>
                    </td>
                </tr>
				<tr>
				  <td colspan="2">
                	<label><span class="star">*</span>渠道名称:</label>
                	<input type="text" class="m-txt required"  id="channelName" name="channelName" disabled="true" style="width:400px;"/>
                	<input type="hidden" id="channelCode" name="channelCode" />
                	<span id="tcquery" style="display: none;"><span class="l-btn-left l-btn-icon-left" onclick="openChild()" style="cursor:pointer;"><span class="l-btn-text" >查询</span><span class="l-btn-icon icon-search">&nbsp;</span></span></span>
                	<span id="errChannelName" class="errmsg" style="display: none;"></span>
                	
                  </td>
				</tr>
				<tr>
				  <td colspan="2">
                	<label><span class="star">*</span>发展人:</label>
                	<input type="text" class="m-txt required"  id="developName" name="developName" disabled="true" style="width:400px;" onclick="checkChannel()"/>
                	<input type="hidden" id="developCode" name="developCode" />
                	<span id="errDevelopCode" class="errmsg" style="display: none;"></span>
                  </td>
				</tr>
				<tr >
                    <td >
                        <label><span class="star">*</span>佣金账户类型:</label>
                        <select class="m-sel required" id="openBank" name="openBank" tabindex="6" style="margin-left:6px;">
                        <#--<option value="*">请选择</option>-->
                        <#list banks as bank>
                        <option value="${bank.dataKey}">${bank.dataValue}</option>
                        </#list>
                        </select>
                        <span id="errBank" class="errmsg" style="display: none;"></span>
                    </td>
                     <td>
                        <label>有无店面:</label>
                        <input type="radio" id="isStore" name="isStore" value="1" style="margin-left:10px;" tabindex="17"/><span>有</span>
                        <input type="radio" class="l-space"  name="isStore"  value="0"   style="margin-left:10px;" tabindex="18" checked/><span>无</span>
                    </td>
                   

                </tr>
                <tr >
                    <td >
                     <label><span class="star">*</span>支付宝姓名:</label><input type="text" class="m-txt required"  id="accountHolder" name="accountHolder"   tabindex="7"/>
                     <span id="errAccountHolder" class="errmsg" style="display: none;"></span>
                     </td>
                    <td >
                    	<label><span class="star">*</span>支付宝账号:</label><input type="text" class="m-txt required" maxlength="100" id="accountNumber" name="accountNumber"   tabindex="8"/>
                    	<span id="errAccountNumber" class="errmsg" style="display: none;"></span>
                    </td>
                </tr>

   				</tr>
				     <tr>
                    <td >
                        <label>邮箱:</label><input type="text" class="m-txt email" id="email" name="email" tabindex="13"/>
                    </td>
                    <td >
                    <label>QQ:</label><input type="text" class="m-txt"  id="qq" name="qq"  maxlength="20"  tabindex="14"/>
                    </td>
                </tr>
                <tr >
                    
                   

                </tr>
                <tr>
                    <td colspan="2">
                        <label>联系地址:</label>
                        <input type="text"  class="m-txt" id="address" name="address" tabindex="9"   style="width:320px;" />
                    </td>
             
				
				</tr>

           </table>
            
            <div class="divshow">
            	<span class="grayfont">根据联通协议,注册用户需上传证件信息(目前仅身份证),请依次上传证件正、反面</span>
            </div>
           
           
			<table border="0" class="f-line" style="padding: 15px 15px 0px;" id="idforchangeiden">
            	 <tr >
                    <td >
                        <label><span class="star">*</span>证件类型:</label>
                        <select class="m-sel" id="identityType" name="identityType" tabindex="3" style="margin-left:6px;" onchange="changeIdentityType(this)">
                            <#--<option value="*">请选择</option>-->
                            <#list idTypes as type>
                                <option value="${type.dataKey}" <#if "1"=="${type.dataKey}">selected="" </#if>>${type.dataValue}</option>
                            </#list>
                        </select>
                        <span id="errIdtype" class="errmsg" style="display: none;"></span>
                    </td>
                     <td >
                        <label><span class="star">*</span>证件号码:</label><input type="text" class="m-txt required idCard" maxlength = "18" id="identityNum" name="identityNum"  tabindex="4" tipMsg = "请输入证件号码"/>
                        <span id="errIdnum" class="errmsg" style="display: none;"></span>
                    </td>

                </tr>
            	
            	<#-- 上传身份证 -->
            	<tr style="height:50px;">
            		<td colspan="2" style="padding-bottom: 0px;width: 924px; height:323px;">
						<div class="bgtx" id="checkFormDiv">
							<input name="identityPic1" id="identityPic1" type="hidden"/>
							<input name="identityPic2" id="identityPic2" type="hidden"/>
							<div class="NO3" id="uploadInfo">
								<ul>
									<#--<label style="color:red;font-size: 13px;margin-left: 60px;width: 800px;text-align:left;">上传身份证信息:身份证正面,身份证反面(请按顺序上传)</label>-->
									<div id="thumbnail-fine-uploader"></div>
								</ul>
							</div>
							<div id="output1" style="display:none"></div>
							<div class="clsPic" style="width: 850px; margin-top: 20px; padding-bottom: 0px;margin-left: 70px;">
								<div id="id_pic1" style="width: 400px; height: 240px; margin-right: 5px;margin-left:auto; margin-right:auto;" class="clsPic1">正面</div>
								<div id="id_pic2" class="clsPic2" style="width: 400px; height: 240px; margin-left: 5px;">反面</div>
							</div>
						</div>
           		   </td>
            	</tr>
            </table>
            
            <div class="btn-area" style="float:top;">
               <input type="submit" value="提 交" style="background-color:#880000;" class="btn"/>
               <input type="reset" value="重 置" class="btn g-btn" id="reset"/>
            </div>
        </@form.form>
    </div>
    <div class="footer">
    	<p>中国联合网络通信有限公司贵州分公司  版权所有 </p>
        <p>中华人民共和国增值电信业务经营许可证 经营许可证编号：A2.B1. B2-20090003</p>
    </div>

</body>
</html>