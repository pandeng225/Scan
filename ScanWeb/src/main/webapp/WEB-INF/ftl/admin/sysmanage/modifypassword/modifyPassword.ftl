<#include "/admin/layout/common/layout.ftl">
<@layout title="员工管理">
<div class="rightBar">
    <link href="${e.res('/css/merchant_staff.css')}" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="${e.res("/js/sysmanage/modifypassword/modifyPassword.js")}"></script>

    <div class="layoutRight">
        <div class="navigation">
            <div class="navigationLeft">
                系统管理<span>&gt;</span>密码修改
            </div>
        </div>
        <div class="passwdBox">
            <h2>密码修改</h2>
            <table width="550" cellspacing="10" cellpadding="0">
                <tr>
                    <th width="170">我的旧密码：</th>
                    <td><input type="password" class="iptW220H21" id="oldPassWord" /></td>
                </tr>
                <tr id="oldPasswordTips" style="display:none;">
                    <th>&nbsp;</th>
                    <td>
                        <div class="error oldPasswordError"></div>
                    </td>
                </tr>
                <tr>
                    <th>请输入新密码：</th>
                    <td>
                        <input type="password" class="iptW220H21" id="newPassword" maxlength="20"/>
                        <div class="tips_password"><i></i><p>密码不允许包含<、>、'、# </p></div>
                    </td>
                </tr>
                <tr id="passwordTips" style="display:none;">
                    <th>&nbsp;</th>
                    <td>
                        <div class="error passwordError"></div>
                    </td>
                </tr>
                <tr>
                    <th>请再次输入新密码：</th>
                    <td><input type="password" class="iptW220H21" id="newPasswordRepeat" maxlength="20"/></td>
                </tr>
                <tr id="passwordTips2" style="display:none;">
                    <th>&nbsp;</th>
                    <td>
                        <div class="error passwordError2"></div>
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td><span class="shortBlueSubmitBtn" id="submitPassword">提　交</span></td>
                </tr>
            </table>
        </div>
    </div>
</@layout>