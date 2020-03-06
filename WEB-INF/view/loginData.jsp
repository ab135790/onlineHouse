<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<script type="text/javascript">
	allowLoad= true;//默认允许登录
	LoginTest='${configMap.LoginTest}';
	yzType='${configMap.IsShowYZMorSFZ}';
	caseStartTime='${configMap.caseStartTime}';
	// commonForLogin.js
	loginIni();

	$(function(){
		var dsData={
			IsShowDjsTime:IsShowDjsTime
		};
		var html1 = template('showDjsTime2', dsData);
		document.getElementById('showDjsTime').innerHTML = html1;
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
<style type="text/css">body{background:#ffffff;}</style>
<div class="center">
	<div class="b-index-w">
		<div id="showDjsTime">
			<!-- 					 <div class="time-djs" id="subtimer" style="display:none">
	                                      <p id="ggts">本轮活动离结束时间剩余</p>
	                                      <div class="liktimer">
	                                           <span class="RemainD Remain">00</span><span class="liksapn">天</span><span class="RemainH Remain">00</span><span class="liksapn">时</span>
	                                           <span class="RemainM Remain">00</span><span class="liksapn">分</span><span class="RemainS Remain">00</span><span class="liksapn">秒</span>
	                                      </div>
	                                  </div> -->
		</div>
		<div class="index-img"><img id="dltPic" style="width:100%"></div>
		<div class="weui-cell" style="">
			<div class="weui-cell__bd" style="line-height:30px;">
				<span style="vertical-align: middle;font-size:1.8rem;margin-top:5px;padding-top:5px;">${configMap.HouseName}</span>
				<span class="weui-badge OBClass" style="margin-left: 5px;margin-top:-2px;" id="zsOrcs">正式</span>
			</div>
		</div>
		<div class="login-w" style="padding-top: 0px;">
			<div class="login-list clearfix">
				<div class="login-list1"><span class="lsep1"></span></div>
				<div class="login-list2"><input type="number" oninput="if(value.length>11)value=value.slice(0,11)"  id="D_Tel" name="D_Tel" placeholder="请输入登记时的手机号码"></div>
			</div>

			<div class="login-list clearfix" id="code">
				<div class="login-list1"><span class="lsep2"></span></div>
				<div class="login-list2 login-list22"><input type="number" oninput="if(value.length>4)value=value.slice(0,4)" id="D_Code" name="D_Code" placeholder="请输入验证码"></div>
				<div class="login-list3"><a href="javascript:void(0);" onclick="send_code()" id="yzmDjs">发送验证码</a></div>
			</div>

			<div class="login-list clearfix" id="card">
				<div class="login-list1"><span class="lsep3"></span></div>
				<div class="login-list2"><input type="number" id="D_Card" name="D_Card" placeholder="请输入您的身份证号"></div>
			</div>

			<!-- <div class="login-button"><input type="submit" value="登录" ></div> -->
			<div class="login-button mb1_6r"><input type="button" value="登录" id="submit" onclick="onSubmit()"></div>
			<div class="tips">
				<p class="mb1r tips_title">本次开盘时间</p>
				<p class="mb1r tips_time">2020年3月30日9:00-11:30</p>
				<p class="mb1r tips_start">温馨提示：申购人在<span>9</span>点之前登陆</p>
				<div class="tips_attachment">
					<a href="javascript:void(0);" onclick="alertFile(1)" class="txt">《预售方案》</a>
					<a href="javascript:void(0);" onclick="alertFile(2)" class="txt">《五证公式》</a>
					<a href="javascript:void(0);" onclick="alertFile(3)" class="txt">《其他公式》</a>
				</div>
			</div>
			<div class="mask" id="mask">
				<div id="alertfile" class="imgMask"></div>
				<i class="layer-icon layui-icon-close closeBtn" onclick="closeBtn()"></i>
			</div>
		</div>
	</div>
</div>
<script id="showDjsTime2" type="text/html">
	{{if IsShowDjsTime=='0'}}
	<div class="time-djs" id="subtimer" style="display:none">
		<p id="ggts">本轮活动离结束时间剩余</p>
		<div class="liktimer">
			<span class="RemainD Remain">00</span><span class="liksapn">天</span><span class="RemainH Remain">00</span><span class="liksapn">时</span>
			<span class="RemainM Remain">00</span><span class="liksapn">分</span><span class="RemainS Remain">00</span><span class="liksapn">秒</span>
		</div>
	</div>
	{{else}}
	<div class="time-djs" id="subtimer">
		<p id="ggts">本轮活动离结束时间剩余</p>
		<div class="liktimer">
			<span class="RemainD Remain">00</span><span class="liksapn">天</span><span class="RemainH Remain">00</span><span class="liksapn">时</span>
			<span class="RemainM Remain">00</span><span class="liksapn">分</span><span class="RemainS Remain">00</span><span class="liksapn">秒</span>
		</div>
	</div>
	{{/if}}
</script>
