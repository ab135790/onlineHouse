<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script type="text/javascript" src="${project}/ds/websocket/sockjs.min.js"></script>
<title>index</title>
<script type="text/javascript">
    var path ="localhost:8080";
	var ws;
	if ('WebSocket' in window) {
		console.log("1");
		ws = new WebSocket("ws://" + path + "/Ds");
	} else if ('MozWebSocket' in window) {
		console.log("2");
		ws = new MozWebSocket("ws://" + path + "/Ds");
	} else {
		console.log("3");
		ws = new SockJS("http://" + path + "/Ds");
	}
	// 初始化一个 WebSocket 对象
	//var ws = new WebSocket("ws://localhost:8080/ws");

	// 建立 web socket 连接成功触发事件
	ws.onopen = function() {
		// 使用 send() 方法发送数据
		ws.send("发送数据");
		console.log("数据发送中...");
	};

	// 接收服务端数据时触发事件
	ws.onmessage = function(evt) {
		var received_msg = evt.data;
		console.log(received_msg);
		 var obj = JSON.parse(received_msg);
		console.log(obj.code);
		console.log(obj.result);
		obj.result.forEach((t, i) => {
             if(t.state ===0){
                console.log(t.id);
             }else if(t.state===1){
               console.log(t.id);
             }else {
               console.log(t.id);
             }                 
        });
		console.log("数据已接收...");
	};

	// 断开 web socket 连接成功触发事件
	ws.onclose = function() {
		console.log("连接已关闭...");
	};
</script>
</head>
<body>
	<h2>Hello WebSocket!</h2>
</body>
</html>