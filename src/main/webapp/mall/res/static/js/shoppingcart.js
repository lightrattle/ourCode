layui.define(['element', 'carousel', 'table', 'util'], function(exports){
  var $ = layui.$
  ,element = layui.element
  ,form = layui.form
  ,carousel = layui.carousel
  ,laypage = layui.laypage
  ,util = layui.util
  ,table = layui.table;

  
  //购物车——表格
  table.render({
    elem: '#house-usershop-table'
    ,url:  '../../user/listShoppingCart'
    ,skin: 'line'
    ,cols: [[
      {type:'checkbox', width:50}
      ,{title:'商品', align:'center', minWidth:260, templet: '#goodsTpl'}
      ,{title:'单价', align:'center', minWidth:160, templet: '#priceTpl'}
      ,{title:'数量', align:'center', width:150, templet: '#numTpl'}
      ,{title:'小计', align:'center', width:120, templet: '#totalTpl'}
      ,{title:'操作', align:'center', width:100, templet: '#shopTpl'}
    ]]
    ,done: function(res, curr, count){
      if($("#house-usershop-table").next("div").find(".layui-none").length != 0){
        $(".house-usershop-table-num").css("display", "none");
      };
    }
    ,text: {
      none: '<div class="house-usershop-table-none"><div><img src="../res/static/img/shopnone.png"></div><p>购物车空空如也</p><a class="layui-btn layui-btn-primary" href="list.html">去逛逛</a></div>'
    }
    ,id: 'house-usershop-table'
  });
  
  //合计
  var goodsVal = $(".house-usershop").find("#total").children("span")
  ,copyWith = $(".house-usershop").find("#toCope").children("p").children("big")
  ,copyTips = $(".house-usershop").find("#toCope").children("span");
  //监听复选框选择 获得总数
  table.on('checkbox(house-usershop-table)', function(obj){
    var checkStatus = table.checkStatus('house-usershop-table');
    goodsVal[0].innerHTML = 0;
    $(checkStatus.data).each(function(){
          goodsVal[0].innerHTML = parseFloat(this.num * this.goods.discount_price) + Number(goodsVal[0].innerHTML);
    });
    //满减
    if(goodsVal[0].innerHTML > 200){
      copyWith[0].innerHTML = '￥' + (goodsVal[0].innerHTML - 20).toFixed(2)
      copyTips.css("display", "inline-block");
    }else{
      copyWith[0].innerHTML =  '￥' + parseFloat(goodsVal[0].innerHTML).toFixed(2);
      copyTips.css("display", "none");
    };
    //转换格式
    goodsVal[0].innerHTML = parseFloat(goodsVal[0].innerHTML).toFixed(2);
    if(checkStatus.data.length != 0){
      $(".house-usershop-table-num").children("input")[0].checked = true;
      form.render('checkbox');
    }else{
      $(".house-usershop-table-num").children("input")[0].checked = false;
      form.render('checkbox');
    };
    $(".house-usershop-table-num").children(".numal").html('已选 ' + checkStatus.data.length + ' 件');
  });
  table.on('tool(house-usershop-table)', function(obj){
    var data = obj.data;
    if(obj.event === 'del'){
    	console.log(data);
      layer.confirm('确定删除此物品？', function(index){

  		$.post('../../user/removeShoppingCart', {
  			productId:data.productId,buyerId:data.buyerId
			}, function(flag) {
				if(flag){
					layer.msg('删除成功')
					table.reload('house-usershop-table', {});//刷新表格
                    // window.location.href = "usershop.html"
				}else{
					layer.msg('删除失败');
				}
			})
        layer.close(index);
      });
    }
  });
  $(".house-usershop").find("#batchBuy").on('click', function(){
	    var checkStatus = table.checkStatus('house-usershop-table')
	    ,checkData = checkStatus.data;
	    if(checkData.length === 0){
	      layer.msg('请选择数据');
	    }else{
	        var productIds = "";
	        var productNums = "";
            for ( var i in checkData) {
                if(i!=0){
                    productIds+=','
                    productNums+=','
                }
                productIds+=checkData[i].productId
                productNums+=checkData[i].num
            }
            var url = "postMoney.html?productIds="+productIds+"&productNums="+productNums+"&type=1";//此处拼接内容
            window.location.href = url
	    }
});
  $(".house-usershop").find("#batchDel").on('click', function(){
    var checkStatus = table.checkStatus('house-usershop-table')
    ,checkData = checkStatus.data;
    if(checkData.length === 0){
      layer.msg('请选择数据');
    }else{
      //执行 Ajax 操作之后再重载
    	 layer.confirm('确定删除此物品？', function(index){
    		 $(checkStatus.data).each(function(){  
    			 console.log(this);
    	  		$.post('../../user/removeShoppingCart', {
    	  			productId:this.productId,buyerId:this.buyerId
    				}, function(flag) {
    					
    				 });
    				})
    				table.reload('house-usershop-table');
    		 		$(".house-usershop-table-num").children("input")[0].checked = false;
    		 			form.render('checkbox');
    		 			$(".house-usershop-table-num").children(".numal").html('已选 0 件')
    		 			copyWith[0].innerHTML = goodsVal[0].innerHTML = '￥0.00';
    		 			copyTips.css("display", "none");
    		 			layer.msg('已删除');
    		 			layer.close(index);
    	 			});
    }
  });
  exports('house', {}); 
})