function showLayer(){
  if($("#commonThickdiv").length ==0){
    $('body').append('<div id="commonThickdiv" class="thickdiv" />');  
  }
  $("#commonThickdiv").height($("body").height());
  $("#commonThickdiv").show();
}

function hideLayer(){
  $("#commonThickdiv").hide();
}

function showError(desc){
  showLayer();
  $.alert(desc, hideLayer);
}


function showWaitLayer() {
  $('body').spin();
  showLayer();
}

function hideWaitLayer() {
  $('body').spin(false);
  hideLayer();
}


$(function() {
	var userAgent = navigator.userAgent.toLowerCase();
	// Figure out what browser is being used 
	jQuery.browser = {
	    version: (userAgent.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/) || [])[1],
	    safari: /webkit/.test(userAgent),
	    opera: /opera/.test(userAgent),
	    msie: /msie/.test(userAgent) && !/opera/.test(userAgent),
	    mozilla: /mozilla/.test(userAgent) && !/(compatible|webkit)/.test(userAgent)
	};  
  // 发货参数对象
  var deliveryparams = {};
  var lgtsParams = {};
  var reg = /^[0-9a-zA-Z]+$/; // 物流单号校验正则表达式
  var checkedLgtsOrder = false;// 物流单号校验标志
  var chooseObject;
  var btnTwoType = 'close';// btnTwo的控制事件
  $("#deliveryTable").insertAfter($("#paperBill").closest("div"));
  $("#applyOrder").show();
  // 切换到第三方配送
  $("#modeFirst").click(function() {
    $("#thirdPartyLogistics").show();
    $("#selectCompanyInfo").hide();
    $("#bicycleDistribution").hide();
    $("#confirmConsignor").hide();
    $("#clientSelf").hide();
    $("#modeFirst").addClass("currentMode");
    $("#modeSecond").removeClass("currentMode");
    $("#modeThird").removeClass("currentMode");
    logisticType = '2';
    if(chooseObject){
        companyParent=chooseObject.parents(".logisticsList");
        companyParent.find("td").eq(1).find("a").click();
        chooseObject = null;
    }
  });


 
  
  // 这个不会提示是否关闭浏览器
  function CloseWin() {
    window.opener = null;
    window.open("", "_self");
    window.close();
  }
     // 物流单号校验
    $("#lgtsOrder").on('blur', function() {
        // 校验物流单号
        var _name = $(this).val();
        if (_name == "") {
            $("#lgtsOrderExample").hide();
            $(lgtsOrderErrorDl).show();
            $(lgtsOrderErrorDl).html("物流单号不能为空");
            // $(this).next(".error").html("<em>物流单号不能为空</em>").show();
            return false;
        }
        lgtsParams.companyId = companyIdVal;
        lgtsParams.lgtsOrder = $("#lgtsOrder").val();
        lgtsParams.orderId = orderId;
        // 校验物流单号

        $(this).next(".error").hide();
        $(this).next(".error").html("");
    });
    // 物流单号 编辑状态时，隐藏错误提示
    $("#lgtsOrder").on('focus', function() {
        $("#lgtsOrderExample").show();
        checkedLgtsOrder = false;
        switchPrintBtn();
        $(this).next(".error").hide();
        $(this).next(".error").html("");
    });

    /**
     * 忽略发货失败错误，继续发货
     */
  function ignoreDeliveryFail (){
    delete  deliveryparams.callPlatform; //忽略平台发货失败
    deliveryparams.CSRFToken=$("input[name='CSRFToken']").val();
    $.ajax({
      type : "post",
      url : doDeliveryUrl,
      async : false,//ajax同步请求
      data : deliveryparams,
      dataType : "json",
      success :  afterDeliveryIngoreFail,
      beforeSend : showWaitLayer,
      complete : hideWaitLayer
    });
  }

    /**
     * 忽略发货失败发货的回调
     */
  function  afterDeliveryIngoreFail(data, textStatus){
    hideWaitLayer();
    if (data.status) {
      refreshParent();
      CloseWin();
      
    }
  } 
  
  // 第三方物流 -- 点击发货按钮
  $("#deliverySubmit").on('click', function() {
      if(!checkDefaultDelivery()){
          return; 
       }
    deliveryparams.orderId = orderId;
    deliveryparams.logisticType = logisticType;
    deliveryparams.callPlatform = '1';//该标示是否忽略第三方发货通知接口调用失败 1 ：不忽略    空值  不忽略
    deliveryparams.companyId = companyIdVal;
    deliveryparams.companyName = companyNameVal;
    deliveryparams.delivery_type_code = "01";//物流方式为快递
    deliveryparams.lgtsOrder = $("#lgtsOrder").val();
    deliveryparams.lgtsRemark = $("#lgtsRemark").val();
    
    var radioId = $("input:radio[name='billType']:checked").attr("id");
    deliveryparams.billType = radioId;
    deliveryparams.CSRFToken=$("input[name='CSRFToken']").val();
    //点击发货
    $.ajax({
        url : doDeliveryUrl,
        data : deliveryparams,
        async : false,//ajax同步请求
        dataType: "json",
        type: "POST",
        success :  function(data, textStatus) {
          if (!data.status) {
            alert('发货失败,'+data.msg);
          }
          afterDeliveryIngoreFail(data, textStatus);
          alert('发货成功');
          
        }
        //,
        //beforeSend : showWaitLayer,
        //complete : hideWaitLayer
      });
  });
  
  function checkDefaultDelivery(){
      if(typeof(defaultDeliveryAddr) == 'undefined' || defaultDeliveryAddr == ''){
          alert("请填写发货地址");
          return false;
      }
      return  true; 
  }
  
/**
 * btnTwo的控制事件
 */
  $("#btnTwo").on('click', function() {
      if(btnTwoType == "close"){
          $(this).closest(".rejectionLayer").hide();
          hideLayer();
          return;
      } else if (btnTwoType == "wait") {
          var data = {};
          data.UPDATE_SUCCESS = true;
          afterDeliveryIngoreFail(data, null);
          $(this).closest(".rejectionLayer").hide();
          hideLayer();
      } else if (btnTwoType == "selPaper") {
          
      }
  });
  
    /**
     * btnTwo的控制事件
     */
    $("#btnOne").on('click', function() {
        $(this).closest(".rejectionLayer").hide();
        hideLayer();
        $(".deliveryTableEdit").trigger("click");
    });
    
    /**
     * 申请退单旁边的关闭按钮事件
     */
    $("#applyClose").on('click', function() {
        var data = {};
        data.UPDATE_SUCCESS = true;
        afterDeliveryIngoreFail(data, null);
    });
    
  /**
     * 初始化纸质和电子运单的选择框
     */
    function resetRadio() {
        $("#paperBill").attr("checked",true);
        $("#deliveryTable").show();
    }
    
  /**
     * 刷新订单发货列表页.
     */
  function refreshParent(){
    if(window.opener){
        var opener = window.opener;
        if(opener.PaginationpageTable){
            opener.PaginationpageTable.refresh();
        }
        if(opener.reloadOrderAmount){
            opener.reloadOrderAmount();
        }
    }
  }

  

  // 选择物流
  $(".selectCompany").on('click', chooseLgts);
  //选择物流公司
  function chooseLgts(operFlag){
      initPrintFace($(this).attr('morePrint'));
      resetRadio();
      var _this=$(this),companyParent=_this.parents(".logisticsList"),_i=companyParent.index();
      chooseObject = _this;
      $("#selectCompanyInfo").show();
      if($(this).attr('isAccess') == '1' && $(this).attr('supportElecBill') == '1'){
          $(".billTypeTitle").show();
          $("#elecBill").show();
          $("#elecBillLabel").show();
      }else{
          $(".billTypeTitle").hide();
          $("#elecBill").hide();
          $("#elecBillLabel").hide();
      }
      companyParent.siblings(".logisticsList").hide();
      companyParent.find("td").eq(0).find("input").val("已选择").attr("disabled","disabled");
      
      needCallLgts = $(this).attr('isAccess'); //去选择的物流商是否可以进行同步
      
      if($(this).attr('isAccess') == '1'){
          if(hashooseLgts=='1'){
              companyParent.find("td").eq(0).find("input").removeClass("selectCompany");
              $("#subLgtsOrder").hide();
              $("#printFace").show();
          }else{
              companyParent.find("td").eq(1).find("a").html('');
              companyParent.find("td").eq(1).append("<a href=\"javascript:window.location.href=window.location.href+(window.location.href.indexOf('?')>=0?'&':'?')+'rnd='+Math.random();\" class=\"deliveryTableEdit1 fontC36cS12B\">【修改】</a>");
              $("#subLgtsOrder").show();
              $("#printFace").hide();
          }
          $("#preview").hide();
      }else{
          companyParent.find("td").eq(1).find("a").html('');
          companyParent.find("td").eq(1).append("<a href=\"javascript:window.location.href=window.location.href+(window.location.href.indexOf('?')>=0?'&':'?')+'rnd='+Math.random();\" class=\"deliveryTableEdit1 fontC36cS12B\">【修改】</a>");
          $("#subLgtsOrder").hide();    
          $("#printFace").show();
          if(!$("#printFace").hasClass("forClass")){
           $("#preview").show();
          }
      }
      
      logisticsIdVal = $(this).attr('logisticsId');
      companyNameVal = $(this).attr('companyName');
      companyCodeVal = $(this).attr('companyCode');
      companyIdVal = $(this).attr('companyId');
      
    }    
  
  
  $(".deliveryTableEdit").on('click', function(){
//      var _this=$(this),companyParent=_this.parents(".logisticsList");
//      if(!_this.hasClass("noEdit")) {
//        $("#selectCompanyInfo").hide();
//        companyParent.siblings(".logisticsList").show();
//        companyParent.find("td").eq(0).find("input").val("选  择").attr("disabled","");
//        _this.remove();  
//        $("#paperNo,.billType").show();
//        $("#deliveryTable").hide();
//        $("#paperNoShow").hide();
//        $("#remarksShow").hide();
//      }
	  window.location.href=window.location.href+(window.location.href.indexOf('?')>=0?'&':'?')+'rnd='+Math.random();
  });
  
  // 选择运单类型
  $("input[name='billType']").on("click",function(){
    var _this=$(this),id=_this.attr("id");
    $("#lgtsRemark").val("");
    $("#deliveryTable").show();
    $("#deliveryTable").insertAfter(_this.closest("div"));
    
    if(id=="paperBill"){
      if(!$("#rePrintFace").hasClass("rePrintFace")) {
          $("#rePrintFace").addClass("rePrintFace");
      }
      $("#paperNo,#remarks").show();
      if(needCallLgts=='1'){
          $("#subLgtsOrder").show();
          $("#printFace,#preview").hide();
      }else{
          $("#subLgtsOrder").hide();
          $("#printFace,#preview").show();
      }
      
      if($("#printFace").hasClass("forClass")){
         $("#preview").hide();
      }
      $("#deliverySubmit,#sendTips,#rePrintFace").hide();
    }else{
      if($("#rePrintFace").hasClass("rePrintFace")) {
          $("#rePrintFace").removeClass("rePrintFace");
      }
      if(needCallLgts=='1'){
          $("#subLgtsOrder").show();
          $("#printFace,#deliverySubmit,#sendTips").hide();
      }else{
          $("#printFace").show();
          $("#subLgtsOrder,#deliverySubmit,#deliverySubmit").hide();
      }
      $("#paperNo,#rePrintFace").hide();
      $("#printFace").removeClass("forClass").hide().next(".preview").hide();
    }
  });
  
  function checkDelivery(deliType){
    if('1' == deliType){
      // 校验物流单号和备注
      if ($("#lgtsOrder").val()== null ||$("#lgtsOrder").val()=="") {
        $("#lgtsOrder").next(".error").html("<em>物流单号不能为空</em>").show();
        return false;
      }
      checkedLgtsOrder=true;
      return checkedLgtsOrder;
    }
    
  }
  
  // 初始化第三方物流确认
  function initPrintFace(morePrint){
    $("#lgtsOrder").val("");
    $("#lgtsRemark").val("");
    $("#printFace").show().removeClass("forClass");
    $("#rePrintFace").hide().removeClass("forClass");
    $("#elecBill").show();
    if('true' == morePrint){
      $("#printFace").addClass("forClass");
      $("#rePrintFace").addClass("forClass");
      $("#preview").hide();
    }else {
      $("#preview").show();  
    }
    
    $("#deliverySubmit").hide();
    $("#lgtsOrder").next(".error").hide();
    $("#lgtsOrder").next(".error").html("");
  }
  /**
   * 发货菜单切换
   */
  function switchPrintBtn(){
     
      if(needCallLgts=='1'){//需要同步物流单号
          $("#printFace").hide();
          $("#rePrintFace").hide();
          $("#preview").hide();
           
      }else{
          
          $("#printFace").show();
          $("#rePrintFace").hide();
          $("#preview").show();
      }
    
    if($("#printFace").hasClass("forClass")){
      $("#preview").hide();
    }
    $("#deliverySubmit").hide();
  }
  
  function afterPrintFace(){
    $("#printFace").hide();
    $("#preview").hide();
    $("#deliverySubmit").show();//发货
    $("#rePrintFace").show();//重打印面单
    
  }
  
  function afterPrintElecFace(){
      $("#printFace").hide();
      $("#preview").hide();
      $("#deliverySubmit").show();//发货
      $("#rePrintFace").show();//重打印面单
    }

    // 延时参数
    var timeoutCount;
    function printWindow() {
        var printIframe = document.getElementById('printIframe');
        var frameWindow = printIframe.window || printIframe.contentWindow;
        if ('1' != frameWindow.loadComplete) {
            timeoutCount = window.setTimeout(printWindow, 1000); // 1S延时等待打印页面加载完成
        }
        else {
            if ($.support.msie) { // IE
                frameWindow.document.execCommand('print', false, null);
            }
            else {
                frameWindow.focus();
                frameWindow.print();
            }
            window.clearTimeout(timeoutCount);
            frameWindow.loadComplete = '0';
        }
    }

    // 重打印物流面单
    $("#rePrintFace").click(function() {
        var radioId = $("input:radio[name='billType']:checked").attr("id");
        if (radioId == "elecBill") {
            if (companyIdVal == '1001') {
                showEmsPrint();
                return;
            }
            else {
                showElecPrint();
                return;
            }
        }
        else {
            rePrintOrPreviewDeliveryDocument('print');
        }
    });

    /**
     * 重新打印、预览 面单
     */
    function rePrintOrPreviewDeliveryDocument(operateType) {
        $('#printForm #operateType').val(operateType);
        var radioId = $("input:radio[name='billType']:checked").attr("id");
        $('#printForm').attr('action', queryDeliveryDocumentUrl);
        if (radioId == "elecBill") {
            $('#printForm #logisticType').val(logisticType);
            $('#printForm #logisticsId').val(logisticsIdVal);
            $('#printForm #companyId').val(companyIdVal);
            $('#printForm #companyCode').val(companyCodeVal);
            $('#printForm #companyName').val(companyNameVal);
            $('#printForm #lgtsOrderForm').val($.trim($("#paperNoShow label").text()));
            $('#printForm #lgtsRemarkForm').val($("#lgtsRemark").val());
        }
        $('#printForm').attr('target', 'printIframe');
        if ('preview' == operateType) {
            $('#printForm').attr('target', '_blank');
        }
        $('#printForm').submit();
        if ('print' == operateType) {
            printWindow();
        }
    }

    // 提交 物流保存、 打印、预览请求
    function preParams(operateType) {
        $('#printForm #operateType').val(operateType);
        $('#printForm #logisticType').val(logisticType);
        $('#printForm #logisticsId').val(logisticsIdVal);
        $('#printForm #companyId').val(companyIdVal);
        $('#printForm #companyCode').val(companyCodeVal);
        $('#printForm #companyName').val(companyNameVal);
        $('#printForm #lgtsOrderForm').val($("#lgtsOrder").val());
        $('#printForm #lgtsRemarkForm').val($("#lgtsRemark").val());
        $('#printForm').attr('action', deliveryDocumentUrl);
        $('#printForm').attr('target', 'printIframe');
        if ('preview' == operateType) {
            $('#printForm').attr('target', '_blank');
        }
        $('#printForm').submit();
    }

    // 为EMS 打印、预览准备参数
    function preParams4EMS(operateType) {
        $('#printForm #operateType').val(operateType);
        $('#printForm #logisticType').val(logisticType);
        $('#printForm #logisticsId').val(logisticsIdVal);
        $('#printForm #companyId').val(companyIdVal);
        $('#printForm #companyCode').val(companyCodeVal);
        $('#printForm #companyName').val(companyNameVal);
        $('#printForm #lgtsOrderForm').val($("#lgtsOrder").val());
        $('#printForm #lgtsRemarkForm').val($("#lgtsRemark").val());
        $('#printForm').attr('action', Esf.contextPath + '/OrderDelivery/queryEMSDeliveryDocumentUrl');
        $('#printForm').attr('target', '_blank');
        if ('print' == operateType) {
            $('#printForm').attr('target', 'printIframe');
        }

        $('#printForm').submit();
    }

    // 电子运单打印、预览请求
    function preParamsElec(type) {
        var printWin = window.open("/admin/am/delivery/showElecImg?orderId=" + orderId + "&type=" + type);
        return printWin;
    }
    // EMS电子运单 打印 预览请求
    function preEmsParamsElec(type) {
        var printWin = window.open("/admin/am/delivery/showEmsElecImg?orderId=" + orderId + "&type=" + type);
        return printWin;

    }
    // 预览物流面单
    $("#preview").on('click', function() {
        preParams("preview");
    });

    // 物流打印面单
    $("#printFace").on('click', function() {

        var radioId = $("input:radio[name='billType']:checked").attr("id");
        // 区分顺丰运单 与 EMS运单
        if (companyIdVal == "2") {
            if (lgtsWait == "3") {
                $.smile("该订单进入人工筛单环节，请耐心等待物流公司的筛单结果！");
                return;
            }
            if (radioId == "paperBill") {
                if ('1' != hashooseLgts && !checkDelivery('1')) {
                    return;
                }
                preParams("print");
                printWindow();
                afterPrintFace();
            }
            else if (radioId == "elecBill") {
                showEmsPrint();
                afterPrintElecFace();
            }
        }
        else if (companyIdVal == "1") {
            // 顺丰 运单
            if (lgtsWait == '3') {//
                $.smile("该订单进入人工筛单环节，请耐心等待物流公司的筛单结果！");
                return;
            }
            if (radioId == "paperBill") {
                if ('1' != hashooseLgts && !checkDelivery('1')) {
                    return;
                }
                if ($(this).hasClass('forClass')) {
                    // 只保存 选择 的配送物流信息
                    showEmsPrint();
                    afterPrintFace();
                }
                else {
                    preParams("print");
                    printWindow();
                    afterPrintFace();
                }
            }
            else if (radioId == "elecBill") {
                showElecPrint();
                afterPrintElecFace();
            }
        }

    });

    // 重打印自行配送面单
    $("#rePrintFaceTwo").on('click', function() {
        rePrintOrPreviewDeliveryDocument('print');
    });

    // 初始化自行配送确认
    function initPrintFaceTwo() {
        $("#printFaceTwo").show();
        $("#previewTwo").show();
        $("#deliverySubmitTwo").hide();
        $("#rePrintFaceTwo").hide();
    }

    // 自行配送打印面单后
    function afterPrintFaceTwo() {
        $("#printFaceTwo").hide();
        $("#previewTwo").hide();
        $("#deliverySubmitTwo").show();
        $("#rePrintFaceTwo").show();
    }

    // 为自行配送 打印、预览准备参数
    function preParamsTwo(operateType) {
        $('#printForm #operateType').val(operateType);
        $('#printForm #logisticType').val(logisticType);
        $('#printForm #staffId').val(staffIdVal);
        $('#printForm #staffCode').val(staffCodeVal);
        $('#printForm').attr('action', deliveryDocumentUrl);
        $('#printForm').attr('target', '_blank');
        if ('print' == operateType) {
            $('#printForm').attr('target', 'printIframe');
        }
        $('#printForm').submit();
    }

    // 预览自行配送面单
    $("#previewTwo").click(function() {
        preParamsTwo("preview");
    });

    // 自行配送打印面单
    $("#printFaceTwo").click(function() {
        preParamsTwo("print");
        printWindow();
        afterPrintFaceTwo();

    });
    changeTextLength();

  // 退单申请弹出层
  $("#applyOrder").click(function(){
    if($(this).attr('canCancel') != 'true'){
      showError($(this).attr('orderFrom')+'订单不允许退单申请！');
      return;
    }
    $(".applyOrderLayer").show().center();
    showLayer();
  });
  $(".rejectionClose").click(function(){
    $(this).closest(".rejectionLayer").hide();
    hideLayer();
  });
  
  $("#cancelConfirm").bind('click', cancelConfirmBtnClk);
  
  /**
     * 退单申请确认
     */
  function cancelConfirmBtnClk() {
    var cancelParams = {};
    cancelParams.reasonCode = $("#cancelReason").val();
    cancelParams.cancelRemark = $("#cancelRemark").val();
    cancelParams.orderId = $("#orderId").val();
    cancelParams.CSRFToken=$("input[name='CSRFToken']").val();
    $.ajax({
      type : "post",
      url : cancelApplyUrl,
      data : cancelParams,
      async : false,//ajax同步请求
      dataType : "json",
      success : function(data, textStatus) {
        var respInfo = data.respInfo;
        var respCode = respInfo.RespCode;
        var respDesc = respInfo.RespDesc;
        if (respCode == '0') {
          refreshParent();
          CloseWin();
        } else {
          showError(respDesc);
        }
      }
    });
    $(".applyOrderLayer").hide();
    hideLayer();
  }

// 显示EMS面单打印
  function showEmsPrint(){
    showLayer();
    $(".orderPrint").show().center();
  }

// 显示电子面单打印
  function showElecPrint(){
    showLayer();
    $(".elecOrderPrint").show().center();
  }

// 打印弹出层 点击打印
  $(".orderPrint .btn .shortBlueBtn").on( 'click',function(){
      $(this).parents("ul").find(".right").show();
      $(this).val("重打印");
  });

// 打印弹出层 点击打印
  $(".elecOrderPrint .btn .shortBlueBtn").on( 'click',function(){
      $(this).parents("ul").find(".right").show();
      $(this).val("重打印");
  });

    // 打印弹出层上 的EMS面单
    $('#btnPrintEMS').on('click', function() {
        if (!checkDefaultDelivery()) {
            $(".orderPrint").hide();
            hideLayer();
            return;
        }
        preParams4EMS("print");
        printWindow();
    });

  // 预览弹出层上 的物流面单
  $('#previewDelivery').on('click',function(){
    rePrintOrPreviewDeliveryDocument("preview");
  });

  // 预览弹出层上 的EMS面单
  $('#previewEMS').on('click',function(){
      if(!checkDefaultDelivery()){
          $(".orderPrint").hide();
          hideLayer();
          return;
      }
    preParams4EMS("preview");
  });
  
// 电子运单弹出层JS控制
  // 打印弹出层上 的物流电子面单
  $('#btnPrintElecOrder').on('click',function(){
    rePrintOrPreviewDeliveryDocument("print");
  });
  
  // 预览弹出层上 的物流电子面单
  $('#previewElecDelivery').on('click',function(){
    rePrintOrPreviewDeliveryDocument("preview");
  });
  
  // 顺风运单打印
  $('#sforderprint').on('click',function(){
    var printWin = preParamsElec("order");
    printWin.print();
    // printWindow();
  });  

  // 顺风运单预览
  $('#sfordershow').on('click',function(){
      preParamsElec("order");
  });

  // 顺风顺风签回单打印
  $('#sfbackorderprint').on('click',function(){
    var printWin = preParamsElec("back");
    printWin.print();
    // printWindow();
  });  

    // 顺风签回单预览
    $('#sfbackordershow').on('click', function() {
        preParamsElec("back");
    });
    // EMS 标准快递发货单
    $("#btnPrintOrder").on('click', function() {
        var printWin = preEmsParamsElec("order");
        printWin.print();
    });
    // EMS 标准快递发货单预览
    $("#previewPrintOrder").on('click', function() {
        preEmsParamsElec("order");
    });
    // EMS 标准快递签回单
    $("#btnPrintBackOrder").on('click', function() {
        var printWin = preEmsParamsElec("backOrder");
        printWin.print();
    });
    // EMS 标准快递签回单预览
    $("#previewPrintBackOrder").on('click', function() {
        preEmsParamsElec("backOrder");
    });
    // EMS 代收货款发货单
    $("#btnPrintCollectionOrder").on('click', function() {
        var printWin = preEmsParamsElec("collectionOrder");
        printWin.print();
    });
    // EMS 代收货款发货单 预览
    $("#previewPrintCollectionOrder").on('click', function() {
        preEmsParamsElec("collectionOrder");
    });
    // EMS 代收货款签回单
    $("#btnPrintSignBackOrder").on('click', function() {
        var printWin = preEmsParamsElec("sign");
        printWin.print();
    });
    // EMS 代收货款签回单 预览
    $("#previewPrintSignBackOrder").on('click', function() {
        preEmsParamsElec("sign");
    });
    // 关闭打印弹出层
    $(".orderPrint .close").on({
        click : function() {
            $(this).parents(".layer").hide();
            hideLayer();
        }
    });

    // 发货修改
    $(".deliveryOpen").on('click', function() {
      location.href="/admin/am/delivery/deliveryAddr";
    });
    
// 关闭电子打印弹出层
  $(".elecOrderPrint .close").on({
      click:function(){
          $(this).parents(".layer").hide();
          hideLayer();
      }
  });
  /**
   * 提交物流单
   */
  $("#subLgtsOrder").on("click",function(){
      if(!checkDefaultDelivery()){
         return ; 
      }
      var subLgtsOrderParams={};
      subLgtsOrderParams.orderId = orderId;
      subLgtsOrderParams.logisticType = logisticType;
      var radioId = $("input:radio[name='billType']:checked").attr("id");
      subLgtsOrderParams.billType = radioId;
      subLgtsOrderParams.companyId = companyIdVal;
      subLgtsOrderParams.companyName = companyNameVal;

      subLgtsOrderParams.CSRFToken=$("input[name='CSRFToken']").val();
      
      if(radioId == "elecBill") {//电子运单
          subLgtsOrderParams.lgtsRemark = $("#lgtsRemark").val();
      }else{//纸质运单
          subLgtsOrderParams.lgtsOrder=$("#lgtsOrder").val();
          subLgtsOrderParams.lgtsRemark=$("#lgtsRemark").val();
          if(!checkDelivery('1')){//校验物流单号
              return ;
          }
      }
      
      $.ajax({
          type : "post",
          url : subLgtsOrderUrl,
          async : false,//ajax同步请求
          data : subLgtsOrderParams,
          dataType : "json",
          success :  function(data, textStatus) {
            // 当订单同步返回“失败”时（纸质和电子）(第三方物流同步失败，不让继续发货)
            if (!data.status) {
                $.alert(data.RESP_DESC);
                //hideWaitLayer();
                return;
            }
           if (data.status) { // 当调用接口成功时 // 当纸质运单返回“人工筛单”时
               $("#modeFirst").unbind();//第三方物流不能点
               $("#modeSecond").hide();//隐藏自行配送选项卡
               $("#modeThird").hide();//隐藏客户自提选项卡
               $(".selectCompany").unbind();//释放绑定 
               var lgtsId = subLgtsOrderParams.companyId;
               var _this =  $("#THIRD_LGTS_"+lgtsId).parents(".logisticsList");
                   _this.find("td").eq(1).find("a").hide();//隐藏修改
                   _this.find("td").eq(0).find("input").removeClass("selectCompany");
//               if (data.RESP_CODE == "WAIT") {
//                    $.smile(data.RESP_DESC);
//                    lgtsWait='3';//wait等待标示
//                }
                if(radioId == "elecBill") {//电子运单
                    $("#paperBill").hide();
                    $("#paperBillLabel").hide();
                    $("#elecBill").attr("checked", "checked");
                }else if (radioId == "paperBill") {//纸质运单
                    $("#elecBill").hide();
                    $("#elecBillLabel").hide();
                    $("#paperBill").attr("checked", "checked");
                }
                $(".billTypeTitle").hide();
                $("#paperBill").attr("disabled", "disabled");
                $("#elecBill").attr("disabled", "disabled");
                $("#paperNo").hide();
                $("#remarks").hide();
                $("#lgtsRemark").hide();
                
                $("#lgtsOrder").val(data.expressId);
                $("#paperNoShow label").text(data.expressId);
                $("#paperNoShow").show();
                
                $("#lgtsRemark").val(data.remark);
                $("#remarksShow label").text(data.remark);
                $("#remarksShow").show();
                //显示打印信息
                $("#subLgtsOrder").hide();
                $("#printFace").show();
                $("#preview").show();
                $("#rePrintFace").hide();
                $("#deliverySubmit").hide();
                $("#sendTips").hide();
                $("#preview").hide();//隐藏预览
                hashooseLgts='1';//防止页面刷新再次出现为选择的物流情况
            }else if (!data.status) {
                $.prompt2('操作失败',data.msg);
                
            }
            //hideWaitLayer();
          }
      	  //,
          //beforeSend : showWaitLayer
        });
  });
  
  //初始化选择的物流商信息公司
  if(hashooseLgts=='1'){
          checkedLgtsOrder = true;
          $("#THIRD_LGTS_"+chooseLgtsId).click();//已选择的物流公司
          if(wayBillForm =='1'){//电子运单
              var _this = $("#elecBill");
              $("#deliveryTable").insertAfter(_this.closest("div"));
              $("#selectCompanyInfo #elecBill").attr("checked",'checked').attr("disabled","disabled");//选中纸质运单
              $("#selectCompanyInfo #paperBill").removeAttr("checked").removeAttr("checked");
              $("#paperBillType").hide();//隐藏电子运单
          }else{// 纸质运单
              $("#selectCompanyInfo #paperBill").attr("checked",'checked').attr("disabled","disabled");//选中纸质运单
              $("#selectCompanyInfo #elecBill").removeAttr("checked").removeAttr("checked");
              $("#elecBillType").hide();//隐藏电子运单
          }
          $(".billTypeTitle").hide();//隐藏标题
          $("#subLgtsOrder").hide();//隐藏提交物流单
          $("#paperNoShow label").text(lgtsOrderNo);//
          $("#paperNoShow").show();//显示物流单号
          $("#remarksShow label").text(lgtsOrderRemark);
          $("#remarksShow").show();//显示物流备注
          $("#paperNo #lgtsOrder").val(lgtsOrderNo);
          $("#remarks #lgtsRemark").val(lgtsOrderRemark);
          $("#paperNo").hide();
          $("#remarks").hide();
          $("#modeSecond").hide();//隐藏自行配送选项卡
          $("#modeThird").hide();//隐藏客户自提
          $("#clientSelf").hide();//隐藏客户自提
          $("#preview").hide();//隐藏预览
          $("#modeFirst").unbind();//第三方物流不能点
      }
  
  

});

function cnLength(Str) {
  var escStr = escape(Str);
  var numI = 0;
  var escStrlen = escStr.length;
  for (i = 0; i < escStrlen; i++) {
    if (escStr.charAt(i) == '%') {
      if (escStr.charAt(++i) == 'u'){numI++;}
    }
  }
  return Str.length + numI;
}
// 截取字符串 中文 占两个
function setString(str, len) {
  var strlen = 0;
  var s = "";
  for ( var i = 0; i < str.length; i++) {
    if (str.charCodeAt(i) > 128) {
      strlen += 2;
    } else {
      strlen++;
    }
    s += str.charAt(i);
    if (strlen >= len) {
      return s;
    }
  }
  return s;
}

function changeTextLength() {
  $(".nameListTable dt span").each(function(index) {
    var _this = $(this);
    var _text = $(this).text();
    _this.attr("title", _text);
    if (cnLength(_text) > "10") {
      $(this).text(setString(_text, "8") + "...");
    } else {
      $(this).text(_text);
    }
  });
}


var selectSendMan = function (clickRadio) {
    var selectcheckedText = $(clickRadio).attr('staffName');
    $(".deliveryStaff").text("配送员工：" + selectcheckedText);
    var phone=$(this).attr('phone');
    phone = phone == 'null' ? '' : phone;
    $("#staffPhone").text(phone);
    staffIdVal = $(this).val();
    staffCodeVal = $(this).attr('staffCode');
    
    $("#confirmConsignor").show();
    $("#paging").hide();
    $("#queryCondition").hide();
    $("#nameList").hide();
    initPrintFaceTwo();
}