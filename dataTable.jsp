<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/WEB-INF/webpage/common/taglibs.jspf"%>
<!DOCTYPE html>
<html>
<head>
	<title>文件列表</title>
	<meta name="decorator" content="list"/>
	<html:css name="bootstrap,bootstrap-editable,bootstrap-table" />
	<script src="${staticPath}/common/js/chosenOne.js"></script>
	<script src="${staticPath}/common/js/chosen.jquery.js"></script>
	<link href="${staticPath}/common/css/chosen.css" rel="stylesheet">
	<style>

		.chosen-single {
			line-height: 24px;
		}
		.chosen-container-single{
			width: 150px;
		}

		.chosen-results{
			height:230px;
		}
		.chosen-drop{
			height:270px;
		}

		tbody>tr>td {
			padding: 2px 2px 0 2px !important;
		}
		.chosen-container-single .chosen-single{
			min-height:26px;
			padding:0;
			margin-bottom:1px !important;
			margin-right:2px;
			width:125px;
		}
		.dataTables_wrapper {
			padding-bottom: 0px;
		}
		#assignReportTable > thead > tr > th:first-child {display: none; }
	</style>
</head>

<body class="white-bg" class="materialoutstoreForm" formid="materialoutstoreForm">
	<input id="saveUrl" type="hidden"
		   value="${adminPath}/stock/materialoutstore/saveOtherParams">
	<input id="saveAndReviewUrl" type="hidden"
		   value="${adminPath}/stock/materialoutstore/saveOtherAndReviewParams">
				<div class="gridArea">
					<table id="assignReportTable"
						   class="nowrap table table-striped table-bordered table-hover table-condensed" width="100%">
						<thead>
						<tr>
							<th style="width:20px;">ID</th>
							<th style="width:80px;">印刷订单号</th>
							<th style="width:80px;">客户名称</th>
							<th style="width:100px;">印件名称</th>
							<th style="width:80px;">产品名称</th>
							<th style="width:80px;">成品尺寸</th>
							<th style="width:50px;">部件</th>
							<th style="width:100px;">任务名称</th>
							<th style="width:100px;">纸张</th>
							<th style="width:80px;">库存数量</th>
							<th style="width:60px;">应产数</th>
							<th style="width:90px;">已完成数量</th>
							<th style="width:80px;">本次报工数</th>
							<th style="width:100px;">报工人</th>
							<th style="width:70px;">处理用时</th>
							<th style="width:80px;">备注</th>
							<th style="width:70px;">工序完成</th>
							<th style="width:60px;">操作</th>
						</tr>
						</thead>
					</table>
				</div>
<html:js name="bootstrap-fileinput" />
<html:js
		name="jqgrid,jqGrid_curdtools,jqGrid_curdtools_inline" />
<script src="${staticPath}/datatable/datatables/js/jquery.dataTables.min.js"></script>
<script src="${staticPath}/datatable/commonDT.js"></script>
<script src="${staticPath}/common/js/chosen.jquery.js"></script>
<script type="text/javascript">
	var type="${type}"
    function initCombox(obj){
        $(obj).chosen();
    }

    function  getRepoterByTask(taskId) {
        var html="";
        $.ajax({
            async : false,
            cache : false,
            url:'${adminPath}/product/task/getRepoterByTask?taskId='+taskId,
            type:'get',
            success:function(data){
                data=eval('('+data+')');
                html += '<option value="">请选择</option>';
                for(var i=0;i<data.length;i++){
                    html += '<option ' + 'value="' + data[i].id + '">' + data[i].userName + '</option>';
                }
            }
        });
        return html;
	}
    function createoutComboxCell(cell, cellData, rowData, rowIndex, colIndex){
           var taskId=rowData.id
		   var comboDataItem=getRepoterByTask(taskId);
            var aInput;
            var value = $(cell).html();
            if(value!=null && value.indexOf("<select")!=-1){
            }else{
                $(cell).parent().attr('rows',"row"+rowIndex);
				$(cell).html(createClassCombox(comboDataItem));
                $(cell).find("select").val(value);
                $(cell).find("select").attr("rows","row"+rowIndex);


            }
        $(cell).on("click", ":input", function (e) {
            e.stopPropagation();
        });
        $(cell).on("change", ":input", function () {
            $(this).blur();
        });
    }
    function hideComboxCell(cell, cellData, rowData, rowIndex, colIndex){
        $(cell).attr('style', 'display:none');
	}
    function createdInputCellandChange(cell, cellData, rowData, rowIndex, colIndex){
        var html=""
        if(colIndex==12){
            html='<input class="producibleAmount" onkeyup="onlyNum2point(this)" type="text" style="width: 100%"/>'
        }
        if(colIndex==14){
            html='<input onkeyup="onlyNum2point(this)" type="text" style="width: 100%"/>'
        }
        if(colIndex==15){
                html='<input type="text" style="width: 100%"/>'
        }
        if(colIndex==16){
            html='<input type="checkbox" style="width: 100%"/>'
        }
        $(cell).html(html);
        var aInput = $(cell).find(":input");
        aInput.focus().val(cellData);
    }

    $(function(){
        var setting = {
            columns: [
                { "data": "id" },
                { "data": "orderNo" },
                { "data": "customer" },
                { "data": "orderName" },
                { "data": "productName" },
                { "data": "mediaSize" },
                { "data": "partName" },
				{ "data": "taskName" },
                { "data": "paperName" },
                { "data": "actualAmount" },
                { "data": "actualPrintAmount" },
                { "data": "printedAmount" },
                { "data": "producibleAmount" },
                { "data": "repoters" },
                { "data": "hours" },
                { "data": "remarks" },
                { "data": "isFinished" },
                { "data": "type" }
            ],
            columnDefs: [{
                "targets": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17],
                "defaultContent":""
            },{
                "targets": [0],
                "defaultContent":"",
                createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                    hideComboxCell(cell, cellData, rowData, rowIndex, colIndex);
              }
            },{
                "targets": [12],
                "defaultContent":"",
                createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                    createdInputCellandChange(cell, cellData, rowData, rowIndex, colIndex);
                }
            },
              {
                "targets": [13],
                "defaultContent":"",
                createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                    createoutComboxCell(cell, cellData, rowData, rowIndex, colIndex);
               }
            }, {
                 "targets": [14],
                 "defaultContent":"",
                 createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                     createdInputCellandChange(cell, cellData, rowData, rowIndex, colIndex);
                }
             },{
                 "targets": [15],
                  "defaultContent":"",
                  createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                      createdInputCellandChange(cell, cellData, rowData, rowIndex, colIndex);
               }
             },{
                  "targets": [16],
                  "defaultContent":"",
                  createdCell: function (cell, cellData, rowData, rowIndex, colIndex) {
                      createdInputCellandChange(cell, cellData, rowData, rowIndex, colIndex);
                }
              },{
				"targets": [17],
				"render": function (data, type, row, meta) {
					return data = '<a class="delete"> 删除</a>';

				}
			}],
            ordering: false,
            paging: false,
            info: false,
            searching: false,
            "fnInitComplete": function(oSettings, json) {
                $(".combo-list").each(function(){
                    initCombox(this);
                });
            },

        };
        editTableObj = $("#assignReportTable").DataTable(setting);
        $('#assignReportTable tbody').on('click', '.delete', function(e) {
            e.preventDefault();
            var table = $('#assignReportTable').DataTable();
            table.row($(this).parents('tr')).remove().draw();

        });
        //要将这个放在后面，必须在表初始化完毕后才能够向其内部添加数据
        var taskIds='${taskIds}'
        var materialList =[];
        $.ajax({
            url: "${adminPath}/product/task/assignReportTable?taskIds="+taskIds ,
            type:'post',
            success:function(data){
                var html="";
                data=eval('('+data+')');
                for(var i=0;i<data.length;i++){
                    console.log("productName="+data[i].businessOrderBasic.productName)
                    var material ={"id":data[i].id,"orderNo":data[i].orderNo,"customer":data[i].customer,"orderName":data[i].orderName,"productName":data[i].businessOrderBasic.productName,
                        "mediaSize":data[i].mediaSize,"partName":data[i].partName,"taskName":data[i].taskName,"paperName":data[i].paperName,"actualAmount":data[i].actualAmount,"actualPrintAmount":data[i].actualPrintAmount,
						"printedAmount":data[i].printedAmount,"type": null}
                    $("#assignReportTable").dataTable().fnAddData(material);
                    $('#assignReportTable tr:last-child').find(".producibleAmount").eq(0).each(function(){
                        $(this).val(Number(data[i].actualPrintAmount)-Number(data[i].printedAmount));
                    });
                    $(".combo-class-list").each(function(){
                        initCombox(this);
                    });
                }
            }
        });
        $("tr[row^='row']").each(function(){
            $(this).find("td:eq(0)").attr().attr('style', 'display:none');
        });


    });
    function doSubmit(func){
        callFunc=func;
        //遍历是否出现跳出现象的标志
        var flag=true;
        var taskReports=[];
        $("#assignReportTable tbody tr").each(function(index,eleTr){

            var taskReport={};
            //首先判断报工数量
            var actualPrintAmount=$(eleTr).find("td:eq(10)").text();
            var printedAmount=$(eleTr).find("td:eq(11)").text();
            var producibleAmount=Number(actualPrintAmount)-Number(printedAmount);
            var finishedAmount=$(eleTr).find("td:eq(12)").find("input").val();
            if(producibleAmount<Number(finishedAmount)){
                top.layer.alert("本次报工数量大于可报工数量", {
                    icon : 0,
                    title : '提示'
                });
                flag=false;
                return false;
            }else{
                if(producibleAmount==finishedAmount){
                    taskReport["taskFinish"]=true;
                }else{
                    var taskFinish=$(eleTr).find("td:eq(16)").find("input").is(":checked");
                    taskReport["taskFinish"]=taskFinish;
                }
            }
            taskReport["finishedAmount"]=finishedAmount;
            var taskId=$(eleTr).find("td:eq(0)").text();
            taskReport["taskId"]=taskId;
            var processName=$(eleTr).find("td:eq(7)").text();
            taskReport["taskName"]=processName;
            var usedTime=$(eleTr).find("td:eq(14)").find("input").val();
            taskReport["usedTime"]=usedTime;
            var remarks=$(eleTr).find("td:eq(15)").find("input").val();
            taskReport["remarks"]=remarks;
            /* var paperUnit=$(eleTr).find("td:eq(11)").text();
            taskReport["paperUnit"]=paperUnit; */
            taskReport["finishTime"]= $("#finishTime").val();
            /* var finishedPaperAmount=$(eleTr).find("td:eq(11)").find("input").val();
            taskReport["finishedPaperAmount"]=finishedPaperAmount; */
            var reporterId=$(eleTr).find("td:eq(13)").find("select").find("option:selected").val();
            taskReport["reporterId"]=reporterId;
            taskReports.push(taskReport)
        })
        if(!flag){
            return false;
        }
        $.ajax({
            type : "POST",
            cache : true,
            async : false,
            url : "${adminPath}/product/task/saveManyReportTask",
            data : {
                "taskReports" : JSON.stringify(taskReports),
                "type":type
            },
            success : function(result) {
                if (result.ret == 0) {
                    top.layer.alert(result.msg, {
                        icon : 0,
                        title : '提示'
                    });
                    callFunc();
                } else {
                    top.layer.alert(result.msg, {
                        icon : 0,
                        title : '警告'
                    });
                }
            }
        });
    }

</script>
</body>
</html>
