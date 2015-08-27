$(function(){
	$("#refundMoney").bind({
		blur : function() {
			var refundMoney = $("#refundMoney").val();
			if (!validateMoney(refundMoney)) {
				$("#validateMoneyTip").html("最多只能输入8位整数，2位小数!");
				$("#validateMoneyTip").addClass("onError").show();
				return;
				//$("#refundMoney").focus();
			}else{
				$("#validateMoneyTip").html("");
				$("#validateMoneyTip").removeClass("onError").hide();
			}

			var availableBalance = $("#availableBalance").text();
			if(parseFloat(refundMoney)>parseFloat(availableBalance)){
				$("#validateMoneyTip").html("退费金额不能大于可用余额！");
				$("#validateMoneyTip").addClass("onError").show();
				// $("#refundMoney").focus();
				return;
			}
		},
		focus : function(){
			$("#validateMoneyTip").html("");
			$("#validateMoneyTip").removeClass("onError").hide();
		},
		keyup : function(){
			var refundMoney = $("#refundMoney").val();
			if (!validateMoney(refundMoney)) {
				$("#validateMoneyTip").html("最多只能输入8位整数，2位小数!");
				$("#validateMoneyTip").addClass("onError").show();
				//$("#refundMoney").focus();
				return;
			}else{
                $("#validateMoneyTip").html("");
                $("#validateMoneyTip").removeClass("onError").hide();
            }
		}
	});

	$("#refundReason").bind({
		blur : function() {
			var refundReason = $("#refundReason").val();
			if (!refundReason || refundReason=="") {
				$("#validateReasonTip").html("请输入退费原因!");
				$("#validateReasonTip").addClass("onError").show();
				return;
			}
		},
		focus : function(){
			$("#validateReasonTip").html("");
			$("#validateReasonTip").removeClass("onError").hide();
		}
	});

	$("#sbt").click(function(){
		var refundMoney = $("#refundMoney").val();
		if (!validateMoney(refundMoney)) {
				$("#validateMoneyTip").html("最多只能输入8位整数，2位小数!");
				$("#validateMoneyTip").addClass("onError").show();
				//$("#refundMoney").focus();
				return;
		}

		var refundReason = $("#refundReason").val();
		if (!refundReason || refundReason=="") {
			$("#validateReasonTip").html("请输入退费原因!");
			$("#validateReasonTip").addClass("onError").show();
			//$("#refundReason").focus();
			return;
		}

		$.ajax({
				url: NL.ctx+"/agent/accountRefund",
				type: "GET",
				async: false,
				//data: {refundMoney:refundMoney,refundReason:encodeURIComponent(encodeURIComponent(refundReason))},
				data: encodeURI(encodeURI("refundMoney="+refundMoney+"&refundReason="+refundReason)),
				success: function(data) {
					if (data.result == "fail") {
						alert(data.msg);
					} else if(data.result == "success") {
						window.location.href=NL.ctx+"/agent/marginAccountQuery";
					} else if($.parseJSON(data).result == "false"){
						window.location.href=NL.ctx+"/agent/login";
					}
				}
		});
	});

	function validateMoney(rechargeMoney) {
        var reg = /^[1-9]{1}[0-9]{0,7}(\.[0-9]{1,2})?$|^0{1}\.[1-9]{1}[0-9]{0,1}$|^0{1}\.[0-9]{1}[1-9]{1}$/;
		if (reg.test(rechargeMoney))
			return true;
		else
			return false;
	}
});