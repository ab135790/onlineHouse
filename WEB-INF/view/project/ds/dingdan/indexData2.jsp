<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp"%>
<script type="text/javascript">
	function readMx() {
		$("#commonBody").load("/dingdan/ddxqData", function() {

		});
	}
</script>

<c:choose>
	<c:when test="${fymodel!=null}">
		<div class="b-dd-w">
			<div class="dd-w-title">
				<div class="dd-w-left">
					<span>下单时间:</span><span>${fymodel.getD_SaleDate()}</span>
				</div>
			</div>
			<a href="javascript:void(0);" onclick="readMx()" class="dd-a-w">
				<div class="dd-w-cont">
					<div class="dd-w-w">
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">房&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</div>
							<div class="d-w-list-left">${fymodel.getD_BanName()}${fymodel.getD_Unit()}${fymodel.getD_RoomNo()}</div>
						</div>
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">证件号码：</div>
							<div class="d-w-list-left">${user.userCode}</div>
						</div>
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">可选套数：</div>
							<div class="d-w-list-left">5</div>
						</div>
					</div>
					<div class="dd-w-w">
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">职业顾问：</div>
							<div class="d-w-list-left">张三</div>
						</div>
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">顾问电话：</div>
							<div class="d-w-list-left">13208851298</div>
						</div>
					</div>
					<div class="dd-w-w" style="padding: .8rem 0;">
						<div class="dd-w-list clearfix" onclick="readMx()">
							<div class="d-w-list-left">订&nbsp;&nbsp;单&nbsp;&nbsp;号：</div>
							<div class="d-w-list-left"
								style="font-size: 1.6rem; font-weight: bold;">${fymodel.getD_SerialNumber()}</div>
						</div>
					</div>
				</div>
				<div class="yxg">
					<img src="${project}/ds/images/yrg.png" />
				</div>
			</a>
		</div>
	</c:when>
	<c:otherwise>
		<div class="b-dd-w">
			<p style="width: 60px; height: 60px; margin: 0px auto; text-align: center;">
				<img src="${project}/ds/images/tsxx.png" style="width: 100%">
			</p>
			<p style="text-align: center; color: #888888; padding-top: 15px;">您还没有订单</p>
		</div>
	</c:otherwise>
</c:choose>
<div class="dc-btnn dc-btn-widtht">
	<a href="/logout">退出</a>
</div>
