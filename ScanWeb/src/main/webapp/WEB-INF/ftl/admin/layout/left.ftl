<#if Session["CURR_MENU"]?exists>
<#assign currMenuId = Session["CURR_MENU"].id>
</#if>
<#if Session["ADMIN_USER"]?exists>
<#assign rootMenuList = Session["ADMIN_USER"].menu>
<div class="leftBar">
 <#list rootMenuList as root>
  <div class="managementDistrict">
    <h3 class=""><label>${root.name}</label><b class="open"></b></h3>
    <ul class="managementList" style="display:none;">
    	<#if root.children??>
	    	<#list root.children as menu>
			   <li><b></b><label><a <#if menu.typeid=='2'> onclick=currentMenu('${menu.id}') href="javascript:void(0);"<#else> href="${menu.url}" </#if> currMenuName='${menu.name}' parentMenuName='${root.name}'  id="menu_${menu.id}" target="${menu.target}" >${menu.name}</a><#if menu.rightcode != null><span id="${menu.rightcode}"></span></#if></label></li>
		    </#list>
	    </#if>
    </ul>
  </div>
 </#list>
   <form id="iframeForm" action="${e.hostRoot}/ManagerIndex/index" method="post">
     <input type="hidden" id="menuId" name="menuId" value=""/> 
   </form>
</div>
<script language="javascript" type="text/javascript">
//点击当前菜单
function currentMenu(menuId){
   $("#iframeForm input[name=menuId]").val(menuId);
   $("#iframeForm").submit();
}

function reloadOrderAmount(){
    var menuCodes = ['orderAllocate','orderConfirm','orderProcess','manualAccount','orderDispatch','orderArchive','orderCancelJudge','orderRefundJudge'];
    var dataInfo = {};
    dataInfo.MenuType = '';
    for(var i in menuCodes){
        var domId = menuCodes[i];
        if( $("#"+domId).length != 0){
            dataInfo.MenuType += menuCodes[i]+",";
        }
    }
     $.ajax({
            type : "post",
            url : "${e.hostRoot}/OrderStateNum/menuStateNum",
            data : dataInfo,
            dataType : "json",
            success : function(data, textStatus) {
                var b = "(";
                var e = ")";
                for(var i in menuCodes){
                 $("#"+menuCodes[i]).html(b + data[menuCodes[i]] + e);
                }
            }
      });
}

function selectMenu(menuId){
    $(".managementList #menu_"+menuId).parents("li").addClass("current");
    
    var linkDom = $('#menu_'+menuId);
    $('#parentMenuName').text(linkDom.attr('parentMenuName'));
    $('#currMenuName').text(linkDom.attr('currMenuName'));
    
}

function initMenuStyle(){
    var topMenuList = $(".managementDistrict .open");
    topMenuList.addClass("up").css("background-position","0 bottom").parent("h3").css("height","29px");
    if('${currMenuId}' != ''){
        var currMenu = $("#menu_"+'${currMenuId}').parents(".managementDistrict").find('.open');
        currMenu.removeClass("up").removeAttr("style").parent("h3").css("height","32px");
        currMenu.parents(".managementDistrict").find(".managementList").show();
    }else{
        $(".managementDistrict .open").eq(0).removeClass("up").removeAttr("style").parent("h3").css("height","32px");
        $(".managementList").eq(0).show();
    }
}

$(function() {
    //reloadOrderAmount();
    selectMenu('${currMenuId}');
    $(".managementList li").mouseout(function(){
        $(this).removeClass('currentOver');
    }).mouseover(function(){
        $(this).addClass('currentOver');
    })
    
     //左侧菜单开关
    $(".managementDistrict h3").on('click',function(){
        switchMenu($(this).find('.open'));
    });
    
    function switchMenu(jQDom){
         if(jQDom.hasClass("up")){
                jQDom.removeClass("up").removeAttr("style").parent("h3").css("height","32px");
                jQDom.parents(".managementDistrict").find(".managementList").slideDown(200);
            }
            else{
                jQDom.addClass("up").css("background-position","0 bottom").parent("h3").css("height","29px");
                jQDom.parents(".managementDistrict").find(".managementList").slideUp(200);
            }
    }
    //左侧菜单开关end
    
    initMenuStyle();
})
</script>
</#if>