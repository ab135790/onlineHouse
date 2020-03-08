$.ajaxSetup({
	 error : function(xhr,textStatus,errorThrown){
	       　　if (xhr.status == 401) {
	       　　　　 console.log("回登录页");
	       　　　　  window.location.replace("/dsCar/index.html");
	         　   }else if(xhr.status == 402){
	         　   	console.log("回到结束页")
	         　   	  $.ajax({
	  				    url:"/finish.do",
					    type:"GET",
					    dataType:"html",
					    success:function(result){
					    	$("#content").html(result); 
					    }
					});		
	         　   } 
	 }
});



//全局变量
var LoginTest='';//'${LoginTest}';//登录测试
var IsTest='';//'${IsTest}';//0正式 1 测试
var yzType='';//'${yzType}'; //验证类型  
var ShoppingTime = '';//${ShoppingTime} * 60;//单位分钟 转为秒 
var StartTime='';//"${StartTime}".replace(/\-/g, "/");
var CountDownTime='';//单元分钟，要转成秒。倒计时时间。
var ExpiredCycle='';//犹豫期
var nowTimeIni='';//"${nowDate}".replace(/\-/g, "/");
var nowDate ='';//new Date(nowTimeIni); 
var now ='';// nowDate.getTime();
var staticVersion=1;
var IsShowYHGS ='';//'${IsShowYHGS}';//是否显示优惠公示 1显示
var userYhgs='';//'${yhgsOnlyOne}';//显示次数
var imageServer='http://47.99.99.232:80';
var alreadyBuyCount = '';//${alreadyBuyCount};//已购买数量	
var IsShowDY='0';//是否显示单元
var IsAllowChongFuBuy='0';//是否允许重复购买
var maxtimeIni = '';//${CountDownTime} * 60; //分钟，按秒计算，自己调整! 
var CollectionCount ='';//${CollectionCount};//收藏上限
var szIds=[];//已经收藏的房源id
var IsShowPrice='0';
var userShowPrice='0';
var userType='0';//用户类别
var IsShowReadStartDate='';
var ReadStartDate='';
var IsShowReadEndDate='';
var ReadEndDate='';
var IsShowReadTestStartDate='';
var ReadTestStartDate='';
var IsShowReadTestEndDate='';
var ReadTestEndDate='';
var imageFolder='fy';
var IsShowDjsTime='0';
var caseStartTime='';

var timeState ="2";//全局时间状态  0 活动已结束 1 在选购时间内,2时间未到时的浏览模式。
var houseState = "4";//全局项目状态 4表示项目启动
var HouseName="";//项目名称
var HouseTel="";//联系电话
var onSure=false;//抢购按钮默认不能点击
var allowLoad= true;//默认允许登录
var ip='';
var user='';
$(function (){
	getConfig();
	getWsIp();
})
var getConfigFlag=true;
 function getConfig(){
    	$.post("/common/getConfigMap.do",
    			function(data){
    		console.log('全局变量', data);
    				sysIni(data);	
    			}, "json");   	
  }
function sysIni(data){
	HouseName=data.HouseName;
	HouseTel = data.HouseTel;
	yzType=data.IsShowYZMorSFZ;
	LoginTest=data.LoginTest;
	imageServer=data.imageServer;
	IsTest =data.IsTest;
	ip=data.websocketIp;
	CollectionCount=data.CollectionCount;
	IsShowYHGS=data.IsShowYHGS;
	staticVersion=data.staticVersion;
	houseState=data.State;	
	StartTime=data.StartTime;
	ShoppingTime=data.ShoppingTime * 60;
	CountDownTime=data.CountDownTime * 60;
	ExpiredCycle=data.ExpiredCycle;
	IsShowDY=data.IsShowDY;
	IsAllowChongFuBuy=data.IsAllowChongFuBuy;
	IsShowPrice=data.IsShowPrice;
	
	IsShowReadStartDate=data.IsShowReadStartDate;
	ReadStartDate=data.ReadStartDate;
	IsShowReadEndDate=data.IsShowReadEndDate;
	ReadEndDate=data.ReadEndDate;
	IsShowReadTestStartDate=data.IsShowReadTestStartDate;
	ReadTestStartDate=data.ReadTestStartDate;
	IsShowReadTestEndDate=data.IsShowReadTestEndDate;
	ReadTestEndDate=data.ReadTestEndDate;
	IsShowDjsTime=data.IsShowDjsTime;
	
	nowTimeIni=data.nowDate;
	nowDate =new Date(nowTimeIni.replace(/\-/g, "/")); 
	now = nowDate.getTime();
	
	imageFolder=data.imageFolder;
	
	countTime();//时间总控
	webIni();    			
}
function loginIni(){
	  showZsOrCs();
      showYzmOrSfz();
      $("#dltPic").attr("src",imageServer+"/UpLoad/"+imageFolder+"/loginimg.jpg?v="+staticVersion);
}
function webIni(){
	$(document).attr('title',HouseName);
	imageSet();
}
var loginCountTime=true;
var openDjs=true;
function countTime() { 
	 var d,h,m,s;
	 if(houseState=="0" || houseState=="5"){//0全部结束，5小结束
		$("#ggts").html("活动已结束!");	
 		d = 0;  
 		h = 0; 
 		m = 0;
 		s = 0;
	 }else{
		 var endDate = new Date(StartTime.replace(/\-/g, "/")); 
	     var end = endDate.getTime();//项目开始时间  
		// now = now + 1000;
		 now = (new Date(localStorage.getItem("ServerTime"))).getTime();
		 var leftTime = end-now; //得到毫秒差
		//定义变量 d,h,m,s保存倒计时的时间  
		 //var d,h,m,s;  
		 if (leftTime>=0) { //开始前
			d = Math.floor(leftTime/1000/60/60/24);  
			h = Math.floor(leftTime/1000/60/60%24);  
			m = Math.floor(leftTime/1000/60%60);  
			s = Math.floor(leftTime/1000%60); 
			s1 = Math.floor(leftTime/1000);//转成秒
			//登录
			$("#ggts").html("活动倒计时!");
		    allowLoad = true;//允许登录
			//房源
			timeState="2";
			$("#ggts2").html("秒后活动开始!");
			//抢购窗口
			if(leftTime<=10000 && openDjs==true){
					//DjsWelcome();
					openDjs=false;
			}
			if(leftTime<=10000){
					$('.yh-nam').html(s);
			}
			//if(leftTime==0){
			//		 layer.close(openDjsWelcome);
			//}
			//抢购按钮
			if(s1>CountDownTime){//与允许显示倒计时的时间进行对比
		         onSure=false;
	             $(".djs").html("还有"+h+"时"+m+"分"+s+"秒开始").css('background-color','#888888'); 
	         }else if(s1<=CountDownTime && s1>0){//在区间内开始倒计时
			    onSure=false;
	            var  minutes = Math.floor(s1 / 60);
	            var seconds = Math.floor(s1 % 60);
			    if(s1>10){
                  $(".djs").html("<span style='color:#fa4e2a;'>"+minutes+"分"+seconds+"秒</span>后开始").css('background-color','#888888');  				  
				}else{
                  $(".djs").html("<span style='color:#fa4e2a;'>"+seconds+"</span>").css('background-color','#888888').css('font-size','3.0rem');  				  
				}                               
	         }else{
		                   	  $(".djs").removeAttr("style","background-color:#888888");
		                   	  //$(".djs").removeClass("forbidBug");
		                   	  onSure=true;//倒计时结束，允许抢购                   	  
		                   	  $(".djs").html("立即选择").css('font-size','1.6rem');
		                   	  //window.clearTimeout(djsTo);
	         }                     	 
		 }else{//
			leftTime = end + ShoppingTime*1000 - now;
			
			if(leftTime >0){//活动进行中
				  d = Math.floor(leftTime/1000/60/60/24);  
		          h = Math.floor(leftTime/1000/60/60%24);  
		          m = Math.floor(leftTime/1000/60%60);  
		          s = Math.floor(leftTime/1000%60); 
				  //登录
		          $("#ggts").html("活动倒计时!");
				  allowLoad = true;//允许登录
				  //房源
				  $("#ggts2").html("秒后活动结束!");
				  timeState="1";//在允许抢购时间范围内，进入抢购模式
				  //详情
				  $("#ggts3").html("秒后活动结束!");
				  //控制详情页选购按钮
					if($(".djs").attr("rstate")==1 || $(".djs").attr("mstate")==2){
					        onSure=false;
					        $(".djs").attr("style","background-color:#888888");
					        $(".djs").html("正被他人认购中").css('font-size','1.6rem'); 
					}else if($(".djs").attr("rstate")==2|| $(".djs").attr("mstate")==3|| $(".djs").attr("mstate")==4){
					        onSure=false;
					        $(".djs").attr("style","background-color:#888888");
					        $(".djs").html("已售出").css('font-size','1.6rem'); 
					}else{
					    	onSure=true;
					    	$(".djs").removeAttr("style","background-color:#888888");
					    	$(".djs").html("立即选购").css('font-size','1.6rem');          	   
					}
		          
			}else if(leftTime==0){
					        		$("#ggts").html("本轮活动已结束!");
					        		timeState="0";//进入查看模式,不允许抢购
					        		//通知服务器，活动已结束，改变状态6
					        		//updateHouseState();让服务端来控制
					        		h=0;m=0;s=0;
					        		//控制详情页选购按钮
					        		onSure=false;
					        		$(".djs").attr("style","background-color:#888888");
					                $(".djs").html("活动已结束").css('font-size','1.6rem'); 
			}else{
					        		//时间为负进行相关操作
					        		timeState="0";
					        		$("#ggts").html("本轮活动已结束!").css('font-size','1.6rem'); 
					        		h=0;m=0;s=0;
					        		allowLoad = false;//不允许登录
					        		//console.log("活动结束很久了!");
					        		//控制详情页选购按钮
					        		onSure=false;
					        		$(".djs").attr("style","background-color:#888888");
					                $(".djs").html("活动已结束").css('font-size','1.6rem'); 
			} 
		 }
	 }
	 //将倒计时赋值到div中 登录 
	 if(d<10){
		 d='0'+d;
	 }
	 if(h<10){
		 h='0'+h;
	 }
	 if(m<10){
		 m='0'+m;
	 }
	 if(s<10){
		 s='0'+s;
	 }
	
	 
	 //默认隐藏时间
	/* if($('#subtimer').is(':hidden')){
		 $('#subtimer').show();
	 }
	 if($('.IsTest').is(':hidden')){
		 $('.IsTest').show();
	 }*/
	$(".RemainD").html(d);
	$(".RemainH").html(h);
	$(".RemainM").html(m);
	$(".RemainS").html(s);
     
	 
	 
	//递归每秒调用countTime方法，显示动态时间效果  
	if(loginCountTime){
		 setTimeout(countTime,1000);   	 
	}
}


var openDjsWelcome;
function DjsWelcome() {
	var content = '<div class=\"yh-wrap\"><img src=\"/project/ds/images/lhbg.png\" style=\"width:100%;\"><div class=\"yh-nam\">10</div></div>';
	openDjsWelcome = layer.open({
		type :1,
		skin : 'DjsWelcome',             
		closeBtn :0,
		anim :2,
		shadeClose : false, 
		title : false,
		//time : 10000,
		content : content
	});
	$('.layui-layer').css('top', '');
	/* times = $('.yh-nam').html();
	time = times;	 */	
}

function updateShouCangState(id,state){ // 0未售 1预售中 2已售
	var d_monitor = $('#href_'+id).attr('d_monitor');
	if(state=='0'){
		$('#href_'+id).attr('onclick',"lookDetail("+id+",'"+state+"','"+d_monitor+"')");
		$('#ysc_'+id).css('display','none');
	}
	if(state=='1'){
		$('#href_'+id).attr('onclick',"lookDetail("+id+",'"+state+"','"+d_monitor+"')");
		$('#ysc_'+id+" img").attr('src','/project/ds/images/ysc-z.png');
		$('#ysc_'+id).css('display','block');
	}
	if(state=='2'){
		$('#href_'+id).attr('onclick',"lookDetail("+id+",'"+state+"','"+d_monitor+"')");
		$('#ysc_'+id+" img").attr('src','/project/ds/images/ysc.png');
		$('#ysc_'+id).css('display','block');
	}
}

var  RoomStateData;
//状态更新
function updateRoomState(objs){
	console.log(objs);
    objs.forEach((t, i) => {
	  $("#Room"+t.D_ID).removeClass("lda0");
	  $("#Room"+t.D_ID).removeClass("lda1");
	  $("#Room"+t.D_ID).removeClass("lda2");
     if(t.D_state ==="0" && (t.D_Monitor==="0" || t.D_Monitor==="1")){
    	 rstate=0;
    	 $("#Room"+t.D_ID).addClass("lda0");  
    	 updateShouCangState(t.D_ID,0);
     }else if(t.D_state==="1" && (t.D_Monitor==="0" || t.D_Monitor==="1")){
    	 rstate=1;
    	 $("#Room"+t.D_ID).addClass("lda1");
    	 updateShouCangState(t.D_ID,1);
     }else if(t.D_state==="2" && (t.D_Monitor==="0" || t.D_Monitor==="1")){
    	 rstate=2;
   	 	$("#Room"+t.D_ID).addClass("lda2");
   	 updateShouCangState(t.D_ID,2);
     }else if(t.D_Monitor==="2"){
    	 $("#Room"+t.D_ID).addClass("lda1");
    	 updateShouCangState(t.D_ID,1);
     }else{//t.D_Monitor==="3" 或 t.D_Monitor==="4"
    	 $("#Room"+t.D_ID).addClass("lda2");
    	 updateShouCangState(t.D_ID,2);
     }
     /*else if(t.D_Monitor==="3"){
    	 $("#Room"+t.D_ID).addClass("lda2");
     } */
     $("#Room"+t.D_ID).attr("rstate",t.D_state);
     $("#Room"+t.D_ID).attr("mstate",t.D_Monitor);
     $("#dsDjs"+t.D_ID).attr("rstate",t.D_state);
     $("#dsDjs"+t.D_ID).attr("mstate",t.D_Monitor);
    });  
} 
 function setIsTest(){
		if(IsTest==='0'){
			$('.IsTest').html("正式");
			$(".IsTest").css("background-color","#f43530");//红色
		}else{
			$('.IsTest').html("公测");
			$(".IsTest").css("background-color","#2196f3");//蓝色
		}
 }  

 function imageSet() {
	 //src="http://47.99.137.243:8080/UpLoad/fy/YHGS.jpg?v=1.0"
	 $("#yhgsImg").attr("src",imageServer+"/UpLoad/"+imageFolder+"/yhgs.jpg?v="+staticVersion);
 }
 
 function lookFangYuan() {
	 window.location.replace("/dsCar/index.html#fangyuan");
 }
 
 function lookDingDan(signData) {
	window.location.replace("/dsCar/index.html#dingdan");
 }
 
 function lookShouCang() {
	 window.location.replace("/dsCar/index.html#shoucang");
 }
 
function goBack() {
	  localStorage.removeItem("whoareyou");
	  localStorage.removeItem("openYhgs");
	 window.location.replace("/dsCar/index.html#logout");
 }