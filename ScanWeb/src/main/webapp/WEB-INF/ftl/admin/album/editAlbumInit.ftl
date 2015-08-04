<#include "/admin/layout/common/layout.ftl">
<@layout title="相册管理">
<div class="rightBar">
<link href="${e.res('/css/prodconf.css')}" rel="stylesheet" type="text/css" />
<script src="${e.res('/js/album/GoodsValidation.js')}" type="text/javascript"></script>
<script src="${e.res('/js/album/albumManage.js')}" type="text/javascript"></script>

<div class="layoutRight">
<div class="navigation">
    <div class="navigationLeft">
        商品管理<span>&gt;</span>编辑相册
    </div>
</div>
<@form.form method="post" id="editAlbumForm" action="${rc.contextPath}/admin/am/album/editAlbumSubmit">
<input type="hidden" value="${albumId}" name="albumId"/>
<div class="fSection">
    <h2 class="sTl">基本信息<label class="cRed">*&nbsp;</label>
    </h2>
    <#if (albumPhotoList?size > 0) >
    <#list albumPhotoList as album>
    <#if (album_index == 0)>
    <table cellspacing="10" cellpadding="0" border="0" class="sTable">
        <tbody>
        <tr>
            <th><label class="cRed">*&nbsp;</label>相册说明：</th>
            <td>
                <input id="albumExplain" name="albumExplain" value="${album.ALBUM_EXPLAIN}" type="text" class="inputStyle w420 mrgR10" onblur="validationAlbumExplain();">
                <label class="cGray">不超过20个汉字</label>
            </td>
        </tr>
        <tr class="goodsNameError" style="display:none;" id="albumExplainErrorTR">
            <th></th>
            <td><span id="albumExplainError" class="error"></span></td>
        </tr>
        <tr>
            <th><label class="cRed">*&nbsp;</label>应用渠道：</th>
            <td>
                <select name="usedChannel" id="usedChannel" class="selectStyle w200">
                    <#list usedChannleList as uc>
                        <option value="${uc.dataKey}" <#if uc.dataKey == album.USED_CHANNEL>selected="selected"</#if> >${uc.dataValue}</option>
                    </#list>
                </select>
            </td>
        </tr>
        <tr class="goodsLabelError" style="display:none" id="usedChannelErrorTR">
            <th></th>
            <td><span class="error" id="usedChannelError"></span></td>
        </tr>
        </tbody>
    </table>

    <h2 class="sTl">添加相册图片<label class="cRed">*&nbsp;</label>
    </h2>
    <div class="picture_information">
        <ul class="new_products_tabbg">
            <li><span>添加图片</span></li>
        </ul>
        <div class="prev_1"><a class="prev_img ie6_png"></a></div>
        <div class="next_1"><a class="next_img ie6_png"></a></div>
        <div class="upload_img">
            <span></span>
            <div class="upload_content">
                <ul class="upload_list" id="imageUploadAddUl">
                <#list albumPhotoList as image>
                    <li>
                        <input type="hidden" id="img${image_index+1}" name="imgs" value="${image.PHOTO_LINKS}" index= "${image_index+1}" biggerThanH="${image.biggerThanH}"/>
                        <label>
                            <img id="imgShow${image_index+1}" style="width:85px; height:85;overflow:hidden;" width="85" height="85" src="${e.res(image.PHOTO_LINKS)}" />
                        </label>
                        <div id="upload_button${image_index+1}" class="upload_btu ie6_png"></div>
                    </li>
                </#list>
                </ul>
            </div>
            <div class="prompt_text"><label class="ie6_png"></label>图片单张大小不得超过300k，图片尺寸为480*320px，并且至少上传一张图片</div>
        </div>
        <div id="imgError_div" class="error" style="display:none"></div>
    </div>

    <div class="submitBox">
        <#--<a href="javascript:" id="GoodsCreateBtn" class="longWhiteSubmitBtn onlySave">保存</a>-->
        <input type="button" id="albumEditBtn" class="longWhiteSubmitBtn onlySave" value="保存" />
    </div>
    </#if>
    </#list>
    </#if>
</div>
</@form.form>
<script type="text/javascript" src="${e.res('/js/ajaxupload.js')}"></script>

<script type="text/javascript">

    var maxNum = 10;//长传数量

    function uploadImagesStyle(i){
        var srcStr = i == 1 ? "src=${e.res('/images/goodsImg.jpg')}" : "";
        return "<li><input type=\"hidden\" id=\"img"+ i +"\" name=\"imgs\" value=\"\" index= \""+i+"\"></input>" +
                "<label><img "+srcStr+" id=\"imgShow"+ i +"\" style=\"width:85px; height:85;overflow:hidden;\" width=\"85\" height=\"85\"/>"+
                "</label>"+
                "<div id=\"upload_button"+ i +"\" class=\"upload_btu ie6_png\"></div>"+
                "</li>";
    }

    var GoodsImageMacro = {};

    GoodsImageMacro.clearErrors = function(){
        $("#imgError_div").hide();
        $("#imgError_div").html("");
    }

    GoodsImageMacro.showErrors = function(msg) {
        $("#imgError_div").show();
        $("#imgError_div").html(msg);
    }

    GoodsImageMacro.validation = function(){
        var flag = false;
        for(var i=0; i<maxNum; i++){
            var n = $("#imageUploadAddUl").find("input:eq("+i+")").attr("index");
            if($("#img"+n).val().length != 0){
                flag = true;
            } else {
                if (i == 0) {
                    GoodsImageMacro.clearErrors();
                    GoodsValidation.reportError("默认图片必须上传");
                    $("#imgError_div").show();
                    $("#imgError_div").html("默认图片必须上传");
                    return false;
                }
            }
        }

        if(!flag){
            GoodsImageMacro.clearErrors();
            GoodsValidation.reportError("最少上传一张图片。");
            $("#imgError_div").show();
            $("#imgError_div").html("最少上传一张图片");
            return false;
        }
        GoodsImageMacro.clearErrors();
        return true;
    }

    GoodsImageMacro.onSubmitInfo = function(pageInfo) {
        var ret = pageInfo || {};
    <#if locked == "true">
        ret.goodsPhotos_ = $("#goodsPhotos_").attr("state");
    </#if>
        ret.uploadImage = new Array();
        var isMain = true;
        var ii = 1;

        for(var i=0; i<maxNum; i++){
            var n = $("#imageUploadAddUl").find("input:eq("+i+")").attr("index");
            var imgUrl = $("#img"+n).val();
            var biggerThanH = $("#img"+n).attr("biggerThanH");
            if(imgUrl.length != 0){
                var tempEn = {};
                tempEn.index = ii;
                tempEn.imgUrl = imgUrl;
                tempEn.isMain = isMain ? 1 : 0;
                tempEn.biggerThanH = biggerThanH;
                isMain = false;
                ret.uploadImage[ii-1] = tempEn;
                ii = ii + 1;
            }
        }
    }

    $(document).ready(function(){

        var tempLiHtml = "";
        for(var i=$("#imageUploadAddUl li").length+1; i<=maxNum; i++){
            tempLiHtml = tempLiHtml + uploadImagesStyle(i);
        }
        $("#imageUploadAddUl").append(tempLiHtml);

        GoodsImageMacro.bindingUpload = function() {
            for(var i=1; i<=maxNum; i++){
                new AjaxUpload($("#upload_button"+i),{
                    action: '${rc.contextPath}/admin/am/uploadImage/uploadFile?num='+i,
                    responseType: 'json',
                    data :{"CSRFToken":$("input[name='CSRFToken']").val()},
                    name: 'img',
                    onSubmit : function(file, ext){
                        if(!(ext && /^(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$/.test(ext))){
                            $.alert("请上传图片文件");
                            return false;
                        }
                    },
                    onComplete: function(file, uploadResult){
                        if(uploadResult.key == 'extNameError'){
                            GoodsImageMacro.showErrors("图片格式不正确");
                            return;
                        }
                        else if(uploadResult.key == 'sizeError'){
                            GoodsImageMacro.showErrors("图片单张大小不超过300K");
                            return;
                        }
                        else if(uploadResult.key == 'whError'){
                            GoodsImageMacro.showErrors("图片尺寸为480*320px");
                            return;
                        }
                        else if(uploadResult.key == 'ioError'){
                            GoodsImageMacro.showErrors(response.ioKey);
                            return;
                        }else if(uploadResult.key == 'fileTypeError'){
                            GoodsImageMacro.showErrors("图片文件无法显示,请确认");
                            return;
                        }
                        else{
                            GoodsImageMacro.clearErrors();
                            $("#img"+uploadResult.num).val(uploadResult.imgValue);
                            $("#img"+uploadResult.num).attr("biggerThanH", uploadResult.biggerThanH);
                            $("#imgShow"+uploadResult.num).attr({src : uploadResult.key });
                        }
                    }
                });
            }
        }

    <#if locked == "true">
        $("#goodsPhotos_").click(function() {
            $("#goodsPhotos_").attr("state", "1").hide();
            GoodsImageMacro.bindingUpload();
        });
    <#else>
        GoodsImageMacro.bindingUpload();
    </#if>

//        $.subscribe(goodsValidationTopic, GoodsImageMacro.validation);
//        $.subscribe(goodsSubmitTopic, GoodsImageMacro.onSubmitInfo);
    });
</script>

<script type="text/javascript">
    $(function(){
        var page = 1;
        var i = 5; //每版放5个图片
        //向后 按钮
        $("div.next_1").click(function(){
            var $parent = $(this).parents("div.picture_information");
            var $v_show = $parent.find("ul.upload_list");
            var $v_content = $parent.find("div.upload_content");
            var v_width = $v_content.width() ;
            var len = $v_show.find("li").length;
            var page_count = Math.ceil(len / i) ;
            if( !$v_show.is(":animated") ){
                if( page == page_count ){
                    $v_show.animate({ left : '0px'}, "slow");
                    page = 1;
                }else{
                    $v_show.animate({ left : '-='+v_width }, "slow");
                    page++;
                }
            }
        });
        //往前 按钮
        $("div.prev_1").click(function(){
            var $parent = $(this).parents("div.picture_information");
            var $v_show = $parent.find("ul.upload_list");
            var $v_content = $parent.find("div.upload_content");
            var v_width = $v_content.width();
            var len = $v_show.find("li").length;
            var page_count = Math.ceil(len / i) ;
            if( !$v_show.is(":animated") ){
                if( page == 1 ){
                    $v_show.animate({ left : '-='+v_width*(page_count-1) }, "slow");
                    page = page_count;
                }else{
                    $v_show.animate({ left : '+='+v_width }, "slow");
                    page--;
                }
            }
        });

    });

</script>

</div></div>
</@layout>