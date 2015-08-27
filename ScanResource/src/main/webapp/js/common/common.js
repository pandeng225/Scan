(function($) {

    /**
     * 通用Ajax方法 传入请求的url
     * data 为ajax请求数据
     * error 为错误时回调方法
     * success 为正确时回调方法
     */  
    $.phwAjax = function(/* String */url, /* Object */data, /* Function */success, /* Function */error){
        $.ajax({
            type : "POST",
            url : url,
            data: data, 
            error : error,
            beforeSend: function(){
                $.startLoading();
                $.overLayOn();
            },
            success: success,
            complete : function(){
                $.endLoading();
                $.overLayOff();
            }
        });
    };
    
    /**
     * 通用Ajax方法 传入请求的url
     * data 为ajax请求数据
     * error 为错误时回调方法
     * success 为正确时回调方法
     * 此方法在结束的时候不自动消除遮蔽 留给smile等消除
     */  
    $.phwAjax2 = function(/* String */url, /* Object */data, /* Function */success, /* Function */error){
        $.ajax({
            type : "POST",
            url : url,
            data: data, 
            error : error,
            beforeSend: function(){
                $.startLoading();
                $.overLayOn();
            },
            success: success,
            complete : function(){
                $.endLoading();
            }
        });
    };
    
    /**
     * 通用Ajax方法 传入请求的url
     * data 为ajax请求数据
     * error 为错误时回调方法
     * success 为正确时回调方法
     * 此方法在结束的时候不自动消除遮蔽和等待标识 留给smile等消除
     */
    $.phwAjax3 = function(/* String */url, /* Object */data, /* Function */success, /* Function */error){
        $.ajax({
            type : "POST",
            url : url,
            data: data, 
            error : error,
            beforeSend: function(){
                $.startLoading();
                $.overLayOn();
            },
            success: success,
            complete : function(){
            }
        });
    };
    
    /**
     * 通用Ajax方法 传入请求的url
     * data 为ajax请求数据
     * success 为正确时回调方法
     */
    $.phwAjax4 = function(/* String */url, /* String */data, /* Function */success){
        $.ajax({
            type : "GET",
            url : url,
            data: data,
            beforeSend: function(){
                $.startLoading();
                $.overLayOn();
            },
            success: success,
            complete : function(){
            	$.endLoading();
                //$.overLayOff();
            }
        });
    };
    
    // 小提示显示
    var tipsLayOn = function(tip) {
        tip.center().show();
        $.overLayOn();
    }
    
    // 小提示隐藏
    var tipsLayOff = function(tip) {
        $.overLayOff();
        tip.remove();
    }
    
    // 开始loading进度条
    $.startLoading = function(/* String */ loadMsg) {
        var _loadMsg = loadMsg || "加载中";
        var loading = "<div id='divloading' style='background-color: rgb(252, 252, 252); border: 1px solid rgb(204, 204, 204);" +
                              " height: 20px; left: 600px; padding: 5px; position: absolute; width: 130px; z-index: 10000003;" +
                              " top: 200px; background-position: initial initial; background-repeat: initial initial;'>" +
                              "<img src='"+Esf.PhotoPath+"/images/waitFor.gif'>&nbsp;&nbsp;&nbsp;&nbsp;"+_loadMsg+"...</div>";
        var docbody = $(document.body);
        docbody.append(loading);
        $("#divloading").center().show();
    }
    
    // 结束loading进度条
    $.endLoading = function() {
        $("#divloading").remove();
    }

    // 启用遮蔽
    $.overLayOn = function() {
        // 如果已经有遮蔽 则返回
        if(0 < $("#Tips_thickdiv").length) {
            return;
        }
        // $("#Tips_thickdiv").remove();
        var docbody = $(document.body);
        docbody.append("<div id='Tips_thickdiv' class='thickdiv' style='display:none'></div>");
        $("#Tips_thickdiv").show();
    }
    
    // 去掉遮蔽
    $.overLayOff = function() {
        var thick = $("#Tips_thickdiv");
        if(thick) {
            thick.remove();
        }
    }
 
    $.alert = function(/* String */msg, /* Function */callback) {
        var _msg = msg || "操作失败!";
        var content = "<div class='popTips' id='successTips' style='display:block;left:200px;top:200px;z-index: 99999999999'>" +
                        "<h3 class='tipsTitle'><label class='failure'>操作失败</label></h3>" +
                        "<p class='topLine tCenter'>" + _msg + "</p>" +
                        "<div class='tipsBtnsW'><span class='mediumBtn' id='pop_comfirm'>关&nbsp;闭</span></div></div>";
        popurFun(content, callback);
    }
    
    $.smile = function(/* String */msg, /* Function */callback) {
        var _msg = msg || "操作成功!";
        var content = "<div class='popTips' id='successTips' style='display:block;left:200px;top:10px;z-index: 99999999999'>" +
                        "<h3 class='tipsTitle'><label class='success'>操作成功</label></h3>" +
                        "<p class='topLine tCenter'>" + _msg + "</p>" +
                        "<div class='tipsBtnsW'><span class='mediumBtn' id='pop_comfirm'>关&nbsp;闭</span></div></div>";
        popurFun(content, callback);
    }
    
    $.onlySmile = function(/* String */ msg, /* Function */callback) {
        var _msg = msg || "操作成功";
        var content = "<div id='pop_div' class='releaseTips saveSuccess' style='z-index:99999999999'>"
        content += "<h3 class='success'>" + msg + "</h3><p>";
        content += "<input value='确&nbsp;定' type='button' class='choiceSubmit' id='pop_comfirm'></p></div>";
        popurFun(content, callback);
    }
    
    $.prompt = function(/* String */ title, /* String */ msg, /* Function */callback) {
        var _title = title || "操作提示";
        var _msg = msg || "是否进行此操作";
        var content = "<div class='popTips' id='successTips' style='display:block;left:200px;top:400px;'>";
        content += "<h3 class='tipsTitle'><label class='change'>"+_title+"</label></h3>";
        content += "<p class='topLine tCenter'>"+_msg+"</p><div class='tipsBtnsW'>";
        content += "<span class='mediumBtn' id='pop_comfirm'>确&nbsp;定</span>";
        content += "<span class='mediumBtn' id='pop_close'>取&nbsp;消</span></div></div>";
        
        popurFun(content, callback);
        
        var tips = $("#successTips");
        var clsBtn = tips.find("#pop_close");
        clsBtn.click(function() {
            tipsLayOff(tips)
        });
    }
    
    $.prompt2 = function(/* String */ title, /* String */ msg) {
        var _title = title || "操作提示";
        var _msg = msg || "是否进行此操作";
        var content = "<div id='pop_div' class='releaseTips' style='z-index:99999999999'>";
        content += "<h3 class='change'>"+ _title + "</h3>";
        content += "<p class='topLine'>"+ _msg + "</p><p>";
        content += "<input value='确&nbsp;定' type='button' class='choiceSubmit' id='pop_close'>";
        content += "</p></div>";
        
        popurFun(content, function(){});
        
        var tips = $("#pop_div");
        var clsBtn = tips.find("#pop_close");
        clsBtn.click(function() {
            tipsLayOff(tips)
        });
    }
    
    $.prompt3 = function(/* String */ title, /* String */ msg) {
        $(".thickdiv").show();
        var _title = title || "操作提示";
        var _msg = msg || "是否进行此操作";
        var content = "<div id='pop_div' class='releaseTips' style='z-index:99999999999'>";
        content += "<h3 class='change'>"+ _title + "</h3>";
        content += "<p class='topLine'>"+ _msg + "</p><p>";
        content += "<input value='确&nbsp;定' type='button' class='choiceSubmit' id='pop_close'>";
        content += "</p></div>";
        
        popurFun(content, function(){});
        
        var tips = $("#pop_div");
        var clsBtn = tips.find("#pop_close");
        clsBtn.click(function() {
            tipsLayOff(tips);
            $(".thickdiv").hide();
        });
    }
    
    $.popurFun = function(/* String */content, /* Function */callback) {
        popurFun(content, callback);
    }
    
    var popurFun = function(/* String */content, /* Function */callback) {
        var docbody = $(document.body);
        docbody.append(content);
        var tips = $("#successTips");
        var clsBtn = tips.find("#pop_comfirm");
        
        tipsLayOn(tips); // 居中和遮罩
        
        var closeFunction = function() {
            tipsLayOff(tips);
            callback && callback();
        } 
        
        clsBtn.click(function() {
            closeFunction();
        });
    }

    $.charLength = function(/* String */valStr) {
        var escStr = escape(valStr);
        var numI = 0;
        var escStrlen = escStr.length;
        for (var i = 0; i < escStrlen; i++)
          if (escStr.charAt(i)== '%')
            if (escStr.charAt(++i)== 'u')
              numI++;
        return valStr.length + numI;
    }

    $.fn.center = function(){
        var top = ($(window).height() - this.height())/2;
        var left = ($(window).width() - this.width())/2;
        var scrollTop = $(document).scrollTop();
        var scrollLeft = $(document).scrollLeft();
        return this.css( { position : 'absolute', 'top' : top + scrollTop, left : left + scrollLeft } ).show();
    }


    //支持placeHolder属性
    //判断浏览器是否支持placeholder属性
    supportPlaceholder='placeholder'in document.createElement('input'),

        placeholder=function(input){

            var text = input.attr('placeholder'),
                defaultValue = input.defaultValue;

            if(!defaultValue){

                input.val(text).addClass("phcolor");
            }

            input.focus(function(){

                if(input.val() == text){

                    $(this).val("");
                }
            });


            input.blur(function(){

                if(input.val() == ""){

                    $(this).val(text).addClass("phcolor");
                }
            });

            //输入的字符不为灰色
            input.keydown(function(){

                $(this).removeClass("phcolor");
            });
        };

    //当浏览器不支持placeholder属性时，调用placeholder函数
    if(!supportPlaceholder){

        $('input').each(function(){

            text = $(this).attr("placeholder");

            if($(this).attr("type") == "text"){

                placeholder($(this));
            }
        });
    }

})(jQuery);
