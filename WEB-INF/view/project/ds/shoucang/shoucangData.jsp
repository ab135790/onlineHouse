<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<c:forEach var="fangyuan"   items="${list}"   varStatus="loop">
				<div class="sc-w-list">
						<div class="dd-w-cont clearfix">
							<div class="dd-w-w-left">
								<span>${loop.index+1}</span>
							</div>
							<div class="dd-w-w">
							    <a  href="javascript:void(0);" onclick="lookDetail(${fangyuan.getD_ID()})" >
								<div class="dd-w-list clearfix">
									<div class="d-w-list-left">房号：</div>
									<div class="d-w-list-left">${fangyuan.getD_BanName()}${fangyuan.getD_Unit()}${fangyuan.getD_RoomNo()}</div>
								</div>
								<div class="dd-w-list clearfix">
									<div class="d-w-list-left">总价：</div>
									<div class="d-w-list-left">${fangyuan.getD_Total()}万</div>
								</div>
								<div class="dd-w-list clearfix">
									<div class="d-w-list-left">类型：</div>
									<div class="d-w-list-left">${fangyuan.getD_RoomType()}</div>
								</div>
								</a>
							</div>
							<div class="b-scinfo">
								<a href="javascript:void(0);" onclick="del(${fangyuan.getD_ID()},${fangyuan.getSort()})"><img src="${project}/ds/images/dcclosed.png"></a>
								<c:if test="${loop.index!=0}" >
									<a href="javascript:void(0);" onclick="dtop(0,${fangyuan.getSort()})"><img src="${project}/ds/images/dtop.png"></a>
								</c:if>
								<c:if test="${!loop.last}">
									<a href="javascript:void(0);" onclick="down(1,${fangyuan.getSort()})"><img src="${project}/ds/images/down.png"></a>
								</c:if>
							</div>							
						</div>
					</div>				
				
			  </c:forEach>