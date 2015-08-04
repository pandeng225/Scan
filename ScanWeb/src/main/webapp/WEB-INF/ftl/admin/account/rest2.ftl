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
		//text-align:center;
	}
	</style>
<script>
	  $(function(){
          jQuery.validator.addMethod("psCk", function(value,element) {
              var length = value.length;
              var reg = /^(?:(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])|(?=.*[A-Z])(?=.*[a-z])(?=.*[^A-Za-z0-9])|(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])|(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9])).{6,20}$/;
              return this.optional(element) || (reg.test(value) );

          }, "6-20位数字、大小写字母或特殊字符(4选3)");
           $('#restForm').validate({
              rules:{
                  password: {
                      required: true,
                      minlength: 6,
                      maxlength:20
                  },
                  rpassword: {
                      required: true,
                      minlength: 6,
                      maxlength:20,
                      equalTo: "#password"
                  }
              }
          });

         $('#restForm').ajaxForm({
         		beforeSubmit:  function(formData, jqForm, options){
         			if($("input[name='checkCode']").val()==""){
			 			$("#error").text("请填写校验码");
			 			return false;
			 		}
			 		if($("input[name='password']").val()==""){
			 			$("#error").text("请填写设置密码");
			 			return false;
			 		}
			 		if($("input[name='rpassword']").val()==""){
			 			$("#error").text("请填写确认密码");
			 			return false;
			 		}
			 		if($("input[name='rpassword']").val()!=$("input[name='password']").val()){
			 			$("#error").text("重复密码不一致");
			 			return false;
			 		}
			 		$("#error").text("提交中...");
			 		return true;
		 		},
	              success: function(json){
	                  var result = eval(json);
	                  if(result.success){
                          $("#restForm").hide();
	                      $("#success").html('重置密码成功,请<a href="${rc.contextPath}/admin/am/login">登录</a>');
	                      $("#sucDiv").show();
	                  }else{
	                      $("#error").text(result.errorMsg);
	                      $("#error").show();
	                  }
	              }
	          });

      });
      

</script>

</head>
<body>
	
	<div class="logobox"><div class="logo"><span>贵州联通电子商务营销服务平台</span></div></div>
    <div class="login-cont">
    	<div>
    	<@form.form method="post" action="${rc.contextPath}/admin/am/register/rest/submitPwd" id="restForm">
            <div id="error" style="display:none"></div>
	    	<div class="f-line restTitle">
		  		您在重置<b style="color:red;margin:0 5px 0 5px;">${agentName}</b>的密码
            </div>
            
        	<div class="f-line">
		  		<label>短信验证码:</label><input type="text" id="checkCode" name="checkCode"  value="" class="l-txt required"
            	 	 autocomplete="off" style="height:30px;"/>
            </div>
        	<div class="f-line">
            	<label>设置密码:</label><input type="password" class="m-txt required psCk"  maxlength = "20" style="height:30px;" id="password" name="password"/>
            </div>
            <div class="f-line">
            	<label>确认密码:</label><input type="password" class="m-txt required psCk" maxlength = "20" style="height:30px;" name="rpassword"/>
            </div>
            <div class="btn-area">
                <input type="button" value="上一步" class="btn" style="margin-left:10px;background-color:#B23AEE;" onclick="location.href='../../../../'"/>
            	<input type="submit" value="下一步" class="btn" />
            </div>
            
        </@form.form>
            <div style="display: none;padding-top:96px;padding-left:81px;" id="sucDiv">
                <span style="color:#EA5200;font-size:18px;" id="success"></span>
            </div>
        </div>
    </div>
    <div class="footer">
    	<p>中国联合网络通信有限公司贵州分公司  版权所有 </p>
        <p>中华人民共和国增值电信业务经营许可证 经营许可证编号：A2.B1. B2-20090003</p>
    </div>
</body>
</html>