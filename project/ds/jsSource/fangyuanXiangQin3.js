function returnFangYuan(){
	closeBuyFail();
	lookFangYuan();
}

function returnShouCang(){
	closeBuyFail();
	lookShouCang();
}

function goOtherFangYuan(){
	$("#commonBody").load("/fangyuan/xiangqingData.do?id="+id,function(){
		layer.close(index);
	});
}

var index;
function showSure(){
	if(!onSure){//没有到到时间，不允许点击
		//layer.msg($(".djs").html());
		return;
	}

	if("0"===timeState || houseState!="4"){
		//layer.msg("活动时间已结束");
		return;
	}

	if($(".djs").attr("rstate")==1|| $(".djs").attr("mstate")==2){
		goBuyFail();
		return;
	}

	if($(".djs").attr("mstate")==1){
		//layer.msg("预定失败!此房源已预定!");
		goBuyFail();
		$.ajax({
			url: "/fangyuan/singleFanHong.do",
			type: "post",
			async: true,
			data: { id: fyId },
			dataType: "json",
			success: function(data) {
				console.log(data.msg);
			}
		});
	}else{
		$.ajax({
			url: "/fangyuan/userYuDingRoom.do",
			type: "post",
			async: true,
			data: { roomId: fyId},
			dataType: "json",
			success: function(data) {
				if(data.result==="true"){
					index= layer.open({
						type: 1,
						title: false,
						area: ['80%', '60%'],
						closeBtn: 0,
						shadeClose: false,//点击区域不允许关闭
						skin: 'yourclass picradius',
						content: $("#J-alert").html(),
						success: function(layero, index){
							yydaojs();
						}
					});
				}else if(data.result==="false"){
					//layer.msg(data.msg);
					goBuyFail();
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


//犹豫倒计时
var yyTimer;
var yyMaxTime = ExpiredCycle; //一个小时，按秒计算，自己调整!
//var end = (new Date(localStorage.getItem("ServerTime"))).getTime() + ExpiredCycle*1000;
function CountDown() {
	var end = localStorage.getItem("OverDjsTime");
	//console.log(end);
	var now = (new Date()).getTime();
	//console.log(now);
	if (now < end) {
		//var minutes = Math.floor(yyMaxTime / 60);
		var seconds = Math.floor((end-now)/1000%60);
		//var msg = minutes + "分" + seconds + "秒";
		var msg = seconds;
		$(".yydjs").html(msg);
		//--yyMaxTime;
	} else {
		closeSure();
	}
}
function yydaojs(){
	var OverDjsTime = (new Date()).getTime() + ExpiredCycle*1000;
	localStorage.setItem("OverDjsTime",OverDjsTime);
	yyTimer = setInterval("CountDown()", 1000);
}
function overYyDaoJs(){
	clearInterval(yyTimer);
	$(".yydjs").html(ExpiredCycle);
	yyMaxTime = ExpiredCycle;//关闭之后，时间重置
	roomResetState()
}
function roomResetState(){//释放房源，允许他们抢购
	$.ajax({
		url: "/fangyuan/roomResetState.do",
		type: "post",
		async: true,
		data: { roomId: fyId},
		dataType: "json",
		success: function(data) {

		}
	});
}




var agreeXftz=true;//同意选房通知
function agreeYNdo(img){
	//var ischeck=$("#agreeYN").is(':checked');
	if(!agreeXftz){
		console.log("1");
		agreeXftz = true;
		$(".buy").attr("style","background-color:#fa4e2a");
		$(img).attr('src','/project/ds/images/dddefuault.png?r='+Math.random());
	}else{
		console.log("2");
		agreeXftz = false;
		//$(img).attr('isck','0');
		$(img).attr('src','/project/ds/images/dddefuaultselect.png?r='+Math.random());
		$(".buy").attr("style","background-color:#C0C0C0");
	}
}

function goBuy(id){
	if(!agreeXftz){
		return;
	}
	clearInterval(yyTimer); //关闭倒计时，防止撤销操作
	layer.close(index);//关闭弹框
	$.post("/fangyuan/buyRoom.do", { "id": fyId},
		function(data){
			//alert(data.msg.D_BanName);
			if(data.result==="true"){

				//window.location.href="/fangyuan/buyRoomForSuccess?id="+id;
				/*$("#commonBody").load("/fangyuan/buyRoomForSuccessData?id="+id,function(){
                    alreadyBuyCount ++;//已购加1
                });*/
				$.ajax({
					url:"/fangyuan/buyRoomForSuccessData.do",
					type:"GET",
					data: { id: id },
					dataType:"html",
					success:function(result){
						$("#commonBody").html(result);
						alreadyBuyCount ++;//已购加1
					}
				});
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
					url:"/fangyuan/buyRoomForFailJson.do",
					type:"GET",
					data:{ "id": fyId},
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
function goBuyFail(){
	$.ajax({
		url:"/fangyuan/buyRoomForFailJson.do",
		type:"GET",
		async:true,
		data:{ "id": fyId},
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
function goNextyxfy(){
	var fyid = $("#fyid").html();
	//console.log(fyid);
	closeBuyFail();
	if(fyid===""){
		lookFangYuan();
		//layer.msg("请到房源列表继续选房");
	}else{
		getInXingQing(Number(fyid));
	}
}

var sjState="0";//收藏状态
function shoucang(){
	if(szIds.length<=0){
		sjState="0";//收藏
	}else{
		if(szIds.indexOf(fyId)!=-1){
			//layer.msg("您已经收藏过");
			sjState="1";//取消收藏
			//return;
		}else{
			sjState="0";
		}
	}
	if(parseInt(sjState)<1 && szIds.length>=CollectionCount){
		layer.msg("收藏已达上限"+CollectionCount+"套");
		return;
	}
	$.post("/shoucang/doShouCang.do", { "id": fyId,"sjState":sjState},
		function(data){
			if(data.result==="true"){
				if(sjState==="0"){
					//var count = Number(${fangyuan.getD_CollectionCount()})+Number(${fangyuan.getE_CollectionCount()});
					var count = Number($("#shouCangCount").html());
					/* var addCount =count+1;
                     $("#shouCangCount").html(addCount);*/
					//layer.msg("收藏成功!");
					//
					//$(".fy-c-right").css("background-image", "url('/project/ds/images/sc-hover.png')");
					//$(".scSpan").css("background-image", "url('/project/ds/images/sc2-hover.PNG')");
					//$(".scSpan").html("取消");
					$("#scimg").removeClass("csimhg").addClass("csimhgg");
					layer.msg("收藏成功");
					szIds.push(fyId);//加入已收藏集合
				}else{//取消收藏
					//var count = Number(${fangyuan.getD_CollectionCount()})+Number(${fangyuan.getE_CollectionCount()});
					/* var count = Number($("#shouCangCount").html());
                      var addCount =count-1;
                     $("#shouCangCount").html(addCount);*/

					//
					// $(".fy-c-right").css("background-image", "url('/project/ds/images/sc.png')");
					// $(".scSpan").css("background-image", "url('/project/ds/images/sc2.png')");
					//$(".scSpan").html("收藏");
					$("#scimg").removeClass("csimhgg").addClass("csimhg");
					layer.msg("已取消收藏");
					var index = szIds.indexOf(5);
					szIds.splice(index, 1);
				}
			}else{
				layer.msg(data.msg);
			}

		}, "json");
}