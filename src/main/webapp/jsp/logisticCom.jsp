<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>物流公司</title>
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
			});

			//提交表单
			form.on('submit(add-submit)', function(data) {
				$.post('../logisticCom/addLogisticCom', data.field, function(
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
				var logisticCom = obj.data;
				if (obj.event === 'edit') {

					//编写修改对话框
					layer.open({
						title : '修改',
						type : 1,
						content : $("#edit-dialog").html()
					})
					//填充修改对话框
				    console.log(logisticCom);
					form.val("edit-load-data-form", {
						"logisticId" : logisticCom.logisticId,
						"comName" : logisticCom.comName
					})

				}
			})
			//提交表单
			form.on('submit(edit-submit)', function(data) {
				$.post('../logisticCom/updateLogisticCom', data.field,
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
					var lids = [];
					for ( var i in array) {
						lids.push(array[i].logisticId);
						console.log("array[i].productTypeId"+array[i].logisticId);
					}
					$.post('../logisticCom/removeLogisticCom', {
						"lids[]" : lids
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
				url : '../logisticCom/listLogisticCom',
				page : true,
				cols : [ [ //表头
				{
					field : 'logisticId',
					title : 'ID',
					type : 'checkbox'
				}, {
					field : 'comName',
					title : '物流公司名称'
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
			<label class="layui-form-label">物流公司名称</label>
			<div class="layui-input-inline">
				<input type="text" name="comName" required lay-verify="required"
					placeholder="请输入物流公司名称" class="layui-input">
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
			<label class="layui-form-label">物流公司名称</label>
			<div class="layui-input-inline">
				<input type="text" name="comName" required lay-verify="required"
					placeholder="请输入物流公司名称" class="layui-input"> 
               <input type="hidden" name="logisticId" class="layui-input">
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