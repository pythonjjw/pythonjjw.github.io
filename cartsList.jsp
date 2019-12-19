<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/webpage/common/taglibs.jspf" %>
<!--Author:guanghe-->
<html>
<head>
    <title>购物车</title>
     <meta charset="UTF-8">
    <meta name="decorator" content="webfront"/>
    <link rel="stylesheet" href="${staticPath}/common/css/reset.css">
    <link rel="stylesheet" href="${staticPath}/common/css/cart.css">
    <script src="${staticPath}/common/js/cart.js"></script>
    <script>
          //页面初始化
          /*  html='<ul class="order_lists"> <li class="list_chk"> <input type="checkbox" id="checkbox_'
           +i+'" class="son_check"> <label for="checkbox_'
           +'"></label><label for="checkbox_'+i+'"></label></li><li class="list_con"><div class="list_text"><a href="javascript:;">'
           +desc+'</a></div></li><li class="list_amount"><div class="amount_box"><a href="javascript:;" class="reduce reSty">-</a><input type="text" value="1" class="sum"><a href="javascript:;" class="plus">+</a></div> </li><li class="list_sum"><p class="sum_price_'
           +i+'">'+tatolMoey+'</p></li><li class="list_op"><p class="del"><a href="javascript:;" class="delBtn">移除商品</a></p></li></ul>'
            */
           
           $(document).ready(function(){
        	
        });
        </script>
</head>
<body>
    <section class="cartMain">
       <!-- <div class="cartMain_hd">
            <ul class="order_lists cartTop">
                <li class="list_chk">
                    所有商品全选
                    <input type="checkbox" id="all" class="whole_check">
                    <label for="all"></label>
                    全选
                </li>
                <li class="list_con">商品信息</li>
                <li class="list_info">商品参数</li>
                <li class="list_price">单价</li>
                <li class="list_amount">数量</li>
                <li class="list_sum">金额</li>
                <li class="list_op">操作</li>
            </ul>
        </div> -->

        <div class="cartBox">
            <div class="order_content">
                  <c:forEach items="${menus}" var="order" varStatus="mainStatus">
	        	   <ul class="order_lists" >
                    <li class="orderId" hidden>
                         <p>${order.id}</p>
                    </li>    
                     <li class="orderNo" hidden>
                         <p>${order.orderNo}</p>
                    </li>     
	               <li class="list_chk">
	                   <label ><input type="checkbox" id="checkbox_${mainStatus.count}" class="son_check"></label>
	               </li>
	               <li class="list_con">
	               <div class="list_img">${order.orderName}</div>
	                   <div class="list_text"><font color="blue">订单详情</font>
	                      <span class="orderDesc">${order.desc}</span>
	                   </div>
	               </li>
	                 <li class="list_info" >
                        <p>备注信息：${order.remarks}</p>
                    </li>
	               <li class="list_price" hidden>
                        <p class="price">￥${order.orderAmount}</p>
                    </li>
	               <li class="list_amount">
	                <p class="sum">数量：${order.printingQuantity}</p>
	                   <!-- <div class="amount_box">
	                       <a href="javascript:;" class="reduce reSty">-</a>
	                       <input type="text" value="1" style="height:22px" class="sum">
	                       <a href="javascript:;" class="plus">+</a>
	                   </div> -->
	               </li>
	               
	               <li class="list_sum">
	                   <p class="sum_price">￥${order.orderAmount}</p>
	               </li>
	               <li class="list_op">
	                   <p class="del"><a href="javascript:;" class="delBtn">删除商品</a></p>
	               </li>
           </ul>
          </c:forEach>
            </div>
        </div>

        <!--底部-->
        <div class="bar-wrapper" style="display: inline-block;">
            <div class="bar-right">
                <div class="all"><input type="checkbox" id="all" class="whole_check"><label for="all"></label>
                      全选</div>
                <div class="piece">已选商品<strong class="piece_num">0</strong>件</div>
                <div class="totalMoney">合计（不含运费）： <strong class="total_text">0.00</strong></div>
                <div class="calBtn"><a href="javascript:submitBatchOrder();">结算</a></div>
            </div>
        </div>
    </section>
    <section class="model_bg"></section>
    <section class="my_model">
        <p class="title">删除宝贝<span class="closeModel">X</span></p>
        <p>您确认要删除该宝贝吗？</p>
        <div class="opBtn"><a href="javascript:;" class="dialog-sure">确定</a><a href="javascript:;" class="dialog-close">关闭</a></div>
    </section>
</body>
</html>
