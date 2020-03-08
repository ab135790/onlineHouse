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
			<div class="ddxx-top">成功选车位的申购人须自开盘之日起3日内（不含开盘当天），前往京都悦府售楼出补签协议或合同，否则开发商有权没收定金并收回该房源另行出售。</div>
			<div class="dx-w-cont">
				<div class="dd-w-w">
					<div class="dd-w-list clearfix">
						<div class="d-w-list-left margin-left">订&nbsp;&nbsp;单&nbsp;&nbsp;号：</div>
						<div class="d-w-list-left">${fymodel.getD_SerialNumber()}</div>
					</div>
					<div class="dd-w-list clearfix">
						<div class="d-w-list-left margin-left">成交时间：</div>
						<div class="d-w-list-left">${fymodel.getD_SaleDate()}</div>
					</div>
				</div>
				<div class="dd-w-w">
					<div class="dd-w-list clearfix">
						<div class="d-w-list-left margin-left">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：</div>
						<div class="d-w-list-left">${fymodel.getD_RoomType()}</div>
					</div>
				</div>
				<div class="dd-w-w">
					<div class="dd-w-list clearfix">
						<div class="d-w-list-left margin-left">客&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;户：</div>
						<div class="d-w-list-left">${user.realName}</div>
					</div>
					<div class="dd-w-list clearfix">
						<div class="d-w-list-left margin-left">手机号码：</div>
						<div class="d-w-list-left">${user.userName}</div>
					</div>
					<div class="dd-w-list clearfix">
						<div class="d-w-list-left margin-left">身份证号：</div>
						<div class="d-w-list-left">${user.userCode}</div>
					</div>
				</div>
			</div>
			 <div class="dc-btnn dc-btn-widtht">
                <a href="/dingdan">返回我的订单</a>
            </div>
		</div>
	</div>
</body>
</html>