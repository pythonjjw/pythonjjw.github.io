       //合并
        function mergeRow(){
            var productNum=0;
            var nowIndexTr=1;
            $("#oprTicketSomeIdGrid tbody tr").each(function (indexTr, elementTr){

                if(indexTr==0){

                }else{
                    if(indexTr == nowIndexTr){
                        productNum=parseInt($(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_productNum']").text());
                        if(productNum>1){

                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_rn']").attr("rowspan", productNum);
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_printOrderNo']").attr("rowspan", productNum);
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_customerName']").attr("rowspan", productNum);
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_isbn']").attr("rowspan", productNum);
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_orderName']").attr("rowspan", productNum);
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_amount']").attr("rowspan", productNum);
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_deliveryTime']").attr("rowspan", productNum);
                        }
                        nowIndexTr+=productNum;
                    }else{
                        if(productNum>1){
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_rn']").remove();
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_printOrderNo']").remove();
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_customerName']").remove();
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_isbn']").remove();
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_orderName']").remove();
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_amount']").remove();
                            $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_deliveryTime']").remove();
                        }

                    }

                }
            });

        }

        function showProcessProgress(){
            $("#oprTicketSomeIdGrid tbody tr").each(function (indexTr, elementTr){
                var rowid=$(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_id']").text();
                var businessOrderBasicId=$(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_businessOrderBasicId']").text();
                if(rowid!=""){
                    var url='/smart-produce/admin/product/showProgress?id='+rowid+''+"&isMonitor=1"+"&businessOrderBasicId="+businessOrderBasicId;
                    $.post(url,function(data){
                        $(elementTr).children("td[aria-describedby='oprTicketSomeIdGrid_progressShow']").html(data);
                    })
                }

            });
        }
