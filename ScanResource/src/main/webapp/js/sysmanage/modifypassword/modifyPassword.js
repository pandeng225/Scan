var oldPasswdIsRight = false;

$(function() {

    var checkOldPassWdURL = ADMIN.ctx+"/admin/am/modifyPassword/checkOldPassWd";
    var modifyPasswordURL = ADMIN.ctx+"/admin/am/modifyPassword/modifyPassword";

    /**
     * 7-20位新密码必须包含以下四类字符中的三类字符:
     *
     * ◎英文大写字母(A 到 Z)
     *
     * ◎英文小写字母(a 到 z)
     *
     * ◎10 个基本数字(0 到 9)
     *
     * ◎非字母字符(例如 !、$、#、%)
     */
    var reg = /^(?:(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])|(?=.*[A-Z])(?=.*[a-z])(?=.*[^A-Za-z0-9])|(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])|(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9])).{7,20}$/;
    /**
     * 旧密码失去焦点
     */
    $("#oldPassWord").bind('blur', function() {

        var oldPassword = $.trim($('#oldPassWord').val());
        if ("" == oldPassword) {
            $(".oldPasswordError").html("请输入旧密码");
            $("#oldPasswordTips").show();
            return;
        }

        var params = {};
        params.oldPassword = oldPassword;
        $.ajax({
            type : "get",
            url : checkOldPassWdURL,
            data : params,
            dataType : "json",
            success : afterCheckOldPassWd
        });
    });
    /**
     * 检查旧密码是否正确
     *
     * @param data
     */
    function afterCheckOldPassWd(data) {
        if (data.result) {// 密码正确
            oldPasswdIsRight = true;
            $("#oldPasswordTips").hide();
        } else {
            oldPasswdIsRight = false;
            $(".oldPasswordError").html("旧密码输入错误");
            $("#oldPasswordTips").show();
        }
    }

    /**
     * 旧密码获得焦点 进入编辑状态
     */
    $("#oldPassWord").bind('focus', function() {
        $("#oldPasswordTips").hide();
        oldPasswdIsRight = false;
    });

    /**
     * 密码复杂度校验
     */
    function checkStrong(value) {
        var strength = 0;
        if (value.length > 6 && value.match(/[\da-zA-Z]+/)) {
            if (value.match(/\d+/)) {
                strength = strength + 1;
            }
            if (value.match(/[a-z]+/)) {
                strength = strength + 1;
            }
            if (value.match(/[A-Z]+/)) {
                strength = strength + 1;
            }
            if (value.match(/[!@*\-_$()+=&￥]+/)) {
                strength = strength + 1;
            }
        }
        if (strength >= 3) {
            return true;
        }
    }
    /**
     * 检查新密码
     */
    function checkNewPassWord() {
        var oldPassword = $.trim($('#oldPassWord').val());
        var newPassword = $.trim($('#newPassword').val());
        var newPasswordRepeat = $.trim($('#newPasswordRepeat').val());
        if ("" == newPassword) {
            $(".passwordError").html("请输入新密码").css('width', '185px');
            $("#passwordTips").show();
            return false;
        }
        if (!checkStrong(newPassword)) {
            $("#passwordTips").show();
            $(".passwordError").html("7-20位数字、大小写字母或特殊字符(4选3)").css('width', 'auto');
            return false;
        }
        if (newPassword == oldPassword) {
            $(".passwordError").html("新密码不能与旧密码相同").css('width', '185px');
            $("#passwordTips").show();
            return false;
        }
        if (newPasswordRepeat != "" && newPassword != newPasswordRepeat) {
            $(".passwordError2").html("输入的密码不一致");
            $("#passwordTips2").show();
            return false;
        } else {
            $("#passwordTips2").hide();
        }
        $("#passwordTips").hide();
        return true;
    }

    /**
     * 新密码失去焦点
     */
    $("#newPassword").bind('blur', checkNewPassWord);

    /**
     * 新密码获得焦点 进入编辑状态
     */
    $("#newPassword").bind('focus', function() {
        $("#passwordTips").hide();
    });

    /**
     * 检查重读输入的新密码
     */
    function checkNewPassWordRepeat() {
        var newPassword = $.trim($('#newPassword').val());
        var newPasswordRepeat = $.trim($('#newPasswordRepeat').val());

        if ("" == newPasswordRepeat) {
            $(".passwordError2").html("请再次输入密码");
            $("#passwordTips2").show();
            return false;
        }

        if (newPassword != newPasswordRepeat) {
            $(".passwordError2").html("输入的密码不一致");
            $("#passwordTips2").show();
            return false;
        }
        $("#passwordTips2").hide();
        return true;
    }

    /**
     * 重复 新密码失去焦点
     */
    $("#newPasswordRepeat").bind('blur', checkNewPassWordRepeat);

    /**
     * 重复 新密码获得焦点 进入编辑状态
     */
    $("#newPasswordRepeat").bind('focus', function() {
        $("#passwordTips2").hide();
    });

    /**
     * 提交密码修改
     */
    $("#submitPassword").on("click", function() {
        if (!oldPasswdIsRight) {
            $(".oldPasswordError").html("请输入旧密码");
            $("#oldPasswordTips").show();
            return;
        }
        if (!checkNewPassWord()) {
            return;
        }
        if (!checkNewPassWordRepeat()) {
            return;
        }

        var oldPassword = $.trim($('#oldPassWord').val());
        var newPassword = $.trim($('#newPassword').val());
        var params = {};
        params.oldPassword = oldPassword;
        params.newPassword = newPassword;
        $.ajax({
            type : "get",
            url : modifyPasswordURL,
            data : params,
            dataType : "json",
            success : afterModifyPassword
        });
    });

    /**
     * 提交密码修改 回调
     */
    function afterModifyPassword(data) {
        if (data.msg) {
            $.alert(data.msg);
            return;
        }
        if (data.result) {
            $.smile("修改成功");
            $('#oldPassWord').val('');
            $('#newPassword').val('');
            $('#newPasswordRepeat').val('');
        } else {
            $.alert("修改失败");
        }
    }

    // 密码提示
    $(".tips_password i").hover(function() {
        $(this).next("p").show();
    }, function() {
        $(this).next("p").hide();
    })
});
