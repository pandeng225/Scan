/* 
 * 商品发布小函数js方法定义
 *
 */

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
        var loading = "<div class='loading' id='pop_loading' style='display : none;z-index:99999999999'>";
        loading += "<i><img src='"+ Esf.resPath +"/back/images/loading.gif' width='20px' height='20px'/></i>";
        loading += "<span>"+ _loadMsg +"...</span></div>";
        var docbody = $(document.body);
        docbody.append(loading);
        $("#pop_loading").center().show();
    }
    
    // 结束loading进度条
    $.endLoading = function() {
        $("#pop_loading").remove();
    }

    // 启用遮蔽
    $.overLayOn = function() {
        // 如果已经有遮蔽 则返回
        if(0 < $("#Tips_thickdiv").length) {
            return;
        }
        //$("#Tips_thickdiv").remove();
        var docbody = $(document.body);
        docbody.append('<div id="Tips_thickdiv" class="thickdiv" style="display:none"/>');
        $("#Tips_thickdiv").height($("body").height());
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
        var content = "<div id='pop_div' class='releaseTips' style='z-index:99999999999'>";
        content += "<h3 class='failure'>操作失败</h3>";
        content += "<p class='topLine'>"+ _msg + "</p>";
        content += "<p><input value='关&nbsp;闭' type='button' class='choiceSubmit' id='pop_comfirm'></p></div>";
        
        popurFun(content, callback);
    }
    
    $.alert2 = function(/* String */title, /* String */msg, /* Function */callback) {
        var _title = title;
        var _msg = msg || "操作失败!";
        var content = "<div id='pop_div' class='releaseTips' style='z-index:99999999999'>";
        content += "<h3 class='failure'>"+ _title +"</h3>";
        content += "<p class='topLine'>"+ _msg + "</p>";
        content += "<p><input value='关&nbsp;闭' type='button' class='choiceSubmit' id='pop_comfirm'></p></div>";
        
        popurFun(content, callback);
    }
    
    $.smile = function(/* String */msg, /* Function */callback) {
        var _msg = msg || "操作成功!";
        var content = "<div id='pop_div' class='releaseTips' style='z-index:99999999999'>";
              content += "<h3 class='success'>操作成功</h3>";
              content += "<p class='topLine'>"+ _msg + "</p>";
              content += "<p><input value='关&nbsp;闭' type='button' class='choiceSubmit' id='pop_comfirm'></p></div>";
                    
              popurFun(content, callback);
    }
    
    $.smile2 = function(title, /* String */msg, /* Function */callback) {
        var _msg = msg || "操作成功!";
        var content = "<div id='pop_div' class='releaseTips' style='z-index:99999999999'>";
              content += "<h3 class='success'>"+title+"</h3>";
              content += "<p class='topLine'>"+ _msg + "</p>";
              content += "<p><input value='关&nbsp;闭' type='button' class='choiceSubmit' id='pop_comfirm'></p></div>";
                    
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
        var content = "<div id='pop_div' class='releaseTips' style='z-index:99999999999'>";
        content += "<h3 class='change'>"+ _title + "</h3>";
        content += "<p class='topLine'>"+ _msg + "</p><p>";
        content += "<input value='确&nbsp;定' type='button' class='choiceSubmit' id='pop_comfirm'>";
        content += "<input value='取&nbsp;消' type='button' class='choiceSubmit' id='pop_close'></p></div>";
        
        popurFun(content, callback);
        
        var tips = $("#pop_div");
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
        var tips = $("#pop_div");
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
    
    /*
    $.fn.center = function(){
        var top = ($(window).height() - this.height())/2;
        var left = ($(window).width() - this.width())/2;
        var scrollTop = $(document).scrollTop();
        var scrollLeft = $(document).scrollLeft();
        return this.css( { position : 'absolute', 'top' : top + scrollTop, left : left + scrollLeft } ).show();
    }
    */
})(jQuery);
