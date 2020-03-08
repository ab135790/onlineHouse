<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta name="applicable-device" content="mobile">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="Expires" content="-1">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta name="application-name" content="">
	<title>${HouseName}</title>
	<link rel="icon" href="data:image/ico;base64,aWNv">
	<link rel="stylesheet" href="${project}/ds/css/public.css?t="+Math.random()></link>
	<link rel="stylesheet" href="${project}/ds/css/index.css?t="+Math.random()></link>
	<link href="${project}/ds/css/swiper.min.css" type="text/css" rel="stylesheet"></link>
	<script type="text/javascript" src="${project}/ds/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${project}/ds/js/ws.js?t="+Math.random()></script>
	<script type="text/javascript" src="${assets}/plugins/layer/layer.js"></script>
	<script type="text/javascript" src="${project}/ds/js/Form64.js"></script>
	<style>
	 .DjsWelcome {
		background-color: rgba(0, 0, 0, 0);
		box-shadow: 0px 0px 0px rgba(0, 0, 0, .3);
	} 
	</style>
	<script type="text/javascript">
	function userGetOut(msg){
		 window.location.href="/logout";	 
	}
	var houseState = "4";//全局项目状态
	var timeState ="2";//全局时间状态  0 活动已结束 1 在选购时间内,2时间未到时的浏览模式。

	var openDjsWelcome;
	function DjsWelcome() {
		var content = '<div class=\"yh-wrap\"><img src=\"${project}/ds/images/lhbg.png\" style=\"width:100%;\"><div class=\"yh-nam\">10</div></div>';
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

	function houseStateControl(state){ 
		if(state==="0"){
		 window.location.href="/finish";		
		}else{
			houseState = state;//5 表示小结束，进行浏览模式
		}
	}
	
	var startTimeIni="${StartTime}".replace(/\-/g, "/");//项目开启时间
	var ShoppingTimeIni = ${ShoppingTime} * 60;//单位分钟 转为秒
	var openDjs=true;
	function countTime(nowSerTime) {  
		if(typeof(nowSerTime) == 'undefined'){
			console.log(nowSerTime);
			return;
		}
		var endDate = new Date(startTimeIni); 
    	var end = endDate.getTime();  
		var ShoppingTime =ShoppingTimeIni;
		/*  if(timeState==="0"){
			 console.log("活动已结束");
    		 if(timeCtr!=null){
    			 window.clearTimeout(timeCtr);
    		 }
    		 return;
    	 } */
        //获取当前时间  
       // var date = new Date();  
        var date = new Date(nowSerTime);  
        var now = date.getTime();  
        //设置截止时间  
       // var str="${StartTime}".replace(/\-/g, "/");
       // var endDate = new Date(str); 
       // var end = endDate.getTime();  
        
        //时间差  
        var leftTime = end-now; //豪秒
        //定义变量 d,h,m,s保存倒计时的时间  
        var h,m,s;  
        if (leftTime>=0) { 
        	
            h = Math.floor(leftTime/1000/60/60);  
            m = Math.floor(leftTime/1000/60%60);  
            s = Math.floor(leftTime/1000%60); 
            $("#ggts").html("秒后活动开始!");
            timeState="2";
            if(leftTime<=10000 && openDjs==true){
            	DjsWelcome();
            	openDjs=false;
            }
            if(leftTime<=10000){
            	$('.yh-nam').html(s);
            }
            if(leftTime==0){
            	layer.close(openDjsWelcome);
            }
        }else{
        	leftTime = end + ShoppingTime*1000 - now;
        	if(leftTime >0){
        		 d = Math.floor(leftTime/1000/60/60/24);  
                 h = Math.floor(leftTime/1000/60/60%24);  
                 m = Math.floor(leftTime/1000/60%60);  
                 s = Math.floor(leftTime/1000%60); 
                 $("#ggts").html("秒后活动结束!");
                 timeState="1";//在允许抢购时间范围内，进入抢购模式
                 
               //控制详情页选购按钮
               if($(".djs").attr("rstate")==1 || $(".djs").attr("mstate")==2){
            	   onSure=false;
           		   $(".djs").attr("style","background-color:#C0C0C0");
                   $(".djs").html("预定中"); 
               }else if($(".djs").attr("rstate")==2|| $(".djs").attr("mstate")==3){
            	   onSure=false;
           		   $(".djs").attr("style","background-color:#C0C0C0");
                   $(".djs").html("已售出"); 
               }else{
         		 onSure=true;
         		 $(".djs").removeAttr("style","background-color:#C0C0C0");
                 $(".djs").html("立即选购");             	   
               }
        	}else if(leftTime==0){
        		$("#ggts").html("本轮活动已结束!");
        		timeState="0";//进入查看模式,不允许抢购
        		//通知服务器，活动已结束，改变状态6
        		//updateHouseState();让服务端来控制
        		h=0;m=0;s=0;
        		//控制详情页选购按钮
        		onSure=false;
        		$(".djs").attr("style","background-color:#C0C0C0");
                $(".djs").html("活动已结束");   
        	}else{
        		//时间为负进行相关操作
        		timeState="0";
        		$("#ggts").html("本轮活动已结束!");
        		h=0;m=0;s=0;
        		//console.log("活动结束很久了!");
        		//控制详情页选购按钮
        		onSure=false;
        		$(".djs").attr("style","background-color:#C0C0C0");
                $(".djs").html("活动已结束");  
        	}
        }
        //将倒计时赋值到div中  
        $(".RemainH").html(h);
        $(".RemainM").html(m);
        $(".RemainS").html(s);
       
	}
	
	</script>
	<script type="text/javascript">
		 $(function(){
			countTime();//倒计时			
		});			
	</script>

</head>
<body>
	<div class="center">
		<div class="b-index-w">
			<div class="dfix" style="padding-top:48px;">
				<nav class="menunav">
					<div class="menunav-w">
						<div class="nav-list" id="lookFangYuan">
						  <a href="/fangyuan?ldIndex=0&dyIndex=0" ><p class="f-n1"></p><span class="f-n-name">房源列表</span></a>
						</div>
						<div class="nav-list  navon" id="lookDingDan">
						  <a href="/dingdan"  ><p class="f-n2"></p><span class="f-n-name">我的订单</span></a>
						</div>
						<div class="nav-list" id="lookShouCang">
						  <a href="/shoucang" ><p class="f-n3"></p><span class="f-n-name">我的收藏</span></a>
						</div>
					</div>
				</nav>
				<div class="sub-dd clearfix">
					<div class="sub-d-left">公告</div>
					<div class="sub-d-center">${IsTest}</div>
				</div>				
					<div class="sub-d-right">
						<div class="subtimer" id="subtimer">
							  <span class="RemainH Remain">0</span><span class="liksapn">时</span>
						 	  <span class="RemainM Remain">0</span><span class="liksapn">分</span>
						 	  <span class="RemainS Remain">0</span><span class="liksapn" id="ggts">秒后活动结束</span>
						</div>
					</div>
			</div>
			<div id="commonBody">
				<c:choose>
	<c:when test="${fymodel!=null}">
		<div class="b-dd-w">
			<div class="dd-w-title">
				<div class="dd-w-left">
					<span>下单时间:</span><span>${fymodel.getD_SaleDate()}</span>
				</div>
			</div>
			<a href="javascript:void(0);" onclick="readMx()" class="dd-a-w">
				<div class="dd-w-cont">
					<div class="dd-w-w">
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">房&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</div>
							<div class="d-w-list-left">${fymodel.getD_BanName()}${fymodel.getD_Unit()}${fymodel.getD_RoomNo()}</div>
						</div>
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">证件号码：</div>
							<div class="d-w-list-left">${user.userCode}</div>
						</div>
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">可选套数：</div>
							<div class="d-w-list-left">5</div>
						</div>
					</div>
					<div class="dd-w-w">
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">职业顾问：</div>
							<div class="d-w-list-left">张三</div>
						</div>
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">顾问电话：</div>
							<div class="d-w-list-left">13208851298</div>
						</div>
					</div>
					<div class="dd-w-w" style="padding: .8rem 0;">
						<div class="dd-w-list clearfix" onclick="readMx()">
							<div class="d-w-list-left">订&nbsp;&nbsp;单&nbsp;&nbsp;号：</div>
							<div class="d-w-list-left"
								style="font-size: 1.6rem; font-weight: bold;">${fymodel.getD_SerialNumber()}</div>
						</div>
					</div>
				</div>
				<div class="yxg">
					<img src="${project}/ds/images/yrg.png" />
				</div>
			</a>
		</div>
	</c:when>
	<c:otherwise>
		<div class="b-dd-w">
			<p style="width: 60px; height: 60px; margin: 0px auto; text-align: center;">
				<img src="${project}/ds/images/tsxx.png" style="width: 100%">
			</p>
			<p style="text-align: center; color: #888888; padding-top: 15px;">您还没有订单</p>
		</div>
	</c:otherwise>
</c:choose>
<div class="dc-btnn dc-btn-widtht">
	<a href="/logout">退出</a>
</div>

	    </div>
	</div>
	</div>
</body>
</html>