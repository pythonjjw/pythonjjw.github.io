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
	<script>
        $(function() {
            $("select").attr("disabled", true);
            $("input[type='checkbox']").attr("disabled", true);
            $(".localpanelhead").each(function(){
                $(this).click(function () {
                    var name = $(this).find("span").eq(0).text();
                    if(name=='close'){
                        $(this).find("span").eq(0).text("open")
                        $(this).parent().addClass("active");
                        $(this).parent().parent().find(".panel-body").eq(0).hide();
                    }else{
                        $(this).find("span").eq(0).text("close")
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
				<td style="width:200px"><label>名称：</label>
							<span><font color="red">${data}</font></span>
					</td>
					<td style="width:200px"><label>名称：</label>
						<span>${data}</span>
					</td>
					<td style="width:260px"><label>名称：</label>
						<span>${data}</span>
					</td>
			     </tr>
		       </table>
		</div>
<c:forEach items="${productList }" var="product" varStatus="status">
  <div>
     <div id="basicPanel" class="panel panel-default" style="display:${hideBasic eq "1" ? "none" : "block"}">
	<div class="panel-heading">
           <strong>${product.productName }</strong>
	      <a href="#" class="pull-right localpanelhead"><span class="pull-right">close</span><span class="fa arrow fa-2x"></span></a>
	   </div>
	<div class="panel-body">
	   <table class="commonInfo">
		<tr>
		    <td class="label-right" style='width:90px;' >属性：</td>
		    <td colspan="7"><label>${product }</label></td>
		    <td class="label-right">属性：</td>
		    <td><label id="orderTypeName"><c:choose>
			<c:when test="${product==1}">
				product
			</c:when>
			<c:when test="${product==2}">
				product
			</c:when>
			<c:otherwise>
				属性
			</c:otherwise>
			</c:choose></label>
		   </td>
		</tr>
		<c:choose>
		<c:when test="${product.orderType==1}">
		   <tr>
		      <td class="label-right">属性：</td>
		      <td><label>${product}</label></td>
		      <td class="label-right">属性：</td>
		      <td><label>${product}<c:if test="${product !=''}">开</c:if></label></td>
		      <td class="label-right">属性：</td>
		      <td><label>${product}</label></td>
		      <td class="label-right">属性：</td>
		      <td><label>${product}</label></td>
		      <td class="label-right">属性：</td>
	              <td ><label>${product}</label></td>
		   </tr>

		   <tr class="card">
		      <td class="label-right" > 属性：</td>
		      <td><label>${product}</label></td>
	           </tr>
		</c:when>
		<c:when test="${product==2}">
		   <tr>
		      <td class="label-right">属性：</td>
		      <td><label>${product}</label></td>
		      <td class="label-right">属性：</td>
		      <td><label>${product}</label></td>
		      <td class="label-right">属性：</td>
		      <td><label>${product}</label></td>
		  </tr>
		</c:when>
		<c:otherwise>
		<tr>
		      <td class="label-right">属性：</td>
		      <td><label>${product}</label></td>
               </tr>
	 </c:otherwise>
     </c:choose>
</table>
<table class="commonInfo">
     <tr>
	  <td class="label-right">属性：</td>
	  <td><span> ${product }</span></td>
     </tr>
     <tr>
	  <td class="label-right">属性：</td>
	  <td><span> ${product }</span></td>
     </tr>
     <tr>
          <td class="label-right">属性：</td>
	  <td><span> ${product }</span></td>
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
		         <th>部件</th> <th>数量</th> <th>任务</th> <th>状态</th> <th>可以</th> <th>内容</th>
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
                              <td>${obj.name}</td>
																	 
                              <td>${obj.statuss}</td>
																	 
                              <td>${obj.printAmount}</td>
																	 
                              <td>${obj.amount}</td>
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
