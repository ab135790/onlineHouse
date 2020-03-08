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
			<div class="i-dc-w" style="padding-bottom:15px;">
				<h3>提示</h3>
				<div class="cc-w-cont">
					<div class="fyyz">房源已被他人选中，请重新选择其他房源</div>
					<a class="btfy" href="/fangyuan/xiangqing?id=${id}">
						<p class="btfyp1">下一个意向房源</p>
						<p class="btfyp2">${loudong}-${danyuan}-${shihao}</p>
					</a>
					<div class="dc-btn">
						<a href="/fangyuan">返回房源</a>
						<a href="/shoucang">返回我的收藏</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>