<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
	<script type="text/javascript">
	 IsShowYHGS ='${IsShowYHGS}';//是否显示优惠公示 1显示
	 userYhgs='${yhgsOnlyOne}';//显示次数	
	 alreadyBuyCount = ${alreadyBuyCount};//已购买数量	
	 setIsTest();
	 DsIsShowDY();
	</script>
    <script type="text/javascript">
		$(function(){
			$('.yy-w').navbarscroll();
			$('.d-l-left').navbarscroll();
		});
	</script>
	
		<div class="b-index-w" style="padding-top:162px;">

			<div id="commonBody">
				<div class="dfix" style="position:fixed;width:100%;height:162px;top:0px;left:0;right:0;z-index:1002;">
					<nav class="menunav" style="position:relative">
						<div class="menunav-w">
							<div class="nav-list navon" id="lookFangYuan">
							  <a href="javascript:void(0);" onclick="lookFangYuan(0,0)"><p class="f-n1"></p><span class="f-n-name">房源列表</span></a>
							</div>
							<div class="nav-list" id="lookShouCang">
							  <a href="javascript:void(0);"  onclick="lookShouCang()"><p class="f-n3"></p><span class="f-n-name">我的收藏</span></a>
							</div>
							<div class="nav-list" id="lookDingDan">
							  <a href="javascript:void(0);"  onclick="lookDingDan()"><p class="f-n2"></p><span class="f-n-name">我的订单</span></a>
							</div>
							
						</div>
					</nav>
					<div class="sub-dd clearfix" style="height:32px;overflow:hidden;">
						<div class="sub-d-right" style="float:left;background:none;">
							<div class="subtimer" id="subtimer">
								  <span class="RemainH Remain">0</span><span class="liksapn">时</span><span class="RemainM Remain">0</span><span class="liksapn">分</span><span class="RemainS Remain">0</span><span class="liksapn" id="ggts2">秒后活动结束</span>
							</div>						
						</div>
						<div class="sub-d-left IsTest"></div>
						<div class="fy-sm" style="float:right;margin-right:10px;">
							<span class="fysp spcor1"></span>
							<span class="spansep">已售</span>
							<span class="fysp spcor2"></span>
							<span class="spansep">未售</span>					
						</div>
					</div>
					<div class="f-l-w">
						<div class="yy-w" id="loudong2">
							<div class="scroller">
								<ul class="clearfix">
									<c:forEach	items="${loudong}" var="item" varStatus="status">
										<c:choose>
											<c:when test="${status.index==ldIndex}">
												<li><a href="javascript:void(0);"  index="${status.index}" onclick="ldChoose(this);">${item.name}</a></li>
											</c:when>
											<c:otherwise>
												<li><a href="javascript:void(0);"  index="${status.index}" onclick="ldChoose(this);">${item.name}</a></li>
											</c:otherwise>
										</c:choose>						
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
					<div class="d-l-w"  id="IsShowDY" style="display: none">
						<c:forEach	items="${loudong}" var="item" varStatus="status">
							<c:choose>
								<c:when test="${status.index==ldIndex}">
									<div class="d-l-left dyShow${status.index}" id="danyuan2">
										<div class="scroller">
											<ul class="clearfix">
												<c:forEach	items="${item.danyuanList}" var="itemDy" varStatus="statusDy">
													<c:choose>
														<c:when test="${statusDy.index==dyIndex}">
															<li><a href="javascript:void(0);"  index="${statusDy.index}" onclick="dyChoose(this);">${itemDy.name}</a></li>
														</c:when>
														<c:otherwise>
															<li><a href="javascript:void(0);"  index="${statusDy.index}" onclick="dyChoose(this);">${itemDy.name}</a></li>
														</c:otherwise>
													</c:choose>							
												</c:forEach>
											</ul>
										</div>
									</div>
								</c:when>
								<c:otherwise>
								<div class="d-l-left  dyShow${status.index}" id="danyuan2" style="display:none">
									<div class="scroller">
										<ul class="clearfix">
											<c:forEach	items="${item.danyuanList}" var="itemDy" varStatus="statusDy">
												<c:choose>
													<c:when test="${statusDy.index==dyIndex}">
														<li><a href="javascript:void(0);"  onclick="dyChoose(this);" index="${statusDy.index}">${itemDy.name}</a></li>
													</c:when>
													<c:otherwise>
														<li><a href="javascript:void(0);"  onclick="dyChoose(this);" index="${statusDy.index}">${itemDy.name}</a></li>
													</c:otherwise>
												</c:choose>							
											</c:forEach>
										</ul>
									  </div>
								</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>					
				</div>
				<div>
				<c:forEach	items="${loudong}" var="item" varStatus="status">
					<c:choose>
		  				<c:when test="${status.index==ldIndex}">
							<div  class="danyuan fyShow${status.index}">
								<div>
								<c:forEach	items="${item.danyuanList}" var="itemDy2" varStatus="statusDy2">
										<c:choose>
											<c:when test="${statusDy2.index==0}">
												<div class="ld-w-c clearfix txShow${statusDy2.index}" id="taoxing" style="background:#f6f6f6;">
													<c:forEach	items="${itemDy2.taoxingList}" var="itemTx" varStatus="statusTx">
														<div class="d-w-c-list">
															<c:forEach	items="${itemTx.shiHaoList}" var="item2" varStatus="status2">
																   <c:choose>
																   <c:when test="${item2.getD_state()==0 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:otherwise>
																</c:choose>				
															</c:forEach>	                  	
														</div>
													</c:forEach>		
												</div>
											</c:when>
											<c:otherwise>
												<div class="ld-w-c clearfix txShow${statusDy2.index}" id="taoxing"  style="display:none">
													<c:forEach	items="${itemDy2.taoxingList}" var="itemTx" varStatus="statusTx">
														<div class="d-w-c-list">
															<c:forEach	items="${itemTx.shiHaoList}" var="item2" varStatus="status2">
																   <c:choose>
																   <c:when test="${item2.getD_state()==0 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:otherwise>
																</c:choose>				
															</c:forEach>	                  	
														</div>
													</c:forEach>		
												</div>
											</c:otherwise>
										</c:choose>							
								</c:forEach>
								</div>
							</div>	
						</c:when>
						<c:otherwise>
							<div  class="danyuan fyShow${status.index}" style="display:none">
								<div>
								<c:forEach	items="${item.danyuanList}" var="itemDy2" varStatus="statusDy2">
										<c:choose>
											<c:when test="${statusDy2.index==0}">
												<div class="ld-w-c clearfix txShow${statusDy2.index}" id="taoxing" >
													<c:forEach	items="${itemDy2.taoxingList}" var="itemTx" varStatus="statusTx">
														<div class="d-w-c-list">
															<c:forEach	items="${itemTx.shiHaoList}" var="item2" varStatus="status2">
																   <c:choose>
																   <c:when test="${item2.getD_state()==0 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:otherwise>
																</c:choose>				
															</c:forEach>	                  	
														</div>
													</c:forEach>		
												</div>
											</c:when>
											<c:otherwise>
												<div class="ld-w-c clearfix txShow${statusDy2.index}" id="taoxing"  style="display:none">
													<c:forEach	items="${itemDy2.taoxingList}" var="itemTx" varStatus="statusTx">
														<div class="d-w-c-list">
															<c:forEach	items="${itemTx.shiHaoList}" var="item2" varStatus="status2">
																   <c:choose>
																   <c:when test="${item2.getD_state()==0 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2" onclick="fyChoose(this)">${item2.getD_RoomNo()}</a>
																   </c:otherwise>
																</c:choose>				
															</c:forEach>	                  	
														</div>
													</c:forEach>		
												</div>
											</c:otherwise>
										</c:choose>							
								</c:forEach>
								</div>
							</div>	
						</c:otherwise>
					</c:choose>					
				</c:forEach>
			</div>
	    </div>
	</div>
	
