<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<script type="text/javascript">
alreadyBuyCount = ${alreadyBuyCount};//已购买数量	
userType='${userType}';
setIsTest();
$(function(){
	 moveid=-1;
	 $.post("/shoucang/indexDataJson.do",
			   function(data){
		       	shoucangXuanranZong(data)
			   }, "json");
			
});
</script>
<style  type="text/css">body{background:#ffffff;}</style>
		<div class="b-index-w">
			<div class="dfix" style="padding-top:48px;height:auto;">
				<nav class="menunav">
					<div class="menunav-w">
						<div class="nav-list" id="lookFangYuan">
						  <a href="javascript:void(0);" onclick="lookFangYuan()" ><p class="f-n1"></p><span class="f-n-name">车位列表</span></a>
						</div>
						<div class="nav-list  navon" id="lookShouCang">
						  <a href="javascript:void(0);"  onclick="lookShouCang()" ><p class="f-n3"></p><span class="f-n-name">我的收藏</span></a>
						</div>
						<div class="nav-list" id="lookDingDan">
						  <a href="javascript:void(0);"  onclick="lookDingDan()" ><p class="f-n2"></p><span class="f-n-name">我的订单</span></a>
						</div>
						
					</div>
				</nav>							
			</div>
					<div class="sub-dd clearfix" style="height:32px;overflow:hidden;vertical-align:middle;">
						<div class="sub-d-right" style="float:left;background:none;" id="showDjsTime">
							<!-- <div class="subtimer" id="subtimer"  style="line-height:32px;padding-top:0px;padding-bottom:0px;">
								  <span class="RemainH Remain">00</span><span class="liksapn">时</span><span class="RemainM Remain">00</span><span class="liksapn">分</span><span class="RemainS Remain">00</span><span class="liksapn" id="ggts2">秒后活动结束!</span>
							</div>		 -->				
						</div>
						<div class="sub-d-left IsTest"  style="border-radius: 3px; margin-top: 5px; background-color: rgb(33, 150, 243);"></div>
                        
					</div>
                   <!--  <div class="ts-w">
                        <span>还可收藏<strong id="syNum">8</strong>套</span>
                    </div> -->
					
			<div id="commonBody">
					<%-- <div class="ts-w">
					<img src="${project}/ds/images/tsdec.png"><span>您还可以收藏<strong id="syNum">${syNum}</strong>个车位</span>
				</div>
				<div class="b-sc-w" id="shoucangList">
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
				</div>--%>
	    </div>
	</div>
<script id="commonBody1" type="text/html">
				<div class="ts-w">
					<span>您已收藏<strong id="syNum">{{length}}</strong>个车位,还可收藏<strong id="syNum">{{syNum}}</strong>个车位</span>
				</div>				
				<div class="b-sc-w" id="shoucangList">
                  {{each list value key}}
				    <div class="fborder"></div>
					<div class="sc-w-list" id="shoucang_{{value.D_ID}}">
						<div class="sc-w-wrap clearfix">
							<div class="dd-w-w-left">
								<span class="spanft">{{key+1}}</span>
								<span class="spanff">{{value.D_BanName}}-{{value.D_Unit}}-{{value.D_RoomNo}}</span>
							</div>
							<div class="dd-w-w-right"><a  href="javascript:void(0);" onclick="del({{value.D_ID}},{{value.sort}})"><img src="/project/ds/images/dcclosed.png?v=1.0"></a></div>
						</div>
						<div class="dd-w-cont clearfix">
						 <a  href="javascript:void(0);" id="href_{{value.D_ID}}"  d_monitor="{{value.D_Monitor}}"  onclick="lookDetail({{value.D_ID}},'{{value.D_state}}','{{value.D_Monitor}}')" >
							<div class="dd-w-wt">
								<div class="dd-w-listt clearfix">
									<div class="d-w-list-left">线上总价：</div>
									{{if showPrice=="1"}}
											<div class="d-w-list-left">￥{{value.D_Total}}元</div>
										{{else}}
											<div class="d-w-list-left">￥*******元</div>
										{{/if}}
								</div>
								
								<div class="dd-w-listt clearfix">
									<div class="d-w-list-left">收藏人数：</div>
									<div class="d-w-list-left">{{value.sumCollectionCount}}</div>
								</div>
								{{if value.D_state=='2' || value.D_Monitor=='3'|| value.D_Monitor=='4'}}
									<div class="ysc" id="ysc_{{value.D_ID}}" style="display:block">
									   <img src="/project/ds/images/ysc.png"/>
									</div>
									{{else if  value.D_state=='1' || value.D_Monitor=='2'}}
									<div class="ysc" id="ysc_{{value.D_ID}}" style="display:block">
									   <img src="/project/ds/images/ysc-z.png"/>
									</div>
									{{else}}
									<div class="ysc" id="ysc_{{value.D_ID}}" style="display:none">
									   <img src="/project/ds/images/ysc.png"/>
									</div>
									{{/if}}
							</div>
							</a>
							<div class="b-scinfo">							
 								{{if key!=0}}
									<a  href="javascript:void(0);" class="ado2" onclick="dtop({{value.D_ID}},0,{{value.sort}})"><img src="/project/ds/images/dtop.png?v=1.0"></a>
								 {{/if}}	
								{{if key+1!=length}}
									<a  href="javascript:void(0);" class="ado1" onclick="down({{value.D_ID}},1,{{value.sort}})"><img src="/project/ds/images/down.png?v=1.0"></a>
								{{/if}}									
							</div>
						</div>						
					</div>	
					
				  {{/each}}
				</div>
</script>
<script id="showDjsTime2" type="text/html">
	 {{if IsShowDjsTime=='0'}}
     <div class="subtimer" id="subtimer"  style="display:none;">
								  <span class="RemainH Remain">00</span><span class="liksapn">时</span><span class="RemainM Remain">00</span><span class="liksapn">分</span><span class="RemainS Remain">00</span><span class="liksapn" id="ggts2">秒后活动结束!</span>
							</div>			
    {{else}}
	<div class="subtimer" id="subtimer"  style="line-height:32px;padding-top:0px;padding-bottom:0px;">
								  <span class="RemainH Remain">00</span><span class="liksapn">时</span><span class="RemainM Remain">00</span><span class="liksapn">分</span><span class="RemainS Remain">00</span><span class="liksapn" id="ggts2">秒后活动结束!</span>
							</div>		
 	{{/if}}
</script>
<script>
		function shoucangXuanRan(syNum,list,length,showPrice){			
			 var dsData={
					 syNum:syNum,
				     list:list,
				     length:length,
				     showPrice:showPrice
			 };			 
			 console.log(dsData);
			 var commonBody1 = template('commonBody1', dsData);
		     document.getElementById('commonBody').innerHTML = commonBody1;
			// alert(moveid+'='+$('#shoucang_'+moveid).length);
			 if(moveid!=-1){
				 //$('#shoucang_'+moveid).css('backgroundColor','#f8e7e6').animate({'backgroundColor':'#FF0000'},1000).stop(true,true);
				 $('#shoucang_'+moveid).hide().show(1000);
			 }
			// $("#syNum").html(syNum);	
			 var dsData1={
		 				IsShowDjsTime:IsShowDjsTime
				 };
				 var htmlshowDjsTime = template('showDjsTime2', dsData1);
			     document.getElementById('showDjsTime').innerHTML = htmlshowDjsTime;
		}   
</script>	