layui.use("jquery",function(){
	var $ = layui.jquery;
	$.ajax({
		url:"/user/getInfo",
		success:function(res){
			console.info(res);
			if(!res.nickname){
				window.location.href = "../../logout"
			}
			$("#nickname").text(res.nickname)
		}
	});
})
