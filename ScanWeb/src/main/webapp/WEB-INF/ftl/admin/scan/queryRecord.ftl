<#include "/admin/layout/common/layout.ftl">
<@layout title="扫描记录查询">
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">扫描查询</span>
        </div>
    </div>

    <!--begin main content-->
    <div class="listW">
        <!--begin right content-->
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/scan/findAllRecord">
                <li>
                    <label>姓&nbsp;&nbsp;名:</label>
                    <input type="text" class="inputStyle w180" name="employeename" value="${record.employeename}"/>
                </li>
                <li>
                    <label>部&nbsp;&nbsp;门:</label>
                    <input type="text" class="inputStyle w180" name="department" value="${record.department}"/>
                </li>
                <li>
                    <label>快递单号:</label>
                    <input type="text" class="inputStyle w180" name="expressno" value="${record.expressno}"/>
                </li>
                <li>
                </li>
                <li>
                </li>
                <li style="text-align: right">
                    <#--href="${rc.contextPath}/admin/am/scan/add"-->
                    <a  class="cBlue" style="cursor: pointer;margin-right: 10px" onclick="updateStatusByID()">导出记录</a>
                    <input type="submit" value="查 询" id="submit" style="margin-right: 30px" class="shortBtn  mrgL60"/>
                </li>

            </@form.form>
        </ul>

        <div class="listTopBox">
            <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                <tbody>
                <tr>
                    <th class="tFourth">编号</th>
                    <th class="tFourth">扫描员工</th>
                    <th class="tFourth">扫描部门</th>
                    <th class="tFourth">快递单号</th>
                    <th class="tFourth">快递公司</th>
                    <th class="tFourth">扫描时间</th>
                    <th class="tFourth">备注</th>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="listContBox">
            <#if (pager.rows?size>0) >
                <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                    <tbody>
                        <#list pager.rows as record>
                        <tr>
                            <td class="tFourth">${record.ID}</td>
                            <td class="tFourth">${record.EMPLOYEENAME} </td>
                            <td class="tFourth">${record.DEPARTMENT}</td>
                            <td class="tFourth">${record.EXPRESSNO}</td>
                            <td class="tFourth">${record.EXPRESSCOMPANY}</td>
                            <td class="tFourth">${record.SCANTIME?date}</td>
                            <td class="tFourth">${record.INFO}</td>
                        </tr>
                        </#list>
                    </tbody>
                </table>
            <#else>
                <tr>
                    <td colspan="8" style="color:red">没有符合条件的记录</td>
                </tr>
            </#if>
        </div>
        <!--end right content-->
        <#import "/admin/layout/common/pager.ftl" as q>
        <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/scan/findAllRecord"/>
    </div>
    <!--end main content-->
    <!--popup -->

    <!--popup end-->
</div>
<div class="clear"></div>
<script type="text/javascript">
    <#--var statusArray = ['入库', '上架', '预占', '已售', '下架', '出库'];-->
    <#--var statusLabelArray = ['<label> <input type="radio" name="chooseStatus" value="0"></input><span>入库</span></label>',-->
        <#--'<label> <input type="radio" name="chooseStatus" value="1"></input><span>上架</span></label>',-->
        <#--'<label> <input type="radio" name="chooseStatus" value="2"></input><span>预占</span></label>',-->
        <#--'<label> <input type="radio" name="chooseStatus" value="4"></input><span>已售</span></label>',-->
        <#--'<label> <input type="radio" name="chooseStatus" value="5"></input><span>下架</span></label>',-->
        <#--'<label> <input type="radio" name="chooseStatus" value="6"></input><span>出库</span></label>',-->
    <#--];-->
    <#--var refresh = function () {-->
        <#--$("#submit").trigger('click');-->
    <#--};-->
    var success = function (result) {
        $.endLoading();
        $.smile(result.mesg, refresh);
    }
    var error = function (result) {
        $.endLoading();
        $.alert("失败", refresh);
    };
    <#--function closeWindow() {-->
        <#--$.overLayOff();-->
        <#--$("#operate").hide();-->
    <#--}-->
    <#--function openWindow(element) {-->
        <#--var serialNumber = $(element).attr('serialNumber');-->
        <#--$("#serialNumber").val(serialNumber);-->
        <#--var provinceCode = $(element).attr('provinceCode');-->
        <#--$("#provinceCode").val(provinceCode);-->
        <#--var status = parseInt($(element).attr('status'));-->
        <#--var main = $("#popMain");-->
        <#--main.html("");-->
        <#--if (status == 0) {-->
            <#--main.append(statusLabelArray[1]);-->
            <#--main.append(statusLabelArray[2]);-->
            <#--main.append(statusLabelArray[3]);-->
            <#--main.append(statusLabelArray[4]);-->
            <#--main.append(statusLabelArray[5]);-->
        <#--} else if (status == 1) {-->
            <#--main.append(statusLabelArray[2]);-->
            <#--main.append(statusLabelArray[3]);-->
            <#--main.append(statusLabelArray[4]);-->
            <#--main.append(statusLabelArray[5]);-->
        <#--} else if (status == 2) {-->
            <#--main.append(statusLabelArray[3]);-->
        <#--} else if (status == 4) {-->
<#--//            main.append(statusLabelArray[1]);-->
        <#--} else if (status == 5) {-->
            <#--main.append(statusLabelArray[1]);-->
            <#--main.append(statusLabelArray[6]);-->
        <#--} else if (status == 6) {-->
            <#--main.append(statusLabelArray[0]);-->
        <#--}-->
        <#--$("#operate").center().show();-->
        <#--$.overLayOn();-->
    <#--}-->
    function updateStatusByID() {

        var url = '${rc.contextPath}/admin/am/scan/add';
        var data = {
            recordList: '[{"department":"测试0","employeename":"测试0","expressno":"0","scantime":1440691924553},{"department":"测试1","employeename":"测试1","expressno":"1","scantime":1440691924553},{"department":"测试2","employeename":"测试2","expressno":"2","scantime":1440691924553},{"department":"测试3","employeename":"测试3","expressno":"3","scantime":1440691924553},{"department":"测试4","employeename":"测试4","expressno":"4","scantime":1440691924553}]',
            listSize: "1"
        };
        $.phwAjax3(url, data, success, error);
    }
</script>
</@layout>