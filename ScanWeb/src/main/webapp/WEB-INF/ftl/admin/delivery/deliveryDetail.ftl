<#include "/admin/layout/common/layout.ftl">
<@layout title="订单发货详情">
<link href="${e.res('/css/order/order_detail.css')}" rel="stylesheet" type="text/css" />
<link href="${e.res('/css/order/order_handle_dispatch.css')}" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${e.res('/js/delivery/delivery.js')}"></script>
<script language="javascript" type="text/javascript" src="${e.res('/js/spin.js')}"></script>
<script>
    var cancelApplyUrl = "${rc.contextPath}/admin/am/delivery/cancelApply";
    var queryDeliveryDocumentUrl = "${rc.contextPath}/admin/am/delivery/queryDeliveryDocumentUrl";
    var queryEMSDeliveryDocumentUrl = "${rc.contextPath}/admin/am/delivery/queryEMSDeliveryDocumentUrl";
    var deliveryDocumentUrl = "${rc.contextPath}/admin/am/delivery/deliveryDocument";
    var deliveryDocumentElecUrl = "${rc.contextPath}/admin/am/delivery/deliveryDocumentElec";
    var doDeliveryUrl = "${rc.contextPath}/admin/am/delivery/doDelivery";
    var subLgtsOrderUrl = "${rc.contextPath}/admin/am/delivery/subLgtsOrder";
    var orderId = '${orderId}';
    var needCallLgts='0';<!--不需要同步物流信息-->
    
    
    var logisticType = '2';//第三方配送
    
    
    <#if orderDataPost.EXPRESS_ID??>
    var hashooseLgts='1';//有选好物流公司
    <#else>
    var hashooseLgts='0';//没有选好物流公司
    </#if>
    <#if orderDataPost.EXPRESS_COMPNAY=='1'>
    var chooseLgtsId ='1';//物流公司编号
    <#elseif orderDataPost.EXPRESS_COMPNAY=='2'>
    var chooseLgtsId ='2';//物流公司编号
    <#else>
    var chooseLgtsId ='1';//物流公司编号
    </#if>
    
    var wayBillForm ='${orderDataPost.EXPRESS_TYPE}';//电子运单
    var lgtsOrderNo ='${orderDataPost.EXPRESS_ID}';//物流编号
    var lgtsOrderRemark='${orderDataPost.STAFF_REMARK}';//物流备注
    
    var lgtsWait ='1';//3：人工筛单
    <#if staffAddr??>
    	var defaultDeliveryAddr = '${staffAddr.POST_ADDR}';//默认发货方式
    <#else>
        var defaultDeliveryAddr = '';
    </#if>
   
</script>
<div class="rightBar">
    <div class="breadcrumbW">
        <div class="breadcrumb">
            <span class="left">订单发货</span>
        </div>
    </div>

    <!--begin main content-->
  <!--操作记录-->
  <h3 class="detailsTitle">订单状态</h3>
  <#if orderLogList?size gt 0>
      <h3 class="detailsTitle"></h3>
      <ul class="operationRecord operationRecordTitle">
        <li class="operationTime">操作时间</li>
        <li class="operationType">操作人</li>
        <li class="operationInfo">操作信息</li>
        <li class="operator">状态变化</li>
      </ul>
      <#list orderLogList as operate>
      <ul class="operationRecord <#if operate_index == (orderLogList?size-1)>operationRecordBottom</#if>">
        <li class="operationTime">${operate.OPERATE_TIME}</li>
        <li class="operationType">${operate.OPERATOR_NAME}</li>
        <li class="operationInfo">${operate.DEAL_CONTENT}</li>
        <li class="operator">
        <#assign state=operate.ORIGINAL_STATE>  
        <#if state=='00'>待支付
        <#elseif state=='01'>待分配 
        <#elseif state=='02'>待处理
        <#elseif state=='03'>处理中
        <#elseif state=='04'>待发货
        <#elseif state=='05'>发货中
        <#elseif state=='06'>物流在途
        <#elseif state=='07'>待归档
        <#elseif state=='08'>成功关闭（已归档）
        <#elseif state=='09'>订单处理退单
        <#elseif state=='10'>客户拒收退单
        <#elseif state == "11">
            店主审核中
        <#elseif state == "12">
            管理员审核中
        <#elseif state == "13">
            审核通过未退款
        <#elseif state == "14">
            审核通过已退款
        </#if>
        ->
         <#assign state=operate.CURRENT_STATE>  
        <#if state=='00'>待支付
        <#elseif state=='01'>待分配 
        <#elseif state=='02'>待处理
        <#elseif state=='03'>处理中
        <#elseif state=='04'>待发货
        <#elseif state=='05'>发货中
        <#elseif state=='06'>物流在途
        <#elseif state=='07'>待归档
        <#elseif state=='08'>成功关闭（已归档）
        <#elseif state=='09'>订单处理退单
        <#elseif state=='10'>客户拒收退单
        <#elseif state == "11">
            店主审核中
        <#elseif state == "12">
            管理员审核中
        <#elseif state == "13">
            审核通过未退款
        <#elseif state == "14">
            审核通过已退款
        </#if>
        </#if>
        </li>
  
      </ul>
      </#list>  
  </#if>
  <!--操作记录 end-->
  <!--============收货及交易详情==============-->
  <h3 class="detailsTitle">收货及交易详情</h3>
  <div class="detailsBoxName">
    <div class="commodityName">商品名称</div>
    <div class="orderInfor">订单信息</div>
  </div>
  <div class="detailsBox">
    <div class="commodityNameContent">
      <#list orderDataProdList as goods>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="commodName">${goods.goodsName}</td>
          <td class="commodContent">金额：￥${goods.topayFee/1000}元</td>
        </tr>
      </table>
      <div class="line"></div>
      </#list>
      
      <div class="money">共需支付：<label>￥${orderDataBase.topayMoney}元</label></div>
    </div>
    <div class="orderInforContent">
      <dl>
        <dt>客户信息：</dt><dd>${orderDataPost.RECEIVER_NAME}&nbsp;&nbsp;&nbsp;&nbsp;${orderDataPost.MOBILE_PHONE}
           <#if orderDataPost.FIX_PHONE?if_exists>&nbsp;/&nbsp;${orderDataPost.FIX_PHONE}</#if>
        </dd>
      </dl>
      <dl>
        <dt>地址信息：</dt><dd>${orderDataPost.PROVINCE_NAME}，${orderDataPost.CITY_NAME}，${orderDataPost.DISTRICT_NAME}，${orderDataPost.POST_ADDR}&nbsp;&nbsp;&nbsp;&nbsp;${orderDataPost.POST_CODE}</dd>
      </dl>
      <#if orderDataPost.POST_REMARK != null >
      <dl>
        <dt>买家备注：</dt><dd>${orderDataPost.POST_REMARK}</dd>
      </dl>
      </#if>      
      <dl>
        <dt>配　　送：</dt><dd><#if orderDataPost.EXPRESS_COMPNAY=='1'>顺丰<#else>宅急送</#if></dd>
      </dl>
    </div>
  </div>
  <!--============收货及交易详情 end==============-->
  <div class="separationLine"></div>
  <!--==============发货/退货信息================-->
  <h3 class="detailsTitle">发货/退货信息</h3>
  <div class="shippingInfor" id="DeliveryAddr">
    <div class="infor">
    <span>发货信息：</span>
    <#if staffAddr??>
    	<label class="provinceId">${staffAddr.PROVINCE_NAME}</label>，
        <label class="cityId">${staffAddr.CITY_NAME}</label>，
        <label class="areaId">${staffAddr.DISTRICT_NAME}</label>，
        <label class="address">${staffAddr.POST_ADDR}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <label class="contact">${staffAddr.LINKMAN}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <label class="tel">${staffAddr.LINK_PHONE}</label>
        </div>
        <div class="edit editTwo">【<a href="javascript:" class="fontC36cS12B deliveryOpen">编辑</a>】</div>
    <#else>
        <span class="shopInfo" style="display:none;">
        <label class="provinceId"></label>，
        <label class="cityId"></label>，
        <label class="areaId"></label>，
        <label class="address"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <label class="contact"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <label class="tel"></label>
        </span>
        <span class="editOne">【<a href="javascript:" class="fontC36cS12B deliveryOpen">设置</a>】</span>
        </div>
        <div class="edit editTwo" style="display:none">【<a href="javascript:" class="fontC36cS12B deliveryOpen">编辑</a>】</div>
    </#if>
  </div>
  

  <div class="separationLine"></div>
  <!--=============物流信息==============-->
  <h3 class="detailsTitle">物流信息</h3>
  <ul class="logisticsInfor">
    <li id="modeFirst" class="currentMode">第三方物流</li>
  </ul>
   <div id="thirdPartyLogistics" class="thirdPartyLogistics">
    <table class="logisticsTable" width="100%" border="0" cellspacing="1" cellpadding="0">
     <tr class="logisticsHeader">
      <td width="90"></td>
      <td width="110">客户选择</td>
      <td width="110">公司名称</td>
      <td width="110">揽收时段</td>
      <td width="210">配送价格 </td>
      <td width="272">说明</td>
    </tr>
  
    <tr class="logisticsList">
      <td>
        <input type="button" class="logisticsSelect selectCompany" value="选&nbsp;&nbsp;择" 
            companyName="顺丰" companyId="1" id="THIRD_LGTS_1" supportElecBill="1" isAccess="1"/>
      </td>
      <td>
        <label class="companyName"><input type="radio" name="custSel" <#if orderDataPost.EXPRESS_COMPNAY=='1'>checked</#if> disabled="true"/></label>
      </td>
      <td>
        <label class="companyName">顺丰</label>
      </td>
      <td>
        <label class="companyTime">08:00--22:00</label>
      </td>
      <td>
        <label>省内：￥0.00　省外：￥10.00</label>
      </td>
      <td>
        <label></label>
      </td>
    </tr>
   
    <tr class="logisticsList">
      <td>
        <input type="button" class="logisticsSelect selectCompany" value="选&nbsp;&nbsp;择" 
            companyName="宅急送" companyId="2" id="THIRD_LGTS_2" supportElecBill="0" isAccess="1"/>
      </td>
      <td>
        <label class="companyName"><input type="radio" name="custSel" <#if orderDataPost.EXPRESS_COMPNAY=='2'>checked</#if> disabled="true"/></label>
      </td>
      <td>
        <label class="companyName">宅急送</label>
      </td>
      <td>
        <label class="companyTime">08:00--22:00</label>
      </td>
      <td>
        <label>省内：￥0.00　省外：￥10.00</label>
      </td>
      <td>
        <label></label>
      </td>
    </tr>
   
    </table>
  <div id="thirdPartyLogistics" class="thirdPartyLogistics">
    <div class="inforExhibit"></div>
    <div id="selectCompanyInfo" class="mrgT10" style="display:none;">
      <p class="billTypeTitle">请选择运单类型：</p>
      <div class="billType" id="paperBillType">
        <input type="radio" id="paperBill" name="billType" checked />
        <label for="paperBill" id="paperBillLabel">纸质运单</label>
      </div>
      <div class="billType" style="vertical-align:bottom;" id="elecBillType">
        <input type="radio" id="elecBill" name="billType" />
        <label for="elecBill" id="elecBillLabel" >电子运单</label>
      </div>
      <table id="deliveryTable" style="margin-bottom:10px;padding-bottom:10px;" class="deliveryTable lgstNumber" width="98%" border="0" cellspacing="1" cellpadding="0" style="display:none;">
        <tr id="paperNo">
          <td class="width63">物流单号：</td>
          <td><input type="text" id="lgtsOrder" maxlength="30" class="inputW127H23"><span class="error"><em></em></span></td>
        </tr>
        <tr id="remarks">
          <td class="width63">输入备注：</td>
          <td><input type="text" id="lgtsRemark" maxlength="20" class="inputW416H23"></td>
        </tr>
        <tr id="paperNoShow" style="display:none;">
          <td class="width63">物流单号：</td>
          <td><label></label></td>
        </tr>
        <tr id="remarksShow" style="display:none;">
          <td class="width63">备　　注：</td>
          <td><label></label></td>
        </tr>
        <tr>
          <td colspan="3">
            <input type="button" id="subLgtsOrder" value="提交物流单" class="left blueBtn">
            <input type="button" id="printFace" value="打印面单" class="left blueBtn">
            <a href="javascript:" id="preview" class="preview cBlue" style="display:none;">预览</a>
            <input type="button" id="deliverySubmit" value="发&nbsp;&nbsp;货" class="left blueBtn" style="display:none;">
            <a href="javascript:" id="rePrintFace" class="rePrintFace cBlue" style="display:none;">重打印面单</a>
            <span id="sendTips" class="sendTips" style="display:none;">发货后系统自动生成物流单号</span>
          </td>
        </tr>
      </table>
    </div>
  </div>  
</div> 
 
  <!--=============物流信息 end==============-->

  <!--面单打印 begin-->
  <div class="orderPrint layer" style="width: 340px;display:none;">
    <div class="layerTop">
        <em class="topr_01"></em><em class="topl_01"></em>
        <div class="topc_01">
            <label>面单打印</label>
            <em class="close"></em>
        </div>
    </div>
    <div class="layerCon">
        <em class="centerr_1"></em><em class="centerl_1"></em>
        <div class="centerc_1">
           <div class="orderPrintList">
                <ul>
                    <li class="orderBg01"></li>
                    <li class="right" style="display: none;"></li>
                    <li class="atE"  style="display: none;"></li>
                    <li>发货面单</li>
                    <li class="btn"><input type="button" class="shortBlueBtn" id='btnPrintOrder'  value="打&nbsp;&nbsp;印"><a class="previewOne" id="previewDelivery" title="预览"></a></li>
                </ul>
                <ul>
                    <li class="orderBg01 orderBgEms"></li>
                    <li class="right"  style="display: none;"></li>
                    <li class="atE" style="display: none;"></li>
                    <li>EMS物流面单</li>
                    <li  class="btn"><input type="button" class="shortBlueBtn" id='btnPrintEMS' value="打&nbsp;&nbsp;印"><a class="previewOne" id="previewEMS" title="预览"></a></li>
                </ul>
           </div>
            
            <div class="printError">
                <div class="error errorOrder" style="display:none;"><div class="errorTop" style=""></div>出库单打印异常，请检查打印链接！</div>
                <div class="error errorEMS" style="display:none;"><div class="errorTop" style=""></div>EMS物流面单打印异常，请检查打印链接！</div>
            </div>
        </div>
    </div>
    <div class="layerBottom">
        <em class="btmr_1"></em>
        <em class="btml_1"></em>
        <div class="btmc_1"></div>
    </div>
  </div>
    
  <!--面单打印 end-->
  
<!--电子运单--面单打印 begin-->
  <div class="elecOrderPrint layer" style="width: 340px;display:none;">
    <div class="layerTop">
        <em class="topr_01"></em><em class="topl_01"></em>
        <div class="topc_01">
            <label>单据打印</label>
            <em class="close"></em>
        </div>
    </div>
    <div class="layerCon">
        <em class="centerr_1"></em><em class="centerl_1"></em>
        <div class="centerc_1">
           <div class="orderPrintList">
                <ul>
                    <li class="orderBg01"></li>
                    <li class="right" style="display: none;"></li>
                    <li class="atE"  style="display: none;"></li>
                    <li>顺丰运单</li>
                    <li class="btn"><input type="button" class="shortBlueBtn" id='sforderprint'  value="打&nbsp;&nbsp;印">
                    <a class="previewOne" id="sfordershow" title="预览"></a></li>
                </ul>
                <ul>
                    <li class="orderBg01 orderBgEms"></li>
                    <li class="right"  style="display: none;"></li>
                    <li class="atE" style="display: none;"></li>
                    <li>顺丰签回单</li>
                    <li class="btn"><input type="button" class="shortBlueBtn" id='sfbackorderprint' value="打&nbsp;&nbsp;印">
                    <a class="previewOne" id="sfbackordershow" title="预览"></a></li>
                </ul>
           </div>
            
            <div class="printError">
                <div class="error errorOrder" style="display:none;"><div class="errorTop" style=""></div>出库单打印异常，请检查打印链接！</div>
                <div class="error errorEMS" style="display:none;"><div class="errorTop" style=""></div>物流面单打印异常，请检查打印链接！</div>
            </div>
        </div>
    </div>
    <div class="layerBottom">
        <em class="btmr_1"></em>
        <em class="btml_1"></em>
        <div class="btmc_1"></div>
    </div>
  </div>
<!--电子运单--面单打印 end-->
<!--发货提示弹出层 end-->
<@form.form id="printForm"  action='${rc.contextPath}/admin/am/delivery/deliveryDocument' method='post'>
    <input type='hidden' name='orderId' id='orderId' value='${orderId}' />
    <input type="hidden" name='operateType' id='operateType'  />
    <input type="hidden" name='logisticType' id='logisticType' />
    <input type="hidden" name='logisticsId' id='logisticsId' />
    <input type="hidden" name='companyId' id='companyId' />
    <input type="hidden" name='companyCode' id='companyCode' />
    <input type="hidden" name='companyName' id='companyName' />
    <input type="hidden" name='lgtsOrder' id='lgtsOrderForm' />
    <input type="hidden" name='lgtsRemark' id='lgtsRemarkForm' />
    <input type="hidden" name='staffId' id='staffId' />
    <input type="hidden" name='staffCode' id='staffCode' />
</@form.form>
<iframe name="printIframe" id="printIframe" src=""  style="position:absolute;width:0px;height:0px;left:-500px;top:-500px;"></iframe>
</div>
</@layout>
