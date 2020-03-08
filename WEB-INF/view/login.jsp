<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<html>
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
	<%@include file="/WEB-INF/view/include/common.jsp" %>
	<script type="text/javascript">
		var allowLoad= true;//默认允许登录
		var LoginTest='${LoginTest}';
		var yzType='${yzType}';
		function houseStateControl(){
			window.location.href="/finish";
		}
		function checkTel(tel){
			if (tel.length === 0){
				layer.msg("手机号不能为空");
				return false;
			}
			if("0"===LoginTest){
				var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
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
			$("#D_Code").val(randomn(4));
		}
		$(function(){
			countTime();//倒计时
			if(yzType==='0'){
				if(LoginTest==='1'){
					createZhangHao();//生成帐号
					$("#card").attr("style","display:none");
				}else{
					$("#code").attr("style","display:none");
				}
			}

			$("#submit").click(function(){
				if(!allowLoad){
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

				$.post("/loginJson", { "D_Tel": $("#D_Tel").val(),"D_Code":$("#D_Code").val(),"D_Card":$("#D_Card").val()},
						function(data){
							if(data.result==="true"){
								//window.location.href="/";
								window.location.replace("/");
							}else{
								layer.msg(data.msg);
							}
						}, "json");
			})

			//刷新图片
			$("#dltPic").attr("src","${imageServer}/UpLoad/fy/loginimg.jpg?t="+Math.random());

		});
		function send_code(){
			if($("#D_Tel").val()===""){
				layer.msg("手机号不能为空");
				return
			}

			$.post("/sendCode", { "tel": $("#D_Tel").val() },
				function(data){
					if(data.result==="true"){
						layer.msg("发送成功");
					}else{
						layer.msg("手机号不存在");
					}
				}, "json");
		}

	</script>
	<script type="text/javascript">
		var ShoppingTime = ${ShoppingTime} * 60;//单位分钟 转为秒
		//设置截止时间
		var StartTime="${StartTime}".replace(/\-/g, "/");
		/*  var endDate = new Date(StartTime);
         var end = endDate.getTime();//项目开始时间 */
		var nowTimeIni ="${nowDate}".replace(/\-/g, "/");
		var nowDate =new Date(nowTimeIni);
		var now = nowDate.getTime();
		function countTime() {

			var endDate = new Date(StartTime);
			var end = endDate.getTime();//项目开始时间
			//获取当前时间
			//var date = new Date();
			now = now + 1000;
			//设置截止时间
			/*  var str="${StartTime}".replace(/\-/g, "/");
            var endDate = new Date(str); 
            var end = endDate.getTime();    */

			//时间差
			var leftTime = end-now; //得到毫秒差
			//定义变量 d,h,m,s保存倒计时的时间
			var d,h,m,s;
			if (leftTime>=0) {
				d = Math.floor(leftTime/1000/60/60/24);
				h = Math.floor(leftTime/1000/60/60%24);
				m = Math.floor(leftTime/1000/60%60);
				s = Math.floor(leftTime/1000%60);
				$("#ggts").html("活动倒计时!");
				allowLoad = true;
			}else{
				leftTime = end + ShoppingTime*1000 - now;
				if(leftTime >=0){
					d = Math.floor(leftTime/1000/60/60/24);
					h = Math.floor(leftTime/1000/60/60%24);
					m = Math.floor(leftTime/1000/60%60);
					s = Math.floor(leftTime/1000%60);
					$("#ggts").html("活动倒计时!");
				}else{
					$("#ggts").html("本轮活动已结束!");
					allowLoad = false;//不允许登录
				}
			}
			//将倒计时赋值到div中
			$(".RemainD").html(d);
			$(".RemainH").html(h);
			$(".RemainM").html(m);
			$(".RemainS").html(s);

			//递归每秒调用countTime方法，显示动态时间效果
			setTimeout(countTime,1000);
		}
	</script>
	<style>
		.weui-cell {
			padding: 10px 15px;
			position: relative;
			display: -webkit-box;
			display: -ms-flexbox;
			display: flex;
			-webkit-box-align: center;
			-ms-flex-align: center;
			align-items: center;
		}
		.weui-cell:before {
			content: " ";
			position: absolute;
			top: 0;
			right: 0;
			height: 1px;
			border-top: 1px solid #e5e5e5;
			color: #e5e5e5;
			-webkit-transform-origin: 0 0;
			transform-origin: 0 0;
			-webkit-transform: scaleY(.5);
			transform: scaleY(.5);
			left: 15px;
			z-index: 2;
		}
		.weui-cell__bd {
			-webkit-box-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		.weui-badge {
			display: inline-block;
			padding: .15em .4em;
			min-width: 8px;
			border-radius: 18px;
			background-color: #f43530;
			color: #fff;
			line-height: 1.2;
			text-align: center;
			font-size: 12px;
			vertical-align: middle;
		}
		.OBClass {
			background: #2196f3;
			border-radius: 3px;
		}
		.login-list .login-list2 input {
			font-size: x-large;
		}
	</style>
</head>

<body style="background:#ffffff;">
<form action="/login" method="post">
	<div class="center">
		<div class="b-index-w">
			<div class="index-img"><img id="dltPic" ></div>
			<div class="weui-cell" style="">
				<div class="weui-cell__bd">
					<span style="vertical-align: middle;">京都御府车位</span> <span
						class="weui-badge OBClass" style="margin-left: 5px;">正式</span>
				</div>
			</div>
			<div class="login-w" style="padding-top: 0px;">
				<div class="login-list clearfix">
					<div class="login-list1"><span class="lsep1"></span></div>
					<div class="login-list2"><input type="text" id="D_Tel" name="D_Tel" placeholder="请输入认筹时的手机号码"></div>
				</div>

				<div class="login-list clearfix" id="code">
					<div class="login-list1"><span class="lsep2"></span></div>
					<div class="login-list2 login-list22"><input type="text" id="D_Code" name="D_Code" placeholder="请输入验证码"></div>
					<div class="login-list3" style="margin-top: 1.5px;"><a href="javascript:void(0);" onclick="send_code()">发送验证码</a></div>
				</div>

				<div class="login-list clearfix" id="card">
					<div class="login-list1"><span class="lsep3"></span></div>
					<div class="login-list2"><input type="text" id="D_Card" name="D_Card" placeholder="请输入您的身份证号"></div>
				</div>
				<!-- <div class="login-button"><input type="submit" value="登录" ></div> -->
				<div class="login-button"><input type="button" value="登录" id="submit"></div>
				<div class="time-djs" id="subtimer" style="display:none">
					<p id="ggts">活动倒计时</p>
					<div class="liktimer">
						<span class="RemainD Remain">0</span><span class="liksapn">天</span><span class="RemainH Remain">0</span><span class="liksapn">时</span>
						<span class="RemainM Remain">0</span><span class="liksapn">分</span><span class="RemainS Remain">0</span><span class="liksapn">秒</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
</body>
</html>