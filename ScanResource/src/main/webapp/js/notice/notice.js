$(document).ready(function() {
    // 提交事件
    Notice.submit = function(type) {
        if (!Notice.validate()) {
            return;
        }
        var e = editor_Notice;
        $("#content").val($.base64Encode(editor_Notice.html()));

//        $("#outerUrl").val($.base64Encode($("#outerUrl").val())); // 防止过滤 转码
        var action = ADMIN.ctx + ("add" == type ? "/admin/am/notice/addSubmit" : "/admin/am/notice/editSubmit");
        $("#NoticeForm").attr("action", action);
        $("#NoticeForm").ajaxSubmit({
            beforeSubmit : function() {
                $.startLoading();
                $.overLayOn();
            },
            dataType : 'json',
            success : function(res) {
                if (res.result=="true") {
                    $.smile("操作成功", Notice.submitCp);
                }
                else {
                    $.alert(res.msg);
                }
            }, // end success
            complete : function() {
                $.endLoading();
                $.overLayOff();
            }
        });
    }

    Notice.checkNoticeTitle = function() {
        $("#noticeTitleError").hide();

        var noticeTitle = $.trim($("#dataTitle").val());
        if ("" == noticeTitle) {
            $("#noticeTitleError_Text").text("公告标题不得为空");
            $("#noticeTitleError").show();
            return false;
        }
        if (60 < $.charLength(noticeTitle)) {
            $("#noticeTitleError_Text").text("公告标题不超过30个汉字");
            $("#noticeTitleError").show();
            return false;
        }
        return true;
    }
    $("#dataTitle").blur(Notice.checkNoticeTitle);

    Notice.checkOrderSeq = function(){
        $("#orderSeqError").hide();

        var orderSeq = $.trim($("#orderSeq").val());
        if("" == orderSeq) {
            $("#orderSeqError_Text").text("公告排序不能为空!");
            $("#orderSeqError").show();
            return false;
        }
        if(!(/^\d+$/.test(orderSeq))){
            $("#orderSeqError_Text").text("公告排序为整数数字!");
            $("#orderSeqError").show();
            return false;
        }
        return true;
    }
    $("#orderSeq").blur(Notice.checkOrderSeq);

    Notice.validate = function() {
        $("#noticeContentError").hide();

        if (!Notice.checkNoticeTitle()) {
            return false;
        }

        if(!Notice.checkOrderSeq()){
            return false;
        }

        if(!Notice.checkContent()){
            return false;
        }

        return true;
    }

    Notice.checkOuterUrl = function() {
        $("#outerLinkError").hide();
        var outerLink = $.trim($("#outerUrl").val());
        if ("" == outerLink) {
            $("#outerLinkError_Text").text("链接地址不得为空");
            $("#outerLinkError").show();
            return false;
        }

        if (1000 < $.charLength(outerLink)) {
            $("#outerLinkError_Text").text("链接地址不超过1000个字符");
            $("#outerLinkError").show();
            return false;
        }
        return true;
    }

    Notice.submitCp = function() {
        window.location.href = ADMIN.ctx+"/admin/am/notice/getPagedNotice";
    }

    Notice.checkContent = function(){
        $("#noticeContentError").hide();

        var content = editor_Notice.html();
        if("" == content) {
            $("#noticeContentError_Text").text("公告内容不能为空!");
            $("#noticeContentError").show();
            return false;
        }
        return true;
    }

    Notice.urlTypeChange = function() {
        $("#outerLinkError").hide();
        $("#noticeContentError").hide();
        var urlType = $("input[name='urlType']:checked").val();
        var b = "0" == urlType;
        $("#editorNotice").toggle(b);
        $("#outerLink").toggle(!b);
    }

    $("input[name='urlType']").click(Notice.urlTypeChange);

    // 选择全部
    Notice.selectAll = function() {
        var checked = $("#checkAllMerchant").attr("checked");
        $("input[name='merchants']").attr("checked", checked);
    }

    Notice.selectOne = function() {
        var checked = $("input[name='merchants']").length == $("input[name='merchants']:checked").length;
        $("#checkAllMerchant").attr("checked", checked);
    }

    $("input[name='merchants']").click(Notice.selectOne);
    $("#checkAllMerchant").click(Notice.selectAll);

    // 删除前弹出提示
    Notice.deleteNoticPrompt = function(noticeID) {
        var doFunction = function() {
            Notice.deleteNotic(noticeID);
        }
        $.prompt('删除提示', '确定删除?', doFunction);
    }

    // 删除公告信息
    Notice.deleteNotic = function(noticeId) {
        var url = ADMIN.ctx+"/admin/am/notice/delById";
        var data = {};
        data['noticeId'] = noticeId;
        data['CSRFToken'] = $("input[name='CSRFToken']").val();
        $.phwAjax2(url, data, Notice.deleteNoticCp);
    }

    Notice.deleteNoticCp = function() {
        $.overLayOff();
        Notice.submitCp();
    }
});
