<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
				<script type="text/javascript">
				
				function down(id,sort){
					console.log(id);
					console.log(sort);
					$("#shoucangList").load("/shoucang/doDown?id="+id+"&sort="+sort);
				}	
				function dtop(id,sort){			
					$("#shoucangList").load("/shoucang/doTop?id="+id+"&sort="+sort);
				}		
				function del(fangyuanId,shoucangId){
					console.log(fangyuanId);
					console.log(shoucangId);
					$("#shoucangList").load("/shoucang/doDel?fangyuanId="+fangyuanId+"&shoucangId="+shoucangId,function(){
						 var count =$("#syNum").html();
				    	 var addCount = Number(count)+1;
				    	 $("#syNum").html(addCount);
					});
				}		
				 function goBuy(id){
					 $.post("/fangyuan/getFangYuanState", { id: id },
			    			   function(data){
			    			      console.log(data.result);
			    			      if(data.result==="1"){
			    			    	  layer.msg("已经被预定");
			    			      }else if(data.result==="2"){
			    			    	  layer.msg("已经卖出");
			    			      }else{
			    			     	  //window.location.href="/fangyuan/xiangqing?id="+id;
			    			     	  var index = layer.load(1, {
			            					shade: [0.1,'#fff'] //0.1透明度的白色背景
			       						 });
			    			     	 $("#commonBody").load("/fangyuan/xiangqingData?id="+id,function(){
			    							layer.close(index);		    							
			    						});
			    			      }
			    			   },"json"); 
		        }
	</script>
				<div class="ts-w">
					<img src="${project}/ds/images/tsdec.png"><span>您还可以收藏<strong id="syNum">${syNum}</strong>套房源</span>
				</div>
				<div class="b-sc-w" id="shoucangList">
				  <c:forEach var="fangyuan"   items="${list}"   varStatus="loop">
					<div class="sc-w-list">
						<div class="sc-title clearfix">
							<div class="sc-title-left">
								<span>${loop.index+1}</span>
							</div>
							<div class="sc-title-right clearfix">
								<c:if test="${loop.index!=0}" >
									<a href="javascript:void(0);" onclick="dtop(0,${fangyuan.getSort()})" class="dtop">向上</a>
								</c:if>
								<c:if test="${!loop.last}">
									<a href="javascript:void(0);" onclick="down(1,${fangyuan.getSort()})" class="down">向下</a>							
								</c:if>
							</div>
						</div>
						<div class="dd-w-cont">
							<div class="dd-w-w">
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
							</div>
							<%-- <c:choose>
	                           <c:when test="${fangyuan.dState==1}">
	                              <a class="yysc" href="javascript:void(0);">订<br/>购中</a>
	                           </c:when>
	                           <c:when test="${fangyuan.dState==2}">
	                              <a class="yysc" href="javascript:void(0);">已经<br/>售出</a>
	                           </c:when>
	                           <c:otherwise>
									<a class="ljqg" href="javascript:void(0);" onclick="goBuy(${fangyuan.id})">立即<br/>认购</a>
	                           </c:otherwise>
							</c:choose> --%>
						</div>
						<div class="b-scdd"><a href="javascript:void(0);" onclick="del(${fangyuan.getD_ID()},${fangyuan.getSort()})" >删除收藏</a></div>
					</div>				
				  </c:forEach>
				</div>
