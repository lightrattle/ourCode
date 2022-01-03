
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品</title>
<link rel="stylesheet" href="../layui/css/layui.css">
</head>

<body>
	<script src="../layui/layui.js"></script>
	<script type="text/javascript">
	
		layui.use([ 'layer', 'upload','form', 'jquery', 'table' ], function() {
			const layer = layui.layer;
			const form = layui.form;
			const $ = layui.jquery;
			const table = layui.table;
			const upload = layui.upload;

			 //普通图片上传
			  var productId11;
			  var uploadInst = upload.render({
			    elem: '#test1'
			    ,url: '../product/addProductpic' //改成您自己的上传接口
			    ,before: function(obj){
			      //预读本地文件示例，不支持ie8
			      this.data = {
			    	  "productId": productId11
			      }
			      obj.preview(function(index, file, result){
			        $('#demo1').attr('src', result); //图片链接（base64）
			      });
			    }
			    ,done: function(res){
			      //如果上传失败
			      if(res.code > 0){
			        return layer.msg('上传失败');
			      }
			      //上传成功
			      $('#upload_img').attr("style","display:none;")//显示div

			      console.info("000000000000");
			      window.location.reload();
			      layer.closeAll();

			    }
			    ,error: function(){
			    }
			  });

			// 商品类型数组
			var productType1;
			// 获取下拉框的值
			$.ajax({
				url: '/productType/listProductType',
				type: 'post',
				success: function (data1) {
					productType1 = data1.data;
					for (var i = 0; i < productType1.length; i++){
				       $('#productTypeName').append(new Option(productType1[i].productTypeName));// 下拉菜单里添加元素
				    }  
					layui.form.render("select");
				}
			});
			// 监听编辑下拉框
			form.on('select(selectProductType2)', function(data){
                for(var i=0; i<productType1.length; i++){
                	if(productType1[i].productTypeName == data.value){
                		$('#productTypeId2').val(productType1[i].productTypeId);
                	}
                }
			});
			// 监听添加下拉框
			form.on('select(selectProductType3)', function(data){
                for(var i=0; i<productType1.length; i++){
                	if(productType1[i].productTypeName == data.value){
                		$('#productTypeId3').val(productType1[i].productTypeId);
                	}
                }
			});

			//添加
			$("#add-but").click(function() {
				//编写添加对话框
				layer.open({
					title : '添加',
					type : 1,
					//	closeBtn : 0,
					content : $("#add-dialog").html()
				});
				// 下拉框选项查询
				$.ajax({
					url: '/productType/listProductType',
					type: 'post',
					success: function (data1) {
						var productType1 = data1.data;
						for (var i = 0; i < productType1.length; i++){
					       $('#productTypeName3').append(new Option(productType1[i].productTypeName));// 下拉菜单里添加元素
					    }  
						layui.form.render("select");
					}
				});
			});
			//提交添加
			form.on('submit(add-submit)', function(data) {

				$.post('../product/addProduct', data.field, function(
						flag) {
					if (flag) {
						layer.msg('添加成功');
						table.reload('dg', {});//刷新表格
						layer.closeAll('page');
					} else {
						layer.msg('添加失败');
					}

				})

				return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
			});

			//监听行事件
			table.on('tool(test)', function(obj) {
				var product = obj.data;
				if (obj.event === 'edit') {
					//编写修改对话框
					layer.open({
						title : '修改',
						type : 1,
						content : $("#edit-dialog").html()
					});
					// 下拉框选项查询
					$.ajax({
						url: '/productType/listProductType',
						type: 'post',
						success: function (data1) {
							var productType1 = data1.data;
							for (var i = 0; i < productType1.length; i++){
						       $('#productTypeName2').append(new Option(productType1[i].productTypeName));// 下拉菜单里添加元素
						    }  
							layui.form.render("select");
						}
					});
					//填充修改对话框
					form.val("edit-load-data-form", {
						"productId" : product.productId,
						"sellerId" : product.sellerId,
						"productTypeId" : product.productTypeId,
						"productTypeName": product.productTypeName,
						"productName" : product.productName,
						"productImage" : product.productImage,
						"price" : product.price,
						"discountPrice" : product.discountPrice,
						"storage" : product.storage,
						"sale" : product.sale,
						"state" : product.state,
						"createTime" : product.createTime,
						"modifyTime" : product.modifyTime,
						"productDescribe" :product.productDescribe
					});
				} else if(obj.event === 'addStorage' ){
					// 填充补货对话框
					layer.open({
						title : '补货',
						type : 1,
						content : $("#addStorage-dialog").html()
					});	
					// 填充给补货对话框
					form.val("adddStorage-load-data-form",{
						"productId": product.productId,
						"productName": product.productName
					});
				} else if(obj.event === 'up' ){
					if(product.state == 1){
						// 1-上架
						layer.msg("已上架");
					}else{
						$.post('../product/setProductState', {
							"productId" : product.productId,
							"state": 1
						}, function(flag) {
							if (flag) {
								layer.msg('上架成功')
								table.reload('dg', {});//刷新表格
							} else {
								layer.msg('上架失败');
							}

						});
					}
				} else if(obj.event == 'down'){
					if(product.state != 1){
						// 0-上架
						layer.msg("已下架");
					}else{
						$.post('../product/setProductState', {
							"productId" : product.productId,
							"state": 0
						}, function(flag) {
							if (flag) {
								layer.msg('下架成功')
								table.reload('dg', {});//刷新表格
							} else {
								layer.msg('下架失败');
							}
						});
					}
				}
				else if(obj.event == 'pic'){    //上传图片

					productId11 = product.productId;
					layer.open({
						type : 1,
						title : '上传图片',
						content : $('#upload_img').attr("style","display:block"),//显示div
                        end: function () {//无论是确认还是取消，只要层被销毁了，end都会执行，不携带任何参数。layer.open关闭事件
                            $('#upload_img').attr("style","display:none")
                        }
					});
                    $('#demo1').attr('src',"../../img/"+product.productImage)
				}
				
			});
			//提交修改
			form.on('submit(edit-submit)', function(data) {
				$.post('../product/updateProduct', data.field,
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
			//提交补货
			form.on('submit(addStorage-submit)', function(data) {
				$.post('../product/setProductStorage', data.field,
						function(flag) {
							if (flag) {
								layer.msg('补货成功');
								table.reload('dg', {});//刷新表格
								layer.closeAll('page');
							} else {
								layer.msg('补货失败');
							}

						});
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
						pids.push(array[i].productId);
						console.log("array[i].productId"+array[i].productId);
					}
					$.post('../product/removeProduct', {
						"pids[]" : pids
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
						productTypeId : $("#productTypeId").val()
					}
				});//刷新表格
			})

			//第一个实例
			table.render({
				elem : '#dg',
				url : '../product/listProduct',
				page : true,
				height:400,
				cols : [ [ //表头
				{
					field : 'productId',
					title : 'ID',
					type : 'checkbox'
				}, {
					field : 'sellerId',
					title : '卖家ID',
					hide: true
				}, {
					field : 'productTypeId',
					title : '商品类型ID'
				}, {
					field : 'productTypeName',
					title : '商品类型名'
				}, {
					field : 'productName',
					title : '商品名称'
				}, {
					field : 'productImage',
					title : '商品图片路径'
				}, {
					field : 'price',
					title : '原价'
				}, {
					field : 'discountPrice',
					title : '优惠价'
				}, {
					field : 'storage',
					title : '库存量'
				}, {
					field : 'sale',
					title : '销量'
				}, {
					field : 'state',
					title : '商品状态',
                    templet:function(data){
                            if(data.state==0){
                                return "下架";
                            }else{
                                return "上架"
                            }
                        }
				}, {
					field : 'createTime',
					title : '创建时间'
				}, {
					field : 'modifyTime',
					title : '修改时间'
				},{
					field : 'productDescribe',
						title : '商品详情'
					},
					{
					title : '操作',
					toolbar : '#barDemo',
					width : 350
				} ] ]
			});
		})
	</script>


	<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs layui-btn-normal"  id='test1' lay-event="pic"><i class="layui-icon">&#xe642;</i>图片</a>
     <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
     <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="addStorage"><i class="layui-icon">&#xe642;</i>补货</a>
     <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="up"><i class="layui-icon">&#xe642;</i>上架</a>
     <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="down"><i class="layui-icon">&#xe642;</i>下架</a>
   </script>

	<div class="demoTable">
		商品类型ID
		<div class="layui-inline">
			<input class="layui-input" id="productTypeId">
		</div>
		<button id="search-but" class="layui-btn ">
			<i class="layui-icon">&#xe615;</i>搜索
		</button>
		<button id="add-but" class="layui-btn  layui-btn-warm">
			<i class="layui-icon">&#xe654;</i>添加
		</button>
		<button id="remove-but" class="layui-btn  layui-btn-danger">
			<i class="layui-icon">&#xe640;</i>删除
		</button>
	</div>
	<table id="dg" lay-filter="test"></table>

	<!-- 	添加 -->
	   <div class="layui-upload" id="upload_img"  style="width:300px;height:300px;display: none" align="center">
			<div class="layui-upload-list">
				<img class="layui-upload-img" src="../res/static/img/person.png" align="middle" width=200px height=200px id="demo1">
			</div>
			<button type="button" class="layui-btn" id="test1">修改图片</button>
		</div>

	<script type="text/html" id="add-dialog">
	<form class="layui-form" method="post">
		<div class="layui-form-item">
			<label class="layui-form-label">商品名称</label>
			<div class="layui-input-inline">
				<input type="text" name="productName" required lay-verify="required"
					placeholder="请输入商品名称" class="layui-input">
			</div>
           <label class="layui-form-label">商品类别名称</label>
            <div class="layui-input-inline">
              <select name="productTypeName" id="productTypeName3" lay-filter="selectProductType3" lay-verify="required">
                <option value=""></option>
              </select>
              <input type="hidden" name="productTypeId" id="productTypeId3" class="layui-input">
            </div>
       

		</div>
		<div class="layui-form-item">

		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">商品原价</label>
			<div class="layui-input-inline">
				<input type="text" name="price" required lay-verify="required"
					placeholder="请输入商品原价" class="layui-input">
			</div>
			<label class="layui-form-label">商品优惠价</label>
			<div class="layui-input-inline">
				<input type="text" name="discountPrice" required lay-verify="required"
					placeholder="请输入商品优惠价" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">库存量</label>
			<div class="layui-input-inline">
				<input type="text" name="storage" required lay-verify="required"
					placeholder="请输入库存量" class="layui-input">
			</div>
            <label class="layui-form-label">商品状态</label>
			<div class="layui-input-inline">
				<input type="text" name="state" required lay-verify="required"
					placeholder="请输入商品状态" class="layui-input">（1上架 0下架）
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">商品详情</label>
			<div class="layui-input-inline">
				<textarea type="text" name="productDescribe" required lay-verify="required"
					   placeholder="请输入商品详情" class="layui-input"></textarea>
			</div>
		</div>
	
	
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="add-submit">保存</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>
	</script>

	<!-- 	修改-->
	<script type="text/html" id="edit-dialog">
		<form class="layui-form" method="post"  lay-filter="edit-load-data-form">
		<div class="layui-form-item">
			<label class="layui-form-label">商品名称</label>
			<div class="layui-input-inline">
				<input type="text" name="productName" required lay-verify="required"
					placeholder="请输入商品名称" class="layui-input">
<!-- 				商品ID-隐藏域 -->
				<input type="hidden" name="productId" class="layui-input">
				<input type="hidden" name="createTime" class="layui-input">
				<input type="hidden" name="modifyTime" class="layui-input">
				<input type="hidden" name="sale" class="'layui-input">
			</div>
            <label class="layui-form-label">商品类别名称</label>
            <div class="layui-input-inline">
              <select name="productTypeName" id="productTypeName2" lay-filter="selectProductType2" lay-verify="required">
                <option value=""></option>
              </select>
              <input type="hidden" name="productTypeId" id="productTypeId2" class="layui-input">
            </div>

		</div>
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input type="hidden" name="sellerId" required lay-verify="required"
					placeholder="请输入卖家ID" class="layui-input">
			</div>  
			<label class="layui-form-label">商品图片路径</label>
			<div class="layui-input-inline">
				<input type="text" name="productImage" required lay-verify="required"
					placeholder="请输入商品图片路径" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">商品原价</label>
			<div class="layui-input-inline">
				<input type="text" name="price" required lay-verify="required"
					placeholder="请输入商品原价" class="layui-input">
			</div>
			<label class="layui-form-label">商品优惠价</label>
			<div class="layui-input-inline">
				<input type="text" name="discountPrice" required lay-verify="required"
					placeholder="请输入商品优惠价" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">库存量</label>
			<div class="layui-input-inline">
				<input type="text" name="storage" required lay-verify="required"
					placeholder="请输入库存量" class="layui-input">
			</div>
            <label class="layui-form-label">商品状态</label>
			<div class="layui-input-inline">
				<input type="text" name="state" required lay-verify="required"
					placeholder="请输入商品状态" class="layui-input">（1上架 0下架）
			</div>
		</div>
		<div>
			<div class="layui-form-item">
				<label class="layui-form-label">商品详情</label>
				<div class="layui-input-inline">
					<textarea type="text" name="productDescribe" required lay-verify="required"
						   placeholder="请输入商品详情" class="layui-input"></textarea>
				</div>
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

<!-- 	发货-->
	<script type="text/html" id="addStorage-dialog">
		<form class="layui-form" method="post"  lay-filter="adddStorage-load-data-form">
		<div class="layui-form-item">
			<label class="layui-form-label">商品名称</label>
			<div class="layui-input-inline">
				<input type="text" name="productName" required lay-verify="required"
					placeholder="请输入商品名称" class="layui-input">
<!-- 				商品ID-隐藏域 -->
				<input type="hidden" name="productId" class="layui-input">
			</div>
			<label class="layui-form-label">补货数量</label>
			<div class="layui-input-inline">
				<input type="text" name="storage" required lay-verify="required"
					placeholder="请输入补货数量" class="layui-input">
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="addStorage-submit">保存</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>
	</script>

</body>
</html>