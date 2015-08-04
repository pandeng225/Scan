<#macro layout title="联通商城_商户管理" content="keyword1,keyword2,keyword3" needfoot="1">
<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta  name="keywords" content="互联网云平台"/>
<meta http-equiv = "X-UA-Compatible" cotent = "IE=edge,chrome=1"/>
<meta  name="description" content="互联网云平台"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
<#include "/admin/layout/jshead.ftl" />
<link href="${e.res('/css/global.css')}" rel="stylesheet" type="text/css" />
<link href="${e.res('/css/backstageLayout.css')}" rel="stylesheet" type="text/css" />
<link href="${e.res('/css/layer.css')}" rel="stylesheet" type="text/css" />
<link href="${e.res('/css/goods_edit_list.css')}" rel="stylesheet" type="text/css" />
<link href="${e.res('/images/favicon.ico')}" type="image/x-icon" rel="shortcut icon">
</head>
<body>

  <!--============topBar begin==============-->
  <#include "/admin/layout/top.ftl">
  <!--============topBar end==============-->
  <!--============mainbody begin==============-->  
  <div class="mainbBodyer">
  <!--============leftbar begin==============-->
    <#include "/admin/layout/left.ftl" />
    <!--============leftbar end==============-->
    <!--============right begin==============-->
    <#nested>
  <!--============mainbody end==============-->
  </div>
</div>
<#if needfoot == 1>
<#include "/admin/layout/foot.ftl">
</#if>
</body>
</html>
</#macro>

