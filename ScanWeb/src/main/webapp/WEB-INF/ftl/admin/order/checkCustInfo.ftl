<#assign form=JspTaglibs["http://www.springframework.org/tags/form"]>
<script language="javascript" type="text/javascript" src="${e.res('/js/jquery/jquery-1.11.0.min.js')}"></script>
<script type="text/javascript" src="${e.res('/css/layer/layer.min.js')}"></script>

<style type="text/css">
* {
    color: #333;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 12px;
    font-weight: normal;
    line-height: 1.6em;
    list-style: outside none none;
    text-decoration: none;
}
#newPost{
padding: 10px;
border: 1px solid #eed97c;
}
#newPost div{
margin-top: 5px; 
margin-bottom: 5px;
}

a.save-btn {
    font-size: 14px;
    height: 28px;
    line-height: 28px;
    padding: 0 14px;
}
.btn-9{
    background-color: #f7f7f7;
    background-image: linear-gradient(to top, #f7f7f7 0px, #f3f2f2 100%);
    border: 1px solid #ddd;
    border-radius: 2px;
    color: #323333;
    display: inline-block;
    height: 18px;
    line-height: 18px;
    padding: 2px 14px 3px;
}
a {
    color: #666;
    text-decoration: none;
}

a.e-btn:link, a.e-btn:visited, a.e-btn:hover, a.e-btn:active {
    color: #333;
    text-decoration: none;
}
</style>

<div>
<#if !(custImg1??) && !(custImg2??)>
						<li style="width:400px;height: 25px;">
							<label style="width:90px;height:20px"> 身份证正面</label>
							<label>
							<label style="width:310px;height:20px;color:red;">该用户暂时没有身份证信息</label>
							</label>
                        </li>
                        <#elseif custImg1??>
                        <li style="width:400px;height: 222px;">
							<label style="width:90px;height:20px"> 身份证正面</label>
							<label>
							<img src="${e.hostImage}/${custImg1}" height="200" width="320"/>
							</label>
						<#else>
						<li style="width:400px;height: 222px;">
							<label style="width:90px;height:20px"> 身份证正面</label>
							<label>
							<label style="width:310px;height:20px;color:red;padding-top: 100px;">该用户暂时没有身份证信息</label>
							</label>
                        </li>
                        </li>
                        
						</#if>
						
                        <#if !(custImg1??) && !(custImg2??)>
						 <li style="width:400px;height: 25px;">
							<label style="width:90px;height:20px"> 身份证反面</label>
							<label>
							<label style="width:310px;height:20px;color:red;">该用户暂时没有身份证信息</label>
							</label>
                        </li>
                        <#elseif custImg2??>
                        <li style="width:400px;height: 222px;">
							<label style="width:90px;height:20px"> 身份证反面</label>
							<label>
							<img src="${e.hostImage}/${custImg2}" height="200" width="320"/>
							</label>
						<#else>
						 <li style="width:400px;height: 222px;">
							<label style="width:90px;height:20px"> 身份证反面</label>
							<label>
							<label style="width:310px;height:20px;color:red;padding-top: 100px;">该用户暂时没有身份证信息</label>
							</label>
                        </li>
                        </li>
                       
						</#if>
</div>