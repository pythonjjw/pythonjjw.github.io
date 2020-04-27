

function createCombox(data) {
    var _html = '<select class="combo-list" style="width:100%;">';
    data.forEach(function (ele, index) {
        _html += '<option value='+ele.value+'>' + ele.text + '</option>';
    });
    _html += '</select>';
    return _html;
}
function createMaterialCombox(data) {
    var _html = '<select class="combo-list" style="width:100%;">';
    data.forEach(function (ele, index) {
        _html += '<option value='+ele.id+'>' + ele.paperName + '</option>';
    });
    _html += '</select>';
    return _html;
}
function createClassCombox(data) {
    var _html = '<select class="combo-class-list" style="width:100%;">';
    _html+=data;
    _html += '</select>';
    return _html;
}

function addRow(tableId, data){
	 var t = $('#'+tableId).DataTable();
	 t.row.add(data).draw( false );
}

function removeRow(row){
	$(row).remove().draw( false );
}

function createdInputCell(cell, cellData, rowData, rowIndex, colIndex){
	$(cell).html('<input type="text" size="16" style="width: 100%"/>');
    var aInput = $(cell).find(":input");
    aInput.focus().val(cellData);
}
function createdPoint6InputCell(cell, cellData, rowData, rowIndex, colIndex){
	$(cell).html('<input onkeyup="onlyNum6point(this)"  type="text" size="16" style="width: 100%"/>');
    var aInput = $(cell).find(":input");
    aInput.focus().val(cellData);
}

function createComboxCell(cell, cellData, rowData, rowIndex, colIndex,comboDataItem){
	if(comboDataItem!=null && comboDataItem != undefined){
            		var aInput;
            		var value = $(cell).html();
            		if(value!=null && value.indexOf("<select")!=-1){
            		}else{
            			$(cell).parent().attr('rows',"row"+rowIndex);
            			$(cell).html(createCombox(comboDataItem));
            			$(cell).find("select").val(value);
            			$(cell).find("select").attr("rows","row"+rowIndex);
            			
            			
            		}
            	}
                $(cell).on("click", ":input", function (e) {
                    e.stopPropagation();
                });
                $(cell).on("change", ":input", function () {
                    $(this).blur();
                });
}

function createMultilevelComboxCell(cell, cellData, rowData, rowIndex, colIndex,comboDataItem){
    if(comboDataItem!=null && comboDataItem != undefined){
        var aInput;
        var value = $(cell).html();
        if(value!=null && value.indexOf("<select")!=-1){
        }else{
            $(cell).parent().attr('rows',"row"+rowIndex);
            $(cell).html(createMultilevelCombox(comboDataItem));
            $(cell).find("select").val(value);
            $(cell).find("select").attr("rows","row"+rowIndex);


        }
    }
    $(cell).on("click", ":input", function (e) {
        e.stopPropagation();
    });
    $(cell).on("change", ":input", function () {
        $(this).blur();
    });
}

function createMultilevelCombox(data) {
    var _html = '<select class="combo-list" style="width:100%;">';
    data.forEach(function (ele, index) {
        _html += '<optgroup label=' + ele.name + '>';
        ele.children.forEach(function (child, index) {
            _html += '<option value =' + child.id + '>' + child.name + '</option>';
        });
        _html += '</optgroup>';
    });
    _html += '</select>';
    return _html;
}
