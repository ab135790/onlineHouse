<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
				<div class="fy-sm clearfix">
					<span class="fysp spcor1"></span>
					<span class="spansep">已售</span>
					<span class="fysp spcor2"></span>
					<span class="spansep">未售</span>
					<span class="fysp spcor3"></span>
					<span class="spansep">订购中</span>
				</div>
				<div class="f-l-w">
					<div class="f-l-left clearfix" id="loudong2">
					<c:forEach	items="${loudong}" var="item" varStatus="status">
						<c:choose>
		  					<c:when test="${status.index==ldIndex}">
								<a href="#" class="pua lon" index="${status.index}">${item.name}</a>
		  					</c:when>
		  					<c:otherwise>
		  						<a href="#" class="pua" index="${status.index}">${item.name}</a>
		  					</c:otherwise>
		  				</c:choose>						
					</c:forEach>
					</div>
				</div>
				<div>
				<c:forEach	items="${loudong}" var="item" varStatus="status">
					<c:choose>
		  				<c:when test="${status.index==ldIndex}">
							<div id="danyuan" class="danyuan dyShow${status.index}">
								<div class="d-l-w">
									<div class="d-l-left clearfix" id="danyuan2">
										<c:forEach	items="${item.danyuanList}" var="itemDy" varStatus="statusDy">
											<c:choose>
												<c:when test="${statusDy.index==dyIndex}">
													<a href="#" class="dua don" index="${statusDy.index}">${itemDy.name}</a>
												</c:when>
												<c:otherwise>
													<a href="#" class="dua" index="${statusDy.index}">${itemDy.name}</a>
												</c:otherwise>
											</c:choose>							
										</c:forEach>
									</div>
								</div>
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
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
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
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
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
							<div id="danyuan" class="danyuan dyShow${status.index}" style="display:none">
								<div class="d-l-w">
									<div class="d-l-left clearfix" id="danyuan2">
										<c:forEach	items="${item.danyuanList}" var="itemDy" varStatus="statusDy">
											<c:choose>
												<c:when test="${statusDy.index==0}">
													<a href="#" class="dua don" index="${statusDy.index}">${itemDy.name}</a>
												</c:when>
												<c:otherwise>
													<a href="#" class="dua" index="${statusDy.index}">${itemDy.name}</a>
												</c:otherwise>
											</c:choose>							
										</c:forEach>
									</div>
								</div>
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
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
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
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda0">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==1 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_state()==2 && (item2.getD_Monitor()==0 || item2.getD_Monitor()==1)}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:when test="${item2.getD_Monitor()==2}">
																		<a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda1">${item2.getD_RoomNo()}</a>
																   </c:when>
																   <c:otherwise>
																	   <a href="javascript:void(0);" id="Room${item2.getD_ID()}" rid="${item2.getD_ID()}" rstate="${item2.getD_state()}" mstate="${item2.getD_Monitor()}" class="sh lda2">${item2.getD_RoomNo()}</a>
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