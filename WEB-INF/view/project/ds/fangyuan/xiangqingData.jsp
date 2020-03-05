<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<script type="text/javascript">
 //var fyId=${fangyuan.getD_ID()};
 var fyId=0;
 // CollectionCount =${CollectionCount};//收藏上限
 szIds='[${szIds}]';//已经收藏的房源id
 //szIds='[]';//已经收藏的房源id
 //var userShowPrice='0';
 var fangyuan; 
$(function(){	
	 $.post("/fangyuan/xiangqingDataJson.do", {"id":${id}},
			   function(data){
			     fangyuan = eval('(' + data.fangyuan+ ')');
			     fyId=fangyuan.D_ID;
			     userShowPrice=data.UserShowPrice;
			     szIds = eval('('+data.szIds+ ')');
			     var user = data.user;
			     xqxuanran(fangyuan,user,timeState,userShowPrice,HouseName);
			     showModelPic(fangyuan.D_HouseModel);
			     showSczt();
			     getFjxq();
			   }, "json");
			
});
var fyHtmlText;
function getFjxq(){
	if(fyHtmlText==null||typeof(fyHtmlText) == 'undefined'){
	 $.post("/common/getHtmlText.do", {"name":"房间详情"},
			   function(data){
			     fyHtmlText = data.result;
			     showFjxq(fyHtmlText);
			   }, "json");			
	}else{
		showFjxq(fyHtmlText);
	}
}
function showFjxq(html){
	 var str = Base64decode(html);
	// console.log(str);
     str=str.replace("[楼栋]",fangyuan.D_BanName);
     str=str.replace("[单元]",fangyuan.D_Unit);
     str=str.replace("[室号]",fangyuan.D_RoomNo);
     if(IsShowPrice==='0'){
    	 if(userShowPrice==='1'){
    		 str=str.replace("[原单价]",fangyuan.D_Price);     		 
    		 str=str.replace("[原总价]",fangyuan.D_Total);  
    		 str=str.replace("[优惠单价]",fangyuan.D_discountPrice);  
    		 str=str.replace("[优惠总价]",fangyuan.D_discountTotal);  
    	 }else{
    		 str=str.replace("[原总价]","******"); 
    		 str=str.replace("[优惠单价]","******");  
    		 str=str.replace("[优惠总价]","******");  
    		 str=str.replace("[原单价]","******");  
    	 }
     }else{
    	 str=str.replace("[原单价]",fangyuan.D_Price);     		 
		 str=str.replace("[原总价]",fangyuan.D_Total);  
		 str=str.replace("[优惠单价]",fangyuan.D_discountPrice);  
		 str=str.replace("[优惠总价]",fangyuan.D_discountTotal);     	 
     }
     str=str.replace("[面积]",fangyuan.D_FloorArea);
     str=str.replace("[房间类型]",fangyuan.D_RoomType);
     str=str.replace("[朝向]",fangyuan.D_position);
     str=str.replace("[套内面积]",fangyuan.D_InnerArea);
     $("#fjHtml").html(str);
}

function showSczt(){
	console.log(szIds);
	console.log(fangyuan.D_ID);
 if(szIds.indexOf(${id})!=-1){
	 $("#scimg").removeClass("csimhg").addClass("csimhgg");
	 // $(".fy-c-right").css("background-image", "url('${project}/ds/images/sc-hover.png')");
    /*  $(".scSpan").css("background-image", "url('${project}/ds/images/sc2-hover.png')"); */
    // $(".scSpan").html("取消");
 }
}
function showModelPic(model){
	$("#modelPic").attr("src",imageServer+"/UpLoad/"+imageFolder+"/"+model+".jpg?v="+staticVersion);	
}
function showImgModel(model){
		wx.previewImage({
		    current: 'http://47.99.99.232:80/UpLoad/'+imageFolder+'/'+model+'.jpg?v='+staticVersion, // 当前显示图片的http链接
		    urls: ['http://47.99.99.232:80/UpLoad/'+imageFolder+'/'+model+'.jpg?v='+staticVersion] // 需要预览的图片http链接列表
		});
	}
 function updateRoomCollectionCount(objs){
	 objs.forEach((t, i) => {					
			  if(t.D_ID==fyId){
				  var count = parseInt(t.E_CollectionCount)+parseInt(t.D_CollectionCount);
				  //var count = t.E_CollectionCount+t.D_CollectionCount;
				 /*  console.log("ec="+t.ec);
				  console.log("dc="+t.dc); */
				  $("#shouCangCount").html(count);//更新收藏							 
			  }		  					  				           
   });
}  
	function zhongzhuan(msg){
		 //console.log(msg);
		 var json = JSON.parse(msg);
		 var code = json.code;
		 if(code==="000"){
			 //console.log(json.result);
		 }else if(code==="001"){
			 //console.log(json.result);
			 //updateRoomState(json.result);
			 if(typeof updateRoomState != 'undefined' && updateRoomState instanceof Function){				 
				/* RoomStateData =json.result;
				 updateRoomState(json.result);	*/
				 //console.log(json.result.time);
				 localStorage.setItem("ServerTime",json.result.time);
				 RoomStateData =json.result.room;
				 updateRoomState(json.result.room);				 
			 }
			 if(typeof updateRoomCollectionCount != 'undefined' && updateRoomCollectionCount instanceof Function){
				 /*updateRoomCollectionCount(json.result);	*/			 
				 updateRoomCollectionCount(json.result.room);				 
			 }
			 
			/* if(typeof countTime != 'undefined' && countTime instanceof Function){
				 countTime(json.result.time);//推送服务器时间
			 }
			 if(typeof daojs != 'undefined' && daojs instanceof Function){
				 daojs(json.result.time);
			 }*/
		 }else if(code==="002"){
			 //localStorage.removeItem("whoareyou");
			 houseStateControl(json.result);
		 }else if(code==="003"){
			 if(typeof userGetOut != 'undefined' && userGetOut instanceof Function){
				 localStorage.removeItem("whoareyou");
				 localStorage.removeItem("tyc");
				 userGetOut(json.result);				 
			 }
		 }else if(code==="004"){
			/* if(typeof countTime != 'undefined' && countTime instanceof Function){
				 countTime(json.result);//推送服务器时间
			 }
			 if(typeof daojs != 'undefined' && daojs instanceof Function){
				 daojs(json.result);
			 }*/
			 if(typeof userGetOut != 'undefined' && userGetOut instanceof Function){
				 localStorage.removeItem("whoareyou");
				 localStorage.removeItem("tyc");
				 console.log("哈哈。。来喝我啊");
				 userGetOut(json.result);
			 }
		 }else if(code==="005"){
			 console.log(json.result);//配置信息
			 var data = json.result;
			 StartTime=data.StartTime.replace(/\-/g, "/");
			 ShoppingTime=parseInt(data.ShoppingTime)*60;
			 CountDownTime=parseInt(data.CountDownTime)*60;
			 alreadyBuyCount=0;
			 yzType=data.IsShowYZMorSFZ;
			 LoginTest=data.LoginTest;
			 IsTest =data.IsTest;
			 CollectionCount=data.CollectionCount;
			 IsShowYHGS=data.IsShowYHGS;
			 staticVersion=data.staticVersion;
			 IsShowDY=data.IsShowDY;
			 IsAllowChongFuBuy=data.IsAllowChongFuBuy;
			 localStorage.removeItem("openYhgs");
			 houseState=data.State;
			 IsShowPrice=data.IsShowPrice;
			 IsShowDjsTime=data.IsShowDjsTime;
			/* localStorage.removeItem("whoareyou");
			 localStorage.removeItem("tyc");*/
		 }else if(code==="006"){
			 localStorage.setItem("ServerTime",json.result);			 	
		 }else if(code==="007"){
			     if(typeof updateRoomState != 'undefined' && updateRoomState instanceof Function){				 
			    	 updateRoomState(json.result);				 
				 }
				 if(typeof updateRoomCollectionCount != 'undefined' && updateRoomCollectionCount instanceof Function){
					 console.log(json.result);
					 updateRoomCollectionCount(json.result);				 
				 }			 	
		 }
	}
</script>
		<div class="b-index-w" style="padding-top:48px;padding-bottom:48px;">
			<nav class="menunav">
				<div class="menunav-w">
					<div class="nav-list navon" >
					  <a href="javascript:void(0);" onclick="lookFangYuan()" ><p class="f-n1"></p><span class="f-n-name">车位列表</span></a>
					</div>
					<div class="nav-list" >
					  <a href="javascript:void(0);"  onclick="lookShouCang()" ><p class="f-n3"></p><span class="f-n-name">我的收藏</span></a>
					</div>
					<div class="nav-list" >
					  <a href="javascript:void(0);"  onclick="lookDingDan()"  ><p class="f-n2"></p><span class="f-n-name">我的订单</span></a>
					</div>					
				</div>
			</nav>					
			<div id="commonBody">
			<!-- 图片 -->
			<div class="swiper-container" style="margin-top:.5rem;">
				<div class="swiper-wrapper" id="showModelImg">
					<!-- <div class="swiper-slide"><img id="modelPic"  style="width: 100%;" onclick="showImgModel()"></div>	 -->				
				</div>
				<div class="swiper-pagination"></div>
			 </div>
			<!-- 标题与收藏 -->
			<div class="fy-c-w clearfix" id="showTitleSc">
				<%-- <div class="fy-c-left">
					<p class="c-left-name1">${fangyuan.getD_BanName()}-${fangyuan.getD_Unit()}-${fangyuan.getD_RoomNo()}</p>
				</div>
				<div class="fy-c-right">
					<p id="shouCangCount">${fangyuan.getD_CollectionCount()+fangyuan.getE_CollectionCount()}</p>
				</div> --%>
			</div>
			<!-- 详情 -->
			<div class="p-w-l" id="fjHtml">
				
			</div>
			<!--选择  -->
			<div class="b_buttons clearfix">
				<a href="javascript:void(0);" class="buttons3" id="shoucang" onclick="shoucang()">
					<p class="csimhg" id="scimg"></p>
					<span class="scSpan">收藏</span>
				</a>
				<div id="gouBuyChoose">
				<%-- <c:choose>
                           <c:when test="${startColor=='0'}">
								<button onclick="showSure()" id="dsDjs${fangyuan.getD_ID()}" rstate="${fangyuan.getD_state()}"  mstate="${fangyuan.getD_Monitor()}"  class="djs" style="background-color:#C0C0C0">活动还未开始!</button>
                           </c:when>
                           <c:otherwise>
                           		<c:choose>
                           		  	<c:when test="${yudingColor=='1'}">
                           		  		<button onclick="showSure()" id="dsDjs${fangyuan.getD_ID()}" rstate="${fangyuan.getD_state()}"  mstate="${fangyuan.getD_Monitor()}"  class="djs" style="background-color:#C0C0C0">预定中</button>
                           		  	</c:when>
                           		  	<c:otherwise>
                           				<button onclick="showSure()" id="dsDjs${fangyuan.getD_ID()}" rstate="${fangyuan.getD_state()}"  mstate="${fangyuan.getD_Monitor()}"  class="djs" >立即选择</button>                           		  	
                           		  	</c:otherwise>
                           		</c:choose>
                           </c:otherwise>
				</c:choose> --%>
				</div>
			</div>
			<!-- 选择按钮  -->
			 <!--弹出确认内容-->
			 <div id="J-alert" style="display:none">
			 	<%-- <div class="i-dc-w" style="padding-bottom:15px;">
					<h3 class="h33">确认订单(<span class="yydjs">60秒</span>)</h3>
					<div class="dd-w-cont">
						<div class="dd-w-w ddd-w">
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
						<div class="dd-w-w ddd-w">
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">客户：</div>
								<div class="d-w-list-left">${user.realName}</div>
							</div>
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">手机号码：</div>
								<div class="d-w-list-left">${user.userName}</div>
							</div>
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">身份证号：</div>
								<div class="d-w-list-left">${user.userCode}</div>
							</div>							
						</div>
						<div class="dd-w-w ddd-w">
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left" style="padding-right:8px;">
								<input type="checkbox"   style="display:none;opacity:1;width:16px;height:16px;" onchange="agreeYNdo(this)" checked="true" />
								</div>
								
								<div class="d-w-list-left d-w-list-left-margin">本人已阅读并同意微信选房须知</div>
							</div>
						</div>
						<div class="s_buttons clearfix">
							<a href="javascript:void(0);" class="buttons5" onclick="closeSure()">取消</a>
							<button class="buttons6 buy" onclick="goBuy(${fangyuan.getD_ID()})" id="buy">确认</button>
						</div>
					</div>
				</div> --%>
			</div>
			 <!--弹出框结束 -->
			 <!--弹出内容结束 失败弹窗-->
			 <div id="buyFail" style="display:none">
				 <div class="i-dc-w" style="padding-bottom:15px;">
					<h3 class="h33">提示</h3>
					<div class="cc-w-cont">
						<div class="fyyz">车位已被他人选中，请重新选择其他车位</div>
						 <p class="btfyp1" style="font-size:1.4rem;text-align:center;color:#888888;padding:0 0 10px 0;">下一个意向车位</p>
						<a class="btfy" style="background:#ee0000;color:#ffffff;height:46px;line-height:46px;padding:0px;" href="javascript:void(0);" onclick="goNextyxfy()">
							<p class="btfyp2" id="nextYxfy" style="color:#ffffff;font-size:2.2rem">1-1-1</p>
							<p style="display:none" id="fyid"></p>
						</a>
						<div class="dc-btn">
							<a href="javascript:void(0);" onclick="returnFangYuan()" style="background:#fa4e2a;color:#ffffff;">返回我的车位列表</a>
							<a href="javascript:void(0);" onclick="returnShouCang()" style="background:#2a7dd2;color:#ffffff;">返回我的收藏</a>
						</div>
					</div>
				</div>
			</div>
			<!--失败结束  -->	
			</div>	
	    </div>
<script id="showModelImg1" type="text/html">
   <div class="swiper-slide"><img id="modelPic"  style="width: 100%;" onclick="showImgModel('{{fangyuan.D_HouseModel}}')"></div>	
</script>		
<script id="showTitleSc1" type="text/html">
   				<div class="fy-c-left" style="width:65%;">
					<p class="c-left-name1">{{fangyuan.D_BanName}}-{{fangyuan.D_Unit}}-{{fangyuan.D_RoomNo}}</p>
				</div>
				<div class="fy-c-right clearfix" style="width:35%;">
					<p><span style="color:#000;font-weight:normal;">收藏人数：</span></p><p  style="/*padding-top:1px;*/" id="shouCangCount">{{dcec}}</p>
				</div>	
</script>		
<script id="gouBuyChoose1" type="text/html">
		{{if timeState=='2'}}
			<button onclick="showSure()" id="dsDjs{{fangyuan.D_ID}}" rstate="{{fangyuan.D_state}}"  mstate="{{fangyuan.D_Monitor}}"  class="djs" style="background-color:#888888">还有0时0分0秒开始</button>
 		{{else}}
			{{if fangyuan.D_state=='1' || fangyuan.D_Monitor=='2'}}
				<button onclick="showSure()" id="dsDjs{{fangyuan.D_ID}}" rstate="{{fangyuan.D_state}}"  mstate="{{fangyuan.D_Monitor}}"  class="djs" style="background-color:#888888">正被他人认购中</button>
			{{else if fangyuan.D_state=='2' || fangyuan.D_Monitor=='3'|| fangyuan.D_Monitor=='4'}}
				<button onclick="showSure()" id="dsDjs{{fangyuan.D_ID}}" rstate="{{fangyuan.D_state}}"  mstate="{{fangyuan.D_Monitor}}"  class="djs" style="background-color:#888888">已售出</button>
			{{else}}
				<button onclick="showSure()" id="dsDjs{{fangyuan.D_ID}}" rstate="{{fangyuan.D_state}}"  mstate="{{fangyuan.D_Monitor}}"  class="djs" >立即选购</button>
			{{/if}}
		{{/if}}  				
</script>		
<script id="J-alert1" type="text/html">
		<div class="i-dc-w" style="padding-bottom:15px;">
					<h3 class="h33">确认订单</h3>
					<div class="dd-w-cont qrdd">
						<div class="dd-w-w ddd-w">
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left"></div>
								<div class="d-w-list-left" style="color:#888888">{{HouseName}}</div>
							</div>
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left"></div>
								<div class="d-w-list-left">{{fangyuan.D_BanName}}-{{fangyuan.D_Unit}}-{{fangyuan.D_RoomNo}}</div>
							</div>
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">表价：</div>
								{{if showPrice=="1"}}
										<div class="d-w-list-left">￥{{fangyuan.D_Total}}元</div>
								{{else}}
										<div class="d-w-list-left">￥*******元</div>
                                 {{/if}}
							</div>	
							
						</div>
						<div class="dd-w-w ddd-w">
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">类型：</div>
								<div class="d-w-list-left">{{fangyuan.D_RoomType}}</div>
							</div>
						</div>
						<div class="dd-w-w ddd-w">
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">姓名：</div>
								<div class="d-w-list-left">{{user.realName}}</div>
							</div>
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">身份证号：</div>
								<div class="d-w-list-left">{{user.userCode}}</div>
							</div>							
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left">手机号码：</div>
								<div class="d-w-list-left">{{user.userName}}</div>
							</div>
						</div>
						<div class="dd-w-w ddd-w">
							<div class="dd-w-list clearfix">
								<div class="d-w-list-left" style="padding-right:8px;">
								<img style="position:relative;top:-2px;" isck='1' src="/project/ds/images/dddefuault.png?r=0.0929" onclick="agreeYNdo(this);" />
								<!--<input type="checkbox" id="agreeYN" style="opacity:1;width:16px;height:16px;display;none;" onchange="agreeYNdo()" checked="true" />-->
								</div>
								<div class="d-w-list-left d-w-list-left-margin">本人已阅读并同意活动协议</div>
							</div>
						</div>
						<div class="s_buttons clearfix">
							<a href="javascript:void(0);" class="buttons5" onclick="closeSure()">取消(<span class="yydjs">{{djsSecond}}</span>)</a>
							<button class="buttons6 buy" onclick="goBuy({{fangyuan.D_ID}})" id="buy">确认</button>
						</div>
					</div>
				</div>			
</script>	
<script>
		function xqxuanran(fangyuan,user,timeState,userShowPrice,HouseName){
			 var dc = fangyuan.D_CollectionCount;
			 var ec = fangyuan.E_CollectionCount;
			 var dcec = Number(dc)+Number(ec);
			 var showPrice="0";
			 var djsSecond = ExpiredCycle;
			 if(IsShowPrice==='0'){
		    	 if(userShowPrice==='1'){
		    		 showPrice="1";  
		    	 }else{
		    		 showPrice="0";
		    	 }
		     }else{
		    	 showPrice="1";     	 
		     }
			 
			 var dsData={
				fangyuan:fangyuan,
				user:user,
				timeState:timeState,
				dcec:dcec,
				showPrice:showPrice,
				HouseName:HouseName,
				djsSecond:djsSecond
			 };
			 var showModelImg1 = template('showModelImg1', dsData);
		     document.getElementById('showModelImg').innerHTML = showModelImg1;
		     var showTitleSc1 = template('showTitleSc1', dsData);
		     document.getElementById('showTitleSc').innerHTML = showTitleSc1;
		     var gouBuyChoose1 = template('gouBuyChoose1', dsData);
		     document.getElementById('gouBuyChoose').innerHTML = gouBuyChoose1;
		     var Jalert1 = template('J-alert1', dsData);
		     document.getElementById('J-alert').innerHTML = Jalert1;
		}   
</script>	