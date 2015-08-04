<#macro pager pageNo pageSize toURL recordCount>
<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<#if recordCount==0>
	<#return />
</#if>
<#assign pageCount=((recordCount + pageSize - 1) / pageSize)?int >

<div class="tPageBox">
<div class="tPage">
  <@form.form method="post" action="" name="qPagerForm">
	<#-- 把请求中的所有参数当作隐藏表单域(无法解决一个参数对应多个值的情况) -->
	<#list RequestParameters?keys as key>
	<#if (key!="pageNo" && key!="pageSize" && RequestParameters[key]??)>
	<input type="hidden" name="${key}" value="${RequestParameters[key]}"/>
	</#if>
	</#list>
  <input type="hidden" name="pageNo" value="${pageNo}">
  <input type="hidden" name="pageSize" value="${pageSize}">
  <span class="pagingNew">
    <label>
      <span>每页</span>
      <select class="pagingNum" style="width:60px;"onChange="Pagination.gotoPage('refresh', '1', '');">
        <option value="5">5条</option>
        <option value="10">10条</option>
        <option value="20">20条</option>
        <option value="30">30条</option>
        <option value="50">50条</option>
      </select>
    </label>
          
    <label>
      <#if pageNo == 1>
        <a href="javascript:void(0);" class="prevPage prevEnd" title="上一页"></a>
      <#else>
        <a href="javascript:Pagination.gotoPage('prev', '${pageNo}', '${recordCount}');" class="prevPage" title="上一页"></a>
      </#if>
      <label id="pageNum"></label>
      <#if pageNo == pageCount>
        <a href="javascript:void(0);" class="nextPage nextEnd" title="下一页"></a>
      <#else>
        <a href="javascript:Pagination.gotoPage('next', '${pageNo}', '${recordCount}');" class="nextPage" title="下一页"></a>
      </#if>
    </label>
    <label class="marginTop2px">共 ${pageCount} 页</label>
    <label class="marginTop2px">跳转至</label>
    <input type="text" class="inputW20H18" id='reRender_inputPageNo'>
    <label class="marginTop2px">页</label>
    <a href="javascript:Pagination.gotoPage('input', '${pageNo}', '${recordCount}');" title="" class="determineBtn">跳 转</a>
  </span>
  <label class="totalRecord">共<font class="font">${recordCount}</font>条</label>
</div>
</div>
</@form.form>
<script>
// 初始页脚
var pageNumDiv = jQuery("#pageNum"); //页脚Lable
var currentPage = ${pageNo!1}; //当前页
var totalPages = ${pageCount!0};  //总页数

// 初始页脚
if(totalPages <= 5){
    for(var i=1;i<=totalPages;i++){
        addDiv(i, currentPage);
    }
}else{
    if(currentPage <4){
        for(var i=1;i<=5;i++){
            addDiv(i, currentPage);
        }
    }else if(totalPages - currentPage < 2){
        for(var iii=1;iii<=5;iii++){
            var k= totalPages+iii-5;
            addDiv(k,currentPage);
        }
    }else{
        for(var ii=1;ii<=5;ii++){
            var kk = ${pageNo}+ii-3;
            addDiv(kk,currentPage);
        }
    }
}

// 添加页面元素
function addDiv(pageNum,currentPage){
    if(pageNum == currentPage){
        pageNumDiv.append("<a href='javascript:chosen("+pageNum+");' class='pagingSelect'>"+pageNum+"</a>");
    }else{
        pageNumDiv.append("<a href='javascript:chosen("+pageNum+")'  class='fontBlueB'>"+pageNum+"</a>");
    }
}

// 页脚调用分页
function chosen(choosepage){
    Pagination.gotoPage('choosepage', choosepage, '${recordCount}');
}

if (!this.Pagination) {
    this.Pagination = {};
    
    // 分页处理方法
    Pagination.gotoPage = function(action, c, t) {
        var cmd = action;
    
        // 当总记录数量小于等于每页记录数量时，分页动作无效
        if (t <= ${pageNo!1} && cmd != 'refresh') {
            return;
        }
    
        // 确定按钮处理
        if(action == 'input') {
            var inValue = $("#reRender_inputPageNo").val();
    
            if(inValue.match(/^[0-9]+$/) && parseInt(inValue) > 0) {
            	if(parseInt(inValue)>${pageCount}){
            		c = ${pageCount};
            	}else
               		c = inValue;
            }
            else {
              c=1;
            }
        }else if(action == 'prev'){
        	c = ${pageNo!1} -1;
        }else if(action == 'next'){
        	c = ${pageNo!1} + 1;
        }else if(action == 'choosepage'){
        	c = c;
        }
        
        var qForm=document.qPagerForm;
	    if(c>${pageCount!0}){no=${pageCount};}
	    if(c<1){no=1;}
	    qForm.pageNo.value=c;
	    qForm.pageSize.value=$(".pagingNum").val();
	    qForm.action="${toURL}";
	    qForm.submit();
    }
    
    Pagination.reQuery = function() {
        Pagination.gotoPage('refresh', '1','');
    }
    
    Pagination.refresh = function() {
        Pagination.gotoPage('refresh', $("#pageNo").val(), $("#totalSize").val());
    }
    
    Pagination.setPageSize = function(val) {
        $(".pagingNum").children("option[value='"+val+"']").attr("selected", "true");
    }
    
}

Pagination.setPageSize("${pageSize}");
</script>
</#macro>