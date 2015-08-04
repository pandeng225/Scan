<#include "/admin/layout/common/layout.ftl">
<@layout title="编辑商品">
<link rel="stylesheet" type="text/css" href="${e.res('/js/jquery.easyui/themes/metro/easyui.css')}">
<link rel="stylesheet" type="text/css" href="${e.res('/js/jquery.easyui/themes/icon.css')}">
<link rel="stylesheet" type="text/css" href="${e.res('/js/jquery.easyui/demo/demo.css')}">
<link href="${e.res('/js/jqueryui/css/ui-lightness/jquery-ui-1.10.4.custom.min.css')}" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="${e.res('/js/jquery/validate.css')}">
<script type="text/javascript" src="${e.res('/js/common/jquery.base64.js')}"></script>
<script type="text/javascript" src="${e.res('/js/jqueryui/js/jquery-ui-1.10.4.custom.min.js')}"></script>
<script type="text/javascript" src="${e.res('/js/jquery/jquery.validate.min.js')}"></script>
<script type="text/javascript" src="${e.res('/js/jquery/jquery.form.js')}"></script>
<script type="text/javascript" src="${e.res('/js/ckeditor/ckeditor.js')}" ></script>
<script type="text/javascript" src="${e.res('/js/ckeditor/adapters/jquery.js')}" ></script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<style>
.addGoodArea dt{
 margin-bottom:5px;
}
.addGoodArea dd{
 margin-bottom:5px;
}
</style>
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">商品管理</span>
        </div>
    </div>

    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
          <@form.form method="post" id="addGoodForm" action="${rc.contextPath}/admin/am/goods/edit">
          <input type="hidden" name="goodsId" value="${good.goodsId}"/>
        <dl class="addGoodArea">
                <dt>
                    <label class="cRed marginR4">*</label>商品分类：
                    <select type="text" id="ctlgCode" style="width:150px;" name="ctlgCode" value="${good.ctlgCode}">
                    	<#if (ctlgList?size>0) >
				        		<#list ctlgList as cc>
				                  <optgroup label="${cc.text}">
				                  	<#list cc.children as c>
							        <option value="${c.id}" <#if c.id=good.ctlgCode>selected</#if> >${c.text}</option>
							        </#list>
							      </optgroup>
			                  </#list>
				        </#if>
                    </select>
                </dt>
                <dt>
                    <label class="cRed marginR4">*</label><span onclick="loadRes()" style="cursor:pointer;color:red;">选择物品</span></dt>
                <dd>
                    <table cellspacing="0" cellpadding="0" border="0" class="listTop">
				        <tbody class="selectResources">
					        <tr>
					            <th scope="tFourth" style="width: 190px;">物品标识</th>
					            <th scope="tFourth" style="width: 180px;">物品名称</th>
					            <th scope="tFourth" style="width: 50px;">选择</th>
					        </tr>
					        <#if (resList?size>0) >
				        		<#list resList as cc>
						        <tr class="selectResource">
							        <td scope="tFourth" style="width: 190px;">${cc.RES_ID}</td>
							        <td scope="tFourth" style="width: 180px;">${cc.RES_NAME}</td>
							        <td scope="tFourth" style="width: 50px;"><input type="checkBox" name="resources" value="${cc.RES_ID}" checked/></td>
						        </tr>
						        </#list>
				        	</#if>
				        </tbody>
				    </table>
				                    
                </dd>
                <dt>
                    <label class="cRed marginR4">*</label>商品名称：<input class="inputStyle" type="text" style="width:400px" name="goodsName" value="${good.goodsName}"/></dt>
                <dd>
                    
                </dd>
                <dt>
                    <label class="cRed marginR4">*</label>原始价格：<input type="text" class="inputStyle" name="originalPrice" value="${price.originalPrice/1000}"/>(单位)元</dt>
                <dd>
                <dt>
                    <label class="cRed marginR4">*</label>销售价格：<input type="text" class="inputStyle" name="price" value="${price.addPrice/1000}"/>(单位)元</dt>
                <dd>
                    
                </dd>
                <dt><label class="cRed marginR4">*</label>销售数量：<input type="text" class="inputStyle" name="amount" value="${amount.goodsAmount}"/></dt>
                <dt><label class="cRed marginR4">*</label><span onclick="loadAlbum()" style="cursor:pointer;color:red;">选择商品图片</span><input type="hidden" class="inputStyle" name="album" value="${good.albumId}"/> </dt>
                <dd id="albumImg">
                <#if (albumList?size>0) >
				    <#list albumList as cc>
                		<#if (cc.DEFAULT_TAG="0")>
                			<img src="${e.res(cc.PHOTO_LINKS)}" alt="${cc.ALBUM_EXPLAIN}"/>
                		</#if>
                	</#list>
				</#if>
                </dd>
                <dt><label class="cRed marginR4">*</label>简单描述：</dt>
                <dd><textarea name="simpDesc" style="width:500px;height:100px;" id="simpDesc">${good.simpDesc}</textarea></dd>
                
                <dt><label class="cRed marginR4">*</label>详细描述：</dt>
                <dd><textarea name="content" id="goodsContent">${goodContent}</textarea></dd>
                <dt><label class="cRed marginR4">*</label>是否上架：<input type="radio" name="state" checked value="1"/>是<input type="radio" name="state" value="2"/>否</dt>
                <dt>
                    <input type="submit" name="goodSubmit" value="更新" class="shortBtn mrgR10 mrgL60"/>
                </dt>
        </dl>
            </@form.form>
	</div>
	<div id="formdiv"></div>
    <!--end main content-->
</div>
<div class="clear"></div>
<script>
 $(document).ready(function() {
 		var CSRFToken=$("input[name='CSRFToken']").val();
		var filebrowserUploadUrl="/admin/am/file/upload/addFileCK?CSRFToken="+CSRFToken;
		var filebrowserImageUploadUrl ="/admin/am/file/upload/addImageCK?CSRFToken="+CSRFToken;
		CKEDITOR.replace( 'simpDesc',{customConfig : './configAdmin.js',filebrowserUploadUrl:filebrowserUploadUrl,filebrowserImageUploadUrl:filebrowserImageUploadUrl});
		CKEDITOR.replace( 'goodsContent',{customConfig : './configAdmin.js',filebrowserUploadUrl:filebrowserUploadUrl,filebrowserImageUploadUrl:filebrowserImageUploadUrl});
 		
	 		    
	 	$("#addGoodForm").validate({
	        rules: {
			   goodsName: "required",
               originalPrice : {
                   required : true,
                   number:true,
                   maxlength: 16,
                   min:0
               },
			   price: {
			    required: true,
			    number: true,
			    maxlength: 16,
			    min:0
			   },
			   amount: {
			    required: true,
			    digits:true,
			    maxlength: 5,
			    min:0
			   },
			   album: {
			    required: true
			   },
			   simpDesc: {
			    required: true
			   },
			   resources:{
			   	required: true
			   }
	  		},
	        messages: {
			   goodsName:{ required:"请输入商品名称"},
               originalPrice : {
                   required :"请输入原始价格",
                   number : "请输入数字",
                   maxlength : "最大不能超过16位数字"
               },
			   price: {
			    required: "请输入价格",
			    number:"请输入数字",
			    maxlength: "最大不能超16位数字"
			   },
			   amount: {
			    required: "请输入数量",
			    digits:"请输入数字",
			    maxlength: "最大不能超5位数字"
			   },
			   album: {
			    required: "请选择相册"
			   },
			   simpDesc: {
			    required: "请输入简单描述"
			   },
			   resources:{
			   	required: "请选择物品"
			   }
	  		},

            submitHandler : function(){
                var sd = CKEDITOR.instances.simpDesc.getData();
                $('#simpDesc').val($.base64Encode(sd));
                var gc = CKEDITOR.instances.goodsContent.getData();
                $('#goodsContent').val($.base64Encode(gc));
                $('#addGoodForm').ajaxSubmit({
                    beforeSubmit:  function(){},
                    success: function (responseText, statusText) {
                        if (responseText.status) {
                            alert("提交成功");
                        } else {
                            alert("提交失败:" + responseText.msg);
                        }
                    }
                });
            }
    });
    
});

function loadAlbum() {
	$.layer({
	    type: 2,
	    shade: [0],
	    fix: false,
	    title: '选择商品图片',
	    maxmin: true,
	    iframe: {src : '/admin/am/goods/queryAlbum'},
	    area: ['800px' , '440px'],
	    end: function(){
	    	//location.reload(true);
	    }
	}); 
}

function loadRes() {
	$.layer({
	    type: 2,
	    shade: [0],
	    fix: false,
	    title: '选择物品',
	    maxmin: true,
	    iframe: {src : '/admin/am/goods/queryRes'},
	    area: ['800px' , '440px'],
	    end: function(){
	    	//location.reload(true);
	    }
	}); 
}
var resAry=[];
 <#if (resList?size>0) >
 	<#list resList as cc>
	resAry.push(${cc.RES_ID});
	</#list>
<#else>
</#if>

	function hasRes(value) {
        var arr = resAry;
        var flag = false;

        $.each(arr, function (i, item) {
            if (value == item) {
                flag = true;
                return;
            }
        });
        return flag;
    }
	function addRes(id,name) {
    	if(!hasRes(id)){
			$(".selectResources").append('<tr class="selectResource"><td scope="tFourth" style="width: 190px;">' + id +
                '<td scope="tFourth" style="width: 180px;">' + name +
                '</td><td scope="tFourth" style="width: 50px;"><input type="checkBox" name="resources" value="' + id + '" checked/></td></tr>');
    		
    		resAry.push(id);
    	}
    }
    
</script>
</@layout>