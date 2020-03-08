var moveid=-1;
				function down(id,sort){
					//$("#shoucangList").load("/shoucang/doDown?id="+id+"&sort="+sort);
					 $.get("/shoucang/doDownJson.do?id="+id+"&sort="+sort,
							   function(data){
						 shoucangXuanranZong(data)
							   }, "json");
				}	
				
				function down(key,id,sort){
					//$("#shoucangList").load("/shoucang/doDown?id="+id+"&sort="+sort);
					moveid=key;
					 $.get("/shoucang/doDownJson.do?id="+id+"&sort="+sort,
							   function(data){
						 shoucangXuanranZong(data)
							   }, "json");
				}	
				function dtop(key,id,sort){
                  			moveid=key;
					//$("#shoucangList").load("/shoucang/doTop?id="+id+"&sort="+sort);
					$.get("/shoucang/doTopJson.do?id="+id+"&sort="+sort,
					   function(data){
						shoucangXuanranZong(data)
					   }, "json");
				}		
				function del(fangyuanId,shoucangId){
					/*$("#shoucangList").load("/shoucang/doDel?fangyuanId="+fangyuanId+"&shoucangId="+shoucangId,function(){
						 var count =$("#syNum").html();
				    	 var addCount = Number(count)+1;
				    	 $("#syNum").html(addCount);
					});*/
					
					var scconfirm =layer.confirm('确认删除？', {
						  btn: ['确认','取消'], //按钮
						  title: false,
						  closeBtn:0
						}, function(){
							$.get("/shoucang/doDelJson.do?fangyuanId="+fangyuanId+"&shoucangId="+shoucangId,
									   function(data){
										layer.close(scconfirm);
										shoucangXuanranZong(data)
									   }, "json");
									    moveid=-1;		
						}, function(){
							  layer.close(scconfirm);
						});
					
				}		
function lookDetail(id,rstate,mstate){
	console.log("rstate="+rstate);
	console.log("mstate="+mstate);
	console.log("timeState="+timeState);
	console.log("IsTest="+IsTest);
	console.log("IsAllowChongFuBuy="+IsAllowChongFuBuy);
	console.log("userType="+userType);
	if("1"===timeState && houseState==="4"){//处于抢购模式才进行如下操作
	    if(IsTest==='1'){//测试模式
	    	console.log("进入测试模式");
	    	if(IsAllowChongFuBuy==='1'){//开启更多
	    		console.log("进入重复购模式");
	    		if(userType==='1'){//管理员
	    			console.log("进入管理员模式");
	    			//无限制
	    		}else{
	    			if(alreadyBuyCount>0){//已买
	    				if("2"===rstate || "3"===mstate ||"4"===mstate){			    			
		    				layer.msg("已售");
		    				return;			    							    			
	    	    		}				    		
			    		if(alreadyBuyCount>0){				    			
			    			layer.msg("您已认购,请往我的订单查看!");
		    				return;			    			
			    		}	
	    			}else{
	    				//无限制
	    			}
	    		}
	    	}else{
	    		console.log("进入无重复购模式");
	    		if("2"===rstate || "3"===mstate||"4"===mstate){			    			
    				layer.msg("已售");
    				return;			    							    			
	    		}				    		
	    		if(alreadyBuyCount>0){				    			
	    			layer.msg("您已认购,请往我的订单查看!");
    				return;			    			
	    		}	
	    	}			    	    	
	    }else{
    	    if("2"===rstate || "3"===mstate){			    			
    				layer.msg("已售");
    				return;			    							    			
	    	}				    		
    		if(alreadyBuyCount>0){				    			
    			layer.msg("您已认购,请往我的订单查看!");
				return;			    			
    		}	
	    }
	}else if("0"===timeState || houseState==="5"){
		layer.msg("抢购活动结束!");
		return;
	}
	 //window.location.replace("/dsCar/index.html#xiangqing?id="+id+"&timeState="+timeState+"&ldIndex=0&dyIndex=0");
	 window.location.replace("/dsCar/index.html#xiangqing?id="+id);
}	
function  shoucangXuanranZong(data){
	var list=[];
	var length=0;
	if(typeof(data.list) != 'undefined'){
		list = data.list;
		length= data.list.length;
	}
	 var showPrice="0";
	 if(IsShowPrice==='0'){
		    if(data.UserShowPrice==="1"){
		    	 showPrice="1"; 
			}else{
	    		 showPrice="0";
	        }
     }else{
    	 showPrice="1";
     }
	 console.log()
	shoucangXuanRan(data.syNum,list,length,showPrice);
}