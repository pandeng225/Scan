<#include "/admin/layout/common/layout.ftl">
<@layout title="广告配置管理">
<div class="rightBar">
<link href="${e.res('/css/prodconf.css')}" rel="stylesheet" type="text/css" />

<div class="layoutRight">
<div class="navigation">
    <div class="navigationLeft">
        配置管理<span>&gt;</span>广告配置管理
    </div>
</div>
    <@form.form method="post" id="decoraterForm" action="${rc.contextPath}/admin/am/decorater/updateDecorater">
    <div class="fSection">
        <h2 class="sTl">首页头部广告
        </h2>
        <input type="hidden" name="typeId" value="HOME_TOP_BANNAR" />
        <input type="hidden" name="dataKey" value="IMG" />
        <input type="hidden" name="dataTitle" value="首页头部广告" />
        <#if (decoraterList?size>0) >
        <div id="decoraterContentId">
        <#list decoraterList as decorater>
            <table cellspacing="10" cellpadding="0" border="0" class="sTable">
                <tbody>
                <tr>
                    <th>图片跳转链接：</th>
                    <td>
                        <input id="clickUrl${decorater_index+1}" value="${decorater.CLICK_URL}" name="clickUrl" type="text" class="inputStyle w420 mrgR10" >
                        <label class="cGray">请输入有效的url地址</label>
                    </td>
                </tr>
                <tr class="goodsNameError" style="display:none;" id="clickUrlErrorTR${decorater_index+1}">
                    <th></th>
                    <td><span id="clickUrlError${decorater_index+1}" class="error"></span></td>
                </tr>
                <tr>
                    <th>上传图片：</th>
                    <td>
                        <input type="hidden" id="imageUrl${decorater_index+1}" name="imageUrl" value="${decorater.IMAGE_URL}" index= "${decorater_index+1}" />
                        <label>
                            <img id="imgShow${decorater_index+1}" style="width:85px; height:85;overflow:hidden;" width="85" height="85" src="${decorater.IMAGE_URL}" />
                        </label>
                        <div id="upload_button${decorater_index+1}" class="upload_btu ie6_png">
                            <div style="padding-left: 370px" ><a href="javascript:" class="shortBtn" id="resetBtn${decorater_index+1}" onclick="resetInfo('${decorater_index+1}')">重&nbsp;&nbsp;置</a></div>
                        </div>
                    </td>
                </tr>
                <tr class="goodsLabelError" style="display:none" id="imageUrlErrorTR${decorater_index}">
                    <th></th>
                    <td><span class="error" id="imageUrlError${decorater_index}"></span></td>
                </tr>
                </tbody>
            </table>
        </#list>
        </div>
        </#if>

        <div class="submitBox">
            <input type="button" id="decoraterBtn" class="longWhiteSubmitBtn onlySave" value="保存" />
        </div>
    </div>
    </@form.form>
<script type="text/javascript" src="${e.res('/js/ajaxupload.js')}"></script>
<script language="javascript" src="${e.res('/js/jquery/jquery.form.js')}"></script>
<script type="text/javascript" language="javascript">
    var maxNum = 5;
    function bindingUpload() {
        for(var i=1; i<=maxNum; i++){
            new AjaxUpload($("#upload_button"+i),{
                action: '${rc.contextPath}/admin/am/decorater/uploadImage?num='+i,
                responseType: 'json',
                data :{"CSRFToken":$("input[name='CSRFToken']").val()},
                name: 'img',
                onSubmit : function(file, ext){
                    if(!(ext && /^(jpg|png|jpeg|gif|JPG|PNG|JPEG|GIF)$/.test(ext))){
                        $.alert("请上传图片文件!");
                        return false;
                    }
                },
                onComplete: function(file, uploadResult){
                    var num = uploadResult.num;
                    if(uploadResult.key == 'extNameError'){
                        showErrors("imageUrlErrorTR"+num,"imageUrlError"+num,"图片格式不正确");
                        return;
                    }
                    else if(uploadResult.key == 'sizeError'){
                        showErrors("imageUrlErrorTR"+num,"imageUrlError"+num,"图片单张大小不超过300K");
                        return;
                    }
                    else if(uploadResult.key == 'whError'){
                        showErrors("imageUrlErrorTR"+num,"imageUrlError"+num,"图片尺寸不得低于310*310");
                        return;
                    }
                    else if(uploadResult.key == 'ioError'){
                        showErrors("imageUrlErrorTR"+num,"imageUrlError"+num,"上传图片异常");
                        return;
                    }else if(uploadResult.key == 'fileTypeError'){
                        showErrors("imageUrlErrorTR"+num,"imageUrlError"+num,"图片文件无法显示,请确认");
                        return;
                    }
                    else{
                        $("#imageUrl"+uploadResult.num).val(uploadResult.imgValue);
                        $("#imgShow"+uploadResult.num).attr({src : uploadResult.key });
                    }
                }
            });
        }
    }

    function resetInfo(i){
        $("#clickUrl"+i).val("");
        $("#imageUrl"+i).val("");
        $("#imgShow"+i).attr("src","");
    }

    function showErrors(idTr,id,msg) {
        $("#"+idTr).show();
        $("#"+id).html(msg);
    }

    function initContent(){
        var size = ${decoraterList?size};
        if(size < maxNum){
            var html = "";
            for(var i=size+1;i<=maxNum;i++){
                html += "<table cellspacing=\"10\" cellpadding=\"0\" border=\"0\" class=\"sTable\">\n" +
                        "                <tbody>\n" +
                        "                <tr>\n" +
                        "                    <th>图片跳转链接：</th>\n" +
                        "                    <td>\n" +
                        "                        <input id=\"clickUrl"+i+"\" value=\"\" name=\"clickUrl\" type=\"text\" class=\"inputStyle w420 mrgR10\" >\n" +
                        "                        <label class=\"cGray\">请输入有效的url地址</label>\n" +
                        "                    </td>\n" +
                        "                </tr>\n" +
                        "                <tr class=\"goodsNameError\" style=\"display:none;\" id=\"clickUrlErrorTR"+i+"\">\n" +
                        "                    <th></th>\n" +
                        "                    <td><span id=\"clickUrlError"+i+"\" class=\"error\"></span></td>\n" +
                        "                </tr>\n" +
                        "                <tr>\n" +
                        "                    <th>上传图片：</th>\n" +
                        "                    <td>\n" +
                        "                        <input type=\"hidden\" id=\"imageUrl"+i+"\" name=\"imageUrl\" value=\"\" index= \""+i+"\" />\n" +
                        "                        <label>\n" +
                        "                            <img id=\"imgShow"+i+"\" style=\"width:85px; height:85;overflow:hidden;\" width=\"85\" height=\"85\" src=\"\" />\n" +
                        "                        </label>\n" +
                        "                        <div id=\"upload_button"+i+"\" class=\"upload_btu ie6_png\">\n" +
                        "                            <div style=\"padding-left: 370px\" ><a href=\"javascript:\" class=\"shortBtn\" id=\"resetBtn"+i+"\" onclick=\"resetInfo('"+i+"')\">重&nbsp;&nbsp;置</a></div>\n" +
                        "                        </div>\n" +
                        "                    </td>\n" +
                        "                </tr>\n" +
                        "                <tr class=\"goodsLabelError\" style=\"display:none\" id=\"imageUrlErrorTR"+i+"\">\n" +
                        "                    <th></th>\n" +
                        "                    <td><span class=\"error\" id=\"imageUrlError"+i+"\"></span></td>\n" +
                        "                </tr>\n" +
                        "                </tbody>\n" +
                        "            </table>";
            }
            $("#decoraterContentId").append(html);
        }
    }

    $(function() {
        initContent();
        bindingUpload();
//        bindRset();
        $("#decoraterBtn").click(function(){
            $("#decoraterForm").ajaxSubmit({
                beforeSubmit: function () {
                    $.startLoading();
                    $.overLayOn();
                },
                dataType: 'json',
                success: function (res) {
                    if (res.result == "true") {
                        $.smile("操作成功", function () {
                            window.location.href = ADMIN.ctx + "/admin/am/decorater/decoraterIndex";
                        });
                    }
                    else {
                        $.alert(res.msg);
                    }
                },
                complete: function () {
                    $.endLoading();
                    $.overLayOff();
                }
            });
        });



    });

</script>


</div></div>
</@layout>