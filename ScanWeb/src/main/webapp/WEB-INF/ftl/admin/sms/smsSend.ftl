<#include "/admin/layout/common/layout.ftl">
<@layout title="发送短信">
<style type="text/css" style="display: none !important;">
    .tabBtn {
    float:left;
    width:83px;
    height:23px;
    background:url(${e.res('/images/editBtn.gif')}) no-repeat;
    color:white
    }
    .active{
    opacity: 1.0;
    }
    .inactive{
    opacity: 0.5;
    }
    #content label{
    display: block;
    margin:5px;
    }

</style>
<div class="rightBar" >


        <div  style="border-bottom: 1px solid #e4e4e4">
        <div id="manhand-button" class="tabBtn active " >
            手动导入
        </div>
        <div id="file-button" class="tabBtn inactive ">
            文件导入
        </div>
        <div id="other-button" class="tabBtn inactive ">
            其他导入
        </div>

        <div class="clear"></div>
        </div>
        <div id="content" class="mrgT10 mrgB10">
            <div id="manhand" style="display: block;">
               <label><span style="vertical-align: top">接入号</span><input class="mrgL5" type="text" id="from" name="from"/></label>
               <label>
                <span style="vertical-align: top">发送对象</span>
                <textarea class="mrgL5" style="width:300px"></textarea>
                <span class="mrgL5"style="color:red;vertical-align: top">支持多目标发送，请使用半角逗号分隔</span>
               </label>
            </div>
            <div id="file" style="display: none;">
                <input type="file" id="upload" name="upload" accept=".xls,.xlsx"/>
            </div>

            <div id="other" style="display: none;">
                <p>This content is for contact.</p>

            </div>
            <div style="margin:0 10px">
            <input class="mediumBtn" type="button" onclick="beforeSubmit()"  style="float:right" value="开始">
            </div>
    </div>
    <#--<div class="breadcrumbW">-->
        <#--<div class="breadcrumb">-->
            <#--<span class="left"></span>-->
        <#--</div>-->
    <#--</div>-->
    <#--<!--begin main content&ndash;&gt;-->
    <#--<div class="listW">-->
        <#--<!--begin right content&ndash;&gt;-->
        <#--<@form.form method="post" id="form" enctype="multipart/form-data"  action="${rc.contextPath}/admin/am/sms/fileUpload">-->
            <#--<div>-->
                <#--<label> <input  type="radio" name="IOType" value="0" onclick="removeErrorMsg()"></input><span  class="mrgL5">批量入库</span></label>-->
                <#--<label> <input class="mrgL10" type="radio" name="IOType" value="1" onclick="removeErrorMsg()"></input><span class="mrgL5">批量出库</span></label>-->
                <#--<div  class="mrgT10" style="padding-right: 20px">-->
                    <#--<input type="file" id="upload" name="upload" accept=".xls,.xlsx"/>-->
                    <#--<input class="mrgL10 mediumBtn" type="button" onclick="beforeSubmit()"  style="float:right" value="开始">-->
                    <#--<a  class="mrgR10 mrgT5" style="color: #ff0000;float:right;" href="${e.res('/file/templet.xls')}">下载模板</a>-->
                <#--</div>-->
                <#--<div class="mrgT10" style="color: #ff0000" id="errorMsg"> ${errorMsg}</div>-->
            <#--</div>-->

        <#--</@form.form>-->
    <#--</div>-->

    <script type="text/javascript">
        $(function(){

            $(".rightBar div.tabBtn").click(function(){

                $clicked = $(this);

                // if the button is not already "transformed" AND is not animated
                if ($clicked.css("opacity") != "1" && $clicked.is(":not(animated)")) {

                    $clicked.animate({
                        opacity: 1,
                    }, 600 );

                    // each button div MUST have a "xx-button" and the target div must have an id "xx"
                    var idToLoad = $clicked.attr("id").split('-');

                    //we search trough the content for the visible div and we fade it out
                    $("#content").find("div:visible").fadeOut("fast", function(){
                        //once the fade out is completed, we start to fade in the right div
                        $(this).parent().find("#"+idToLoad[0]).fadeIn();
                    })
                }

                //we reset the other buttons to default style
                $clicked.siblings(".tabBtn").animate({
                    opacity: 0.5,
                }, 600 );

            });
        });


        var c=0;
        var t;
        function beforeSubmit(){
            var IOType = $("input[name='IOType']:checked").val();
            if(!IOType){
                $("#errorMsg").html("请选择操作");
            }else{
                if(document.getElementById('upload').value!=""){
                    $.overLayOn();
                    timedCount();
                    $("#form").submit();
                }else{
                    $("#errorMsg").html("请选择文件");
                }

            }
        }
        function removeErrorMsg(){
            $("#errorMsg").html("");
        }
        function timedCount()
        {
            $("#errorMsg").html("正在操作..."+c+"s");
            c=c+1;
            t=setTimeout("timedCount()",1000)
        }
    </script>
</@layout>