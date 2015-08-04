<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<!DOCTYPE html>
<html>
<head>
    <title>用户登陆</title>

    <link href="${e.res('/images/favicon.ico')}" type="image/x-icon" rel="shortcut icon">
    <link rel="stylesheet" type="text/css" href="${e.res('/css/login.css')}"/>
    <link rel="stylesheet" type="text/css" href="${e.res('/js/jquery/validate.css')}"/>
    <script type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
    <script type="text/javascript" src="${e.res('/js/jquery/jquery.validate.min.js')}"></script>
    <script type="text/javascript" src="${e.res('/js/jquery/messages_bs_zh.js')}"></script>


    <style>
        #error {
            position: absolute;
            top: -16px;
            left: 65px;
            z-index: 11;
            line-height: 30px;
            color: #EA5200;
            font-family: 微软雅黑;
            font-size: 9pt;
        }

        #error i {
            background: url(${e.res('/images/temp/error.gif')}) 0px 0px no-repeat;
            display: inline-block;
            height: 20px;
            width: 18px;
            margin-right: -3px;
            vertical-align: middle;
        }
        a:link{color:blue}
        a:visited {color: #2a00ff}
        a:hover {color: #4bab33}
        a:active {color: #ff0080}
        
        
		#errorPause {
		    color: #ea5200;
		    font-family: 微软雅黑;
		    font-size: 9pt;
		    left: 65px;
		    line-height: 30px;
		    position: absolute;
		    top: -16px;
		    z-index: 11;
		}
		
		#errorPause i {
            background: url(${e.res('/images/temp/error.gif')}) 0px 0px no-repeat;
            display: inline-block;
            height: 20px;
            width: 18px;
            margin-right: -3px;
            vertical-align: middle;
        }
    </style>
    <script type="text/javascript">

        function changeCode() {
            document.getElementById("captchaImage").src = '${rc.contextPath}/admin/am/loginCaptcha.jpg' + '?' + Math.floor(Math.random() * 100);
        }

    </script>

    <script>
        $(function () {

            $('#loginForm').validate();

        });
    </script>

    <script>
        $(document).ready(function(){
            <#--<#if "true"=="${smsCodeFlag}">
                $("#smsCode").show();
            </#if>-->

            /*$("#username").blur(function(){
                var username = $("#username").val();
                var timstamp = (new Date).valueOf();
//                alert(username);
                if(username == null || username ==""){
//                   alert("请输入用户名");
                    $("#error").show();
                }else{
                    $.ajax({
                        dataType: "json",
                        url:"${rc.contextPath}/agent/login/setSmsFlag?timstamp="+timstamp,
                        data:{username:username},
                        success:function(json){
                            var result = eval(json);
                            var status = result.status;
                            if(status){
//                                alert("smsFlag："+result.smsFlag);
                                if(result.smsFlag){
                                    $("#smsCode").show();
                                }else{
                                    $("#smsCode").hide();
                                }

                            }else{
//                                alert(result.errorMsg);
//                                alert("error");
                            }
                        }
                    });
                }

            });*/
            $("#username").focus(function(){
                $(".err").hide();
            })
        });

    </script>

    <script>
        function getSmsCode(){
            $("#sms").prop("disabled",false);
            var username = $("#username").val();
            var timstamp = (new Date).valueOf();
            $.ajax({
                dataType: "json",
                url:"${rc.contextPath}/agent/login/getSmsCode?timstamp="+timstamp,
                data:{username:username},
                success:function(json){
                    var result = eval(json);
                    var status = result.status;
                    var dtphone = result.checkphone;
                    if(status){
                    	$("#hqdxyzm").css("display","none");
                    	$("#hqdxyzmzc").remove();
                    	var str="短信动态码已发送给"+dtphone+"，请查收!"
                    	$("#hqdxyzm").after("<span id='hqdxyzmzc' style='font-size: 11px;'>"+ str +"<a href='#' onclick='getSmsCode()'>重新获取</a></span>");
                    }else{
                        alert(result.errorMsg);
                      //  alert("获取验证码失败,请重试");
                    }

                }
            });
        }
        
        //检查当前商户号是否存在
       function checkusername() {
       	 	var CSRFToken = $("input[name=CSRFToken]").val();
       	 	var usernameval = $("#username").val();
       	 	if(usernameval != "") {
	       	 	 $.ajax({
					url: "${rc.contextPath}/admin/am/login/checkUserName",
					type: "POST",
					async: false,
					data: {"username":usernameval,"CSRFToken":CSRFToken},
					success: function(data) {
						if (data.result == "success") {
							$("#errorPause").toggle();
						}
					}
				});
       	 	}
       }
    </script>
</head>
<body>

<div class="logobox">
    <div ><span>贵州联通电子商务营销服务平台</span></div>
</div>
<div class="login-cont">
    <div class="form">
    <@form.form method="post" action="" id="loginForm">
        <div id="error" style="display: none" class="err">
            <i></i>
            请输入用户名！
        </div>
        <#if "5555"=="${error}" >
            <div id="error" class="err">
                <i></i>
            ${errorMsg}
            </div>
        </#if>
        <#if "6666"=="${error}" >
            <div id="error" class="err">
                <i></i>
                用户名不存在或未审核！
            </div>
        </#if>
        <#if "7777"=="${error}" >
            <div id="error" class="err">
                <i></i>
                用户名/密码错误！
            </div>
        </#if>
        <#if "3333"=="${error}" >
            <div id="error" class="err">
                <i></i>
               	该用户已经停用，请联系管理员重新启用!
            </div>
        </#if>
        <div id="errorPause" style="display: none" class="err">
            <i></i>
                                     该用户已经停用，请联系管理员重新启用!
        </div>

        <div class="f-line">
            <label>用户名:</label><input type="text" id="username" name="username" value="admin"
                                      class="l-txt required"
                                      autocomplete="off" style="height:30px;" tabindex="1"
                />
        </div>
        <div id="capslock">
            <i></i>
            <s></s>
            大写锁定已打开，请注意大小写
        </div>
        <div class="f-line">
            <label>密&nbsp;&nbsp;&nbsp;码:</label><input type="password" class="l-txt required "
                                                       id="password" name="password" autocomplete="off" value="1"
                                                       style="height:30px;" tabindex="2"/>
            <script type="text/javascript">
                $('#password')[0].onkeypress = function (event) {
                    var e = event || window.event,
                            $tip = $('#capslock'),
                            kc = e.keyCode || e.which, // 按键的keyCode
                            isShift = e.shiftKey || (kc == 16 ) || false; // shift键是否按住
                    if (((kc >= 65 && kc <= 90) && !isShift) || ((kc >= 97 && kc <= 122) && isShift)) {
                        $tip.show();
                    }
                    else {
                        $tip.hide();
                    }
                };
                $('#password').blur(function(){
                    $('#capslock').hide();
                })
            </script>
        </div>
        <#--<div class="f-line"  id="smsCode" style="display: none;">
            <label>动态码:</label><input type="text" class="m-txt required" style="width:70px;height:30px;"
                                     id="sms"  name="smsCode" disabled tabindex="3"/>
            <span id="hqdxyzm" style="font-size: 11px;"><a href="#" onclick="getSmsCode()">获取短信动态码</a></span>
            
        </div>-->
        <div class="f-line" id="smsdiv">
            <label>验证码:</label><input type="text" class="m-txt" style="width:70px;height:30px;margin-right: 23px;" id="captchaCode"
                                      name="captchaCode" tabindex="4"/>
            	<span class="checkcode">
            		<img id="captchaImage" src="${rc.contextPath}/admin/am/loginCaptcha.jpg" onclick="changeCode()"
                         style="width:135px;"/>
            	</span>
                <span style="font-size: 11px;"><a href="javascript:void(0)" onclick="changeCode()">看不清</a></span>
            <#if "9999"=="${error}" >
                <div id="error" class="err">
                    <i></i>
                    验证码不能为空！
                </div>
            </#if>
            <#if "9998"=="${error}">
                <div id="error"  class="err">
                    <i></i>
                    动态码不能为空！
                </div>
            </#if>
            <#if "9997"=="${error}" >
                <div id="error" class="err">
                    <i></i>
                    动态码不正确，请重新获取动态码！
                </div>
            </#if>
            <#if "8888"=="${error}" >
                <div id="error" class="err">
                    <i></i>
                    验证码错误！
                </div>
            </#if>
        </div>
        <div class="f-line sel-fun">
            <#--<input type="checkbox" id="rememberName" name="rememberName"/>-->
            <#--<span>记住商户号</span>-->
            <#--<input type="checkbox" class="sec" id="rememberMe" name="rememberMe"/>-->
            <#--<span>记住我</span>-->
        </div>
        <div class="btn-area">
            <input type="submit" value="登 录" class="btn"/>
            <#--<input type="button" value="加 盟" class="btn" style="background-color:#8968CD;" onclick="location='${rc.contextPath}/am/register'"/>-->
            <#--<a href="/admin/am/register/rest" style="font-size: 11px;" class="signup">忘记密码?</a>-->
            <#--<a href="/agent/register" class="signup">注&nbsp;册</a>-->
        </div>

    </@form.form>
    </div>
</div>
<div class="footer">
    <p>版权所有 </p>

    <p>中华人民共和国增值电信业务经营许可证</p>
</div>

</body>
</html>