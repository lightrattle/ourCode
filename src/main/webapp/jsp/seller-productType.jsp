
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>类别</title>
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

			//添加
			$("#add-but").click(function() {
				//编写添加对话框
				layer.open({
					title : '添加',
					type : 1,
					//	closeBtn : 0,
					content : $("#add-dialog").html()
				});
				$.ajax({
					url: '/productType/listProductType',
					type: 'post',
					success: function (data1) {
						var productType1 = data1.data;
						console.log(productType1);
						for (var i = 0; i < productType1.length; i++){
							console.log("productTypeName: "+productType1[i].productTypeName) ;
					       $('#productTypeName').append(new Option(productType1[i].productTypeName));// 下拉菜单里添加元素
					    }  
						layui.form.render("select");
					}
				});
			});

			//提交表单
			form.on('submit(add-submit)', function(data) {
				$.post('../productType/addProductType', data.field, function(
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
				var productType = obj.data;
				if (obj.event === 'edit') {

					//编写修改对话框
					layer.open({
						title : '修改',
						type : 1,
						content : $("#edit-dialog").html()
					})
					//填充修改对话框
					form.val("edit-load-data-form", {
						"productTypeId" : productType.productTypeId,
						"productTypeName" : productType.productTypeName
					})

				}
			})

			//删除
			$("#remove-but").click(function() {
				var array = table.checkStatus('dg').data;

				if (array.length == 0) {
					layer.msg('请选择要删除的记录');
				} else {
					var pids = [];
					for ( var i in array) {
						pids.push(array[i].productTypeId);
						console.log("array[i].productTypeId"+array[i].productTypeId);
					}
					$.post('../productType/removeProductType', {
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
						productTypeName : $("#productTypeName").val()
					}
				});//刷新表格

			})

			//第一个实例
			table.render({
				elem : '#dg',
				url : '../productType/listProductType',
				page : true,
				cols : [ [ //表头
				{
					field : 'productTypeId',
					title : 'ID',
					type : 'checkbox'
				}, {
					field : 'productTypeName',
					title : '分类名称'
				}, {
					title : '操作',
					toolbar : '#barDemo',
					width : 100
				} ] ]
			});
		})
	</script>


	<script type="text/html" id="barDemo">
     <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
   </script>

	<div class="demoTable">
		<button id="add-but" class="layui-btn  layui-btn-warm">
			<i class="layui-icon">&#xe654;</i>添加
		</button>
		<button id="remove-but" class="layui-btn  layui-btn-danger">
			<i class="layui-icon">&#xe640;</i>删除
		</button>
	</div>
	<table id="dg" lay-filter="test"></table>
	<!-- 	添加 -->
	<script type="text/html" id="add-dialog">
	<form class="layui-form" method="post">
       <div class="layui-form-item">
          <label class="layui-form-label">选择商品类别</label>
          <div class="layui-input-block">
            <select name="productTypeName" id="productTypeName" lay-filter="selectProductType" lay-verify="required">
              <option value=""></option>
            </select>
            <input type="hidden" name="productTypeId" class="layui-input">
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
			<label class="layui-form-label">类别名称</label>
			<div class="layui-input-inline">
				<input type="text" name="productTypeName" required lay-verify="required"
					placeholder="请输入类别名称" class="layui-input"> <input
					type="hidden" name="productTypeId" class="layui-input">
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