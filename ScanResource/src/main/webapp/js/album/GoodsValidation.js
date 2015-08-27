
if (!this.GoodsValidation) {
    this.GoodsValidation = {};
    var shortCircuitFlag = 0;
    var isDebug = true;
    GoodsValidation.errorList = [];
    GoodsValidation.ok = true;
    
    GoodsValidation.log = function(msg){
        if (isDebug && typeof console != 'undefined' && console != null) {
            try {
                if (!$.isArray(msg)) {
                    console.debug(msg);
                    return;
                }
                $.each(msg, function(i, item){
                    console.debug(item);
                })
            } 
            catch (e1) {
                /* ignore */
            }
        }
    };
    
    GoodsValidation.startCapture = function(){
        GoodsValidation.ok = true;
        shortCircuitFlag = 1;
    };
    
    GoodsValidation.endCapture = function(){
        shortCircuitFlag = 0;
        if (GoodsValidation.errorList.length != 0) {
            GoodsValidation.log(GoodsValidation.errorList);
            var msg = "错误内容：\n";
            for(var i = 0 ; i < GoodsValidation.errorList.length; i++) {
                msg += "第" + i + "个 : " + GoodsValidation.errorList[i].message + "\n";
            }
            // alert(msg);
            GoodsValidation.ok = true;
            GoodsValidation.errorList = [];
            throw 'error';
        }
    };
    
    GoodsValidation.requiredCheck = GoodsValidation.baseCheck;
    
    // 报告错误信息
    GoodsValidation.reportError = function(error, element){
        if (shortCircuitFlag > 0) {
            GoodsValidation.errorList.push({
                message: error,
                element: element
            })
        }
    };
    
    // 展示错误信息
    GoodsValidation.showErrors = function(error, element){
        var errorTr = $(element).parent().parent().next();
        errorTr.toggle(true);
        errorTr.children("td").children().html(error);
        GoodsValidation.reportError(error, element);
    };
    
    // 清理异常信息
    GoodsValidation.clearErrors = function(element){
        $(element).parent().parent().next().toggle(false);
    };
    
    // 特殊字符校验
    GoodsValidation.suppressSpecLetterCheck = function(element){
        if (!jQuery(element).hasClass('suppressSpecLetterCheck') && /['"<>&]/.test(element.value)) {
            GoodsValidation.showErrors("输入包含了特殊字符，请修正后重试", element);
            return false;
        }
        return true;
    };
    
    // 当字段拥有这个属性时,不做其他校验
    GoodsValidation.suppressBaseCheck = function(element){
        if (jQuery(element).hasClass('suppressBaseCheck')) {
            return false;
        }
        return true;
    };
    
    // 最大长度校验
    GoodsValidation.maxLengthCheck = function(element){
        /*
         *  暂时不校验时间 校验长度即可
        if (element.maxLength && element.value.length > 0) {
            var matchRet = element.value.match(/[^\x00-\xff]/ig);
            var arrByteLen = element.value.length + ((matchRet && matchRet.length) ? matchRet.length : 0);
            if (arrByteLen > element.maxLength) {
                GoodsValidation.showErrors("输入超过" + element.maxLength + "字节，请修正后重试", element);
                return false;
            }
        }
        */
        var length = jQuery(element).attr('length');
        if (length && element.value.length > 0) {
            if (element.value.length > parseInt(length)) {
                GoodsValidation.showErrors(element.title + "不超过" + length + "个汉字", element);
                return false;
            }
        }
        return true;
    };
    
    GoodsValidation.baseCheck = function(event){
        GoodsValidation.clearErrors(this);
        var isFocusOut = event && event.type == 'focusout';
        this.value = jQuery.trim(this.value);
        
        if (!GoodsValidation.suppressSpecLetterCheck(this)) {
            return;
        }
        
        if (!GoodsValidation.suppressBaseCheck(this)) {
            return;
        }
        
        // 暂时不校验字节 只校验长度
        if (!GoodsValidation.maxLengthCheck(this)) {
            return;
        }
        
        var thisId = jQuery(this).attr('id');
        if (thisId != '') {
            var js = jQuery('#validation_' + thisId).attr('js');
            if (js && js != '') {
                new Function(js)();
            }
        }
        
        var next = jQuery(this).next();
        if (next.length && next.attr('tagName') == "VALIDATION") {
            var validator = next;
            var notEmpty = validator.attr('notEmpty');
            if (notEmpty && 'true' == notEmpty && this.value.length <= 0) {
                GoodsValidation.showErrors(this.title + "不能为空", this);
                return;
            }
            
            var regex = validator.attr('regex');
            
            if (regex && regex.length > 0 && this.value.length > 0 &&
            !this.value.match(validator.attr('regex'))) {
                GoodsValidation.showErrors(validator.attr('msg') || "输入格式错误", this);
                return;
            }
            
            var byteMinLength = validator.attr('byteMinLength');
            if (!isFocusOut &&
            byteMinLength &&
            byteMinLength.match(/^[0-9]+$/) &&
            parseInt(byteMinLength) > 0 &&
            this.value.replace(/[^\x00-\xff]/g, "xx").length < parseInt(byteMinLength)) {
                GoodsValidation.showErrors("输入少于最少字节要求:" + byteMinLength, this.title);
                return;
            }
            
            var minLength = validator.attr('minLength');
            if (!isFocusOut && minLength && minLength.match(/^[0-9]+$/) &&
            parseInt(minLength) > 0 &&
            this.value.length < parseInt(minLength)) {
                GoodsValidation.showErrors("输入少于最少位数要求:" + minLength, this.title);
                return;
            }
            
            var dateFmt = validator.attr('dateFmt');
            if (dateFmt && dateFmt.length > 0 && this.value.length > 0) {
                if (!jQuery.isDate(this.value, dateFmt)) {
                    GoodsValidation.showErrors("输入格式错误:" + dateFmt, this.title);
                    return;
                }
                
                var datePoint = validator.attr('datePoint');
                if (!datePoint) {
                    return;
                }
                
                var today = new Date().getTime();
                var thisDay = jQuery.parseDate(this.value, dateFmt);
                
                datePoint = datePoint.toLowerCase();
                
                if (datePoint == 'future' && thisDay < today) {
                    GoodsValidation.showErrors(" 应晚于当前日期", this.title);
                }
                else 
                    if (datePoint == 'past' &&
                    thisDay > today - 24 * 60 * 60 * 1000) {
                        GoodsValidation.showErrors(" 应早于当前日期", this.title);
                    }
            }
        }
        else 
            if (!isFocusOut && this.value.length <= 0 &&
            next.hasClass('red') &&
            next.css('display') != 'none') {
                GoodsValidation.showErrors("必须输入", this.title);
                return;
            }
    };
}

$(function() {
    $("#goodsName,#goodsLabel,#sellingPointTextOne,#sellingPointTextTwo,#sellingPointTextThree").keyup(function() {
        var replaceText = $(this).val();
        var zz=/\<|\>|\#|\'/g; 
        
        var noChar = replaceText.match(zz);
        if(noChar!=null) {
            $(this).val(replaceText.replace(zz, ""))
        }
    });
});
