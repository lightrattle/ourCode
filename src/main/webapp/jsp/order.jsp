<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单</title>
<link rel="stylesheet" href="../layui/css/layui.css">
</head>

<body>
	<script src="../layui/layui.js"></script>
	<script type="text/javascript">
		layui.use([ 'layer', 'form', 'jquery', 'table' ], function() {
			const layer = layui.layer;
			const form = layui.form;
			const $ = layui.jquery;
			const table = layui.table

			// 商品类型数组
			var logisticCom1;
			
			// 监听下拉框
			form.on('select(selectComName)', function(data){
                for(var i=0; i<logisticCom1.length; i++){
                	if(logisticCom1[i].comName == data.value){
                		$('#logisticId').val(logisticCom1[i].logisticId);
                	}
                }
			});
			
			//监听toolbar事件
			table.on('tool(test)', function(obj) {
				var order = obj.data;
				if (obj.event === 'edit') {
					//编写修改对话框
					layer.open({
						title : '修改',
						type : 1,
						area: ['800px', '450px'],
						content : $("#edit-dialog").html()
					});
					//填充修改对话框
					form.val("edit-load-data-form", {
						"orderId" : order.orderId,
						"productId" : order.productId,
						"productName": order.productName,
						"productNum" : order.productNum,
						"price" : order.price,
						"buyerId" : order.buyerId,
						"sellerId" : order.sellerId,
						"orderTime" : order.orderTime,
						"buyerAddr" : order.buyerAddr,
						"sellerAddr" : order.sellerAddr,
						"logisticId" : order.logisticId,
						"comName" : order.comName,
						"status" : order.status,
						"buyerAddrName":order.buyerAddrName
					});
					// 获取下拉框的值
					$.ajax({
						url: '/logisticCom/listLogisticCom',
						type: 'post',
						success: function (data1) {
							logisticCom1 = data1.data;
							for (var i = 0; i < logisticCom1.length; i++){
						       $('#comName').append(new Option(logisticCom1[i].comName));// 下拉菜单里添加元素
							}  
							layui.form.render("select");
						}
					});
				}else if(obj.event == 'deliver'){    // 发货
					console.log(order.status);
					if(order.status == 2 ){  // 2--已签收
						layer.msg("买家已签收");
					}else if(order.status == 1 ){  // 1--已发货
						layer.msg("此订单已发货");
					}else if(order.status == 0 ){  // 0--未发货
						
						if(order.logisticId <= 0){
							layer.msg("请选择物流公司");
						}else{
							order.status=1;
							$.ajax({  // 发货--修改订单状态
								url: '../order/updateOrder',
								type: 'post',
								data: order,
								success:function(flag){
									layer.msg("发货成功");
									table.reload('dg', {});//刷新表格
								},
								error:function(flag){
									console.log(flag);
								}
							});
						}
					}
				}
			});
			//提交表单
			form.on('submit(edit-submit)', function(data) {
				$.post('../order/updateOrder', data.field,
						function(flag) {
							if (flag) {
								layer.msg('修改成功');
								table.reload('dg', {});//刷新表格
								layer.closeAll('page');
							} else {
								layer.msg('修改失败');
							}

						})

				return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
			});

			//删除
			$("#remove-but").click(function() {
				var array = table.checkStatus('dg').data;

				if (array.length == 0) {
					layer.msg('请选择要删除的记录');
				} else {
					var pids = [];
					for ( var i in array) {
						pids.push(array[i].orderId);
						console.log("array[i].productTypeId"+array[i].orderId);
					}
					$.post('../order/removeOrder', {
						"oids[]" : pids
					}, function(flag) {
						if (flag) {
							layer.msg('删除成功')
							table.reload('dg', {});//刷新表格
						} else {
							layer.msg('删除失败');
						}

					})
				}

			})

			//条件查询
			$("#search-but").click(function() {
				table.reload('dg', {
					where : {
						productTypeName : $("#productTypeName").val()
					}
				});//刷新表格
			})

			//第一个实例
			table.render({
				elem : '#dg',
				url : '../order/listOrder',
				page : true,
				cols : [ [ //表头
				{
					field : 'orderId',
					title : 'ID',
					type : 'checkbox'
				}, {
					field : 'productId',
					title : '商品ID'
				},  {
					field : 'productName',
					title : '商品名字'
				}, {
					field : 'productNum',
					title : '订购商品数量'
				}, {
					field : 'price',
					title : '商品单价'
				}, {
					field : 'buyerId',
					title : '买家ID'
				}, {
					field : 'sellerId',
					title : '卖家ID',
					hide: true
				}, {
					field : 'orderTime',
					title : '订单生成时间'
				}, {
					field : 'buyerAddr',
					title : '买家收货地址'
				}, {
					field : 'sellerAddr',
					title : '卖家收货地址'
				}, {
					field : 'logisticId',
					title : '物流公司ID'
				}, {
					field : 'comName',
					title : '物流公司名称'
				}, {
					field : 'status',
					title : '订单状态',
					templet:function(data){
						if(data.status==0){
						    return "未发货";
						}else if(data.status==1){
						    return "已发货"
						}else{
						    return "已签收"
						}
					}
				}, {
					title : '操作',
					toolbar : '#barDemo',
					width : 160
				} ] ]
			});
		})
	</script>


	<script type="text/html" id="barDemo">
     <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
     <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="deliver"><i class="layui-icon">&#xe642;</i>发货</a>
   </script>

	<div class="demoTable">
		<button id="remove-but" class="layui-btn  layui-btn-danger">
			<i class="layui-icon">&#xe640;</i>删除
		</button>
	</div>
	
	<table id="dg" lay-filter="test"></table>

	<!-- 	修改-->
	<script type="text/html" id="edit-dialog">
		<form class="layui-form" method="post"  lay-filter="edit-load-data-form">
        <br>
		<div class="layui-form-item">
			<label class="layui-form-label">商品名称</label>
			<div class="layui-input-inline">
				<input type="text" name="productName" required lay-verify="required"
					placeholder="请输入商品名称" class="layui-input"> 
<!-- 				隐藏域	 -->
                <input type="hidden" name="productId" class="layui-input">
				<input type="hidden" name="orderId" class="layui-input">
			</div>
			<label class="layui-form-label">订购商品数量</label>
			<div class="layui-input-inline">
				<input type="text" name="productNum" required lay-verify="required"
					placeholder="请输入订购商品数量" class="layui-input"> 
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">商品单价</label>
			<div class="layui-input-inline">
				<input type="text" name="price" required lay-verify="required"
					placeholder="请输入商品单价" class="layui-input"> 
			</div>
			<div class="layui-input-inline">
				<input type="hidden" name="buyerId" required lay-verify="required"
					placeholder="请输入买家ID" class="layui-input"> 
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input type="hidden" name="sellerId" required lay-verify="required"
					placeholder="请输入卖家ID" class="layui-input"> 
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">买家收货地址</label>
			<div class="layui-input-inline">
				<input type="text" name="buyerAddr" required lay-verify="required"
					placeholder="请输入买家收货地址" class="layui-input"> 
			</div>
			<label class="layui-form-label">卖家发货地址</label>
			<div class="layui-input-inline">
				<input type="text" name="sellerAddr" required lay-verify="required"
					placeholder="请输入卖家发货地址" class="layui-input"> 
			</div>
		</div>
		
		<div class="layui-form-item">
            <label class="layui-form-label">物流公司</label>
            <div class="layui-input-inline">
              <select name="comName" id="comName" lay-filter="selectComName" lay-verify="required" class="layui-input">
                <option value=""></option>
              </select>
              <input type="hidden" name="logisticId" id="logisticId" class="layui-input">
            </div>


			<label class="layui-form-label">订单状态</label>
			<div class="layui-input-inline">
				<input type="text" name="status" required lay-verify="required"
					placeholder="请输入订单状态" class="layui-input"> （0未发货 1已发货 2已签收）
			</div>
		</div>
	
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="edit-submit">保存</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>
	</script>

</body>
</html>