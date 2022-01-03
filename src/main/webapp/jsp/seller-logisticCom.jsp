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
				} ] ]
			});
		})
	</script>
	<table id="dg" lay-filter="test"></table>
</body>
</html>