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
	<%-- <script type="text/javascript" src="${project}/ds/js/common.js"></script> --%>
	<script type="text/javascript" src="${project}/ds/js/Form64.js"></script>
	<style type="text/css">
		.swiper-slide {
			text-align: right;
			font-size: 18px;
			background:#fff;
    	}
		.swiper-slide img{width:100%}
		.sub-d-center{
			    float: left;
			    width: 80px;
			    height: 26px;
			    line-height: 26px;
			    background: #ef5232;
			    border-radius: 20px;
			    text-align: center;
			    color: #ffffff;
			    margin-left: 1rem;
			    margin-top: 8px;
		}
	</style>
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
	var IsShowYHGS ='${IsShowYHGS}';//是否显示优惠公示 1显示
	var userYhgs='${yhgsOnlyOne}';//显示次数
	function checkShowYHGS(){
		if (IsShowYHGS ==='1'){
			if(userYhgs==='0'){
				layer.open({
					  type: 1,
					  title: false,
					  closeBtn: 0,
					  area: '300px',
					  skin: 'layui-layer-nobg', //没有背景色
					  shadeClose: true,
					  content: $('#yhgs'),
					  success: function(layero, index){
						  changeShowYhgsState();
						  }
					});				
			}
		}
	}
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
	function changeShowYhgsState(){
		$.ajax({
            url: "/fangyuan/changeShowYhgsState",
            type: "post",
            async: true,
            dataType: "json",
            success: function(data) {
                console.log(data.result);
            }
        });
	}
	function houseStateControl(state){ 
		if(state==="0"){
		 window.location.href="/finish";		
		}else{
			houseState = state;//5 表示小结束，进行浏览模式
		}
	}
	
	var alreadyBuyCount = ${alreadyBuyCount};//已购买数量	
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
	/* function updateHouseState(){
		  $.ajax({
	            url: "/fangyuan/updateHouseState",
	            type: "post",
	            async: true,
	            dataType: "json",
	            success: function(data) {
	                console.log(data.result);
	            }
	        });
	} */
	function updateRoomState(objs){
		    objs.forEach((t, i) => {
			  $("#Room"+t.D_ID).removeClass("lda0");
			  $("#Room"+t.D_ID).removeClass("lda1");
			  $("#Room"+t.D_ID).removeClass("lda2");
             if(t.D_state ==="0" && (t.D_Monitor==="0" || t.D_Monitor==="1")){
            	 rstate=0;
            	 $("#Room"+t.D_ID).addClass("lda0");              
             }else if(t.D_state==="1" && (t.D_Monitor==="0" || t.D_Monitor==="1")){
            	 rstate=1;
            	 $("#Room"+t.D_ID).addClass("lda1");
             }else if(t.D_state==="2" && (t.D_Monitor==="0" || t.D_Monitor==="1")){
            	 rstate=2;
           	 	$("#Room"+t.D_ID).addClass("lda2");
             }else if(t.D_Monitor==="2"){
            	 $("#Room"+t.D_ID).addClass("lda1");
             }else if(t.D_Monitor==="3"){
            	 $("#Room"+t.D_ID).addClass("lda2");
             } 
             $("#Room"+t.D_ID).attr("rstate",t.D_state);
             $("#Room"+t.D_ID).attr("mstate",t.D_Monitor);
             $("#djs"+t.D_ID).attr("rstate",t.D_state);
             $("#djs"+t.D_ID).attr("mstate",t.D_Monitor);
        });  
	}  
	function reloadFangYuan(){
		if(typeof dsLoudong != 'undefined' && dsLoudong.length>0){
			getTaoXing(dsLoudong,dsDanyuan)			
		}else{
			loadFangYuan();
		}
	}
	function loadFangYuan(){//加载房源
		$("#lookFangYuan").addClass('navon').siblings().removeClass('navon');
				console.log("fangyuan");
				/* var index = layer.load(1, {
		            shade: [0.3,'#fff'], //0.1透明度的白色背景
					time: 5000 //5秒关闭
		        }); */
				/* $("#commonBody").load("/fangyuan/indexData",function(){
					layer.close(index);
				}); */
				var url = "/fangyuan/indexData";
			    $.ajax({
				    url:url,
				    type:"post",
				    dataType:"html",
				    data:{ldIndex:dsLoudongIndex,dyIndex:dsDanyuanIndex},
				    success:function(result){				    	
				    	$("#commonBody").html(result); 
				    	//layer.close(index);
				    }
				});
	}
	function loadDingDan(){//加载订单
				console.log("dingdan");
				$("#lookDingDan").addClass('navon').siblings().removeClass('navon');
				//$("#commonBody").load("/dingdan/indexData");
				/* var index = layer.load(1, {
		            shade: [0.3,'#fff'], //0.1透明度的白色背景
					time: 5000 //5秒关闭
		        }); */
				var url = "/dingdan/indexData";
			    $.ajax({
				    url:url,
				    type:"post",
				    dataType:"html",
				    success:function(result){				    	
				    	$("#commonBody").html(result); 
				    	//layer.close(index);
				    }
				});
	}
	function loadShouCang(){//加载收藏
				console.log("ShouCang");
				$("#lookShouCang").addClass('navon').siblings().removeClass('navon');
				//$("#commonBody").load("/shoucang/indexData");
				/* var index = layer.load(1, {
		            shade: [0.3,'#fff'], //0.1透明度的白色背景
					time: 5000 //5秒关闭
		        }); */
				var url = "/shoucang/indexData";
			    $.ajax({
				    url:url,
				    type:"post",
				    dataType:"html",
				    success:function(result){				    	
				    	$("#commonBody").html(result); 
				    	//layer.close(index);
				    }
				});
	}
	<!--开始-->
	var dsLoudongIndex=0;
	var dsDanyuanIndex=0;
	function getDanYuan(name){ //加载单元
				console.log(name);
				/* var index = layer.load(1, {
		            shade: [0.3,'#fff'], //0.1透明度的白色背景
					time: 5000 //5秒关闭
		        }); */
				/* $("#danyuan").load("/fangyuan/danyuanData?name="+name,function(){}); */
				var url = "/fangyuan/danyuanData";
			    $.ajax({
				    url:url,
				    type:"post",
				    dataType:"html",
				    data: { name: name},
				    success:function(result){
				    	$("#danyuan").html(result); 
				    	//layer.close(index);
				    }
				});
			}
			
	function getTaoXing(loudongName,danyuanName){//加载房源
				console.log(loudongName);
				console.log(danyuanName);
				/* var index = layer.load(1, {
		            shade: [0.3,'#fff'], //0.1透明度的白色背景
					time: 5000 //5秒关闭
		        }); */
				/* $("#taoxing").load("/fangyuan/taoxingData?loudongName="+loudongName+"&danyuanName="+danyuanName); */
				var url = "/fangyuan/taoxingData";
			    $.ajax({
				    url:url,
				    type:"post",
				    dataType:"html",
				    data: { loudongName: loudongName,danyuanName:danyuanName},
				    success:function(result){
				    	$("#taoxing").html(result); 
				    	//layer.close(index);
				    }
				});
	}
	<!--结束-->
		 <!--楼栋更多-->
			function ldgd(){//楼栋更多设置 
				return ;
				var ldgd=${ldgd};
				if(ldgd===0){

				}else{
					$("#loudong2").after('<div class="lmore"><a href="#" id="ldgd">更多</a></div>');
					//超过4个，第二排隐藏
					$(".pua").each(function(i){
						if(i>3){
	   						this.style = "display:none";
						}
	 				});
					//点击弹出
					$('#ldgd').live('click', function () {
						
							$(".pua").each(function(i){
								if(i>3){
									this.style = "display:block";
								}
							});
							
		    		});				
				}
			}
			
			
			//进入详情页
			 function getInXingQing(id){
				console.log(timeState);
				/*   var index = layer.load(1, {
  					shade: [0.3,'#fff'], //0.1透明度的白色背景
  					time:5000
				   }); */
				  
				  $.ajax({
					    url:"/fangyuan/xiangqingData",
					    type:"GET",
					    data:{id:id,timeState:timeState},
					    dataType:"html",
					    success:function(result){
					    	$("#commonBody").html(result); 
					    	//layer.close(index);
					    }
					});		     			    			     	   			    
			 }
	</script>
	<script type="text/javascript">
		 $(function(){
			countTime();//倒计时
			checkShowYHGS();//优惠公示设置	
			//ldgd();//楼栋更多设置
			$(".f-l-left .pua").click(function(){
				$(this).addClass('lon').siblings().removeClass('lon');
				var index = $(this).index();
			});
			$(".d-l-left .dua").click(function(){
				$(this).addClass('don').siblings().removeClass('don');
				var index = $(this).index();
				
			});
			
			$(".pua").live('click',function () { 
				console.log("11");
				$(this).addClass("lon").siblings().removeClass("lon");
				//getDanYuan($(this).html());
				dsLoudongIndex = $(this).attr("index");
				dsDanyuanIndex =0;
				console.log(dsLoudongIndex);
				$(".dyShow"+dsLoudongIndex).show().siblings().hide();
				//$(this).insertBefore(".pua:first");//移动当前对象
				/* $(".pua").each(function(i){
					if(i>3){
						this.style = "display:none";
					}
				}); */
			});
			

		    $('.dua').live('click', function () {
		    	$(this).addClass("don").siblings().removeClass("don");
		    	//getTaoXing($(".lon").html(),$(this).html())
		    	dsDanyuanIndex = $(this).attr("index");
		    	console.log(dsDanyuanIndex);
		    	$(".txShow"+dsDanyuanIndex).show().siblings().hide();
		    	//$(this).insertBefore(".dua:first");//移动当前对象
				/* $(".dua").each(function(i){
					if(i>3){
						this.style = "display:none";
					}
				}); */
	    	});

			
			//房源点击总控制
			$('.sh').live('click', function () {
		    	var id = $(this).attr("rid");
		    	console.log("id="+id);
		    	var rstate = $(this).attr("rstate");//房源状态
		    	var mstate = $(this).attr("mstate");//监控状态
		    	if("1"===timeState && houseState==="4"){//处于抢购模式才进行如下操作
			    	/*if("1"===rstate || "1"===mstate || "2"===mstate){
			    		 layer.msg("已经被预定");
			    		 if("1"===mstate){
			    			 changeMonitor(id);
			    		 }
			    		 return;
			    	}else*/ if("2"===rstate || "3"===mstate){
			    		 layer.msg("已经售出");
			    		 return;
			    	}
			    	
			    	if(alreadyBuyCount>0){
			    		 layer.msg("您已达订购上限");
			    		 return;
			    	}		    		
		    	}else if("0"===timeState){
		    		layer.msg("抢购活动结束!");
		    		return;
		    	}
		    	getInXingQing(id);//进入详情页
	    	});
			
			function changeMonitor(id){
				 $.ajax({
			            url: "/fangyuan/singleFanHong",
			            type: "post",
			            async: true,
			            data: { id: id },
			            dataType: "json",
			            success: function(data) {
			                console.log(data.msg);
			            }
			        });
			}
		});
			
	</script>

</head>
<body>
	<div class="center">
		<div class="b-index-w">
			<div class="dfix" style="padding-top:48px;">
				<nav class="menunav">
					<div class="menunav-w">
						<div class="nav-list navon" id="lookFangYuan">
						  <a href="javascript:void(0);" onclick="loadFangYuan()"><p class="f-n1"></p><span class="f-n-name">房源列表</span></a>
						</div>
						<div class="nav-list" id="lookDingDan">
						  <a href="javascript:void(0);"  onclick="loadDingDan()"><p class="f-n2"></p><span class="f-n-name">我的订单</span></a>
						</div>
						<div class="nav-list" id="lookShouCang">
						  <a href="javascript:void(0);" onclick="loadShouCang()"><p class="f-n3"></p><span class="f-n-name">我的收藏</span></a>
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
				<div class="fy-sm clearfix">
					<span class="fysp spcor1"></span>
					<span class="spansep">已售</span>
					<span class="fysp spcor2"></span>
					<span class="spansep">未售</span>
					<span class="fysp spcor3"></span>
					<span class="spansep">订购中</span>
				</div>
				<div class="f-l-w">
					<div class="f-l-left clearfix" id="loudong2">
					<c:forEach	items="${loudong}" var="item" varStatus="status">
						<c:choose>
		  					<c:when test="${status.index==0}">
								<a href="#" class="pua lon" index="${status.index}">${item.name}</a>
		  					</c:when>
		  					<c:otherwise>
		  						<a href="#" class="pua" index="${status.index}">${item.name}</a>
		  					</c:otherwise>
		  				</c:choose>						
					</c:forEach>
					</div>
				</div>
				<div>
				<c:forEach	items="${loudong}" var="item" varStatus="status">
					<c:choose>
		  				<c:when test="${status.index==0}">
							<div id="danyuan" class="danyuan dyShow${status.index}">
								<div class="d-l-w">
									<div class="d-l-left clearfix" id="danyuan2">
										<c:forEach	items="${item.danyuanList}" var="itemDy" varStatus="statusDy">
											<c:choose>
												<c:when test="${statusDy.index==0}">
													<a href="#" class="dua don" index="${statusDy.index}">${itemDy.name}</a>
												</c:when>
												<c:otherwise>
													<a href="#" class="dua" index="${statusDy.index}">${itemDy.name}</a>
												</c:otherwise>
											</c:choose>							
										</c:forEach>
									</div>
								</div>
								<div>
								<c:forEach	items="${item.danyuanList}" var="itemDy2" varStatus="statusDy2">
										<c:choose>
											<c:when test="${statusDy2.index==0}">
												<div class="ld-w-c clearfix txShow${statusDy2.index}" id="taoxing" >
													<c:forEach	items="${itemDy2.taoxingList}" var="itemTx" varStatus="statusTx">
														<div class="d-w-c-list">
															<c:forEach	items="${itemTx.shiHaoList}" var="item2" varStatus="status2">
																   <c:choose>
																   <c:when test="${item2.getD_state()==0 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:otherwise>
																</c:choose>				
															</c:forEach>	                  	
														</div>
													</c:forEach>		
												</div>
											</c:when>
											<c:otherwise>
												<div class="ld-w-c clearfix  txShow${statusDy2.index}" id="taoxing"  style="display:none">
													<c:forEach	items="${itemDy2.taoxingList}" var="itemTx" varStatus="statusTx">
														<div class="d-w-c-list">
															<c:forEach	items="${itemTx.shiHaoList}" var="item2" varStatus="status2">
																   <c:choose>
																   <c:when test="${item2.getD_state()==0 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:otherwise>
																</c:choose>				
															</c:forEach>	                  	
														</div>
													</c:forEach>		
												</div>
											</c:otherwise>
										</c:choose>							
								</c:forEach>
								</div>
							</div>	
						</c:when>
						<c:otherwise>
							<div id="danyuan" class="danyuan dyShow${status.index}" style="display:none">
								<div class="d-l-w">
									<div class="d-l-left clearfix" id="danyuan2">
										<c:forEach	items="${item.danyuanList}" var="itemDy" varStatus="statusDy">
											<c:choose>
												<c:when test="${statusDy.index==0}">
													<a href="#" class="dua don" index="${statusDy.index}">${itemDy.name}</a>
												</c:when>
												<c:otherwise>
													<a href="#" class="dua" index="${statusDy.index}">${itemDy.name}</a>
												</c:otherwise>
											</c:choose>							
										</c:forEach>
									</div>
								</div>
								<div>
								<c:forEach	items="${item.danyuanList}" var="itemDy2" varStatus="statusDy2">
										<c:choose>
											<c:when test="${statusDy2.index==0}">
												<div class="ld-w-c clearfix" id="taoxing" class="taoxing txShow${statusDy2.index}">
													<c:forEach	items="${itemDy2.taoxingList}" var="itemTx" varStatus="statusTx">
														<div class="d-w-c-list">
															<c:forEach	items="${itemTx.shiHaoList}" var="item2" varStatus="status2">
																   <c:choose>
																   <c:when test="${item2.getD_state()==0 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:otherwise>
																</c:choose>				
															</c:forEach>	                  	
														</div>
													</c:forEach>		
												</div>
											</c:when>
											<c:otherwise>
												<div class="ld-w-c clearfix" id="taoxing" class="taoxing txShow${statusDy2.index}" style="display:none">
													<c:forEach	items="${itemDy2.taoxingList}" var="itemTx" varStatus="statusTx">
														<div class="d-w-c-list">
															<c:forEach	items="${item.shiHaoList}" var="item2" varStatus="status2">
																   <c:choose>
																   <c:when test="${item2.getD_state()==0 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:otherwise>
																</c:choose>				
															</c:forEach>	                  	
														</div>
													</c:forEach>		
												</div>
											</c:otherwise>
										</c:choose>							
								</c:forEach>
								</div>
							</div>	
						</c:otherwise>
					</c:choose>					
				</c:forEach>
				</div>		
			</div>	
	    </div>
	</div>
	<div style="display:none" id="yhgs">
		<img style="width:100%" src="${imageServer}/UpLoad/fy/YHGS.jpg?t="+Math.random()>
	</div>	
</body>
</html>