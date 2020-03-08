
//var path ="localhost:8080";
	/*var ip ;
	var user;*/
	//getWsIp();
    function getWsIp(){
    	$.post("/fangyuan/getWebSocketIp.do",
    			function(data){
    				ip=data.result;
    				user = data.msg;
    				createWebSocket(ip,user);
    			}, "json");   	
    }
    var lockReconnect = false;//避免重复连接
    var ws;
    var tt;
    function createWebSocket(path,user){
    	console.log("连接中");
    	try {
    		
        	ws = new WebSocket("ws://" + path + "/Ds");
        	
            init(user);
          } catch(e) {
             reconnect(ip,user);
          }
    }
    function init(user) {
        ws.onclose = function () {
          console.log('连接关闭');
          reconnect(ip,user);
        };
        ws.onerror = function() {
          console.log('发生异常了');
          reconnect(ip,user);
        };
        ws.onopen = function () {
        	ws.send(user);
        };
        ws.onmessage = function (evt) {
          //拿到任何消息都说明当前连接是正常的
        	zhongzhuan(evt.data);
        }
      }
    function reconnect(ip,user) {
        if(lockReconnect) {
          return;
        };
        lockReconnect = true;
        //没连接上会一直重连，设置延迟避免请求过多
        tt && clearTimeout(tt);
        tt = setTimeout(function () {
          createWebSocket(ip,user);
          lockReconnect = false;
        }, 4000);
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
	
		
