//优惠公式
var winYhgs;
function checkShowYHGS(){
	if (IsShowYHGS ==='1'){
		 var openYhgs=localStorage.getItem("openYhgs");
		 if(openYhgs==null){
            winYhgs=layer.open({
			  type: 1,
			  title: false,
			  closeBtn: 0,
			  area: '300px',
			  skin: 'layui-layer-nobg picradius', //没有背景色
			  shadeClose:true,
			  shade:0.5,
			  /*time: 5000,*/
			  content: $('#yhgs'),
			  success: function(layero, index){
				  localStorage.setItem("openYhgs",1);
			  }
			});				
		 }
	}
}
function closeYhgs(){
	layer.close(winYhgs);
}
/*function changeShowYhgsState(){
	$.ajax({
        url: "/fangyuan/changeShowYhgsState",
        type: "post",
        async: true,
        dataType: "json",
        success: function(data) {
            console.log(data.result);
        }
    });
}*/
	

			var dsLoudongIndex=0;
			var dsDanyuanIndex=0;
	
			
			 function changeMonitor(id){
				 $.ajax({
			            url: "/fangyuan/singleFanHong",
			            type: "post",
			            async: true,
			            data: { id: id },
			            dataType: "json",
			            success: function(data) {
			                console.log(data.msg);
			            }
			        });
			}
			 
			/*	$(".pua").live('click',function () { 
					$(this).addClass("lon").siblings().removeClass("lon");
					//getDanYuan($(this).html());
					dsLoudongIndex = $(this).attr("index");
					dsDanyuanIndex =0;
					console.log(dsLoudongIndex);
					$(".dyShow"+dsLoudongIndex).show().siblings().hide();
					$(".fyShow"+dsLoudongIndex).show().siblings().hide();
					
				});*/
				function ldChoose(obj){
					/*var index = layer.load(1, {
						  shade: [0.3, '#393D49'], //0.1透明度的白色背景
						  time: 500
						});*/
					$("#dsLouDong li a").removeClass("lon");
					//$(obj).addClass("lon").siblings().removeClass("lon");
					$(obj).addClass("lon");
					//getDanYuan($(this).html());
					dsLoudongIndex = $(obj).attr("index");
					dsDanyuanIndex =0;
					console.log(dsLoudongIndex);
					$(".dyShow"+dsLoudongIndex).show().siblings().hide();
					$(".fyShow"+dsLoudongIndex).show().siblings().hide();
					var data=eval('('+jsonData+')');
					xuanranDy(data,dsLoudongIndex,dsDanyuanIndex);
					$(".txShow"+dsDanyuanIndex).show().siblings().hide();
				}

			   /* $('.dua').live('click', function () {
			    	$(this).addClass("don").siblings().removeClass("don");
			    	//getTaoXing($(".lon").html(),$(this).html())
			    	dsDanyuanIndex = $(this).attr("index");
			    	$(".txShow"+dsDanyuanIndex).show().siblings().hide();
			    	
		    	});*/
			    
			    function dyChoose(obj){
			    	/*var index = layer.load(1, {
			    		  shade: [0.3, '#393D49'], //0.1透明度的白色背景
			    		  time: 500
			    		});*/
			    	//$(obj).addClass("don").siblings().removeClass("don");
			    	$("#IsShowDY li a").removeClass("don");
			    	$(obj).addClass("don");
			    	//getTaoXing($(".lon").html(),$(this).html())
			    	dsDanyuanIndex = $(obj).attr("index");
			    	$(".txShow"+dsDanyuanIndex).show().siblings().hide();
			    }
				
				/*//房源点击总控制
				$('.sh').live('click', function () {
			    	var id = $(this).attr("rid");
			    	console.log("id="+id);
			    	var rstate = $(this).attr("rstate");//房源状态
			    	var mstate = $(this).attr("mstate");//监控状态
			    	if("1"===timeState && houseState==="4"){//处于抢购模式才进行如下操作
				    	if("1"===rstate || "1"===mstate || "2"===mstate){
				    		 layer.msg("已经被预定");
				    		 if("1"===mstate){
				    			 changeMonitor(id);
				    		 }
				    		 return;
				    	}else if("2"===rstate || "3"===mstate){
				    		 layer.msg("已经售出");
				    		 return;
				    	}
				    	
				    	if(alreadyBuyCount>0){
				    		 layer.msg("您已达订购上限");
				    		 return;
				    	}		    		
			    	}else if("0"===timeState){
			    		layer.msg("抢购活动结束!");
			    		return;
			    	}
			    	getInXingQing(id);//进入详情页
		    	});*/
				function fyChoose(obj){
					var id = $(obj).attr("rid");
			    	console.log("id="+id);
			    	var rstate = $(obj).attr("rstate");//房源状态
			    	var mstate = $(obj).attr("mstate");//监控状态
			    	if("1"===timeState && houseState==="4"){//处于抢购模式才进行如下操作
				    	/*if("1"===rstate || "1"===mstate || "2"===mstate){
				    		 layer.msg("已经被预定");
				    		 if("1"===mstate){
				    			 changeMonitor(id);
				    		 }
				    		 return;
				    	}else */
			    	    if(IsTest==='1'){//测试模式
			    	    	if(IsAllowChongFuBuy==='1'){//开启更多
			    	    		if(userType==='1'){//管理员
			    	    			//无限制
			    	    		}else{
			    	    			if(alreadyBuyCount>0){//已买
			    	    				if("2"===rstate || "3"===mstate|| "4"===mstate){			    			
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
			    	    		if("2"===rstate || "3"===mstate || "4"===mstate){			    			
				    				layer.msg("已售");
				    				return;			    							    			
			    	    		}				    		
					    		if(alreadyBuyCount>0){				    			
					    			layer.msg("您已认购,请往我的订单查看!");
				    				return;			    			
					    		}	
			    	    	}			    	    	
			    	    }else{
				    	    if("2"===rstate || "3"===mstate || "4"===mstate){			    			
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
			    	getInXingQing(id);//进入详情页
				}
				//进入详情页
				 function getInXingQing(id){
					 //window.location.replace("/dsCar/index.html#xiangqing?id="+id+"&timeState="+timeState+"&ldIndex="+dsLoudongIndex+"&dyIndex="+dsDanyuanIndex);
					 //window.location.replace("/dsCar/index.html#xiangqing?id="+id+"&timeState="+timeState);
					 window.location.replace("/dsCar/index.html#xiangqing?id="+id);
				 }
	function DsIsShowDY(){//是否显示单元
		if(IsShowDY==='1'){
			$("#IsShowDY").show();
		}else{
			$("#IsShowDY").hide();
			$(".b-index-w").css("padding-top","120px");
			$(".dfix").css("height","120px");
		}
	}