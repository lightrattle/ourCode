layui.use(["jquery","table","element"],function(){
	//个人中心——订单
	var table = layui.table;
	var $ = layui.jquery;
	//所有订单
	  table.render({
	    elem: '#house-user-order'
	    ,url:  '/listUserOrder?status=-1'
	    ,skin: 'line'
	    ,cols: [[
	      {field:'number', title:'订单信息', align:'center', templet: '#orderTpl'}
	      ,{field:'productName', title:'商品', templet: '#imgTpl', align:'center'}
	      ,{field:'productNum', title:'件数', align:'center', width:80}
	      ,{field:'price', title:'单价', align:'center', templet: '#priceTpl', width:100}
	      ,{field:'status', title:'订单状态', align:'center', templet: '#stateTpl', width:100}
	      ,{title:'订单操作', align:'center', templet: '#handleTpl', width:120}
	    ]]
	  	,parseData:function(res){
	  		return{
	  			code:0,
	  			data:res
	  		}
	  	}
	  });
	  //等待发货
	  table.render({
	    elem: '#house-user-order-status0'
	    ,url:  '/listUserOrder?status=0'
	    ,skin: 'line'
	    ,cols: [[
	      {field:'number', title:'订单信息', align:'center', templet: '#orderTpl'}
	      ,{field:'productName', title:'商品', templet: '#imgTpl', align:'center'}
	      ,{field:'productNum', title:'件数', align:'center', width:80}
	      ,{field:'price', title:'单价', align:'center', templet: '#priceTpl', width:100}
	      ,{field:'status', title:'订单状态', align:'center', templet: '#stateTpl', width:100}
	      ,{title:'订单操作', align:'center', templet: '#handleTpl', width:120}
	    ]]
	  	,parseData:function(res){
	  		return{
	  			code:0,
	  			data:res
	  		}
	  	}
	  });
    table.on('tool(house-user-order-status0)', function(obj){
        if(obj.event === 'check'){
            var logisticName;
            var logisticId = obj.data.logisticId;  //此处javabean出错，只能将错就错
            $.ajax({
                url:"/getLogisticName",
                type:"post",
                data:{
                    logisticId: logisticId
                },
                success:function(res){
                    logisticName = res;
                    layer.open({
                        type: 1
                        ,content: "物流公司：" + logisticName
                        ,area: ['150px', '100px']
                    });
                }
            })
        }else if(obj.event === 'evaluate'){
            layer.confirm('确定已收货？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                $.ajax({
                    url:"/receiveProduct",
                    type:"post",
                    data:{
                        orderId: obj.data.orderId
                    },
                    success:function(res){
                        if(res == true){
                            layer.msg('收货成功');
                            window.location.reload();
                        }else{
                            layer.msg('错误！');
                        }
                    }
                })
            })
        }else if(obj.event === 'appraise'){
			layer.prompt({title: '请评价NoMore250char', formType:2}, function(text, index){
				//text即为评价内容
				$.ajax({
					url:"/addAppraise",
					type:"post",
					data:{
						id:obj.data.productId,
						appdetail: text,
					},
					success:function(res){
						if(res == true){
							layer.msg('评价成功！');
							window.location.reload();
						}else{
							layer.msg('错误！');
						}
					}
				});
			});
		}
    });
	  //已发货
	  table.render({
	    elem: '#house-user-order-status1'
	    ,url:  '/listUserOrder?status=1'
	    ,skin: 'line'
	    ,cols: [[
	      {field:'number', title:'订单信息', align:'center', templet: '#orderTpl'}
	      ,{field:'productName', title:'商品', templet: '#imgTpl', align:'center'}
	      ,{field:'productNum', title:'件数', align:'center', width:80}
	      ,{field:'price', title:'单价', align:'center', templet: '#priceTpl', width:100}
	      ,{field:'status', title:'订单状态', align:'center', templet: '#stateTpl', width:100}
	      ,{title:'订单操作', align:'center', templet: '#handleTpl', width:120}
	    ]]
	  	,parseData:function(res){
	  		return{
	  			code:0,
	  			data:res
	  		}
	  	}
	  });
    table.on('tool(house-user-order-status1)', function(obj){

        if(obj.event === 'check'){
            var logisticName;
            var logisticId = obj.data.logisticId;  //此处javabean出错，只能将错就错
            $.ajax({
                url:"/getLogisticName",
                type:"post",
                data:{
                    logisticId: logisticId
                },
                success:function(res){
                    logisticName = res;
                    layer.open({
                        type: 1
                        ,content: "物流公司：" + logisticName
                        ,area: ['150px', '100px']
                    });
                }
            })

        }else if(obj.event === 'evaluate'){
            layer.confirm('确定已收货？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                $.ajax({
                    url:"/receiveProduct",
                    type:"post",
                    data:{
                        orderId: obj.data.orderId
                    },
                    success:function(res){
                        if(res == true){
                            layer.msg('收货成功');
                            window.location.reload();
                        }else{
                            layer.msg('错误！');
                        }
                    }
                })
            })
        }else if(obj.event === 'appraise'){
			layer.prompt({title: '请评价NoMore250char', formType:2}, function(text, index){
				//text即为评价内容
				$.ajax({
					url:"/addAppraise",
					type:"post",
					data:{
						id:obj.data.productId,
						appdetail: text,
					},
					success:function(res){
						if(res == true){
							layer.msg('评价成功！');
							window.location.reload();
						}else{
							layer.msg('错误！');
						}
					}
				})
			});
		}
    });
	  //已签收
	  table.render({
	    elem: '#house-user-order-status2'
	    ,url:  '/listUserOrder?status=2'
	    ,skin: 'line'
	    ,cols: [[
	      {field:'number', title:'订单信息', align:'center', templet: '#orderTpl'}
		  ,{field:'productName', title:'商品', templet: '#imgTpl', align:'center'}
		  ,{field:'productNum', title:'件数', align:'center', width:80}
		  ,{field:'price', title:'单价', align:'center', templet: '#priceTpl', width:100}
		  ,{field:'status', title:'订单状态', align:'center', templet: '#stateTpl', width:100}
		  ,{title:'订单操作', align:'center', templet: '#handleTpl', width:120}
	    ]]
	  	,parseData:function(res){
	  		return{
	  			code:0,
	  			data:res
	  		}
	  	}
	  });
    table.on('tool(house-user-order-status2)', function(obj){

        if(obj.event === 'check'){
            var logisticName;
            var logisticId = obj.data.logisticId;  //此处javabean出错，只能将错就错
            $.ajax({
                url:"/getLogisticName",
                type:"post",
                data:{
                    logisticId: logisticId
                },
                success:function(res){
                    logisticName = res;
                    layer.open({
                        type: 1
                        ,content: "物流公司：" + logisticName
                        ,area: ['150px', '100px']
                    });
                }
            })

        }else if(obj.event === 'evaluate'){
            layer.confirm('确定已收货？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                $.ajax({
                    url:"/receiveProduct",
                    type:"post",
                    data:{
                        orderId: obj.data.orderId
                    },
                    success:function(res){
                        if(res == true){
                            layer.msg('收货成功');
                            window.location.reload();
                        }else{
                            layer.msg('错误！');
                        }
                    }
                })
            })
        }else if(obj.event === 'appraise'){
			layer.prompt({title: '请评价NoMore250char', formType:2}, function(text, index){
				//text即为评价内容
				$.ajax({
					url:"/addAppraise",
					type:"post",
					data:{
						id:obj.data.productId,
						appdetail: text,
					},
					success:function(res){
						if(res == true){
							layer.msg('评价成功！');
							window.location.reload();
						}else{
							layer.msg('错误！');
						}
					}
				})
			});
		}
    });
	  table.on('tool(house-user-order)', function(obj){
		  
	    if(obj.event === 'check'){
	    	var logisticName;
			var logisticId = obj.data.logisticId;  //此处javabean出错，只能将错就错
	    	 $.ajax({
	    			url:"/getLogisticName",
	    			type:"post",
	    			data:{
	    				logisticId: logisticId
	    			},
	    			success:function(res){
	    				logisticName = res;
	    				layer.open({
	    			        type: 1
	    			        ,content: "物流公司：" + logisticName
	    			        ,area: ['150px', '100px']
	    			      });
	    			}
	    	 })
	      
	    }else if(obj.event === 'evaluate'){
	    	layer.confirm('确定已收货？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
    		  $.ajax({
    			url:"/receiveProduct",
    			type:"post",
    			data:{
    				orderId: obj.data.orderId
    			},
    			success:function(res){
    				if(res == true){
    					layer.msg('收货成功');
    					window.location.reload();
    				}else{
    					layer.msg('错误！');
    				}
    			}
    		  })
    		})
	    }else if(obj.event === 'appraise'){
			layer.prompt({title: '请评价NoMore250char', formType:2}, function(text, index){
				//text即为评价内容
				$.ajax({
					url:"/addAppraise",
					type:"post",
					data:{
						id:obj.data.productId,
						app_detail: text,
					},
					success:function(res){
						if(res == true){
							layer.msg('评价成功！');
							window.location.reload();
						}else{
							layer.msg('错误！');
						}
					}
				});
			});
		}
	  });
})


layui.use(['jquery', 'layer'], function(){ 
	  var $ = layui.jquery //重点处
	  ,layer = layui.layer;
	  $.post('../../user/getInfo','',
	  function(user)
	  {
		  $("#nickname").text(user.nickname);
		  $("#_nickname").text(user.nickname);
		  $("#sex").text(user.sex);
		  $("#phone_number").text(user.phoneNumber);
		  $("#username").text(user.username);
	  });
	
});