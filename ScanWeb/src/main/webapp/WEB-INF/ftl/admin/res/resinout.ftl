<#include "/admin/layout/common/layout.ftl">
<@layout title="物品导入">
<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">物品导入&nbsp;&gt;&nbsp;excel导入</span>
  </div>
</div>

<div style="margin-top: 20px;">
<a style="color:blue;" href='${rc.contextPath}/admin/am/res/download'>下载Excel模板</a>
	<br/>
	<span style="color:red">提示：如果显示“文件已损坏，无法打开”，右击“属性”->“解除锁定”</span>
	<br/><br/><br/>
	</div>
	<div  style="margin-bottom: 25px;">
	<div  style="margin-bottom: 15px;">
	<span>请选择文件</span>
	</div>
	<@form.form action="${rc.contextPath}/admin/am/res/upload" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td><input type="file" name="userUploadFile"></td>
				<td>
					<input type="submit" value="提交">
				</td>
			</tr>
		</table>
	</@form.form>
	</div>
	<div class="clear"></div>
</@layout>