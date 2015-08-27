//条件查询
function searchSubmit(){
    pageData.staffID = $("#staffID").val();
    pageData.staffName = $("#staffName").val();
    pageData.roleName = $("#roleName").val();
    PaginationpageTable.reQurey();
};

//显示员工详情
function showStaffInfo(id){
    $("#table_model tr").css({"position":"static"});
    $("#staffDiv"+id).parents(".staffList").css("position","relative");
    $("#employeeDetails"+id).show();
    $("#employeeDetails"+id).mouseenter(function(){
        $("#employeeDetails"+id).show();
    }).mouseleave(function(){
        $("#employeeDetails"+id).hide();
    });
};

function hideStaffInfo(id){
    $("#employeeDetails"+id).hide();
}

// 新增时根据角色类表刷新分组列表
function refreshGroupList(){
    var roleListValue ="";
    $("input[name='roleCheckbox']").each(
        function(){
            if(this.checked){
                roleListValue += this.value+";";
            }
        }
    );
    $(".globalThickdiv").show();
    $.ajax({
        type : "POST",
        url : "RefreshGroupList",
        data:  {
            'roleListValue' : roleListValue,
            'staffID':$("#editStaffIdHide").val()
        },
        success: function(res){
            $(".globalThickdiv").hide();
            var str = res.replace(new RegExp("<script(.|\s)*?\/script>", "ig"), "");
            var startindex = str.lastIndexOf("<div id='groupListDiv' class='listContent'>");
            var endindex   = str.lastIndexOf("<span id='groupListDivFlag'></span>");
            var tempstr = str.substring(startindex+43,endindex-6);
            jQuery("#groupListDiv").html(tempstr);
        }
    });
};
//检查提交字段
function checkData(n){
    if(n==1){
        if (!staffLoginNameValue()){
            $("#staffLoginNameError").focus();
            return false;
        }

        /*if(!checkPassword()){
         $("#mobileError").focus();
         return false;
         }*/

        if(!checkMobile()){
            $("#mobileError").focus();
            return false;
        }

        if($("#staffLoginNameError").css("display") == 'block') {
            return false;
        }
    }
    if (!checkName()){
        $("#staffNameValueError").focus();
        return false;
    }
    if (!checkMobile()){
        $("#mobileError").focus();
        return false;
    }
    if (!checkEmail()){
        $("#emailError").focus();
        return false;
    }
    if(!checkAreaCode()){
        $("#areaCode").focus();
        return false;
    }
//    if(!checkBusiArea()){
//        return false;
//    }
}

//确定新增
function checkIncrease(){
    if(checkData(1) == false){
        return;
    }
    var roleListValue ="";
    var groupListValue = "";
    var busiListValue = "";
    var appLevel = "";
    var appListValue = "";
    var busiAreaCode = $(".busiArea ul.listSelect input:checked");

    $("input[name='roleCheckbox']").each(
        function(){
            if(this.checked){
                roleListValue += this.value+";";
            }
        }
    );
    /*$("input[name='groupCheckbox']").each(
     function(){
     if(this.checked){
     groupListValue += this.value+";";
     }
     }
     );
     busiAreaCode.each(
     function(){
     busiListValue += $(this).attr("id")+";";
     }
     );
     if(busiListValue != ""){
     busiListValue = busiListValue.substr(0,busiListValue.length-1);
     }*/
    $(".globalThickdiv").show();
    $.ajax({
        type : "POST",
        url : ADMIN.ctx+"/admin/am/staffManage/addStaff",
        data:  {
            'staffCode' : $("#staffLoginName").val(),
            'staffName' : $("#staffNameValue").val(),
            'linkPhone' : $("#mobile").val(),
            'email' : $("#emailValue").val(),
            'areaCode' : $("#areaCode").val(),
            'roleListValue' : roleListValue,
            'groupListValue' : groupListValue,
            'busiListValue' : busiListValue,
            'appListValue' : appListValue,
            'merchantType' : $("#merchantType").val(),
            'smsPassword' : $("#smsPassword").val(),
            'CSRFToken' : $("input[name='CSRFToken']").val()
        },
        beforeSend: function(){
            startLoading();
            overLayOn();
        },
        success: function(res){
            $("#newSuccess").fadeIn();
            $(".globalThickdiv").show();
        },
        complete : function(){
            endLoading();
            overLayOff();
        }

    });
};

//确定编辑
function editCommit(){
    if(checkData(2) == false){
        return;
    }
    var roleListValue ="";
    var groupListValue = "";
    var busiListValue = "";
    var appLevel = "";
    var appListValue = "";
    var busiAreaCode = $(".busiArea ul.listSelect input:checked");
    //联通员工号拼接
    var essStaffCode = "";
    $("input[name='roleCheckbox']").each(
        function(){
            if(this.checked){
                roleListValue += this.value+";";
            }
        }
    );
    $("input[name='groupCheckbox']").each(
        function(){
            if(this.checked){
                groupListValue += this.value+";";
            }
        }
    );
    busiAreaCode.each(
        function(){
            busiListValue += $(this).attr("id")+";";
        }
    );
    if(busiListValue != ""){
        busiListValue = busiListValue.substr(0,busiListValue.length-1);
    }
    $(".globalThickdiv").show();
    $.ajax({
        type : "POST",
        url : ADMIN.ctx+"/admin/am/staffManage/updateStaff",
        data:  {
            'staffID' : $("#editStaffIdHide").val(),
            'staffCode' : $("#staffLoginName").val(),
            'essStaffId' : essStaffCode,
            'staffName' : $("#staffNameValue").val(),
            'linkPhone' : $("#mobile").val(),
            'smsPassword' : $("#smsPassword").val(),
            'email' : $("#emailValue").val(),
            'areaCode' : $("#areaCode").val(),
            'roleListValue' : roleListValue,
            'groupListValue' : groupListValue,
            'busiListValue' : busiListValue,
            'appListValue' : appListValue,
            'merchantType' : $("#merchantType").val(),
            "CSRFToken" : $("input[name='CSRFToken']").val()
        },
        success: function(res){
            $("#modifySuccess").fadeIn();
            $(".globalThickdiv").show();
        }
    });
};

//新增成功关闭
function successClose(){
    window.location.href = ADMIN.ctx+"/admin/am/staffManage/init";
};

//编辑成功关闭
function modifySuccessClose(){

    $("#modifySuccess").fadeOut();
    $(".globalThickdiv").hide();
    window.location.href=ADMIN.ctx+"/admin/am/staffManage/init";
//    backToInit();
};

//删除确认提示
function deleteStaff(id,code,name){
    $("#deleteLayer").fadeIn();
    $(".globalThickdiv").show();
    $(".deleteStaffId").html(code);
    $(".deleteStaffName").html(name);
    $("#deleteStaffIdHide").val(id);
};

//确认删除
function deleteSure(){
    if($("#deleteStaffIdHide").val() == "" || $("#deleteStaffIdHide").val() == null){
        alert("要删除的员工不存在");
        return;
    }
    $.ajax({
        type : "POST",
        url : ADMIN.ctx+"/admin/am/staffManage/delStaffByID",
        data:  {
            'delStaffId' : $("#deleteStaffIdHide").val(),
            "CSRFToken" : $("input[name='CSRFToken']").val()
        },
        success: function(r){
            $("#deleteLayer").fadeOut();
            $(".globalThickdiv").hide();
            window.location.href=ADMIN.ctx+"/admin/am/staffManage/init";
        },
        complete: function(XMLHttpRequest, textStatus) {
            $("#deleteLayer").hide();
        }
    });
};

//编辑员工
function editStaff(id,code,name,phone,email,areaCode){
    $(".error").each(function(){
        $(this).hide();
    });
    $("#areasError").show();
    $("#busiAreaRemind").hide();
    $(".correct").each(function(){
        $(this).hide();
    });
    $("#smsPassword").val("");
    $("#editStaffIdHide").val(id);
    $("#addStaffInfo").html("修改员工信息");
    $("#editBtnArea").show();
    $("#addBtnArea").hide();
    $("#editStaffCodeDiv").html("<span>"+code+"</span>");
    $("#staffCodeDiv").hide();
    $("#editStaffCodeDiv").show();
    $("#staffLoginName").val(code);
    $("#staffNameValue").val(name);
    $("#mobile").val(phone);
    //$("#smsNotif").show();
    $("#emailValue").val(email);
    $("#areaCode").val(areaCode);
    $(".globalThickdiv").show();
    $.ajax({
        type : "POST",
        url : ADMIN.ctx+"/admin/am/staffManage/queryStaffInfoByID",
        data:  {
            'staffID' : id,
            "CSRFToken" : $("input[name='CSRFToken']").val()
        },
        success: function(res){
            $(".globalThickdiv").hide();
            var str = res.replace(new RegExp("<script(.|\s)*?\/script>", "ig"), "");
            var roleStartIndex = str.lastIndexOf("<div id='roleListDiv' class='listContent'>");
            var roleEndIndex = str.lastIndexOf("<span id='roleListDivFlag'></span>");
            jQuery("#roleListDiv").html(str.substring(roleStartIndex+42,roleEndIndex-6));

            /*var startindex = str.lastIndexOf("<div id='groupListDiv' class='listContent'>");
             var endindex   = str.lastIndexOf("<span id='groupListDivFlag'></span>");
             jQuery("#groupListDiv").html(str.substring(startindex+43,endindex-6));*/

            //给应用区域赋值
            /*var areaStartindex = str.lastIndexOf("<dd class='busiArea'>");
             var areaEndindex   = str.lastIndexOf("<span id='busiListDivFlag'></span>");
             jQuery(".busiArea").html(str.substring(areaStartindex+21,areaEndindex-5));*/

            //点编辑是否需要选中全选按钮
//                  checkOneBusiArea();

            //如果是归属区域为地市，则应用区域不可编辑
            /*if(areaCode && areaCode.length==3){
             $(".busiArea .selectAll ul input[type=checkbox] ").attr("disabled",true);
             $(".busiArea ul.listSelect input[type=checkbox]").each(function(){
             $(this).attr("disabled",true);
             });
             }*/

            //给绑定区域赋值
            /*var appAreaStartindex = str.lastIndexOf("<div class='unbindTop'>");
             var appAreaEndindex   = str.lastIndexOf("<span id='appAreaListDivFlag'></span>");
             jQuery(".unbindTop").html(str.substring(appAreaStartindex+23,appAreaEndindex-6));*/

            //ESS工号绑定【已绑定、未绑定】修改
//                  checkBind();

            //截取角色权限长度
            //cutRoleRigthS();
            //cutRoleRigthB();

        }
    });
};

//恢复
function backToInit(){
    $("#addStaffInfo").html("新增员工信息");
    $("#editStaffIdHide").val("");
    $("#staffCodeDiv").show();
    $("#editStaffCodeDiv").hide();
    $("#editBtnArea").hide();
    $("#addBtnArea").show();
    clearStaffInfo();
    $("#channelType").val("");
    $("#channelId").val("");
    $("#channelDesc").html("");
    $("#cityId").attr("disabled","");
    $("#areaId").attr("disabled","");
    $("#provinceCode").attr("disabled","");
}

//重置
function clearStaffInfo(){
    $(".correct").hide();
    $(".autoDistribution").show();
    $("#checkJobNumber").show();
    $("#smsPassword").val("");
    $("#staffLoginName").val("");
    $("#staffNameValue").val("");
    $("#mobile").val("");
    //$("#smsNotif").show();
    $("#emailValue").val("");
    $("#areaCode").val("");
    $("#allBusiArea").attr("checked",false);
    $("#essStaffId").val("");
    $("#provinceCode").html("");
    $("#cityId").html("");
    $("#areaId").html("");
    $("#channelType").val("");
    $("#channelId").val("");
    $("#channelDesc").html("");
    $("#groupListDiv").html("");
    $("input[name='roleCheckbox']").each(
        function(){
            this.checked = false;
        }
    );
    $(".error").each(function(){
        $(this).hide();
    });
    $("#busiAreaRemind").hide();
    $("#cityId").attr("disabled","");
    $("#areaId").attr("disabled","");
    $("#provinceCode").attr("disabled","");
    $(".busiArea ul.listSelect input").each(function(){
        $(this).attr("checked",false);
    });
    $(".inforUnbind").hide();
    $(".unbindTitle").show();
//      clearEssStaffInfo();
    $("#inforTable tr:gt(0)").remove();
//      clearAllCheckButton();
    //检查是否有绑定区域
//      checkBind();
};

//登录名校验
function staffLoginNameValue(){
    $("#autoDistributionCorrect").hide();
    var staffLoginName = document.getElementById("staffLoginName");
    var reg = /^[A-Za-z0-9]*$/;
    if(!reg.test($(staffLoginName).val())){
        $("#staffLoginNameError").html("登录名只能是字母或数字");
        $("#staffLoginNameError").show();
        return false;
    }
    if ($.trim(staffLoginName.value) == ""){
        $("#autoDistributionCorrect").hide();
        $("#staffLoginNameError").show();
        $("#staffLoginNameError").html("登录名不能为空");
        $(".autoDistribution").show();
        return false;
    }
    if (cnLength(staffLoginName.value) < 6) {
        $("#staffLoginNameError").show();
        $("#staffLoginNameError").html("登录名必须大于等于6个字符");
        $("#autoDistributionCorrect").hide();
        return false;
    }
    $(".globalThickdiv").show();
    $.ajax({
        async : false,
        type : "GET",
        url : ADMIN.ctx+"/admin/am/staffManage/checkStaffCode",
        data:  {
            'staffCode' : $("#staffLoginName").val()
        },
        success: function(res){
            if(res.isOk == "true"){
                $(".globalThickdiv").hide();
                $(".autoDistribution").hide();
                $("#staffLoginNameError").hide();
                $("#autoDistributionCorrect").show();
            }else{
                $(".globalThickdiv").hide();
                $("#staffLoginNameError").show();
                $("#staffLoginNameError").html("登录名已存在，请重新输入！");
            }
        }
    });
    return true;
}

// 返回字符串字节数
function cnLength(Str) {
    var escStr = escape(Str);
    var numI = 0;
    var escStrlen = escStr.length;
    for (i = 0; i < escStrlen; i++)
        if (escStr.charAt(i) == '%')
            if (escStr.charAt(++i) == 'u')
                numI++;
    return Str.length + numI;
}

// 姓名校验
function checkName() {
    $("#nameCorrect").hide();
    var nameValue = document.getElementById("staffNameValue");
    var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）;—|{}【】‘；：”“'。，、？]");
    if (pattern.test($(nameValue).val())) {
        $("#staffNameValueError").html("员工名只能是汉字字母或数字");
        $("#staffNameValueError").show();
        return false;
    }
    if ($.trim(nameValue.value) == "") {
        $("#staffNameValueError").show();
        $("#staffNameValueError").html("请填写员工姓名");
        return false;
    }
    if (nameValue.value.length > 10) {
        $("#staffNameValueError").show();
        $("#staffNameValueError").html("员工姓名过长，请您最多输入10个汉字。");
        return false;
    }
    if (nameValue.value.length < 2) {
        $("#staffNameValueError").show();
        $("#staffNameValueError").html("员工姓名必须大于2个汉字");
        return false;
    } else if (stringHelper.checkScript(nameValue.value)) {
        $("#staffNameValueError").show();
        $("#staffNameValueError").html("员工姓名包含非法字符。");
        return false;
    } else {
        $("#staffNameValueError").hide();
        $("#nameCorrect").show();
    }
    return true;
}

// 手机验证
function checkMobiles(theForm) {
    return /^((13|15|18|14|17)+\d{9})$/.test(theForm);
}

function checkMobile() {
    var mobile = document.getElementById("mobile");
    //$("#smsNotif").show();
    $("#mobelCorrect").hide();
    if ($.trim(mobile.value) == "") {
        $("#mobelCorrect").hide();
        $("#mobileError").show();
        $("#mobileError").html("手机号码不能为空");
        return false;
    }
    if (!checkMobiles($.trim(mobile.value))) {
        $("#mobileError").show();
        $("#mobileError").html("手机格式不正确");
        $("#mobelCorrect").hide();
        return false;
    } else {
        $("#mobileError").hide();
    }
    $("#mobelCorrect").show();
    return true;
}

// 邮箱验证
function checkEmail() {
    $("#emailCorrect").hide();
    var email = document.getElementById("emailValue");
    if ($.trim(email.value) == "") {
        $("#emailValueError").show();
        $("#emailValueError").html("请填写邮箱");
        return false;
    }
    if (!$("#emailValue").val().match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)) {
        $("#emailValueError").show();
        $("#emailValueError").html("邮箱格式不正确");
        return false;
    } else {
        $("#emailValueError").hide();
        $("#emailCorrect").show();
    }
    return true;
}

/**
 * 校验归属区域是否选择
 * @returns {boolean}
 */
function checkAreaCode(validateAreaCode){
    var areaCode = $("#areaCode").val();
    if(areaCode == ""){
        $("#areaCodeCorrect").hide();
        $("#areaCodeValueError").html("归属区域不能为空");
        $("#areaCodeValueError").show();
        return false;
    }else{
        $("#areaCodeValueError").hide();
        $("#areaCodeCorrect").show();
    }
    return true;
}

function stringHelper() {
}
stringHelper.checkScript = function(text) {
    var flag = false;
    var scriptWord = "<|>|script|alert|{|}|#|$|'|\"|:|;|&|*|@@|%|^|?";
    var words = scriptWord.split('|');
    for ( var i = 0; i < words.length; i++) {
        if (text.indexOf(words[i]) != -1) {
            flag = true;
            break;
        }
    }
    return flag;
};

// 开始loading进度条
function startLoading(loadMsg){
    var _loadMsg = loadMsg || "加载中";
    var loading = "<div class='loading' id='pop_loading' style='display : none;z-index:99999999999'>";
    loading += "<i><img src='"+ Esf.resPath +"/images/loading.gif' width='20px' height='20px'/></i>";
    loading += "<span>"+ _loadMsg +"...</span></div>";
    var docbody = $(document.body);
    if(document.getElementById("pop_loading")==null){
        docbody.append(loading);
    }
    $("#pop_loading").center().show();
}
// 启用遮蔽
function overLayOn() {
    // 如果已经有遮蔽 则返回
    if(0 < $("#Tips_thickdiv").length) {
        return;
    }
    var docbody = $(document.body);
    if(document.getElementById("Tips_thickdiv")==null){
        docbody.append("<div id='Tips_thickdiv' class='thickdiv' style='display:none'></div>");
    }
    $("#Tips_thickdiv").show();
}

// 结束loading进度条
function endLoading(){
    $("#pop_loading").remove();
}

function overLayOff() {
    var thick = $("#Tips_thickdiv");
    if(thick) {
        thick.remove();
    }
}

$(function(){

    // 删除取消
    $("#deleteCancel").click(function() {
        $("#deleteStaffIdHide").val("");
        $("#deleteLayer").fadeOut();
        $(".globalThickdiv").hide();
    });

    // 自动分配
    $(".autoDistribution").click(function() {
        $(".autoDistribution").hide();
        $("#staffLoginNameError").hide();
        $(".globalThickdiv").show();
        $.ajax({
            type : "GET",
            url : ADMIN.ctx+"/admin/am/staffManage/getStaffCode",
            success : function(ret) {
                $("#staffLoginName").val(ret);
                $("#autoDistributionCorrect").show();
                $("#staffLoginNameError").hide();
                $(".globalThickdiv").hide();
            }
        });
    });
});