layui.use(["form","table","layer","jquery"],function(){
	var $ = layui.$
	  ,form = layui.form
	  ,laypage = layui.laypage
	  ,table = layui.table
	  ,layer = layui.layer;
	//地址管理——表格

	  table.render({
			elem : '#user-address',
			url : '../../user/address/listPageAddress',
			page : true,
			cols : [ [ //表头
			{
				field : 'address_id',
				title : '序号',
				type : 'numbers'
			}, {
				field : 'name',
				title : '收货人'
				
			}, {
			
				title : '地址',
				width : '40%',
				templet : function(val) {
				　　　　return val.province+val.city+val.county+val.address_detail;
				　　}
			},{
				field : 'phone_number',
				title : '联系方式'
			},{
				title : '操作',
				align:'center',
				templet: '#addressTpl',
				width:120
			} ] ]
		});
	  //地址管理——监听工具条
	  table.on('tool(user-address)', function(obj){
	    var data = obj.data;
	    if(obj.event === 'del'){
	      layer.confirm('真的删除行么', function(index){
	    	  
	    	  $.post('../../user/address/removeAddress', {
	    		  address_id: data.address_id
				}, function(flag) {
					if(flag){
						layer.msg('删除成功')
						table.reload('user-address', {});//刷新表格
					}else{
						layer.msg('删除失败');
					}

				})
	        layer.close(index);
	      });
	    }else if(obj.event === 'edit'){
	      layer.open({
	        type: 2
	        ,title: '编辑地址'
	        ,content: 'iframe.html'
	        ,area: ['730px', '420px']
	        ,shade: 0.8
	        ,skin: 'address-class'
	        ,btn: '确定'
	        ,success: function(layero,index ){
	        	
	        	 let body = layer.getChildFrame('body', index);
	        	 body.find(".telephone").val(data.phone_number);
	        	 body.find(".name").val(data.name); 
	        	 body.find(".layui-textarea").val(data.address_detail); 
	        	 body.find(".address_id").val(data.address_id); 
	             body.find(".province-selector").attr("data-value",data.province);
	        	 body.find(".city-selector").attr("data-value",data.city);
	        	 body.find(".county-selector").attr("data-value",data.county);
	        	 layui.form.render();
	        }
	        ,yes: function(index, layero){
	          window['layui-layer-iframe'+ index].layui.form.on('submit(useradd-submit)', function(data){
	        	  $.post('../../user/address/updateAddress', data.field, function(flag) {
	      			if (flag) {
	      				layer.msg('修改成功');
	      				table.reload('user-address', {});//刷新表格
	      				
	      			} else {
	      				layer.msg('修改失败');
	      			}

	      		})
	            layer.close(index);
	          });  
	          
	          layero.find('iframe').contents().find("#useradd-submit").trigger('click');
	        }
	      });
	      console.log(data);

	    }
	    
	  });
	  $(".useradd").find(".address-add").on('click', function(){
	    layer.open({
	      type: 2
	      ,title: '新建地址'
	      ,content: 'iframe.html'
	      ,area: ['730px', '420px']
	      ,shade: 0.8
	      ,skin: 'address-class'
	      ,btn: '确定'
	      ,yes: function(index, layero){
	    	  
	        window['layui-layer-iframe'+ index].layui.form.on('submit(useradd-submit)', function(data){
	        console.log(data.field);
	        $.post('../../user/address/saveAddress', data.field, function(flag) {
				if (flag) {
					layer.msg('添加成功');
					table.reload('user-address', {});//刷新表格
					
				} else {
					layer.msg('添加失败');
				}

			})
	          layer.close(index);
	          
	        });  
	        layero.find('iframe').contents().find("#useradd-submit").trigger('click');
	      }
	    });
	  });
})