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
	<link rel="stylesheet" href="${project}/ds/css/public.css"></link>
	<link rel="stylesheet" href="${project}/ds/css/index.css"></link>
</head>
<body>
	<div class="center">
		<div class="b-index-w">
			<div class="ddcg"><img src="${project}/ds/images/fg.png" style="width:100%"></div>
			<div class="succ"><p class="scccp1">恭喜您成功认购</p><p class="scccp2">${fangyuan.louDong}-${fangyuan.danYuan}-${fangyuan.shiHao}</p></div>
			<p class="succinfo">意向金20万自动转为定金<br/>请在2018年11月30日前参加正式选房活动</p>
			<div class="dc-btn dc-btn-width">
				<a href="/dingdan">返回我的订单</a>
				<a href="/shoucang">返回我的收藏</a>
			</div>
		</div>
	</div>
</body>
</html>