<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
	<script type="text/javascript">	
	 alreadyBuyCount = ${alreadyBuyCount};//已购买数量	
	 userType='${userType}';
	 setIsTest();
	 DsIsShowDY();
	</script>
	<style type="text/css">body{background-color:#f5f5f5;}</style>
    <script type="text/javascript">
    	var jsonData;
		$(function(){
			$.ajax({
	            url: "/fangyuan/getFangYuanJson.do",
	            type: "post",
	            async: true,
	            dataType: "json",
	            success: function(data) {
	            	jsonData=JSON.stringify(data);
	            	var data=eval('('+JSON.stringify(data)+ ')');
	            	//var data=eval('('+"{loudong:"+JSON.stringify(data)+"}"+ ')');
	            	xuanran(data,dsLoudongIndex,dsDanyuanIndex);
	                $('.yy-w').navbarscroll();
	    			/* $('.d-l-left').navbarscroll();  */
	    			//$(".ldy"+dsDanyuanIndex).addClass("fon");
	    			$(".ldy0").addClass("fon");
	            }
	        });
			/* if(jsonData==null||typeof(jsonData) == 'undefined'){
				$.ajax({
		            url: "/fangyuan/getFangYuanJson.do",
		            type: "post",
		            async: true,
		            dataType: "json",
		            success: function(data) {
		            	jsonData=JSON.stringify(data);
		            	var data=eval('('+JSON.stringify(data)+ ')');
		            	//var data=eval('('+"{loudong:"+JSON.stringify(data)+"}"+ ')');
		            	xuanran(data,dsLoudongIndex,dsDanyuanIndex);
		                $('.yy-w').navbarscroll();
		    			//$('.d-l-left').navbarscroll(); 
		    			$(".ldy"+dsDanyuanIndex).addClass("fon");
		            }
		        });
			}else{
				var data=eval('('+jsonData+')');
				xuanran(data,dsLoudongIndex,dsDanyuanIndex);
                $('.yy-w').navbarscroll();
                $(".ldy"+dsDanyuanIndex).addClass("fon");
    			// $('.d-l-left').navbarscroll();  
				$(".fyShow"+dsLoudongIndex).show().siblings().hide();
    			$(".txShow"+dsDanyuanIndex).show().siblings().hide();
    			updateRoomState(RoomStateData);
			} */
			
		});
		
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
		<div class="b-index-w">
			<div class="dfix">
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
				<div class="sub-dd clearfix" style="height:32px;overflow:hidden;vertical-align:middle;">
					<div class="sub-d-right" style="float:left;background:none;" id="showDjsTime">
						<!-- <div class="subtimer" id="subtimer" style="line-height:32px;padding-top:0px;padding-bottom:0px;">
                              <span class="RemainH Remain">00</span><span class="liksapn">时</span><span class="RemainM Remain">00</span><span class="liksapn">分</span><span class="RemainS Remain">00</span><span class="liksapn" id="ggts2">秒后活动结束!</span>
                        </div>		 -->
					</div>
					<div class="sub-d-left IsTest"  style="border-radius: 3px; margin-top: 5px; background-color: rgb(33, 150, 243);"></div>
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
							<ul class="clearfix" id="dsLouDong">
								<!-- 填充模版 -->
							</ul>
						</div>
					</div>
				</div>
				<div   id="IsShowDY" >

					<!-- 填充模版 -->

				</div>
			</div>
			<div id="commonBody">
				<div id="IsShowFangYuan">
					<!-- 填充模版 -->		
				</div>
	    </div>
	</div>
	<script id="loudong" type="text/html">
        {{each loudong value key}}
					{{if key==dsLoudongIndex}}             
                    <li><a href="javascript:void(0);"  index="{{key}}" id="ldIndex{{key}}" onclick="ldChoose(this);" class="lon">{{value.name}}</a></li>              													
	                {{else}}
                    <li><a href="javascript:void(0);"  index="{{key}}" id="ldIndex{{key}}" onclick="ldChoose(this);">{{value.name}}</a></li>              													
					{{/if}}			
		{{/each}}  
	</script>
	<script id="danyuan" type="text/html">
        {{each loudong value key}}
                                {{if key==dsLoudongIndex}}
									<div  class="d-l-w dyShow{{key}}" >
										<div class="swiper-containerq3">
											<div class="swiper-wrapper">
                                                {{include 'danyuan1' value}}
											</div>
										</div>
									</div>                              
								{{/if}}	
        {{/each}}
</script>
<script id="danyuan1" type="text/html">
    {{each danyuanList value key}}      
			<a href="javascript:void(0);" class="ldy{{key}} swiper-slide" index="{{key}}" onclick="dyChoose(this);" >{{value.name}}</a>             					                                               
    {{/each}}
</script>
	<script id="test1" type="text/html">
    {{each loudong value key}}
            {{if key==dsLoudongIndex}}
                    <div  class="danyuan fyShow{{key}}">
                        <div>
                                {{include 'test2' value}}
                        </div>
                    </div>	
            {{else}}
                    <div  class="danyuan fyShow{{key}}" style="display:none">
                        <div>
                                {{include 'test2' value dsDanyuanIndex}}
                        </div>
                    </div>	
            {{/if}}					
    {{/each}}
</script>
<script id="test2" type="text/html">
    {{each danyuanList value key}}
        {{if key==0}}
			<div class="ld-w-c clearfix txShow{{key}}"  style="background:#f6f6f6;">
                {{include 'test3' value}}	
			</div>
        {{else}}
			<div class="ld-w-c clearfix txShow{{key}}"   style="background:#f6f6f6;display:none">
                {{include 'test3' value}}	
			</div>
        {{/if}}								
    {{/each}}	
</script>
<script id="test3" type="text/html">
    {{each taoxingList value key}}
		
                {{include 'test4' value}}												                 	
		
    {{/each}}		
</script>
<script id="test4" type="text/html">
<div class="d-w-c-list">
    {{each shiHaoList value key}}
			{{if key<roomLine}}
           		{{include 'test5' value}}
			{{/if}}	
    {{/each}}
</div>	                
<div class="d-w-c-list">
    {{each shiHaoList value key}}
			{{if key>=roomLine}}
           		{{include 'test5' value}}
			{{/if}}	
    {{/each}}
</div>	                
</script>
<script id="test5" type="text/html">
            {{if D_state=='0' && (D_Monitor=='0' || D_Monitor=='1')}}
                 <a href="javascript:void(0);" id="Room{{D_ID}}" rid="{{D_ID}}" rstate="{{D_state}}" mstate="{{D_Monitor}}" class="sh lda0" onclick="fyChoose(this)">{{D_RoomNo}}</a>
            {{else if D_state=='1' && (D_Monitor=='0' || D_Monitor=='1')}}
                 <a href="javascript:void(0);" id="Room{{D_ID}}" rid="{{D_ID}}" rstate="{{D_state}}" mstate="{{D_Monitor}}" class="sh lda1" onclick="fyChoose(this)">{{D_RoomNo}}</a>
            {{else if D_state=='2' && (D_Monitor=='0' || D_Monitor=='1')}}
                 <a href="javascript:void(0);" id="Room{{D_ID}}" rid="{{D_ID}}" rstate="{{D_state}}" mstate="{{D_Monitor}}" class="sh lda2" onclick="fyChoose(this)">{{D_RoomNo}}</a>
            {{else if D_Monitor=='2'}}
                 <a href="javascript:void(0);" id="Room{{D_ID}}" rid="{{D_ID}}" rstate="{{D_state}}" mstate="{{D_Monitor}}" class="sh lda1" onclick="fyChoose(this)">{{D_RoomNo}}</a>
            {{else}}
                <a href="javascript:void(0);" id="Room{{D_ID}}" rid="{{D_ID}}" rstate="{{D_state}}" mstate="{{D_Monitor}}" class="sh lda2" onclick="fyChoose(this)">{{D_RoomNo}}</a>        
            {{/if}}					 	                
</script>
<script id="showDjsTime2" type="text/html">
	 {{if IsShowDjsTime=='0'}}
     <div class="subtimer" id="subtimer" style="display:none;">
								  <span class="RemainH Remain">00</span><span class="liksapn">时</span><span class="RemainM Remain">00</span><span class="liksapn">分</span><span class="RemainS Remain">00</span><span class="liksapn" id="ggts2">秒后活动结束!</span>
							</div>		
    {{else}}
	<div class="subtimer" id="subtimer" style="line-height:32px;padding-top:0px;padding-bottom:0px;">
								  <span class="RemainH Remain">00</span><span class="liksapn">时</span><span class="RemainM Remain">00</span><span class="liksapn">分</span><span class="RemainS Remain">00</span><span class="liksapn" id="ggts2">秒后活动结束!</span>
							</div>		
	</div>
 	{{/if}}
</script>
<script>
		function xuanran(data,ldIndex,dyIndex){
			 var dsData={
				dsLoudongIndex:ldIndex,
				loudong:data
			 };
			 var html1 = template('loudong', dsData);
		     document.getElementById('dsLouDong').innerHTML = html1;
		     var html2 = template('danyuan', dsData);
		     document.getElementById('IsShowDY').innerHTML = html2; 
		     var html3 = template('test1', dsData);
		     document.getElementById('IsShowFangYuan').innerHTML = html3;
		     //$('.d-l-left').navbarscroll();
		     dyScroll();
		     swiperHangye.slideTo(dyIndex);//移动到可视范围
		     
		     	var dsData1={
		 				IsShowDjsTime:IsShowDjsTime
				 };
				 var htmlshowDjsTime = template('showDjsTime2', dsData1);
			     document.getElementById('showDjsTime').innerHTML = htmlshowDjsTime;
		} 
		//单元重新渲染
		function xuanranDy(data,ldIndex,dyIndex){
			 var dsData={
						dsLoudongIndex:ldIndex,
						dsDanyuanIndex:dyIndex,
						loudong:data
					 };
			 var html2 = template('danyuan', dsData);
		     document.getElementById('IsShowDY').innerHTML = html2; 
		     dyScroll();//绑定滚动
		     $(".ldy"+dyIndex).addClass("fon");
		}
		var  swiperHangye;
		function dyScroll(){
			    swiperHangye = new Swiper('.swiper-containerq3', {
				paginationClickable: true,
				spaceBetween: 7,
				freeMode: true,
				loop: false,
				slidesPerView: 'auto',
				//loopedSlides: 0
				
			});
			 $(".swiper-containerq3 a").click(function(){
				$(this).addClass('fon').siblings().removeClass('fon');
				var index = $(this).index();
				swiperHangye.slideTo(index);
			});
		}
</script>
