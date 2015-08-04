<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<link rel="stylesheet" type="text/css" href="${e.res('/css/global.css')}">
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<script>
var index = parent.layer.getFrameIndex(window.name);
var ParentWin;
$(function(){
ParentWin=window.parent;
});
function selectAlbum(albumId,src){
	ParentWin.$("input[name='album']").val(albumId);
	ParentWin.$("#albumImg").html("<img src='"+src+"'/>");
	parent.layer.close(index);
}
</script>

<style type="text/css">

.listContBox p{
	cursor:pointer;
	width:100px;
	margin-right:10px;
	float:left;
}
</style>
<div class="listW" style="margin-left:10px;">
     <!--begin right content-->
	<ul class="sList" style="padding-top:10px;">
    	<@form.form method="post" action="${rc.contextPath}/admin/am/goods/queryAlbum">
        	<li>
        	<label>相册描述：</label>
        	<input type="text" class="inputStyle" name="albumExplain" value=""/>
        	</li>
        	<li><input type="submit" name="searchAlbum" value="搜索" class="shortBtn mrgR10 mrgL10"/></li>
        	<input type="hidden" name="pageSize" value="${pager.pageSize}">
        </@form.form>
	</ul> 

	<div class="listContBox">
		
        <#if (pager.rows?size>0) >
              <#list pager.rows as album>
                <p onclick="selectAlbum(${album.ALBUM_ID},'${e.res(album.PHOTO_LINKS)}')">
	                <img src='${e.res(album.PHOTO_LINKS)}' alt="${album.ALBUM_EXPLAIN}" height="90px" width="90px" />
	                <span>${album.ALBUM_EXPLAIN}</span><br/>
	                <span>使用渠道:${album.USED_CHANNEL_VALUE}</span>
                </p>
              </#list>
              <#else>
              	没有符合条件的记录
         </#if>
</div>
     <!--end right content-->
     <div style="clear:both;"></div>
     <#import "/admin/layout/common/pager.ftl" as q>
	 <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/goods/queryAlbum"/>