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
       
        //递归每秒调用countTime方法，显示动态时间效果  
      //var timeCtr =  setTimeout(countTime,1000); 
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
						<div class="nav-list" id="lookDingDan">
						  <a href="/dingdan" ><p class="f-n2"></p><span class="f-n-name">我的订单</span></a>
						</div>
						<div class="nav-list  navon" id="lookShouCang">
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
					<div class="ts-w">
					<img src="${project}/ds/images/tsdec.png"><span>您还可以收藏<strong id="syNum">${syNum}</strong>套房源</span>
				</div>
				<div class="b-sc-w" id="shoucangList">
				  <c:forEach var="fangyuan"   items="${list}"   varStatus="loop">
					<div class="sc-w-list">
						<div class="sc-title clearfix">
							<div class="sc-title-left">
								<span>${loop.index+1}</span>
							</div>
							<div class="sc-title-right clearfix">
								<c:if test="${loop.index!=0}" >
									<a href="javascript:void(0);" onclick="dtop(0,${fangyuan.getSort()})" class="dtop">向上</a>
								</c:if>
								<c:if test="${!loop.last}">
									<a href="javascript:void(0);" onclick="down(1,${fangyuan.getSort()})" class="down">向下</a>							
								</c:if>
							</div>
						</div>
						<div class="dd-w-cont">
							<div class="dd-w-w">
								<div class="dd-w-list clearfix">
									<div class="d-w-list-left">房号：</div>
									<div class="d-w-list-left">${fangyuan.getD_BanName()}${fangyuan.getD_Unit()}${fangyuan.getD_RoomNo()}</div>
								</div>
								<div class="dd-w-list clearfix">
									<div class="d-w-list-left">总价：</div>
									<div class="d-w-list-left">${fangyuan.getD_Total()}万</div>
								</div>
								<div class="dd-w-list clearfix">
									<div class="d-w-list-left">类型：</div>
									<div class="d-w-list-left">${fangyuan.getD_RoomType()}</div>
								</div>
							</div>
							<%-- <c:choose>
	                           <c:when test="${fangyuan.dState==1}">
	                              <a class="yysc" href="javascript:void(0);">订<br/>购中</a>
	                           </c:when>
	                           <c:when test="${fangyuan.dState==2}">
	                              <a class="yysc" href="javascript:void(0);">已经<br/>售出</a>
	                           </c:when>
	                           <c:otherwise>
									<a class="ljqg" href="javascript:void(0);" onclick="goBuy(${fangyuan.id})">立即<br/>认购</a>
	                           </c:otherwise>
							</c:choose> --%>
						</div>
						<div class="b-scdd"><a href="javascript:void(0);" onclick="del(${fangyuan.getD_ID()},${fangyuan.getSort()})" >删除收藏</a></div>
					</div>				
				  </c:forEach>
				</div>
	    </div>
	</div>
	</div>
	<div style="display:none" id="yhgs">
		<img style="width:100%" src="${imageServer}/UpLoad/fy/YHGS.jpg?t="+Math.random()>
	</div>
	<script type="text/javascript">
				
				function down(id,sort){
					console.log(id);
					console.log(sort);
					$("#shoucangList").load("/shoucang/doDown?id="+id+"&sort="+sort);
				}	
				function dtop(id,sort){			
					$("#shoucangList").load("/shoucang/doTop?id="+id+"&sort="+sort);
				}		
				function del(fangyuanId,shoucangId){
					console.log(fangyuanId);
					console.log(shoucangId);
					$("#shoucangList").load("/shoucang/doDel?fangyuanId="+fangyuanId+"&shoucangId="+shoucangId,function(){
						 var count =$("#syNum").html();
				    	 var addCount = Number(count)+1;
				    	 $("#syNum").html(addCount);
					});
				}		
				 function goBuy(id){
					 $.post("/fangyuan/getFangYuanState", { id: id },
			    			   function(data){
			    			      console.log(data.result);
			    			      if(data.result==="1"){
			    			    	  layer.msg("已经被预定");
			    			      }else if(data.result==="2"){
			    			    	  layer.msg("已经卖出");
			    			      }else{
			    			     	  //window.location.href="/fangyuan/xiangqing?id="+id;
			    			     	  var index = layer.load(1, {
			            					shade: [0.1,'#fff'] //0.1透明度的白色背景
			       						 });
			    			     	 $("#commonBody").load("/fangyuan/xiangqingData?id="+id,function(){
			    							layer.close(index);		    							
			    						});
			    			      }
			    			   },"json"); 
		        }
	</script>	
</body>
</html>