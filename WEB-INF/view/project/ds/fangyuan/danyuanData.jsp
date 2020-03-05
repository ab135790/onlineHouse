<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
				<div class="d-l-w">
					<div class="d-l-left clearfix" id="danyuan2">
						<c:forEach	items="${danyuan}" var="item" varStatus="status">
							<c:choose>
								<c:when test="${status.index==0}">
									<a href="#" class="dua don" >${item.name}</a>
			  					</c:when>
			  					<c:otherwise>
			  						<a href="#" class="dua">${item.name}</a>
			  					</c:otherwise>
							</c:choose>							
						</c:forEach>
					</div>
					
				</div>
				<div class="ld-w-c clearfix" id="taoxing">
					<c:forEach	items="${danyuan.get(0).taoxingList}" var="item" varStatus="status">
						<div class="d-w-c-list">
							<c:forEach	items="${item.shiHaoList}" var="item2" varStatus="status2">
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
			