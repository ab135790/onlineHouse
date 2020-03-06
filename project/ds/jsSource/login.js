
//登录页
function showZsOrCs(){
	if(IsTest==="0"){
		$("#zsOrcs").html("正式");
		$("#zsOrcs").css("background-color","#f43530");//红色
	}else{
		$("#zsOrcs").html("公测");
		$("#zsOrcs").css("background-color","#2196f3");//蓝色
	}
}
/*2020/3/5
* 作者：王青高
* 功能：{Function} 弹出pdf协议文本
* 参数：{}
*/
function alertFile(val) {
	if($('#mask').hasClass('active')) {
		return
	} else {
		$('#mask').addClass('active');
		$('.closeBtn').addClass('active');
		$('#alertfile').media({
			width: '100%',
			height: '100%',
			autoplay: true,
			src:'http://storage.xuetangx.com/public_assets/xuetangx/PDF/PlayerAPI_v1.0.6.pdf',
		});
	}
}
/*2020/3/5
* 作者：王青高
* 功能：{关闭pdf弹窗}
* 参数：{}
*/
function closeBtn() {
	if($('.closeBtn').hasClass('active')) {
		$('.closeBtn').removeClass('active');
		$('#mask').removeClass('active');
	}
}

function showYzmOrSfz(){
	 if(yzType==='0'){
		   if(LoginTest==='1'){
	  		 createZhangHao();//生成帐号
		   }
		   $("#code").attr("style","display:none");
	  }else{
		  $("#card").attr("style","display:none");				   
	  }
}

    function checkTel(tel){
			if (tel.length === 0){
				layer.msg("手机号不能为空");
				return false;
			}	
			 if("0"===LoginTest){
				  var myreg=/^[1][3,4,5,6,7,8,9][0-9]{9}$/;
		         if (!myreg.test(tel)) {
		        	 layer.msg("请输入有效的手机号");
		             return false;
		         } else {
		             return true;
		         } 			 
			 }
         return true;
	}
    
    function randomn(n) {
    	  if (n > 21) return null
    	  return parseInt((Math.random() + 1) * Math.pow(10,n-1))
    } 
    
    function createZhangHao(){
    	$("#D_Tel").val(randomn(11));
    	$("#D_Card").val(randomn(18));
    }
    
    function send_code(){
    	 if(!allowLoad || houseState==='5'){
			  layer.msg("活动已结束!");
			  return;
		  }
    	 if(LoginTest==='1'){//免登录模式
    		 layer.msg("输入任意四位验证码");
    		 return;
    	 }
    	//手机号
    	if($("#D_Tel").val()===""){
    		layer.msg("手机号不能为空");
    		return
    	}
    	//验证手机号码
    	var checkTel=true;
    	  $.ajax({
              url: "/checkTel.do",
              type: "post",
              async: false,
              data: { tel: $("#D_Tel").val() },
              dataType: "json",
              success: function(data) {
            	  if(data.result==="true"){
  			    	 //layer.msg("发送成功");
  			     }else{
  			    	 layer.msg(data.msg);
  			    	checkTel=false;
  			     }
              }
          });
    	if(!checkTel){
    		return;
    	}
    	//发送间隔
    	/*var sendCodeTime  = localStorage.getItem("sendCodeTime");
    	var sendCodeCount = localStorage.getItem("sendCodeCount");
    	if(sendCodeTime!=null){
    		 var sendCodeDateTime = (new Date(sendCodeTime)).getTime(); 
    	     var nowTime = (new Date()).getTime();
    	     if(nowTime-sendCodeDateTime<60000){
    	    	 layer.msg("发短信过于频繁!");
    	    	 return
    	     }
    	}*/
    	//发送次数
    	/*if(sendCodeCount!=null){
    		if(sendCodeCount>5){
    			 layer.msg("短信超过使用次数");
    	    	 return
    		}
    		localStorage.setItem("sendCodeCount",Number(sendCodeCount)+1);
    	}else{
    		localStorage.setItem("sendCodeCount",1);
    	}*/
    	//发送时间
    	//localStorage.setItem("sendCodeTime",dateFtt("yyyy-MM-dd hh:mm:ss",new Date()));
    	//倒计时
    	startScDjs();
    	$.post("/sendCode.do", { "tel": $("#D_Tel").val() },
    			   function(data){
    			     if(data.result==="true"){
    			    	 layer.msg(data.msg);
    			     }else{
    			    	 layer.msg("发送失败!");	    	 
    			     }
    			   }, "json");
      }
    //短信倒计时			
	var scTimer;
    var scMaxTime = 1 * 60; //一个分钟，按秒计算，自己调整!   
    function scCountDown() {
        if (scMaxTime >= 0) {                   	
           //var minutes = Math.floor(scMaxTime / 60);
           //var seconds = Math.floor(scMaxTime % 60);
           //var msg = minutes + "分" + seconds + "秒";
        	var msg='('+scMaxTime+'s)';
            $("#yzmDjs").html(msg);                       
            --scMaxTime;
        } else {
        	 $("#yzmDjs").html("发送");  
        	overScDjc();
        }
    }
    function startScDjs(){
    	$("#yzmDjs").attr("disabled",true);//禁止点击
    	$("#yzmDjs").addClass("yzmDjs");
    	scTimer = setInterval("scCountDown()", 1000);                  
    }  
    function overScDjc(){
    	$("#yzmDjs").attr("disabled",false);//允许点击
    	$("#yzmDjs").removeClass("yzmDjs");//变灰色
    	 clearInterval(scTimer); 
    	 scMaxTime = 1 * 60;//关闭之后，时间重置
    }
    //
   function onSubmit(){
	   console.log("yzType="+yzType);
		  if(!allowLoad || houseState==='5'){
			  layer.msg("活动已结束!");
			  return;
		  }
		  if(!checkTel($("#D_Tel").val())){				  
			  return;
		  }	
			if(yzType==='1'){
					  if($("#D_Code").val()=="" || $("#D_Code").val().length!=4){
						  layer.msg("验证码请输入有效的4位数!");
						  return;
					  }	
			}else{
				 if($("#D_Card").val()==""){
					  layer.msg("身份证号不能为空");
					  return;
				  }				
			}
			
		  $.post("/loginJson.do", { "D_Tel": $("#D_Tel").val(),"D_Code":$("#D_Code").val(),"D_Card":$("#D_Card").val()},
  			   function(data){
  			     if(data.result==="true"){
  			    	localStorage.setItem("whoareyou",$("#D_Tel").val()+"="+$("#D_Code").val()+"="+(new Date()).getTime());
  			    	 //window.location.href="/";
  			    	 window.location.replace("/dsCar/index.html#index");
  			     }else{
  			    	 /*if(yzType==='0'){
			    		 layer.msg("手机号或者身份证号不正确!"); 
			    	 }else{
			    		 layer.msg("验证码不正确!");
			    	 }   */ 
  			    	 layer.msg(data.msg);
  			     }
  			   }, "json");			 
	 	 }	
   
 //登录页倒计时
   /**************************************时间格式化处理************************************/
   function dateFtt(fmt,date)   
   { //author: meizz   
     var o = {   
       "M+" : date.getMonth()+1,                 //月份   
       "d+" : date.getDate(),                    //日   
       "h+" : date.getHours(),                   //小时   
       "m+" : date.getMinutes(),                 //分   
       "s+" : date.getSeconds(),                 //秒   
       "q+" : Math.floor((date.getMonth()+3)/3), //季度   
       "S"  : date.getMilliseconds()             //毫秒   
     };   
     if(/(y+)/.test(fmt))   
       fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length));   
     for(var k in o)   
       if(new RegExp("("+ k +")").test(fmt))   
     fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
     return fmt;   
   }