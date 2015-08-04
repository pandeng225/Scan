<#include "/admin/layout/common/layout.ftl">
<@layout title="财务日报表">
<script language="javascript" type="text/javascript" src="${e.res('/js/datePicker/WdatePicker.js')}"></script>
<style type="text/css">
    *{
        color: #333;
        font-family: Arial,Helvetica,sans-serif;
        font-size: 12px;
        font-weight: normal;
        line-height: 1.6em;
        list-style: outside none none;
        margin: 0;
        padding: 0;
        text-decoration: none;
    }
    .tableBody table p {
        z-index: 98;
        margin-left: 5px;
    }
    .tableBody table p.top {
        margin-top: 5px;
    }
    .tableBody table p.bottom {
        margin-bottom: 5px;
    }

    .tableBody table td{
        width:20%;
        word-break: break-all;
        word-wrap: break-word;
    }
    .tableBody table td.first{
        border-left: 1px solid #e6f0f5;
        border-top:1px solid #e6f0f5;
        text-align:center;
    }
    .tableBody table td.others {
        border-collapse: collapse;
        border-left: 1px solid #e6f0f5;
        border-top: 1px solid #e6f0f5;
        border-right: 1px solid #e6f0f5;
        padding-bottom: 10px;
        padding-top: 10px;
        text-align: center;
        vertical-align: top;
    }
     .tableBody table td.third {
        border-top: 1px solid #e6f0f5;
    }

    .tleft{
        text-align: left;
    }

</style>
<script>
function exportXls(){
 window.open('${rc.contextPath}/admin/am/report/financial/exportFDS?beginTime='+$("#beginTime").val()+'&endTime='+$("#endTime").val());
}
</script>
<!--begin crumb-->
<div class="rightBar">
<div class="breadcrumbW">
  <div class="breadcrumb">
    <span class="left">报表管理&nbsp;&gt;&nbsp;财务日报表</span>
  </div>
</div>
    <!--end curmb-->
<!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
			<@form.form method="post" action="${rc.contextPath}/admin/am/report/financial/queryFDS">
            		<li>
	            		<label>开始时间&nbsp;</label>
	            		<input type="text" value="${beginTime}" placeholder="开始时间" id="beginTime" class="inputStyle w180" name="beginTime" onclick="WdatePicker({readOnly:true,maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd'})"/>
            		</li>
            		<li>
	            		<label>结束时间&nbsp;</label>
	            		<input type="text" value="${endTime}" placeholder="结束时间" id="endTime" class="inputStyle w180" name="endTime" onclick="WdatePicker({readOnly:true,minDate:'#F{$dp.$D(\'beginTime\')}',dateFmt:'yyyy-MM-dd'})" />
            		</li>
            		<li style="text-align:left;">
            		<input type="submit" value="查询" class="shortBtn mrgR10 mrgL60" />
            		<input onclick="exportXls()" type="button" value="导出" class="shortBtn" />
            		</li>
          </@form.form>
        </ul>
        <!--end right content-->
        
         <div class="listTopBox">
    	<table cellspacing="0" cellpadding="0" border="0" class="listTop">
      	<tbody>
        		 <tr>
                    <th class="tFourth">市州渠道</th>
                    <th class="tFourth">应收营业款(元)</th>
                    <th class="tFourth">实收营业款(元)</th>
                    <th class="tFourth">应补营业款(元)</th>
                  </tr>
         </tbody>
     	</table>
      </div>
      <div class="tableBody" cellpadding="0" cellspacing="0" border="0" width="100%"  style="margin-bottom: 7px;"> 
                  <#if (financialForm??) >
	                <table cellspacing="0" cellpadding="0" border="0" width="100%">
	      			   <tbody>
		                  <#list financialForm as item>
		                  <#if item.CITY_NAME="合计">
		                  <#assign sumItem=item>
		                  <#else>
		                   <tr>
		                  	<td class="first">
		                  		${item.CITY_NAME}
		                  	</td>
		                    <td class="first">
		                    	${item.TOPAYMONEY}
		                    </td>
		                    <td class="first">
		                    	${item.INCOMEMONEY}
		                    </td>
		                    <td class="others">
		                    	${item.YBMONEY}
		                    </td>
		                   </tr>
		                   </#if>
		                  </#list>
		                  <tr>
		                  	<td class="first">
		                  		${sumItem.CITY_NAME}
		                  	</td>
		                    <td class="first">
		                    	${sumItem.TOPAYMONEY}
		                    </td>
		                    <td class="first">
		                    	${sumItem.INCOMEMONEY}
		                    </td>
		                    <td class="others">
		                    	${sumItem.YBMONEY}
		                    </td>
		                   </tr>
	                   </tbody>
	                 </table>
	                 
                  <#else>
                  	<tr><td colspan="8" style="color:red">没符合条件的记录</td></tr>
                  </#if>
     </div>
    </div>
    <!--end main content-->  
</div>

</@layout>