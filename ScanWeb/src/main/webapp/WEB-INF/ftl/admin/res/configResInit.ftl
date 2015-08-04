<#include "/admin/layout/common/layout.ftl">

<@layout title="物品配置">
<style type="text/css">
    * {
        color: #333;
        font-family: Arial,Helvetica,sans-serif;
        font-size: 12px;
        font-weight: normal;
        text-decoration: none;
    }
    #attrval{
        padding: 10px;
        border: 1px solid #eed97c;
        margin-bottom: 5px;
    }
    #attrval div{
        margin-top: 5px;
        margin-bottom: 5px;
    }

    .btna{
        cursor:pointer;
        margin-left: 40px;
        color:blue;
    }

</style>

<script>

    function newAttr(id){
        //alert(id);
        $.layer({
            type: 2,
            shade: [0],
            fix: false,
            title: '新增物品属性',
            maxmin: true,
            iframe: {src : '/admin/am/res/newAttr?resId='+id},
            area: ['800px' , '440px'],
            end: function(){
                location.reload(true);
            }
        });
    }

    function delAttr(id){
        var resId = $("#resId").val();
        var attrCode = $(id).parent().parent().find("input[name='attrCode']").val();
        var CSRFToken = $("input[name=CSRFToken]").val();
//alert(resId);
//alert(attrCode);
        $.ajax({
            url: "${rc.contextPath}/admin/am/res/delAttr",
            type: "POST",
            dataType: "json",
            async: false,
            data: {"resId":resId,"attrCode":attrCode,"CSRFToken":CSRFToken},
            success: function(data) {
                if (data.result == "success") {
                    alert(data.msg);
                    location.reload(true);
                }else{
                    alert(data.msg);
                }
            }
        });
    }

    function editAttrval(id){
        var resId = $("#resId").val();
        var attrCode = $(id).parent().parent().find("input[name='attrCode']").val();
        $.layer({
            type: 2,
            shade: [0],
            fix: false,
            title: '编辑属性值',
            maxmin: true,
            iframe: {src : '/admin/am/res/editAttrval?resId='+resId+'&attrCode='+attrCode},
            area: ['800px' , '440px'],
            end: function(){
                location.reload(true);
            }
        });
    }
</script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>
<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">物品管理  > 物品配置 </span>
  </div>
</div>
<div>
<@form.form>
	<div id="title">
			<input id="resId" type="hidden" value="${resId}"/>
			<div id="newPost" style="margin-bottom: 10px;">
				<div style="margin-left: 5px; margin-top: 10px;">
				物品名称：${resinfo.resName}&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="btna" onclick="newAttr(${resId})">新增属性</a>
				</div>
			</div>
	</div>
	
	<div id="attrs">
		<#list attr as i>
			<#list i?keys as ii>
				<div id="attrval">
					<div>属性名称：${ii}
						<a class="btna" onclick="delAttr(this)">删除属性</a> 
						<a class="btna" onclick="editAttrval(this)">编辑属性值</a>
					</div> 
					<div>
						属性值：
							<#list i[ii] as iii>
								<#list iii as iiii>
									${iiii.ATTR_VAL_NAME}
									<input name="attrCode" type="hidden" value="${iiii.ATTR_CODE}"/>
								</#list>
							</#list>
						
					</div>
				</div>
			</#list>
		</#list>
	</div>	
</@form.form>	
</div>

<div class="clear"></div>
</div>
</@layout>