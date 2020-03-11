<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/webpage/common/taglibs.jspf" %>
<!DOCTYPE html>
<html>
<head>
	<title>订单中心</title>
	<meta name="decorator" content="form"/>
	<style>
		input {border: 0px;outline:none;cursor: pointer;}
		select {
			border: 0px;outline:none;cursor: pointer;
			appearance:none;
			-moz-appearance:none;
			-webkit-appearance:none;
		}
		.arrow{margin-top: -3px;margin-right: 10px;}
		.pull-right{margin-right: 0px;}
		.fa.arrow:before {content: "\f106";}
		.active > a > .fa.arrow:before {content: "\f107";}
		.panel{margin: 5px auto;}
		.label-right
		{
			text-align: right;
		}
		table.commonInfo td label{
			width:70px;
			text-align: left;
			margin-bottom:0px;
		}
	</style>
	<script type="text/javascript" src="${staticPath}/common/js/iframe.js"></script>
	<script>
        $(function() {
            $("select").attr("disabled", true);
            $("input[type='checkbox']").attr("disabled", true);
            $(".localpanelhead").each(function(){
                $(this).click(function () {
                    var name = $(this).find("span").eq(0).text();
                    if(name=='收起'){
                        $(this).find("span").eq(0).text("展开")
                        $(this).parent().addClass("active");
                        $(this).parent().parent().find(".panel-body").eq(0).hide();
                    }else{
                        $(this).find("span").eq(0).text("收起")
                        $(this).parent().removeClass("active");
                        $(this).parent().parent().find(".panel-body").eq(0).show();
                    }
                })
            })
        });

	</script>
</head>
<body class="white-bg" formid="oprPrintOrderForm">
<form:form id="oprPrintOrderForm" modelAttribute="data" method="post" class="form-horizontal no-footer">
	<div class="panel panel-default" style="margin-bottom: 2px;">
	<div class="pageclass panel-body tab-pane fade in active" id="basic">
		<!---------------------------------------------------------------------------------------->
		<div class="page-content">
			<table class="commonInfo" style="margin-left: 5px; height: 39px;">
			     <tr>
				<td style="width:200px"><label>印刷订单：</label>
							<span><font color="red">${data.orderNo}</font></span>
					</td>
					<td style="width:200px"><label>制单人：</label>
						<span>${username}</span>
					</td>
					<td style="width:260px"><label>制单时间：</label>
						<span>${createDate}</span>
					</td>
			     </tr>
		       </table>
		</div>
		<!--印件信息------------------------------------------------------------------------------->
		<jsp:include page="../businessorder/preview-basic2.jsp"></jsp:include>
		<!--产品信息------------------------------------------------------------------------------->
		<c:forEach items="${productList }" var="product" varStatus="status">
<div>
  <div id="basicPanel" class="panel panel-default" style="display:${hideBasic eq "1" ? "none" : "block"}">
	<div class="panel-heading">
           <strong>${product.productName }</strong>
	      <a href="#" class="pull-right localpanelhead"><span class="pull-right">收起</span><span class="fa arrow fa-2x"></span></a>
	   </div>
	<div class="panel-body">
	   <table class="commonInfo">
		<tr>
		    <td class="label-right" style='width:90px;' >产品名称：</td>
		    <td colspan="7"><label>${product.productName }</label></td>
		    <td class="label-right">印件类型：</td>
		    <td><label id="orderTypeName"><c:choose>
			<c:when test="${product.orderType==1}">
				画册
			</c:when>
			<c:when test="${product.orderType==2}">
				名片
			</c:when>
			<c:when test="${product.orderType==3}">
				单页
			</c:when>
			<c:otherwise>
				图书
			</c:otherwise>
			</c:choose></label>
		   </td>
		</tr>
		<c:choose>
		<c:when test="${product.orderType==1}">
		   <tr>
		      <td class="label-right">成品尺寸：</td>
		      <td><label>${product.mediaSize}</label></td>
		      <td class="label-right">开本：</td>
		      <td><label>${product.bookSize}<c:if test="${product.bookSize !=''}">开</c:if></label></td>
		      <td class="label-right">订购数量：</td>
		      <td><label>${product.printingQuantity}</label></td>
		      <td class="label-right">左翻\右翻：</td>
		      <td><label>${product.leftRight}</label></td>
		      <td class="label-right">勒口：</td>
	              <td ><label>${product.flapSize}</label></td>
		   </tr>

		   <tr class="card">
		      <td class="label-right" > 封套：</td>
		      <td><label>${product.fengTao}</label></td>
	           </tr>
		</c:when>
		<c:when test="${product.orderType==2}">
		   <tr>
		      <td class="label-right">成品尺寸：</td>
		      <td><label>${product.mediaSize}</label></td>
		      <td class="label-right">订购数量：</td>
		      <td><label>${product.printingQuantity}</label></td>
		      <td class="label-right">每盒张数：</td>
		      <td><label>${product.cartonNumber}</label></td>
		  </tr>
		</c:when>
		<c:when test="${product.orderType==3}">
		  <tr>
		      <td class="label-right">成品尺寸：</td>
		      <td><label>${product.mediaSize}</label></td>
                      <td class="label-right">订购数量：</td>
		      <td><label>${product.printingQuantity}</label></td>
		      <td class="label-right">左翻\右翻：</td>
		      <td><label>${product.leftRight}</label></td>
		      <td class="label-right">勒口：</td>
                      <td><label>${product.flapSize}</label></td>
		      <td class="label-right" > 封套：</td>
		      <td><label>${product.fengTao}</label></td>
		  </tr>
		</c:when>
		<c:otherwise>
		<tr>
		      <td class="label-right">成品尺寸：</td>
		      <td><label>${product.mediaSize}</label></td>
		      <td class="bookAndDraw label-right">开本：</td>
		      <td  class="bookAndDraw">
		      <label>${product.bookSize}<c:if test="${product.bookSize !=''}">开</c:if></label></td>
		      <td class="label-right">订购数量：</td>
		      <td><label>${product.printingQuantity}</label></td>
		      <td class="label-right">左翻\右翻：</td>
		      <td><label>${product.leftRight}</label><td class="label-right">勒口：</td>
		      <td ><label>${product.flapSize}</label></td>
		</tr>
		<tr>
		      <td class="label-right" > 封套：</td>
		      <td><label>${product.fengTao}</label></td>
		      <td class="label-right">印张：</td>
		      <td><label>${product.sheet}</label></td>
		      <td class="label-right">版次印次：</td>
		      <td><label>${product.edition}</label></td>
		      <td class="label-right"> 书号：</td>
		      <td ><label style="width:150px">${product.isbn}</label></td>
		      <td class="label-right"> 定价：</td>
		      <td><label>${product.bookPrice}</label></td>
		</tr>
		<tr>
                      <td class="label-right">包装：</td>
		      <td><label>${zBusinessOrderBasic.wrap}</label></td>
		      <td class="label-right">本厂标记：</td>
		      <td><label>${product.factoryMark}</label></td>
             </tr>
	 </c:otherwise>
     </c:choose>
</table>
<table class="commonInfo">
     <tr>
	  <td class="label-right">印装次序：</td>
	  <td><span> ${product.bindingSequence }</span></td>
     </tr>
     <tr>
	  <td class="label-right">装订工艺：</td>
	  <td><span> ${product.bindProcess }</span></td>
     </tr>
     <tr>
          <td class="label-right">备注：</td>
	  <td><span> ${product.remarks }</span></td>
     </tr>
</table>
<c:if test="${!empty product.partTaskMap}">
   <form class="form-horizontal">
      <div class="form-group">
        <div class="col-sm-12">
          <div class="page-content">
	    <table class="innerTable" style="width: 100%; margin-left: 0px;">
	         <thead>
	             <tr>
		         <th>部件</th> <th>生产环节</th> <th>任务</th> <th>状态</th> <th>应产数</th> <th>已报工数量</th>
		     </tr>
		 </thead>
    <tbody>
      <c:forEach items="${product.partTaskMap}" var="reportMap" varStatus="reportMapIndex">
	   <!--此处flag是为了判断是否进入第一次循环--------------------------------------->
	   <c:set var="flag" value="1"/>
	      <c:forEach items="${reportMap.value}" var="reportMapObj" varStatus="reportMapObjIndex">
		 <c:forEach items="${reportMapObj.value }" var="obj"  varStatus="objIndex">
                     <tr>
			<c:if test="${flag==1}">
			<c:set var="flag" value="0"/>
                            <td rowspan="${fn:substring(reportMap.key,fn:indexOf(reportMap.key,''),fn:length(reportMap.key))}">此处省略...</td>
			</c:if>
			<c:if test="${ objIndex.index==0}">
                             <td rowspan="${fn:length(reportMapObj.value) }">${reportMapObj.key }</td>
			</c:if>													 
                              <td>${obj.taskName}</td>
																	 
                              <td>${obj.taskStatus}</td>
																	 
                              <td>${obj.actualPrintAmount}</td>
																	 
                              <td>${obj.printedAmount}</td>
		     </tr>
		  </c:forEach>
	       </c:forEach>
	</c:forEach>
    </tbody>
 </table>
</div>
</div>
</div>
</form>
</c:if>
</div>
</div>
</div>
</c:forEach>
<!---------------------------------------------------------------------------------------->
</div>
</div>
</form:form>
</body>
</html>
