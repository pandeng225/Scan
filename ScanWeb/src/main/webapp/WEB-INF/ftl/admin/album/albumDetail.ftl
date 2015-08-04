<#include "/admin/layout/common/layout.ftl">
<@layout title="相册管理">
<div class="rightBar">
    <link href="${e.res('/css/prodconf.css')}" rel="stylesheet" type="text/css" />

    <div class="layoutRight">
        <div class="navigation">
            <div class="navigationLeft">
                商品管理<span>&gt;</span>相册管理
            </div>
        </div>

        <div class="fSection">
            <h2 class="sTl">相册图片信息</h2>
            <div class="picture_information">
                <ul class="new_products_tabbg">
                    <li><span>图片详情</span></li>
                </ul>
                <div class="prev_1"><a class="prev_img ie6_png"></a></div>
                <div class="next_1"><a class="next_img ie6_png"></a></div>
                <div class="upload_img">
                    <span></span>
                    <div class="upload_content">
                        <ul class="upload_list" id="imageUploadAddUl">
                        <#list photoList as image>
                            <li>
                                <input type="hidden" id="img${image_index+1}" name="imgs" value="${e.res(image.PHOTO_LINKS)}" index= "${image_index+1}" biggerThanH="${image.biggerThanH}"/>
                                <label>
                                    <img id="imgShow${image_index+1}" style="width:85px; height:85;overflow:hidden;" width="85" height="85" src="${e.res(image.PHOTO_LINKS)}" />
                                </label>
                                <#--<div id="upload_button${image_index+1}" class="upload_btu ie6_png"></div>-->
                            </li>
                        </#list>
                        </ul>
                    </div>
                    <#--<div class="prompt_text"><label class="ie6_png"></label>图片单张大小不得超过300k，图片尺寸不低于310*310px，并且至少上传一张图片</div>-->
                </div>
            </div>
        </div>
    </div>
</div>

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
</@layout>