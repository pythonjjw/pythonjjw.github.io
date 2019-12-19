/**
 * Created by Administrator on 2019/5/24.
 */

$(function () {

        $wholeChexbox = $('.whole_check'),              //全选
        $cartBox = $('.cartBox'),                       //商铺盒子
        $sonCheckBox = $('.son_check');                 //商品的checkbox
        $delBtn = $('.delBtn');                         //删除按钮
    //===============================================全局全选与单个商品的关系================================
    $wholeChexbox.click(function () {
        var $checkboxs = $cartBox.find('input[type="checkbox"]');
        if ($(this).is(':checked')) {
            $checkboxs.prop("checked", true);
            $checkboxs.next('label').addClass('mark');
        } else {
            $checkboxs.prop("checked", false);
            $checkboxs.next('label').removeClass('mark');
        }
        totalMoney();
    });


    $sonCheckBox.each(function () {
        $(this).click(function () {
            if ($(this).is(':checked')) {
                //判断：所有单个商品是否勾选
                var len = $sonCheckBox.length;
                var num = 0;
                $sonCheckBox.each(function () {
                    if ($(this).is(':checked')) {
                        num++;
                    }
                });
                if (num == len) {
                    $wholeChexbox.prop("checked", true);
                    $wholeChexbox.next('label').addClass('mark');
                }
            } else {
                //单个商品取消勾选，全局全选取消勾选
                $wholeChexbox.prop("checked", false);
                $wholeChexbox.next('label').removeClass('mark');
            }
        })
    })

    //店铺$sonChecks有一个未选中，店铺全选按钮取消选中，若全都选中，则全选打对勾
    $cartBox.each(function () {
        var $this = $(this);
        var $sonChecks = $this.find('.son_check');
        $sonChecks.each(function () {
            $(this).click(function () {
                if ($(this).is(':checked')) {
                    //判断：如果所有的$sonChecks都选中则店铺全选打对勾！
                    var len = $sonChecks.length;
                    var num = 0;
                    $sonChecks.each(function () {
                        if ($(this).is(':checked')) {
                            num++;
                        }
                    });
                    if (num == len) {
                        $(this).parents('.cartBox').find('.shopChoice').prop("checked", true);
                        $(this).parents('.cartBox').find('.shopChoice').next('label').addClass('mark');
                    }

                } else {
                    //否则，店铺全选取消
                    $(this).parents('.cartBox').find('.shopChoice').prop("checked", false);
                    $(this).parents('.cartBox').find('.shopChoice').next('label').removeClass('mark');
                }
                totalMoney();
            });
        });
    });


    //=================================================商品数量==============================================
    var $plus = $('.plus'),
        $reduce = $('.reduce'),
        $all_sum = $('.sum');
    $plus.click(function () {
        var $inputVal = $(this).prev('input'),
            $count = parseInt($inputVal.val())+1,
            $obj = $(this).parents('.amount_box').find('.reduce'),
            $priceTotalObj = $(this).parents('.order_lists').find('.sum_price'),
            $price = $(this).parents('.order_lists').find('.price').html(),  //单价
            $priceTotal = $count*parseInt($price.substring(1));
        $inputVal.val($count);
        $priceTotalObj.html('￥'+$priceTotal);
        if($inputVal.val()>1 && $obj.hasClass('reSty')){
            $obj.removeClass('reSty');
        }
        totalMoney();
    });

    $reduce.click(function () {
        var $inputVal = $(this).next('input'),
            $count = parseInt($inputVal.val())-1,
            $priceTotalObj = $(this).parents('.order_lists').find('.sum_price'),
            $price = $(this).parents('.order_lists').find('.price').html(),  //单价
            $priceTotal = $count*parseInt($price.substring(1));
        if($inputVal.val()>1){
            $inputVal.val($count);
            $priceTotalObj.html('￥'+$priceTotal);
        }
        if($inputVal.val()==1 && !$(this).hasClass('reSty')){
            $(this).addClass('reSty');
        }
        totalMoney();
    });

    $all_sum.keyup(function () {
        var $count = 0,
            $priceTotalObj = $(this).parents('.order_lists').find('.sum_price'),
            $price = $(this).parents('.order_lists').find('.price').html(),  //单价
            $priceTotal = 0;
        if($(this).val()==''){
            $(this).val('1');
        }
        $(this).val($(this).val().replace(/\D|^0/g,''));
        $count = $(this).val();
        $priceTotal = $count*parseInt($price.substring(1));
        $(this).attr('value',$count);
        $priceTotalObj.html('￥'+$priceTotal);
        totalMoney();
    })

    //======================================删除商品========================================

    var $order_lists = null;
    var $order_content = '';
    $delBtn.click(function () {
    	 $order_lists = $(this).parents('.order_lists');
         $order_content = $order_lists.parents('.order_content');
    	var orderId=$(this).parents('.order_lists').find('.orderId').find("p").html();
    	var tipMsg="您确定要删除该宝贝！";
 	   swal({
           title: "提示",
           text: tipMsg,
           type: "warning",
           showCancelButton: true,
           confirmButtonColor: "#DD6B55",
           confirmButtonText: "确定",
           closeOnConfirm: false,
           cancelButtonText: "取消",
       }, function () {
			$.ajax({
				url : "/smart-produce/webfront/mycart/deleteOrder",
				type : 'post',
				data : {
					id : orderId
				},
				cache : false,
				success : function(d) {
					if (d.ret==0) {
						var msg = d.msg;
					    swal("提示！", msg, "success");
					    $order_lists.remove();
				        if($order_content.html().trim() == null || $order_content.html().trim().length == 0){
				            $order_content.parents('.cartBox').remove();
				        }
				        closeM();
				        $sonCheckBox = $('.son_check');
				        totalMoney();
					    //刷新表单
					}else{
						var msg = d.msg;
					    swal("提示！", msg, "error");
					}
				}
			});
       });
    });
    //======================================总计==========================================

    function totalMoney() {
        var total_money = 0;
        var total_count = 0;
        var calBtn = $('.calBtn a');
        $sonCheckBox.each(function () {
            if ($(this).is(':checked')) {
                var goods = parseInt($(this).parents('.order_lists').find('.sum_price').html().substring(1));
                var num =  parseInt($(this).parents('.order_lists').find('.sum').val());
                total_money += goods;
                total_count += num;
            }
        });
        $('.total_text').html('￥'+total_money);
        $('.piece_num').html(total_count);
        $('#order_num').html(total_count);

        // console.log(total_money,total_count);

        if(total_money!=0 && total_count!=0){
            if(!calBtn.hasClass('btn_sty')){
                calBtn.addClass('btn_sty');
            }
        }else{
            if(calBtn.hasClass('btn_sty')){
                calBtn.removeClass('btn_sty');
            }
        }
    }


});

function getOrderIds(){
	var orderIds="";
	$sonCheckBox.each(function () {
        if ($(this).is(':checked')) {
        	orderIds+=$(this).parents('.order_lists').find('.orderId').find("p").html()+",";
        }
    });
	return orderIds;
}
//购物车实现批量结算
function submitBatchOrder(){
	var orderIds= getOrderIds();
	window.location.href = "/smart-produce/webfront/mycart/toAddress?orderIds=" + orderIds;
	/*orderIds=orderIds.substring(0,orderIds.length-1);
	$.ajax({
        url: apiPath + "/submitBatchOrder" ,
        type: 'post',
        contentType: 'application/json',
        dataType: "json",
        data : orderIds,
        cache: false,
        async: true,
        success: function (result, status, xhr) {
            if(result.code == 0) {
            	top.layer.alert(result.msg);
            } else {
                top.layer.alert(result.msg);
            }
        },
        error: function (xhr, status, err) {
            setTimeout(function () {
                top.layer.alert(err);
            }, 100);
        }
    });*/
}
