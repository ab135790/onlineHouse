/**
 * 
 */
$.ajaxSetup({
	 error : function(xhr,textStatus,errorThrown){
	       　　if (xhr.status == 401) {
	       　　　　 console.log("回登录页");
	       　　　　 window.location.href="/login";
	         　   } 
	 }
});