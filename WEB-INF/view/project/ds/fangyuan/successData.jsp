<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<script type="text/javascript">
$(function(){	
	 $.post("/fangyuan/buyRoomForSuccessDataJson.do", {"id":${id}},
			   function(data){
		 		 console.log(data);
			     //fangyuan = eval('(' + data.msg+ ')');
			     fangyuan = data;
			     console.log("ok");
			     XfcgXuanRan(fangyuan,IsTest);
			     console.log("sorry");
			     getXfcgHtml();
			   }, "json");
			
});

function getXfcgHtml(){
	var name="正式选房成功文字";
	if(IsTest==='1'){
		name='公测选房成功文字';
	}
	$.post("/common/getHtmlText.do", {"name":name},
			   function(data){
			     var str = Base64decode(data.result);
			     $("#xfcgHtml").html(str);
			   }, "json");			
}
		
	</script>	
	<div class="center">
		<div class="b-index-w"  id="showSuccess">
			<%-- <div class="ddcg"><img src="${project}/ds/images/fg.png" style="width:100%"></div>
			<div class="succ"><p class="scccp1">恭喜您成功认购</p><p class="scccp2">${fangyuan.getD_BanName()}-${fangyuan.getD_Unit()}-${fangyuan.getD_RoomNo()}</p></div>
			<p class="succinfo" id="xfcgHtml">
			
			</p>
			<div class="dc-btn dc-btn-width">
				<a href="/dsCar/index.html#dingdan"  style="background:#fa4e2a;color:#ffffff;">返回我的订单</a>
				<a href="/dsCar/index.html#shoucang" style="background:#2a7dd2;color:#ffffff;">返回我的收藏</a>
			</div> --%>
		</div>
	</div>
<script id="showSuccess1" type="text/html">
		<div class="ddcg">
			{{if IsTest==0}}
				<img src="/project/ds/images/fg.png" style="width:100%"></div>
 			{{else}}
				<img src="/project/ds/images/fg-b.png" style="width:100%"></div>
            {{/if}}
			<div class="succ"><p class="scccp1">恭喜您成功认购</p><p class="scccp2">{{fangyuan.D_BanName}}-{{fangyuan.D_Unit}}-{{fangyuan.D_RoomNo}}</p></div>
			<p class="succinfo" id="xfcgHtml">
			
			</p>
			<div class="dc-btn dc-btn-width">
				<a href="javascript:void(0);"  onclick="lookDingDan()"  style="background:#fa4e2a;color:#ffffff;">返回我的订单</a>
				<a href="javascript:void(0);"  onclick="lookShouCang()" style="background:#2a7dd2;color:#ffffff;">返回我的收藏</a>
			</div>
</script>	
<script>
		function XfcgXuanRan(fangyuan,IsTest){	
			console.log(fangyuan);
			 var dsData={
					 fangyuan:fangyuan,
					 IsTest:IsTest
			 };			 
			 var showSuccess1 = template('showSuccess1', dsData);
		     document.getElementById('showSuccess').innerHTML = showSuccess1;			
		}   
</script>	