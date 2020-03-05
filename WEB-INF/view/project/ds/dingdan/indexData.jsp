<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<script type="text/javascript">
$(function(){	
	 $.post("/dingdan/indexDataJson.do",
			   function(data){
		 		var fangyuan = null;
		 	    if(data.fangyuan!=""){
			    	fangyuan = eval('(' + data.fangyuan+ ')');		 	    	
		 	    }
		 	   var user=null;
		 	    if(data.user !=""){
			    	user=eval('(' + data.user+ ')');		 	    	
		 	    }
			    var xfcgwzHtml=data.xfcgwzHtml;
			    var UserShowPrice =data.UserShowPrice;
			    dingdanXuanRan(fangyuan,user,HouseName,UserShowPrice);
			    showXfcgwzHtml(xfcgwzHtml);
			   }, "json");
			
});


function showXfcgwzHtml(html){
	var str = Base64decode(html);
	$("#xfcgwzHtml").html(str);
}
</script>
		<div class="b-index-w">
			<div class="dfix" style="padding-top:48px;height:auto;">
				<nav class="menunav">
					<div class="menunav-w">
						<div class="nav-list" id="lookFangYuan">
						  <a href="javascript:void(0);" onclick="lookFangYuan()" ><p class="f-n1"></p><span class="f-n-name">车位列表</span></a>
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
	
	        </div>
	</div>
<script id="MyDingDan" type="text/html">
				{{if haveDingDan=='1'}}
				<div style="background:#fbf6ed;text-align:center;padding-top:8px;"><img style="width:10%;" src="/project/ds/images/dddding.png;"></div>
				<div class="sub-dd clearfix" id="xfcgwzHtml" style="height:auto;text-align:center;padding:8px 0px;"></div>				
		<div class="b-dd-w">
		
				<div class="dd-w-cont" style="background: #ffffff;">
					<div class="dd-w-w ddd-w">
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left"></div>
							<div class="d-w-list-left" style="color:#888888;"> {{HouseName}}</div>
						</div>
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left"></div>
							<div class="d-w-list-left">{{fangyuan.D_BanName}}-{{fangyuan.D_Unit}}-{{fangyuan.D_RoomNo}}</div>
						</div>
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">￥：</div>
								{{if showPrice=="1"}}
										<div class="d-w-list-left">{{fangyuan.D_Total}}元</div>
								{{else}}
										<div class="d-w-list-left">*******元</div>
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
						<div class="clearfix">
							<div class="dd-w-list clearfix" style="float:left;width:45%">
								<div class="d-w-list-left">姓名：</div>
								{{if user != null }}
								<div class="d-w-list-left">{{user.D_Name}}</div>
								{{else}}
								<div class="d-w-list-left"> </div>
								{{/if}}
							</div>
							<div class="dd-w-list clearfix" style="float:left;width:55%">
								<div class="d-w-list-left">手机号码：</div>
								{{if user != null }}
								<div class="d-w-list-left">{{user.D_Tel}}</div>
                            	{{else}}
								<div class="d-w-list-left"> </div>
                            	{{/if}}							
							</div>
						</div>
						<div class="dd-w-list clearfix">
								<div class="d-w-list-left">身份证号：</div>
								{{if user != null }}
								<div class="d-w-list-left">{{user.D_Card}}</div>
								{{else}}
								<div class="d-w-list-left"> </div>
								{{/if}}
						</div>
					</div>

					<div class="dd-w-w ddd-w">
						<div class="clearfix">
							<div class="dd-w-list clearfix"  style="float:left;width:45%">
								<div class="d-w-list-left">置业顾问：</div>
								{{if user != null }}
								<div class="d-w-list-left">{{user.D_Saller}}</div>
								{{else}}
								<div class="d-w-list-left"> </div>
								{{/if}}
								
							</div>
							<div class="dd-w-list clearfix"  style="float:left;width:55%">
								<div class="d-w-list-left">手机号码：</div>
								{{if user != null }}
								<div class="d-w-list-left">{{user.D_SallerTel}}</div>
								{{else}}
								<div class="d-w-list-left"> </div>
								{{/if}}
								
							</div>
						</div>
					</div>
					<div class="dd-w-w ddd-w" style="padding: .8rem .5rem;">
						<div class="dd-w-list clearfix" >
							<div class="d-w-list-left">订&nbsp;&nbsp;单&nbsp;&nbsp;号：</div>
							<div class="d-w-list-left"
								style="font-size: 1.6rem; font-weight: bold;">{{fangyuan.D_SerialNumber}}</div>
						</div>
						<div class="dd-w-list clearfix" >
							<div class="d-w-list-left">下单时间：</div>
							<div class="d-w-list-left"
								style="font-size: 1.6rem; font-weight: bold;">{{fangyuan.D_SaleDate}}</div>
						</div>
					</div>
				</div>
				<div class="yxg">
					{{if IsTest=='0'}}
					<img src="/project/ds/images/yrg.png" />
					{{/if}}
				</div>
		</div>
	{{else}}
		<div style="background:#fbf6ed;text-align:center;padding-top:8px;"><img style="width:10%;" src="/project/ds/images/dddding.png;"></div>
				<div class="sub-dd clearfix" id="xfcgwzHtml" style="height:auto;text-align:center;padding:8px 0px;"></div>				
		<div class="b-dd-w">
		
				<div class="dd-w-cont" style="background: #ffffff;">
					<div class="dd-w-w ddd-w">
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left"></div>
							<div class="d-w-list-left" style="color:#888888;"> {{HouseName}}</div>
						</div>
						<!--
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left"></div>
							<div class="d-w-list-left"></div>
						</div>
						-->
						<div class="dd-w-list clearfix">
						<!--
							<div class="d-w-list-left">￥：</div>
								-->
								{{if showPrice=="1"}}
										<div class="d-w-list-left"></div>
								{{else}}
										<div class="d-w-list-left"></div>
                                 {{/if}}
						</div>
						
					</div>
					<div class="dd-w-w ddd-w">						
						<div class="dd-w-list clearfix">
							<div class="d-w-list-left">类型：</div>
							<div class="d-w-list-left"></div>
						</div>
					</div>
					
					<div class="dd-w-w ddd-w">
						<div class="clearfix">
							<div class="dd-w-list clearfix" style="float:left;width:45%">
								<div class="d-w-list-left">姓名：</div>
								{{if user != null }}
								<div class="d-w-list-left">{{user.D_Name}}</div>
								{{else}}
								<div class="d-w-list-left"> </div>
								{{/if}}
							</div>
							<div class="dd-w-list clearfix" style="float:left;width:55%">
								<div class="d-w-list-left">手机号码：</div>
								{{if user != null }}
								<div class="d-w-list-left">{{user.D_Tel}}</div>
                            	{{else}}
								<div class="d-w-list-left"> </div>
                            	{{/if}}							
							</div>
						</div>
						<div class="dd-w-list clearfix">
								<div class="d-w-list-left">身份证号：</div>
								{{if user != null }}
								<div class="d-w-list-left">{{user.D_Card}}</div>
								{{else}}
								<div class="d-w-list-left"> </div>
								{{/if}}
						</div>
					</div>

					<div class="dd-w-w ddd-w">
						<div class="clearfix">
							<div class="dd-w-list clearfix"  style="float:left;width:45%">
								<div class="d-w-list-left">置业顾问：</div>
								{{if user != null }}
								<div class="d-w-list-left">{{user.D_Saller}}</div>
								{{else}}
								<div class="d-w-list-left"> </div>
								{{/if}}
								
							</div>
							<div class="dd-w-list clearfix"  style="float:left;width:55%">
								<div class="d-w-list-left">手机号码：</div>
								{{if user != null }}
								<div class="d-w-list-left">{{user.D_SallerTel}}</div>
								{{else}}
								<div class="d-w-list-left"> </div>
								{{/if}}
								
							</div>
						</div>
					</div>
					<div class="dd-w-w ddd-w" style="padding: .8rem .5rem;">
						<div class="dd-w-list clearfix" >
							<div class="d-w-list-left">订&nbsp;&nbsp;单&nbsp;&nbsp;号：</div>
							<div class="d-w-list-left"
								style="font-size: 1.6rem; font-weight: bold;"></div>
						</div>
						<div class="dd-w-list clearfix" >
							<div class="d-w-list-left">下单时间：</div>
							<div class="d-w-list-left"
								style="font-size: 1.6rem; font-weight: bold;"></div>
						</div>
					</div>
				</div>				
		</div>
	{{/if}}
			<div class="dc-btnn dc-btn-widtht" style="margin-top:15px">
				<a href="javascript:void(0);" onclick="goBack()">退出</a>
			</div>
</script>	
<script>
		function dingdanXuanRan(fangyuan,user,HouseName,UserShowPrice){	
			haveDingDan ='0'; 
			if(fangyuan!=null){
				haveDingDan='1';
			}
			 var showPrice="0";
			 if(IsShowPrice==='0'){
		    	 if(UserShowPrice==='1'){
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
					 HouseName:HouseName,
					 haveDingDan:haveDingDan,
					 showPrice:showPrice,
					 IsTest:IsTest
			 };			 
			 var MyDingDan = template('MyDingDan', dsData);
		     document.getElementById('commonBody').innerHTML = MyDingDan;
		}   
</script>	
