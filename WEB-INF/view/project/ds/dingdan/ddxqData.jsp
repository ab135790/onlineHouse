<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<script type="text/javascript">
var str = Base64decode('${xfcgwzHtml}');
$("#xfcgwzHtml").html(str);
</script>
		<div class="b-index-w">
				<div style="background:#fbf6ed;text-align:center;padding-top:8px;"><img style="width:10%;" src="${project}/ds/images/dddding.png;"></div>
				<div class="sub-dd clearfix" id="xfcgwzHtml" style="height:auto;text-align:center;padding:8px 0px;">
					
				</div>
			<div class="dx-w-cont">
				<div class="dd-w-w ddd-w">
					<div class="dd-w-list clearfix">
						<div class="d-w-list-left margin-left">订&nbsp;&nbsp;单&nbsp;&nbsp;号：</div>
						<div class="d-w-list-left">${fymodel.getD_SerialNumber()}</div>
					</div>
					<div class="dd-w-list clearfix">
						<div class="d-w-list-left margin-left">成交时间：</div>
						<div class="d-w-list-left">${fymodel.getD_SaleDate()}</div>
					</div>
				</div>
				<div class="dd-w-w ddd-w">
					<div class="dd-w-list clearfix">
						<div class="d-w-list-left margin-left">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：</div>
						<div class="d-w-list-left">${fymodel.getD_RoomType()}</div>
					</div>
				</div>
				<div class="dd-w-w ddd-w" style="padding-left:.5rem">
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
                <a href="javascript:void(0);"  onclick="dingdanIndex()">返回我的订单</a>
            </div>
		</div>
