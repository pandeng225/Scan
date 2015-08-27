function validationAlbumExplain() {
	$("#albumExplainErrorTR").hide();
	var len = $.charLength($.trim($("#albumExplain").val()));
	if (len <= 0) {
		GoodsValidation.reportError("相册说明不能为空！");
		$("#albumExplainError").html("相册说明不能为空！");
		$("#albumExplainErrorTR").show();
        return false;
	} else if (len > 40) {
		GoodsValidation.reportError("相册说明不超过20个汉字！");
		$("#albumExplainError").html("相册说明不超过20个汉字！");
		$("#albumExplainErrorTR").show();
        return false;
	}
    return true;
}

function validationUsedChannel(){
    $("#usedChannelErrorTR").hide();
    var len = $.charLength($.trim($("#usedChannel").val()));
    if (len <= 0) {
        GoodsValidation.reportError("应用渠道不能为空！");
        $("#usedChannelError").html("应用渠道不能为空！");
        $("#usedChannelErrorTR").show();
        return false;
    }
    return true;
}

$(function(){
    $("#albumCreateBtn").click(function(){
        var a = validationAlbumExplain();
        var b = validationUsedChannel();
        var c = GoodsImageMacro.validation();
        if(a && b && c)
            $("#addAlbumForm").submit();
        else
            return false;
    });

    $("#albumEditBtn").click(function(){
        var a = validationAlbumExplain();
        var b = validationUsedChannel();
        var c = GoodsImageMacro.validation();
        if(a && b && c)
            $("#editAlbumForm").submit();
        else
            return false;
    });
});

/**
 * 表单提交
 * @param {Object} action url地址
 * @param {Object} msg 提示消息
 */
function formSubmit(action, msg){
    //获取提交数据
    var formData = {};
    $.publish(goodsSubmitTopic, [formData]);

    GoodsValidation.log($.toJSON(formData));

    $("#serializeServicePath").val(GoodsConfigCommon.serializeServicePath);
    $("#goodsData").val($.toJSON(formData));
    $("#GoodsConfigForm").attr("action", action);
    $("#GoodsConfigForm").ajaxSubmit({
        beforeSubmit: function() {
            $.startLoading("处理中");
        },
        success: function(result) {
            if (result.IS_SUCCESS) {
                if("OK" == result.message) {
                    $.smile(msg + "成功", GoodsConfigCommon.redirect);
                } else {
                    $.smile(result.message, GoodsConfigCommon.redirect);
                }
            } else {
                $.alert(result.message);
            }
        },
        dataType: 'json',
        complete : function(){
            $.endLoading();
        }
    });
};