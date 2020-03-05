var allowLoadFangyuan=false; 				
var index;
                function openJac(){
                /*	var sfty = $('#ckboxRgxz').prop("checked");
                	console.log(sfty);*/
        			if(sfchecked==true){
        				localStorage.setItem("tyc","true");
        				window.location.replace("/dsCar/index.html#fangyuan");
        				return;
        			}else{
        				layer.msg('请先阅读协议并勾选"已阅读并同意活动协议"')
        				return;
        			}
                	index =layer.open({
                        title: false,
                        type: 1,
                        skin: 'layui-rgxz', //样式类名
                        closeBtn: 0, //不显示关闭按钮
                        anim: 2,
                        shadeClose: true, //开启遮罩关闭
                        offset: 'b',
                        area: ['100%', '65%'],
                        content: $("#J-bottom").html(),
                        success: function(layero, index){
                        	//$("#global").css('overflow-y','hidden');

                        	$(".rgxzText").scroll(function(){
                        		 var $this =$(this),viewH =$(this).height(), contentH =$(this).get(0).scrollHeight, scrollTop =$(this).scrollTop();//滚动高度

                    			//if(contentH - viewH - scrollTop <= 100) { //到达底部100px时,加载新内容
                    			if(scrollTop/(contentH -viewH)>=0.8){ //到达底部100px时,加载新内容
                    				$(".buttons2").css("background","#d86239");
                    				allowLoadFangyuan=true;
                    			}else{
                    				$(".buttons2").css("background","#d1d1d1");
                    				allowLoadFangyuan=false;
                    			} 
                        		/*console.log(viewH);
                        		console.log(contentH);
                    			console.log(scrollTop);*/
                        	});	
                          }                        
                      });
                }             
                
				function loadfangyuan(){
					if(!allowLoadFangyuan){
						return ;
					}
					localStorage.setItem("tyc",1);//头一次
					layer.close(index);
					window.location.replace("/dsCar/index.html#fangyuan");
				}
                function colseForm(){
                	//$("#global").css('overflow-y','auto');
                    layer.close(index);
                }
                
                function getRgxz(){
            		$.ajax({
            			url : "/common/getHtmlText.do",
            			type : "post",
            			async : true,
            			data : {
            				name : "活动协议"
            			},
            			dataType : "json",
            			success : function(data) {
            				var str = Base64decode(data.result);
            				//$("#rgxzText").html(str);
            				$("#rgxzText2").html(str);
            				//$("#rgxzText2").append("<div class='layui-layer-btn layui-layer-btn-'><a class='layui-layer-btn0' href='javascript:void(0);' onclick='agreeBtn()'>同意</a><a class='layui-layer-btn1' href='javascript:void(0);' onclick='refuseBtn()'>不同意</a></div>");
            			}
            		});
            	}
                function getWxts(){
                	$.ajax({
                		url : "/common/getHtmlText.do",
                		type : "post",
                		async : true,
                		data : {
                			name : "温馨提示"
                		},
                		dataType : "json",
                		success : function(data) {
                			var str = Base64decode(data.result);
                			//$("#rgxzText").html(str);
                			$("#wxtsText").html(str);
                			$("#wxtsDiv").show();
                		}
                	});
                }
                function setIndexImg(){
                	 $("#bjtPic").attr("src",imageServer+"/UpLoad/"+imageFolder+"/bgimg.jpg?v="+staticVersion);
                	 $("#ghtPic").attr("src",imageServer+"/UpLoad/"+imageFolder+"/ghimg.jpg?v="+staticVersion);
                	// $("#ghtPic").attr("layer-src",imageServer+"/UpLoad/fy/规划图.jpg?v="+staticVersion);
                	// $("#ghtPic").attr("data-original",imageServer+"/UpLoad/fy/规划图.jpg?v="+staticVersion);
                	 
                	// layer-src="${imageServer}/UpLoad/fy/规划图.jpg?v=1.0"
                }
                
                function openJac2(){
                	index =layer.open({
                        title: ['活动协议', 'font-size:18px;text-align:center;font-weight:bold;padding-left:0px;padding-right:0px;'],
                        type: 0,
                        skin: 'layui-rgxz', //样式类名
                        closeBtn: 0, //不显示关闭按钮
                        //anim: 1,
                        shadeClose: false, //开启遮罩关闭
                        offset: 'auto',
                        area: 'auto',
                        btn: ['同意', '不同意'],
                        success: function(layero, index){
                        	$(".layui-layer-title").css("border-radius","10px 10px 0 0");
                        	$(".layui-layer").css("border-radius","10px");
                        	//$(".layui-layer-content").css("padding-left","2px");
                        	$(".layui-layer-content").css("padding","0px 2px 0px 2px");
                        	//$(".layui-layer-content").css("padding-right","2px");
                        	$(".layui-layer-btn0").css({color:"#000000",background:"#fff",border:"1px solid #dedede"});                                
                        	if(localStorage.getItem("tyc")==null){
                                $(".rgxzText").scroll(function(){                           		
                                	var $this =$(this),viewH =$(this).height(), contentH =$(this).get(0).scrollHeight, scrollTop =$(this).scrollTop();//滚动高度

    	                   			if(scrollTop/(contentH -viewH)>=0.8){ //到达底部100px时,加载新内容
    	                   				$(".layui-layer-btn0").css({color:"#ffffff",background:"#d86239"});
    	                   				allowLoadFangyuan=true;
    	                   			}else{
    	                   				$(".layui-layer-btn0").css({color:"#000000",background:"#fff"});
    	                   				allowLoadFangyuan=false;
    	                   			} 
                           		
                                });	
                        	}                            
                         },
                        yes: function(index, layero){
                        	if(localStorage.getItem("tyc")==null){
                        	 if(!allowLoadFangyuan){
                        		layer.msg('请先阅读完活动协议');
                 				return;
                        	 }
                        	}
                        	 $('#ckboxRgxz').prop("checked",true);
                        	 $("#ckboxRgxz").prop("disabled", false);
                        	 sfchecked=true;
							 $('#selectimg').attr('src','/project/ds/images/indexxydefuaultselect.png?r='+Math.random());
                        	 /*$(".J-ac-btn").css("background-color","#d86239");*/
                            //layer.msg("同意");
                        	 layer.close(index);
                          },
                         btn2: function(index, layero){
                        	 $("#ckboxRgxz").prop("disabled", true);	
                        	 $('#ckboxRgxz').prop("checked",false);
                        	 sfchecked=false;
							 $('#selectimg').attr('src','/project/ds/images/indexxydefuault.png?r='+Math.random());
                        	/* $(".J-ac-btn").css("background-color","#C0C0C0");*/
                        	// layer.msg("不同意");
                          },
                        content: $("#J-bottom2").html()                       
                      });
                	
                }   
               /* function agreeBtn(){
                	 $('#ckboxRgxz').prop("checked",true);
                	 $("#ckboxRgxz").prop("disabled",false);
                	 sfchecked=true;
					 $('#selectimg').attr('src','/project/ds/images/indexxydefuaultselect.png?r='+Math.random());
                	 layer.close(index);
                }
                
                function refuseBtn(){
                	$("#ckboxRgxz").prop("disabled", true);	
               	 	$('#ckboxRgxz').prop("checked",false);
               	 	sfchecked=false;
					 $('#selectimg').attr('src','/project/ds/images/indexxydefuault.png?r='+Math.random());
                }
                function openJac2(){
                	index =layer.open({
                        title: ['活动协议', 'font-size:18px;text-align:center;font-weight:bold;padding-left:0px;padding-right:0px;'],
                        type: 1,
                        skin: 'layui-rgxz', //样式类名
                        closeBtn: 0, //不显示关闭按钮
                        //anim: 1,
                        shadeClose: false, //开启遮罩关闭
                        offset: 'auto',
                        area: 'auto',                       
                        content: $("#J-bottom2").html()                       
                      });
                	
                }   */
                function ckboxRgxz_fun(){
                	console.log(sfchecked);
                	/*var sfty = $('#ckboxRgxz').prop("checked");*/
                	if(localStorage.getItem("tyc")==null){
                		return;
                	}
                	if(sfchecked==false){
                		console.log(sfchecked);
                		sfchecked=true;
                		 //$(".J-ac-btn").css("background-color","#d86239");
						 $('#selectimg').attr('src','/project/ds/images/indexxydefuaultselect.png?r='+Math.random());
                	}else{
                		console.log(sfchecked);
                		sfchecked=false;
                		 //$(".J-ac-btn").css("background-color","#C0C0C0");
						 $('#selectimg').attr('src','/project/ds/images/indexxydefuault.png?r='+Math.random());
                	}
                	
				}