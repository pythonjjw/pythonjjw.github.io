# pythonjjw.github.io
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>block_script</title>
    <style>
body
{ 
    background-color:#b0c4de;
}


    
button
{
   background-color:#e0ffff;
}



</style>
</head>
<body>
<div>
    <h1> [1/256]、[经纬度]、[度]  相互转换   </h1>
    <p>[1/256]向[经纬度]、[度]的转换</p>
    <div>
        <label>[1/256]经度</label>
        <input id="input_lon_1" type="" name="" value="128584704">
        <label>[1/256]纬度</label>
        <input id="input_lat_1" type="" name="" value="33090048">
    </div>
    <div>
        <button id="make_trans1">转换1</button>
    </div>
    <div>
        <label>[度]经度</label>
        <input id="input_lon_2" type="" name="" value="">
        <label>[度]纬度</label>
        <input id="input_lat_2" type="" name="" value="">
    </div>
    <div>
        <label>[度分秒]经度</label>
        <input id="input_lon_3" type="" name="" value="">
        <label>[度分秒]纬度</label>
        <input id="input_lat_3" type="" name="" value="">
    </div>
    <p>度向经纬度、1/256的转换</p>
    
    <div>
        <label>[度]经度</label>
        <input id="input_lon_4" type="" name="" value="139.52333333333334">
        <label>[度]纬度</label>
        <input id="input_lat_4" type="" name="" value="35.905">
    </div>
    
    <div>
        <button id="make_trans3">转换1</button>
    
    </div>
    <div>
        <label>[1/256]经度</label>
        <input id="input_lon_5" type="" name="" value="">
        <label>[1/256]纬度</label>
        <input id="input_lat_5" type="" name="" value="">
    </div>
    <div>
        <label>[度分秒]经度</label>
        <input id="input_lon_6" type="" name="" value="">
        <label>[度分秒]纬度</label>
        <input id="input_lat_6" type="" name="" value="">
    </div>
    <p>经纬度向度、1/256的转换</p>
    <div>
        <label>[度分秒]经度</label>
        <input id="input_lon_7" type="" name="" value="139.31.24" <label="">[度分秒]纬度
        <input id="input_lat_7" type="" name="" value="35.54.18" <="" div="">
    
    <div>
        <button id="make_trans5">转换1</button>
    
    </div>
    <div>
        <label>[度]经度</label>
        <input id="input_lon_8" type="" name="" value="">
        <label>[度]纬度</label>
        <input id="input_lat_8" type="" name="" value="">
    </div>
    <div>
        <label>[1/256]经度</label>
        <input id="input_lon_9" type="" name="" value="">
        <label>[1/256]纬度</label>
        <input id="input_lat_9" type="" name="" value="">
    </div>

</div>
<div>
    <h1>RandomKey GPS录入页面制作脚本</h1>
    <div>
        <label>经度</label>
        <input id="input_lon" type="" name="" value="E139.13.45">
        <label>纬度</label>
        <input id="input_lat" type="" name="" value="N46.32.23">
    </div>
    <div>
        <button id="make_script">生成脚本</button>
    </div>
    <div>
        <textarea id="script_text" rows="20" cols="80">TAP 460 150 500 #按压经度
TAP 300 280 500  #1
TAP 700 280 500  #3
TAP 700 500 500  #9
TAP 300 280 500  #1
TAP 700 280 500  #3
TAP 300 380 500  #4
TAP 550 380 500  #5
TAP 460 60 500 #按压维度
TAP 300 380 500  #4
TAP 700 380 500  #6
TAP 700 280 500  #3
TAP 550 280 500  #2
TAP 550 280 500  #2
TAP 700 280 500  #3
TAP 1100 60 500 #按压OK
</textarea>
    </div>
</div>

<script src="jquery-3.2.1.js"></script>

<script type="text/javascript">

var gps_page_map = {
'0'         : { 'x' : 550 , 'y' : 650  },
'1'         : { 'x' : 300 , 'y' : 280  },
'2'         : { 'x' : 550 , 'y' : 280  },
'3'         : { 'x' : 700 , 'y' : 280  },
'4'         : { 'x' : 300 , 'y' : 380  },
'5'         : { 'x' : 550 , 'y' : 380  },
'6'         : { 'x' : 700 , 'y' : 380  },
'7'         : { 'x' : 300 , 'y' : 500  },
'8'         : { 'x' : 550 , 'y' : 500  },
'9'         : { 'x' : 700 , 'y' : 500  },
'backspace' : { 'x' : 950 , 'y' : 280  },
'lat'       : { 'x'  :460  , 'y' : 60  },//纬度 Latitude
'lon'       : { 'x'  :460  , 'y' : 150 },//经度 Longitude
'ok'        : { 'x'  :1100 , 'y' : 60  },
}

// console.log(gps_page_map["0"].x);
// console.log(gps_page_map["0"].y);





function split_gps_string(gps_string) {
    // body...
    gps_string  =  gps_string.substring(1, gps_string.length);
    
    gps_string  = gps_string.split(".");
    gps_degree  = gps_string[0];
    gps_minute  = gps_string[1];
    gps_second  = gps_string[2];

    // for (var i = 0; i < gps_string.length; i++) {

    //     console.log(gps_string[i].length);
    //     if(i>0 && gps_string[i].length)
    //     {

    //     }

    // }

    if (gps_minute.length==1)
    {
        gps_minute = "0"+gps_minute;
    }
    else if (gps_minute.length==0)
    {
        gps_minute = "00";
    }

    if (gps_second.length==1)
    {
        gps_second = "0"+gps_second;
    }
    else if (gps_second.length==0)
    {
        gps_second = "00";
    }
    

    return gps_degree+gps_minute+gps_second;
}

var delay_time  = "2000"

function make_number_string_to_srcipt(number_string) {
    // body...
    var number_script_text = ""
    var number_script_line = ""
    for (var i = 0; i < number_string.length; i++) {
        var number = number_string[i];
        console.log(gps_page_map[number].x,gps_page_map[number].y,number);
        number_x =  gps_page_map[number].x;
        number_y =  gps_page_map[number].y;
        number_script_line = "TAP "+number_x+" "+number_y+" "+delay_time+""+"  #"+number+"\n";
        number_script_text = number_script_text + number_script_line ;
    }
    return number_script_text;
}

//检查输入
function input_text_check() {
    // body...
    var input_lon1 = $("#input_lon").val();
    var input_lat1 = $("#input_lat").val();
    input_lon1=input_lon1.split(".");
    input_lat1=input_lat1.split(".");
    console.log(input_lon1);

    if(input_lon1.length>4||input_lat1.length>4)
    {
        return false;
    }
    var input_lon = split_gps_string($("#input_lon").val());
    var input_lat = split_gps_string($("#input_lat").val());
    // console.log(input_lon);
    // console.log(input_lat);
    // console.log(input_lon.length);
    // console.log(input_lat.length);
    if((input_lon.length!=7)||(input_lat.length!=6))
    {    
        return false;
    }
    else
    {
        var count1=0,count2=0;
        for (var i = 0; i < input_lon.length; i++)
        {
            if(input_lon[i]>='0'&&input_lon[i]<='9')
            {
                count1++;
            }
        }
        
        for (var i = 0; i < input_lat.length; i++)
        {
            if(input_lat[i]>='0'&&input_lat[i]<='9')
            {
                count2++;
            }
        }
        console.log(count1);
        console.log(count2);
        if((count1==input_lon.length)&&(count2==input_lat.length))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
   //ok
}
$("#make_script").click(function(event) {
    /* Act on the event */
    $("#script_text").empty();
    var script_text = ""
    var script_line = ""
    
    console.log($("#input_lon").val());
    console.log($("#input_lat").val());

    var input_lon = $("#input_lon").val();
    var input_lat = $("#input_lat").val();

    //检查输入
    if (input_text_check()==true)
     {  console.log(input_text_check());
    
        input_lon = split_gps_string($("#input_lon").val());
        input_lat = split_gps_string($("#input_lat").val());
        console.log(input_lon);
        console.log(input_lat);
    
        //1 按经度
        script_line  = "TAP "+gps_page_map["lon"].x+" "+gps_page_map["lon"].y+" "+delay_time+" #按压经度"+"\n";
        script_text = script_text + script_line
    
        //2 按经度的数字
    
        script_text = script_text + make_number_string_to_srcipt(input_lon);
    
        //3 按纬度
        script_line  = "TAP "+gps_page_map["lat"].x+" "+gps_page_map["lat"].y+" "+delay_time+" #按压维度"+"\n";
        script_text = script_text + script_line
    
    
        //4 按纬度的数字
        script_text = script_text + make_number_string_to_srcipt(input_lat);
    
        //5 按OK
        script_line  = "TAP "+gps_page_map["ok"].x+" "+gps_page_map["ok"].y+" "+delay_time+" #按压OK"+"\n";
        script_text = script_text + script_line

        //6 添加到 文本框
        $("#script_text").append(script_text);

    }
    else //检查失败  需要重新输入
    {
        $("#script_text").append("输入的内容有误，请重新输入！");
    }
});

//[1/256]向[经纬度]、[度]的转换
$("#make_trans1").click(function(event) {
    /* Act on the event */
    $("#input_lon_2").empty();
    $("#input_lat_2").empty();
    var input_lon_1 = $("#input_lon_1").val();
    var input_lat_1 = $("#input_lat_1").val();
    var fLonFrom = parseFloat(input_lon_1);
    var fLatTo =parseFloat(input_lat_1);
    var fLonTo = fLonFrom/(60*60*256);
    fLatTo = fLatTo/(60*60*256);
    $("#input_lon_2").val(fLonTo);
    // $("#script_text_1").append("\n");
    $("#input_lat_2").val(fLatTo);

    $("#input_lon_3").empty();
    $("#input_lat_3").empty();

    var input_lon_1 = $("#input_lon_2").val();
    var input_lat_1 = $("#input_lat_2").val();
    
    var finput_lon_1 = parseFloat(input_lon_1);
    var finput_lat_1 = parseFloat(input_lat_1);
    
    var finput_lon_1Temp = finput_lon_1;
    var  input_lat_1Temp = input_lat_1;

    var fLonDeg = parseInt(finput_lon_1);
    finput_lon_1 = finput_lon_1 - fLonDeg;
    finput_lon_1 = finput_lon_1*60;
    var fLonMinu = parseInt(finput_lon_1);
    finput_lon_1 = finput_lon_1 - fLonMinu;
    finput_lon_1 = finput_lon_1*60;
    var fLonSec = parseInt(finput_lon_1);

    var fLatDeg = parseInt(input_lat_1);
    input_lat_1 = input_lat_1 - fLatDeg;
    input_lat_1 = input_lat_1*60;
    var fLatMinu = parseInt(input_lat_1);
    input_lat_1 = input_lat_1 - fLatMinu;
    input_lat_1 = input_lat_1*60;
    var fLatSec = parseInt(input_lat_1);

    var input_lon_2=fLonDeg+"°"+fLonMinu+"′"+fLonSec+"″";
    var input_lat_2=fLatDeg+"°"+fLatMinu+"′"+fLatSec+"″";

    // $("#input_lon_2").append(input_lon_2);
    // $("#input_lat_2").append(input_lat_2);
    $("#input_lon_3").val(input_lon_2);
    $("#input_lat_3").val(input_lat_2);

    });

$("#make_trans3").click(function(event) {
    /* Act on the event */
    $("#input_lon_5").empty();
    $("#input_lat_5").empty();
    var input_lon_1 = $("#input_lon_4").val();
    var input_lat_1 = $("#input_lat_4").val();
    var fLonFrom = input_lon_1;
    var fLatTo =input_lat_1;
    var fLonTo = fLonFrom*(60*60*256);
    fLatTo = fLatTo*(60*60*256);
    $("#input_lon_5").val(fLonTo);
    // $("#script_text_1").append("\n");
    $("#input_lat_5").val(fLatTo);
    /* Act on the event */
    $("#input_lon_6").empty();
    $("#input_lat_6").empty();

    var input_lon_1 = $("#input_lon_4").val();
    var input_lat_1 = $("#input_lat_4").val();
    
    var finput_lon_1 = parseFloat(input_lon_1);
    var finput_lat_1 = parseFloat(input_lat_1);
    
    var finput_lon_1Temp = finput_lon_1;
    var  input_lat_1Temp = input_lat_1;

    var fLonDeg = parseInt(finput_lon_1);
    finput_lon_1 = finput_lon_1 - fLonDeg;
    finput_lon_1 = finput_lon_1*60;
    var fLonMinu = parseInt(finput_lon_1);
    finput_lon_1 = finput_lon_1 - fLonMinu;
    finput_lon_1 = finput_lon_1*60;
    var fLonSec = parseInt(finput_lon_1);

    var fLatDeg = parseInt(input_lat_1);
    input_lat_1 = input_lat_1 - fLatDeg;
    input_lat_1 = input_lat_1*60;
    var fLatMinu = parseInt(input_lat_1);
    input_lat_1 = input_lat_1 - fLatMinu;
    input_lat_1 = input_lat_1*60;
    var fLatSec = parseInt(input_lat_1);

    var input_lon_2=fLonDeg+"°"+fLonMinu+"′"+fLonSec+"″";
    var input_lat_2=fLatDeg+"°"+fLatMinu+"′"+fLatSec+"″";

    // $("#input_lon_2").append(input_lon_2);
    // $("#input_lat_2").append(input_lat_2);
    $("#input_lon_6").val(input_lon_2);
    $("#input_lat_6").val(input_lat_2);
});
$("#make_trans5").click(function(event) {
    /* Act on the event */
    $("#input_lon_8").empty();
    $("#input_lat_8").empty();

    var input_lon_1 = $("#input_lon_7").val();
    console.log(input_lon_1);
    var input_lat_1 = $("#input_lat_7").val();
    var input_lon_1= input_lon_1.split(".");
    
    console.log(input_lon_1);
    input_lon_1[0]=parseInt(input_lon_1[0]);
    console.log(input_lon_1[0]);
    input_lon_1[1]=parseInt(input_lon_1[1]);
    input_lon_1[2]=parseInt(input_lon_1[2]);
    var fLonTo=input_lon_1[0]+(input_lon_1[2]/60+input_lon_1[1])/60;

    console.log(fLonTo);

    input_lat_1= input_lat_1.split(".");
    console.log(input_lat_1);
    input_lat_1[0]=parseInt(input_lat_1[0]);
    console.log(input_lon_1[0]);
    input_lat_1[1]=parseInt(input_lat_1[1]);
    input_lat_1[2]=parseInt(input_lat_1[2]);
    var fLatTo=input_lat_1[0]+(input_lat_1[2]/60+input_lat_1[1])/60;
    console.log(fLatTo);
    $("#input_lon_8").val(fLonTo);
    $("#input_lat_8").val(fLatTo);
    /* Act on the event */
    $("#input_lon_9").empty();
    $("#input_lat_9").empty();
    var input_lon_1 = $("#input_lon_8").val();
    var input_lat_1 = $("#input_lat_8").val();
    var fLonFrom = input_lon_1;
    var fLatTo =input_lat_1;
    var fLonTo = fLonFrom*(60*60*256);
    fLatTo = fLatTo*(60*60*256);
    $("#input_lon_9").val(fLonTo);
    // $("#script_text_1").append("\n");
    $("#input_lat_9").val(fLatTo);
    });

</script>
</body>
</html>
#<script type="text/javascript">
#<div>
#<a href="http://www.gpsspg.com/maps.htm" target="_blank">经纬度查询网站</a>
#<a href="http://www.google.cn/maps/@35.6798863,139.7680405,14.75z" target="_blank">谷歌经纬度查询</a></div>
