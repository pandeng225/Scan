<#assign BaseResPath="${e.hostRoot}">
<#assign PhotoPath="${e.hostAdmRes}">
<#assign MallWebIndex="/index">
<#assign MallWebContentPath="/">
<#assign MallWebResPath="${e.hostAdmRes}">
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script>

    if (!this.NL) {
        this.ADMIN = {};
        ADMIN.contextPath = "${e.hostRoot}";
        ADMIN.servletContext = "${e.hostRoot}";
        ADMIN.ctx = "${rc.contextPath}";
        ADMIN.resPath = "${e.hostRes}";
    }

if (!this.Esf) {
    this.Esf = {};
    Esf.contextPath = "${e.hostRoot}";
    Esf.resPath = "${BaseResPath}";
    Esf.MallWebIndex = "${MallWebIndex}";
    Esf.MallWebContentPath = "${MallWebContentPath}";
    Esf.MallWebResPath = "${MallWebResPath}"; 
    Esf.PhotoPath = "${PhotoPath}"; 
}


</script>
<script language="javascript" type="text/javascript" src="${e.res('/js/json/json2.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/js/common/common.js')}"></script>