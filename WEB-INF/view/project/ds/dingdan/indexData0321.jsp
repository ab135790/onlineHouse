<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<script type="text/javascript">
var str = Base64decode('${xfcgwzHtml}');
$("#xfcgwzHtml").html(str);
function readMx(){
	$.ajax({
		url : "/dingdan/ddxqData.do",
		type : "post",
		async : true,
		dataType : "html",
		success : function(result) {
			$("#commonBody").html(result);
		}
	});		
}
</script>
		<div class="b-index-w">
			<div class="dfix" style="padding-top:48px;height:auto;">
				<nav class="menunav">
					<div class="menunav-w">
						<div class="nav-list" id="lookFangYuan">
						  <a href="javascript:void(0);" onclick="lookFangYuan()" ><p class="f-n1"></p><span class="f-n-name">房源列表</span></a>
						</div>
						<div class="nav-list" id="lookShouCang">
						  <a href="javascript:void(0);"  onclick="lookShouCang()" ><p class="f-n3"></p><span class="f-n-name">我的收藏</span></a>
						</div>
						<div class="nav-list  navon" id="lookDingDan">
						  <a href="javascript:void(0);"  onclick="lookDingDan()"  ><p class="f-n2"></p><span class="f-n-name">我的订单</span></a>
						</div>
						
					</div>
				</nav>
					
			</div>
			<div id="commonBody">
				<c:choose>
			<c:when test="${fymodel!=null}">
				<div style="background:#fbf6ed;text-align:center;padding-top:8px;"><img style="width:10%;" src="${project}/ds/images/dddding.png;"></div>
				<div class="sub-dd clearfix" id="xfcgwzHtml" style="height:auto;text-align:center;padding:8px 0px;">
					
				</div>
				
		<div class="b-dd-w">
			<div class="dd-w-title">
				<div class="dd-w-left">
					<span>下单时间:</span><span>${fymodel.getD_SaleDate()}</span>
				</div>
			</div>
			<a href="javascript:void(0);" onclick="readMx()" class="dd-a-w">
				<div class="dd-w-cont">
					<div class="dd-w-w ddd-w">
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
					<div class="dd-w-w ddd-w">
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">职业顾问：</div>
							<div class="d-w-list-left">张三</div>
						</div>
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">顾问电话：</div>
							<div class="d-w-list-left">13208851298</div>
						</div>
					</div>
					<div class="dd-w-w ddd-w" style="padding: .8rem .5rem;">
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
			<p style="width: 60px; height: 60px; margin: 0px auto; text-align: center;margin-top:15px;">
				<img src="${project}/ds/images/tsxx.png" style="width: 100%">
			</p>
			<p style="text-align: center; color: #888888; padding-top: 15px;">您还没有订单</p>
		</div>
	</c:otherwise>
</c:choose>
<div class="dc-btnn dc-btn-widtht">
	<a href="javascript:void(0);" onclick="goBack()">退出</a>
</div>
	    </div>
	</div>