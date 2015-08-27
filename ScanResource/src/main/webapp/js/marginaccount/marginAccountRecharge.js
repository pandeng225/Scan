$(function() {
	$("#rechargeMoney").bind({
		blur : function() {
			var rechargeMoney = $("#rechargeMoney").val();
			if (!validateMoney(rechargeMoney)) {
				$("#validateMoneyTip").html("最多只能输入8位整数，2位小数!");
				$("#validateMoneyTip").addClass("onError").show();
				return;
			}else{
				$("#validateMoneyTip").html("");
				$("#validateMoneyTip").removeClass("onError").hide();
			}
		},
		focus : function(){
			$("#validateMoneyTip").html("");
			$("#validateMoneyTip").removeClass("onError").hide();
		},
		keyup : function(){
			var rechargeMoney = $("#rechargeMoney").val();
			if (!validateMoney(rechargeMoney)) {
				$("#validateMoneyTip").html("最多只能输入8位整数，2位小数!");
				$("#validateMoneyTip").addClass("onError").show();
				return;
			}else{
                $("#validateMoneyTip").html("");
                $("#validateMoneyTip").removeClass("onError").hide();
            }
		}
	});

	$("input:radio[name='payInfo']").click(function(){
		$("#validatePayTypeTip").html("");
		$("#validatePayTypeTip").removeClass("onError").hide();
	});

	function validateMoney(rechargeMoney) {
        var reg = /^[1-9]{1}[0-9]{0,7}(\.[0-9]{1,2})?$|^0{1}\.[1-9]{1}[0-9]{0,1}$|^0{1}\.[0-9]{1}[1-9]{1}$/;
		if (reg.test(rechargeMoney))
			return true;
		else
			return false;
	}

	$("#popwinClose").click(function(){
		$("#popwinbgId").hide();
		$("#popwinId").hide();
	});

	$("form:eq(0)").bind("submit",function(){

		var rechargeMoney = $("#rechargeMoney").val();
		if (!validateMoney(rechargeMoney)) {
			$("#validateMoneyTip").html("最多只能输入8位整数，2位小数!");
			$("#validateMoneyTip").addClass("onError").show();
//			$("#rechargeMoney").focus();
			return false;
		}

		var payInfo = "";
		if($("input:radio[name='payInfo']").is(":checked")){
			payInfo = $("input:radio[name='payInfo']:checked").val();
		}else{
			$("#validatePayTypeTip").html("请选择支付方式!");
			$("#validatePayTypeTip").addClass("onError").show();
			return false;
		}

		// if(!payInfo || payInfo==""){

		// }

		var _result = false;
		$.ajax({
				url: NL.ctx+"/agent/recharge/beforeSendThirdPay",
				type: "get",
				async: false,
				data: "rechargeMoney=" + rechargeMoney + "&payInfo=" + payInfo,
				success: function(data) {
					if (data.result == "fail") {
						alert(data.msg);
					} else if(data.result == "success") {
						showMaskDiv();
						_result = true
					} else if($.parseJSON(data).result == 'false'){
						window.location.href= NL.ctx+"/agent/login";
					}
				}
			});
		
		return _result;

	});

	function showMaskDiv() {
		$("#popwinContId").text("支付完成前，请不要关闭此支付验证窗口");
		$("#popwinbgId").show();
		$("#popwinId").show();
	}

});