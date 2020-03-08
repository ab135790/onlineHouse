<!DOCTYPE html>
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
<link rel="stylesheet" href="${project}/ds/css/public.css" type="text/css"></link>
<link rel="stylesheet" href="${project}/ds/css/index.css?r=1000" type="text/css"></link>
<link rel="stylesheet" href="${project}/ds/css/swiper.min.css" type="text/css"></link>
<script type="text/javascript" src="${project}/ds/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${assets}/plugins/layer/layer.js"></script>
<style>
.layui-layer {
	background-color: rgba(0, 0, 0, 0);
	box-shadow: 0px 0px 0px rgba(0, 0, 0, .3);
}
</style>
<script>
	var clock;
	var times, time;
	function totimeout() {
		var content = '<div class=\"yh-wrap\"><img src=\"${project}/ds/images/lhbg.png\" style=\"width:100%;\"><div class=\"yh-nam\">10</div></div>';
		layer.open({
			type : 1,
			skin : 'b-index-w1', //样式类名
			closeBtn : 0, //不显示关闭按钮
			anim : 2,
			shadeClose : false, //开启遮罩关闭
			title : false,
			time : 10000,
			content : content
		});
		$('.layui-layer').css('top', '');
		times = $('.yh-nam').html();
		time = times;
		clock = setInterval(countDown, 1000);
	}

	function countDown() {
		time--;
		if (time > 0) {
			$('.yh-nam').html(time);
		} else {
			clearInterval(clock); //清除js定时器
			time = times; //重置时间
		}
	}
</script>
</head>
<body>
	<div class="b-index-w1" style="padding-top: 48px; display: none;">

	</div>
	<!--
		<div class="b-index-w" style="padding-top:48px;">
        	<div class="yh-wrap">
            	<img src="images/lhbg.png" style="width:100%;">
                <div class="yh-nam">10</div>
            </div>
		</div>
	</div>
	-->
	<input type="button" value="弹出" onclick="totimeout();" />
</body>
</html>