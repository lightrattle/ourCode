loadData();
function loadData(){

    layui.use(["jquery","element","laypage"],function(){
        var $ = layui.jquery;
        var element = layui.element;
        var laypage = layui.laypage
        $.ajax({
            type:"post",
            url:"/productType/listProductType",
            data:{
                "page":1,
                "limit":10, //给定了一个分类个数，需要时再改
            },
            success:function(res){
                //console.info(res);
                var data = res.data
                data.forEach(function(item){//显示分类
                    element.tabAdd('type_list', {
                        title: item.productTypeName
                        ,content: "<div id='tabdiv'+"+ item.productTypeId +">hhhhhhhhhhhhhhhhhh</div>" //支持传入html
                        ,id: 'tab'+item.productTypeId
                    });
                })
            }
        })

        element.on('tab(type_list)', function(data){
            var tab = data.elem.context.attributes[0].value
            var dataNum; //获得数据总数
            $.ajax({
                url:"/getProductNum",
                type:"post",
                data:{
                    productTypeId:tab.split("tab")[1], //恰好对应
                },
                success:function(res){
                    dataNum = res;
                    //渲染放在ajax里面。同步刷新
                    laypage.render({
                        elem: 'houseList'
                        ,count: dataNum //数据总数，从服务端得到
                        ,limit: 20
                        ,jump: function(obj, first){ //jump就是跳转的回调函数
                            //obj包含了当前分页的所有参数，比如：
                            $.ajax({
                                type:"post",
                                url:"/listPageProductByType",
                                data:{
                                    goodname:document.getElementById("queryGoodName").value,
                                    typeId:tab.split("tab")[1], //分类id
                                    pageNo:obj.curr, //页数
                                    pageCapacity:obj.limit, //每页个数
                                },
                                success: function(res){
                                    $("#product_list").html("")//清空原内容
                                    res.forEach(function(item){//显示每个商品
                                        var price;
                                        if(item.discountPrice==null){
                                            price = item.price;
                                        }else{
                                            price = item.discountPrice;
                                        }
                                        var newText =
                                            "<div class='layui-col-xs6 layui-col-sm3'>"+
                                            "<div class='list-detail'>"+
                                            "<div class='img'><img style='height:300px' src='../../img/"+
                                            item.productImage+ "'"+
                                            "/></div>"+
                                            "<p class='title'>" +
                                            "<a href='detail.html?productId="+ item.productId +"'>"+ item.productName +"</a>"+
                                            "</p>"+
                                            "<p>" +
                                            "<span class='price'>￥"+ item.price +"</span>"+
                                            "<span>"+ item.sale +"</span>人付款"+
                                            "</p>"+
                                            "</div>"+
                                            "</div>";
                                        $("#product_list").html($("#product_list").html()+newText)

                                    });
                                }
                            })
                            //首次不执行
                            if(!first){
                                //do something
                            }
                        }
                    });
                }
            })
        });
    })
}

document.onkeydown = function (e) { // 回车提交表单
    var theEvent = window.event || e;
    var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
    if (code == 13) {
        layui.use(["jquery","element","laypage"],function() {
            var $ = layui.jquery;
            $.ajax({
                type: "post",
                url: "/listPageProductByType",
                data: {
                    goodname: document.getElementById("queryGoodName").value,
                    typeId: -1, //分类id
                    pageNo: 1, //页数
                    pageCapacity: 20, //每页个数
                },
                success: function (res) {
                    $("#product_list").html("")//清空原内容
                    res.forEach(function (item) {//显示每个商品
                        var price;
                        if (item.discountPrice == null) {
                            price = item.price;
                        } else {
                            price = item.discountPrice;
                        }
                        var newText =
                            "<div class='layui-col-xs6 layui-col-sm3'>" +
                            "<div class='list-detail'>" +
                            "<div class='img'><img style='height:300px' src='../../img/" +
                            item.productImage + "'" +
                            "/></div>" +
                            "<p class='title'>" +
                            "<a href='detail.html?productId=" + item.productId + "'>" + item.productName + "</a>" +
                            "</p>" +
                            "<p>" +
                            "<span class='price'>￥" + item.price + "</span>" +
                            "<span>" + item.sale + "</span>人付款" +
                            "</p>" +
                            "</div>" +
                            "</div>";
                        $("#product_list").html($("#product_list").html() + newText)

                    });
                }
            })
        })
    }
}