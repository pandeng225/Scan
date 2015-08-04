<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<!DOCTYPE html>
<html>
<head>
    <title>帐号密码重置</title>
    <link href="${e.res('/images/favicon.ico')}" type="image/x-icon" rel="shortcut icon">
    <link rel="stylesheet" type="text/css" href="${e.res('/css/login.css')}"/>
    <link rel="stylesheet" type="text/css"  href="${e.res('/js/jquery/validate.css')}" />
	<script type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
	<script type="text/javascript" src="${e.res('/js/jquery/jquery.validate.min.js')}" ></script>
	<script type="text/javascript" src="${e.res('/js/jquery/messages_bs_zh.js')}" ></script>
    <script type="text/javascript" src="${e.res('/js/jquery/jquery.form.js')}"></script>

	<style>
		#error{
	    //position: absolute;
	    //top:123px;
	    //left:273px;
	    z-index: 11;
	    line-height: 30px;
        color:#EA5200;
        font-family:微软雅黑;
        font-size:9pt;
	}
	#error{
        //background:url(${e.res('/images/temp/error.gif')}) 0px 0px no-repeat;
	    display: inline-block;
	    height: 20px;
	    width:300px;
	    margin-right: -3px;
	    vertical-align: middle;
	}
	.login-cont{
	background:none;
	background-color:#f7f7f7;
	padding-top:60px;
	}
	.restTitle{
		font-size:20px;
		text-align:center;
	}
	</style>
<script>
	  $(function(){	
         $('#restForm').ajaxForm({
         		beforeSubmit:  function(formData, jqForm, options){
			 		if($("#username").val()==""){
			 			$("#error").text("请填写帐号");
			 			return false;
			 		}
			 		if($("#captchaCode").val()==""){
			 			$("#error").text("请填写校验码");
			 			return false;
			 		}
			 		$("#error").text("校验中...");
			 		return true;
		 		},
	              success: function(json){
	                  var result = eval(json);
	                  if(result.success){
	                      window.location.href="${rc.contextPath}/admin/am/register/rest/inputCode";
	                  }else{
	                      $("#error").text(result.errorMsg);
	                      $("#error").show();
	                  }
	              }
	          });

      });
      
      function changeCode() {
			 document.getElementById("captchaImage").src = '${rc.contextPath}/admin/am/loginCaptcha.jpg'+ '?'+Math.floor(Math.random()*100);
		 }
</script>

</head>
<body>
	
	<div class="logobox"><div class="logo"><span>贵州联通电子商务营销服务平台</span></div></div>
    <div class="login-cont">
    	<div class="form">
    	<@form.form method="post" action="${rc.contextPath}/admin/am/register/rest/checkAccount" id="restForm">
            <div id="error"></div>
	    	<div class="f-line restTitle">
		  		请输入您要找回密码的商户号
            </div>
            
        	<div class="f-line">
		  		<label>账号:</label><input type="text" id="username" name="username"  value="" class="l-txt required"
            	 	 autocomplete="off" style="height:30px;"/>
            </div>
                       	
        	<div class="f-line">
            	<label>验证码:</label><input type="text" class="m-txt" style="width:97px;height:30px;" id="captchaCode" name="captchaCode"/>
            	<span class="checkcode">
            		<img id = "captchaImage" src="${rc.contextPath}/admin/am/loginCaptcha.jpg" onclick="changeCode()" style="width:135px;"/>
            	</span>
            	
            </div>
            <div class="btn-area">
            	<input type="submit" value="下一步" class="btn" style="margin-left:15px;" />
            </div>
            
        </@form.form>
        </div>
    </div>
    <div class="footer">
    	<p>中国联合网络通信有限公司贵州分公司  版权所有 </p>
        <p>中华人民共和国增值电信业务经营许可证 经营许可证编号：A2.B1. B2-20090003</p>
    </div>
</body>
</html>