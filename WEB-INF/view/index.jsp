<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="applicable-device" content="mobile">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Cache-Control" content="no-cache">
<meta name="application-name" content="">
<title>${HouseName}</title>
<link rel="icon" href="data:image/ico;base64,aWNv">
<link rel="stylesheet" href="${project}/ds/css/public.css"></link>
<link rel="stylesheet" href="${project}/ds/css/index.css?r=1000"></link>
<!--弹出引用样式-->
<link rel="stylesheet" href="${project}/ds/css/slideAlert.css"></link>
<!--弹弹出引用样式结束-->
<script type="text/javascript"
	src="${project}/ds/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${project}/ds/js/Form64.js"></script>
<script type="text/javascript" src="${project}/ds/js/ws.js"></script>
<!--弹出引用js-->
<%-- <script type="text/javascript" src="${project}/ds/js/zepto.min.js"></script>
<script type="text/javascript" src="${project}/ds/js/slideAlert.js"></script> --%>
<script type="text/javascript" src="${assets}/plugins/layer/layer.js"></script>

<!--弹出引用js结束-->
<style type="text/css">
/*  .peple{
	     position: relative;
	  	 float:left;
	     width:45%;
	     margin-left:2%;
	  } */
	  .layui-rgxz{
	    /*width:100%;*/
	    /*left:0;*/
	  }
</style>
<script type="text/javascript">
	function userGetOut(msg) {
		window.location.href = "/logout";
	}
	function houseStateControl() {
		window.location.href = "/finish";
	}
	$(function() {
		$.ajax({
			url : "/common/getHtmlText",
			type : "post",
			async : true,
			data : {
				name : "认购须知"
			},
			dataType : "json",
			success : function(data) {
				var str = Base64decode(data.result);
				$("#rgxzText").html(str);
			}
		});

		//背景图
		$("#bjtPic").attr("src",
				"${imageServer}/UpLoad/fy/bgimg.jpg?t=" + Math.random());
		//规划图
		$("#ghtPic").attr("src",
				"${imageServer}/UpLoad/fy/ghimg.jpg?t=" + Math.random());
	})
</script>
<style>
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

.weui-cell {
	background-color: #fff;
	padding: 10px 15px;
	position: relative;
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-align: center;
	-ms-flex-align: center;
	align-items: center;
	border-bottom: 1px solid #e9e8e9;
}

.weui-cell__bd {
	-webkit-box-flex: 1;
	-ms-flex: 1;
	flex: 1;
}

.weui-cell__ft {
	text-align: right;
	color: #999;
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

.loginOut {
	padding: 6px 10px;
	border-radius: 5px;
	display: block;
	border: 1px solid #e7e7e7;
	background: #fff;
	color: #000;
}

.xm-peple {
    display:flex;
}

</style>
</head>
<body>
	<div class="center">
		<div class="b-index-w" style="padding-bottom: 55px;">
			<div class="index-img">
				<img id="bjtPic">
			</div>
			<div class="weui-cell">
				<div class="weui-cell__bd">
					<p>${name}</p>
				</div>
				<div class="weui-cell__ft">
					  <span class="weui-badge loginOut"><a href="/logout" >退出</a></span>
				</div>
			</div>
			<div class="index-xm-w clearfix">
				<div class="xm-w-left">
					<p class="xm-name">${HouseName}</p>
					<p>
						咨询电话：<span class="tel-num">${HouseTel}</span>
					</p>
				</div>
				<div class="xm-w-right">
					<a href="tel:${HouseTel}">电话</a>
				</div>
			</div>
			<div class="xm-hd-w">
				<div class="hd-wlist">
					<h3 class="hd-title1">公测活动</h3>
					<p>${ReadTestStartDate}开始</p>
					<p>${ReadTestEndDate}结束</p>
				</div>
				<div class="hd-wlist">
					<h3 class="hd-title2">正式活动</h3>
					<p>${ReadStartDate}开始</p>
					<p>${ReadEndDate}结束</p>
				</div>
			</div>
			<div class="xm-peple">
			  <div  style="width:33%">
				<p class="peple xm-p1">
					姓名:${name}
				</p>
			  </div>
			  <div>
				<p class="peple xm-p2">身份证号:${idCard}</p>
			  </div>
			</div>
			<div class="xm-pmt">
				<h3>规划图</h3>
				<div class="pmt-img">
					<img id="ghtPic">
				</div>
			</div>
			<!--弹出按钮-->
			<div class="index-button">
				<button class="J-ac-btn" data-type="bottom" />
				进入
				</button>
			</div>
			<!--弹出按钮结束-->
			<!--弹出内容-->
			<div id="J-bottom" style="display: none">
				<div class="i-dc-w" style="padding-bottom: 40px;">
					<h3>认购须知</h3>
					<div class="dc-w-cont" id="rgxzText"
						style="height: 300px; overflow-y: scroll">
						<p>
							1.本次开盘正式在线选房时间为：<br />2018年xx月xx日xx:xx，<br />
							登录收藏时间：2018年xx月xx日xx:xx，<br /> <span
								style="color: #ff0000; font-weight: bold">正式开盘时间:2018年xx月xx日xx:xx-xx:xx<br /></span>
						</p>
						<p>
							2.验证码一天同一手机号码最多发送10次，不要频繁发送，以免收不到短信，若在线选车位期间发现身份验证不通过等相关问题，请及时跟您的置业顾问联系。
						</p>
						<p>
							3.本次所有参与在线选房的客户必须为参与【xxxxx】房源意向登记的客户，且提前支付意向金并签署《xxxxx房源申购报名确认单》。
						</p>
						<p>
							4.客户需在规定时间内完成在线选房流程，成功认购后，认购人凭“成功认购”短信或者系统成功选购“成交信息截图”自开盘之日起3日内（不含开盘当天）携带有效身份证件、户口本、结婚证、诚意金收据,报名确认单及相关资料至售楼处补签协议或合同，开发商不另行催告；如未能按时补签定购书的，开发商有权没收定金并收回该房源另行出售。
						</p>
						<p>
							5.本人对xxxxxx房源的现状（包括所处位置、楼层、周边环境、长度、宽度、高度、停车便利度、消防设施、集水井设施、管线布置、公建设施分布状况、单元通道、入户通道、电梯位置、地下车库出入口、有无柱子、不利因素等）均已知悉并认可。本人知悉车位交付时，若面积有差异，仍维持合同总价款不变。

						</p>
						<p>6.本项目为预售商品房，销售平面图的尺寸与其他情况以实际交付为准。</p>
						<p>7.本次预售商品房明码标价销售，所有显示价格为该房源的表价。本次在线选房开盘结束后剩余房源的销售地点：xxxxxxxxxxxx</p>
						<p>8.本次在线开盘体验活动最终解释权归xxxxxxxx有限公司。以上条款请仔细阅读，对其内容及事项无异议后方可开始线上选房。</p>
					</div>
					<div class="bottom_buttons clearfix">
						    <a href="javascript:void(0);" class="buttons1" onclick="colseForm()">取消</a> <a href="javascript:void(0);"  onclick="loadfangyuan()"
                            class="buttons2">确认</a>

					</div>
				</div>
			</div>
			<!--弹出内容结束-->
			<!--弹出js-->
			<script type="text/javascript">
				/* $(".J-ac-btn").click(function() {
					var type = $(this).attr('data-type');
					var instance = $(this).slideAlert({
						type : type,
						content : $('#J-' + type).html(),
						beforeOpen : function() {
							console.log('before open callback');
						},
						afterClose : function() {
							console.log('after close callback');
						},
						afterOpen : function() {
							$('#haha').on('click', function() {
								$(this).slideAlert({
									type : 'tips',
									content : "test"
								});
							});
						}
					});
				}); */
                var index;
                $(".J-ac-btn").click(function() {

                     index =layer.open({
                                  title: false,
                                  type: 1,
                                  skin: 'layui-rgxz', //样式类名
                                  closeBtn: 0, //不显示关闭按钮
                                  anim: 2,
                                  shadeClose: true, //开启遮罩关闭
                                  offset: 'b',
                                  area: ['80%', '50%'],
                                  content: $("#J-bottom").html()
                                });
                })

				function loadfangyuan(){
					console.log("跳转")
					window.location.replace("/fangyuan?ldIndex=0&dyIndex=0");
				}
                function colseForm(){
                    layer.close(index);
                }

			</script>
			<!--弹出js结束-->
		</div>
	</div>
</body>
</html>