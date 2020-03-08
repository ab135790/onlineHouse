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
	<link href="${project}/ds/css/swiper.min.css" type="text/css" rel="stylesheet"></link>
	<script type="text/javascript" src="${project}/ds/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${assets}/plugins/layer/layer.js"></script>
	<script type="text/javascript" src="${project}/ds/js/Form64.js"></script>

	<link rel="stylesheet" href="${project}/ds/css/public.css"></link>
	<link rel="stylesheet" href="${project}/ds/css/index.css"></link>
	<script type="text/javascript" src="${project}/ds/js/ws.js"></script>
	<style>
		.DjsWelcome {
			background-color: rgba(0, 0, 0, 0);
			box-shadow: 0px 0px 0px rgba(0, 0, 0, .3);
		}
	</style>
	<style type="text/css">
		.forbidBug{
			background-color:#C0C0C0;
		}
		.allowBug{
			background-color:#FF5722;
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

			var date = new Date(nowSerTime);
			var now = date.getTime();

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


		<!--开始-->
		var dsLoudongIndex=0;
		var dsDanyuanIndex=0;
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
					<div class="nav-list navon" >
						<a href="/fangyuan?ldIndex=0&dyIndex=0" ><p class="f-n1"></p><span class="f-n-name">房源列表</span></a>
					</div>
					<div class="nav-list" >
						<a href="/dingdan"  ><p class="f-n2"></p><span class="f-n-name">我的订单</span></a>
					</div>
					<div class="nav-list" >
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
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide"><img id="modelPic" style="width: 100%;"></div>
				</div>
				<div class="swiper-pagination"></div>
			</div>
			<div class="fy-c-w clearfix">
				<div class="fy-c-left">
					<p class="c-left-name1">${fangyuan.getD_BanName()}${fangyuan.getD_Unit()}${fangyuan.getD_RoomNo()}</p>
					<!-- <p class="c-left-name2">中梁宝龙于康新盘3期</p> -->
				</div>
				<div class="fy-c-right">
					<p id="shouCangCount">${fangyuan.getD_CollectionCount()+fangyuan.getE_CollectionCount()}</p>
				</div>
			</div>
			<div class="p-w-l" id="fjHtml">
				<div class="w-l-list clearfix">
					<div class="l-list-left">面积：</div>
					<div class="l-list-right">${fangyuan.getD_FloorArea()}平方米</div>
				</div>
				<c:choose>
					<c:when  test="${IsShowPrice==1}">
						<div class="w-l-list clearfix">
							<div class="l-list-left">总价：</div>
							<div class="l-list-right"><span class="bj-zj">${fangyuan.getD_Total()}万</span></div>
						</div>
					</c:when >
					<c:otherwise>
						<div class="w-l-list clearfix">
							<div class="l-list-left">总价：</div>
							<div class="l-list-right"><span class="bj-zj">******万</span></div>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="w-l-list clearfix">
					<div class="l-list-left">类型：</div>
					<div class="l-list-right">${fangyuan.getD_RoomType()}</div>
				</div>
			</div>
			<div class="b_buttons clearfix">
				<a href="javascript:void(0);" class="buttons3" id="shoucang" onclick="shoucang()"><span class="scSpan">收藏</span></a>
				<c:choose>
					<c:when test="${startColor=='0'}">
						<button onclick="showSure()" id="djs${fangyuan.getD_ID()}" rstate="${fangyuan.getD_state()}"  mstate="${fangyuan.getD_Monitor()}"  class="djs" style="background-color:#C0C0C0">活动还未开始!</button>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${yudingColor=='1'}">
								<button onclick="showSure()" id="djs${fangyuan.getD_ID()}" rstate="${fangyuan.getD_state()}"  mstate="${fangyuan.getD_Monitor()}"  class="djs" style="background-color:#C0C0C0">预定中</button>
							</c:when>
							<c:otherwise>
								<button onclick="showSure()" id="djs${fangyuan.getD_ID()}" rstate="${fangyuan.getD_state()}"  mstate="${fangyuan.getD_Monitor()}"  class="djs" >立即选择</button>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
			<!--弹出按钮--><!--弹出按钮结束-->
			<!--弹出内容-->
			<div id="J-alert" style="display:none">
				<div class="i-dc-w" style="padding-bottom:15px;">
					<h3>确认订单(<span class="yydjs">60秒</span>)</h3>
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
						<div class="dd-w-w">
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">客户：</div>
								<div class="d-w-list-left">${user.realName}</div>
							</div>
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">手机号码：</div>
								<div class="d-w-list-left">${user.userName}</div>
							</div>
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">身份证号：</div>
								<div class="d-w-list-left">${user.userCode}</div>
							</div>
							<!-- <div class="dd-w-list clearfix">
								<div class="d-w-list-left">身份证号：</div>
								<div class="d-w-list-left">4104225478941122</div>
							</div>
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">身份证号：</div>
								<div class="d-w-list-left">4104225478941122</div>
							</div> -->
						</div>
						<div class="dd-w-w">
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left d-w-list-left-img"></div>
								<div class="d-w-list-left d-w-list-left-margin">本人已阅读并同意微信选房须知</div>
							</div>
						</div>
						<div class="s_buttons clearfix">
							<a href="javascript:void(0);" class="buttons5" onclick="closeSure()">取消</a>
							<button class="buttons6" onclick="goBuy(${fangyuan.getD_ID()})" id="buy">确认</button>
						</div>
					</div>
				</div>
			</div>
			<!--弹出内容结束 失败弹窗-->
			<div id="buyFail" style="display:none">
				<div class="i-dc-w" style="padding-bottom:15px;">
					<h3>提示</h3>
					<div class="cc-w-cont">
						<div class="fyyz">房源已被他人选中，请重新选择其他房源</div>
						<a class="btfy" href="javascript:void(0);" onclick="goNextyxfy()">
							<p class="btfyp1" >下一个意向房源</p>
							<p class="btfyp2" id="nextYxfy" >1-1-1</p>
							<p style="display:none" id="fyid"></p>
						</a>
						<div class="dc-btn">
							<a href="javascript:void(0);" onclick="returnFangYuan()">返回房源</a>
							<a href="javascript:void(0);" onclick="returnShouCang()">返回我的收藏</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
	function returnFangYuan(){
		closeBuyFail();
		loadFangYuan();
	}

	function returnShouCang(){
		closeBuyFail();
		loadShouCang();
	}
	function goOtherFangYuan(){
		$("#commonBody").load("/fangyuan/xiangqingData?id="+id,function(){
			layer.close(index);
		});
	}
</script>
<!--弹出js-->
<script type="text/javascript">
	var index;
	function showSure(){
		if(!onSure){//没有到到时间，不允许点击
			layer.msg($(".djs").html());
			return;
		}

		if("0"===timeState || houseState!="4"){
			layer.msg("活动时间已结束");
			return;
		}

		if($(".djs").attr("mstate")==1){
			layer.msg("预定失败!此房源已预定!");
			$.ajax({
				url: "/fangyuan/singleFanHong",
				type: "post",
				async: true,
				data: { id: ${fangyuan.getD_ID()} },
				dataType: "json",
				success: function(data) {
					console.log(data.msg);
				}
			});

		}else{
			$.ajax({
				url: "/fangyuan/userYuDingRoom",
				type: "post",
				async: true,
				data: { roomId: ${fangyuan.getD_ID()}},
				dataType: "json",
				success: function(data) {
					if(data.result==="true"){
						index= layer.open({
							type: 1,
							title: false,
							area: ['350px', '350px'],
							closeBtn: 0,
							shadeClose: false,//点击区域不允许关闭
							skin: 'yourclass',
							content: $("#J-alert").html(),
							success: function(layero, index){
								yydaojs();
							}
						});
					}else{
						layer.msg(data.msg);
					}
				}
			});

		}

	}

	function closeSure(){
		overYyDaoJs();
		layer.close(index);
	}
	function buyFailShow(){
		index= layer.open({
			type: 1,
			title: false,
			area: ['350px', '350px'],
			closeBtn: 0,
			shadeClose: true,
			skin: 'yourclass',
			content: $("#buyFail").html()
		});
	}
	function closeBuyFail(){
		layer.close(index);
	}
</script>
<%-- <script type="text/javascript" src="${project}/ds/js/swiper.jquery.min.js"></script>
<script type="text/javascript">
    var swiper = new Swiper('.swiper-container', {
        autoplay: true,
        pagination: '.swiper-pagination',
        paginationType: 'fraction',
        autoplay : 3000,
        loop:true
    });
</script> --%>
<!--弹出js结束-->
<script type="text/javascript">
	//犹豫倒计时
	var yyTimer;
	var yyMaxTime = 1 * 60; //一个小时，按秒计算，自己调整!
	function CountDown() {
		if (yyMaxTime >= 0) {
			var minutes = Math.floor(yyMaxTime / 60);
			var seconds = Math.floor(yyMaxTime % 60);
			var msg = minutes + "分" + seconds + "秒";
			//console.log(msg);
			$(".yydjs").html(msg);
			--yyMaxTime;
		} else {
			//clearInterval(yyTimer);
			//overYyDaoJs();
			closeSure();
		}
	}
	function yydaojs(){
		yyTimer = setInterval("CountDown()", 1000);
	}
	function overYyDaoJs(){
		clearInterval(yyTimer);
		yyMaxTime = 1 * 60;//关闭之后，时间重置
		roomResetState()
	}
	function roomResetState(){//释放房源，允许他们抢购
		$.ajax({
			url: "/fangyuan/roomResetState",
			type: "post",
			async: true,
			data: { roomId: ${fangyuan.getD_ID()}},
			dataType: "json",
			success: function(data) {

			}
		});
	}
	//抢购倒计时

	var maxtimeIni = ${CountDownTime} * 60; //分钟，按秒计算，自己调整!
	var onSure=false;//抢购按钮
	function daojs(nowSerTime){
		var maxtime = maxtimeIni;
		if(timeState==="0"){
			$(".djs").attr("style","background-color:#C0C0C0");//点击按钮变灰
			/*  if(djsTo != null){
                 window.clearTimeout(djsTo);
             } */
			return;
		}
		//var date = new Date();
		//alert("nowSerTime="+nowSerTime);
		var date = new Date(nowSerTime);
		var now = date.getTime();
		//alert("now="+now);
		//var str="${StartTime}".replace(/\-/g, "/");
		var endDate = new Date(startTimeIni); //项目启动时间 str 在index页
		//alert("startTimeIni="+startTimeIni);
		var end = endDate.getTime();
		//时间差
		var leftTime = end-now; //项目启动时间与当前时间的时间差
		var h=Math.floor(leftTime/1000/60/60);
		//alert("leftTime="+leftTime);
		if(leftTime>0){//项目还未开始
			s = Math.floor(leftTime/1000);//转成秒
			//alert("s="+s);
			if(s>maxtime){//与允许显示倒计时的时间进行对比
				//按钮继续不可点
				//console.log("时间还没有到");
				$(".djs").attr("style","background-color:#C0C0C0");
				//$(".djs").addClass("forbidBug");
				onSure=false;
				$(".djs").html("离活动还剩"+h+"时"+minutes +"分"+seconds+"秒开始");
			}else if(s<=maxtime && s>0){//在区间内开始倒计时

				if(s>10){
					var  minutes = Math.floor(s / 60);
					var seconds = Math.floor(s % 60);
					var  msg = "距离抢购还有" + minutes + "分" + seconds + "秒";
					$(".djs").attr("style","background-color:#C0C0C0;color:#fb4d2a");
					$(".djs").html(msg);
				}else{
					var seconds = Math.floor(s % 60);
					var  msg = "离抢购开始还剩"+seconds+"秒";
					$(".djs").attr("style","background-color:#C0C0C0;color:#fb4d2a");
					$(".djs").html(msg);
				}


			}else{
				$(".djs").removeAttr("style","background-color:#C0C0C0");
				//$(".djs").removeClass("forbidBug");
				onSure=true;//倒计时结束，允许抢购
				$(".djs").html("立即选择");
				//window.clearTimeout(djsTo);
			}
		}/* else if(){//活动进行中
                    	$(".djs").removeClass("forbidBug");
                    	onSure=true;//项目开始抢
                    	 $(".djs").html("立即选择"); 
                    	//window.clearTimeout(djsTo); 
                    }else{//活动结束
                    	$(".djs").addClass("forbidBug");
                        $(".djs").html("活动还未开始!");       
                    } */
		// var djsTo = setTimeout(daojs,1000);
	}
	//推送收藏
	function updateRoomCollectionCount(objs){
		objs.forEach((t, i) => {
			if(t.D_ID==${fangyuan.getD_ID()}){
				var count = parseInt(t.E_CollectionCount)+parseInt(t.D_CollectionCount);
				//var count = t.E_CollectionCount+t.D_CollectionCount;
				/*  console.log("ec="+t.ec);
                 console.log("dc="+t.dc); */
				$("#shouCangCount").html(count);//更新收藏
			}
		});
	}
	var CollectionCount =${CollectionCount};//收藏上限
	var szIds=${szIds};//已经收藏的房源id
	var sjState="0";//收藏状态
	function shoucang(){
		console.log(CollectionCount);
		if(szIds.length>=CollectionCount){
			//layer.msg("收藏已达上限"+CollectionCount+"套");
			return;
		}
		if(szIds.length<=0){
			sjState="0";//收藏
		}else{
			if(szIds.indexOf(${fangyuan.getD_ID()})!=-1){
				//layer.msg("您已经收藏过");
				sjState="1";//取消收藏
				//return;
			}else{
				sjState="0";
			}
		}
		$.post("/shoucang/doShouCang", { "id": ${fangyuan.getD_ID()},"sjState":sjState},
				function(data){
					if(data.result==="true"){
						if(sjState==="0"){
							//var count = Number(${fangyuan.getD_CollectionCount()})+Number(${fangyuan.getE_CollectionCount()});

							var count = Number($("#shouCangCount").html());
							var addCount =count+1;
							$("#shouCangCount").html(addCount);
							//layer.msg("收藏成功!");
							//
							$(".fy-c-right").css("background-image", "url('${project}/ds/images/sc-hover.PNG')");
							$(".scSpan").css("background-image", "url('${project}/ds/images/sc2-hover.PNG')");
							$(".scSpan").html("取消收藏");
							szIds.push(${fangyuan.getD_ID()});//加入已收藏集合
						}else{//取消收藏
							//var count = Number(${fangyuan.getD_CollectionCount()})+Number(${fangyuan.getE_CollectionCount()});
							var count = Number($("#shouCangCount").html());
							var addCount =count-1;
							$("#shouCangCount").html(addCount);
							//layer.msg("收藏成功!");
							//
							$(".fy-c-right").css("background-image", "url('${project}/ds/images/sc.png')");
							$(".scSpan").css("background-image", "url('${project}/ds/images/sc2.png')");
							$(".scSpan").html("收藏");
							var index = szIds.indexOf(5);
							szIds.splice(index, 1);
						}
					}else{
						layer.msg(data.msg);
					}

				}, "json");
	}
	function goBuy(id){
		clearInterval(yyTimer); //关闭倒计时，防止撤销操作
		layer.close(index);//关闭弹框
		$.post("/fangyuan/buyRoom", { "id": ${fangyuan.getD_ID()}},
				function(data){
					//alert(data.msg.D_BanName);
					if(data.result==="true"){
						showSignature(data, id);

						//    $.ajax({
						//     url:"/fangyuan/buyRoomForSuccessData",
						//     type:"GET",
						//  	data: { id: id },
						//     dataType:"html",
						//     success:function(result){
						//     	$("#commonBody").html(result);
						//      	alreadyBuyCount ++;//已购加1
						//     }
						// });
					}else{
						// window.location.href="/fangyuan/buyRoomForFail";
						/* $.post("/fangyuan/buyRoomForFailJson",function(data){
                            if(data.result==="true"){
                                console.log(data.msg);
                                console.log(data.msg.D_BanName);
                                console.log(data.msg.D_BanName+"-"+data.msg.D_Unit+"-"+data.msg.D_RoomNo);
                                $("#nextYxfy").html(data.msg.D_BanName+"-"+data.msg.D_Unit+"-"+data.msg.D_RoomNo);
                                $("#fyid").html(data.msg.D_ID);
                            }else{
                                $("#nextYxfy").html(data.msg);
                            }
                            buyFailShow();
                        },"json"); */
						/* $("#yxfy").html(data.msg.D_BanName+"-"+data.msg.D_Unit+"-"+data.msg.D_RoomNo);
                        showFalse(); */
						$.ajax({
							url:"/fangyuan/buyRoomForFailJson",
							type:"GET",
							dataType:"json",
							success:function(data){
								if(data.result==="true"){
									console.log("南哥");
									console.log(data.msg.D_ID);
									console.log(data.msg.D_BanName);
									console.log(data.msg.D_BanName+"-"+data.msg.D_Unit+"-"+data.msg.D_RoomNo);
									$("#nextYxfy").html(data.msg.D_BanName+"-"+data.msg.D_Unit+"-"+data.msg.D_RoomNo);
									$("#fyid").html(data.msg.D_ID);
								}else{
									$("#nextYxfy").html(data.msg);
								}
								buyFailShow();
							}
						});
					}
				}, "json");
	}

	function goNextyxfy(){
		var fyid = $("#fyid").html();
		console.log(fyid);
		closeBuyFail();
		if(fyid===""){
			layer.msg("请到房源列表继续选房");
		}else{
			getInXingQing(Number(fyid));
		}
	}

	$(function(){
		//详情图
		$("#modelPic").attr("src","${imageServer}/UpLoad/fy/${fangyuan.getD_HouseModel()}.jpg?t="+Math.random());
		var str = Base64decode('${fjHtml}');

		str=str.replace("[楼栋]",'${fangyuan.getD_BanName()}');
		str=str.replace("[单元]",'${fangyuan.getD_Unit()}');
		str=str.replace("[室号]",'${fangyuan.getD_RoomNo()}');
		str=str.replace("[原总价]",'${fangyuan.getD_Total()}');
		str=str.replace("[面积]",'${fangyuan.getD_FloorArea()}');
		str=str.replace("[房间类型]",'${fangyuan.getD_RoomType()}');
		$("#fjHtml").html(str);

		if(szIds.indexOf(${fangyuan.getD_ID()})!=-1){
			$(".fy-c-right").css("background-image", "url('${project}/ds/images/sc-hover.PNG')");
			$(".scSpan").css("background-image", "url('${project}/ds/images/sc2-hover.PNG')");
			$(".scSpan").html("取消收藏");
		}
	})
</script>