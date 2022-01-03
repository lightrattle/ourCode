function login_exchange() {
    window.location.href = "http://81.69.235.254:8808/mall/html/index.html";
}
function Myclick() {
    var media = document.getElementById("clickMusic");
    media.play();
}
function choose_search() {
    var root_info = document.getElementById('search-info').value;
    var str_info = root_info.toString();
    var search_choose = str_info.substring(0,2);
    var search_text = str_info.substring(2);
    if(search_choose == "百度" || search_choose == "baidu") {
        window.location.href = "https://www.baidu.com/s?wd=" + search_text;
    } else if(search_choose == "必应" || search_choose == "bing") {
        window.location.href = "https://cn.bing.com/search?q=" + search_text;
    } else if(search_choose == "头条" || search_choose == "baidu") {
        window.location.href = "https://so.toutiao.com/search?keyword=" + search_text;
    }
}
function inAjax(cho) {
    if(cho == 1) {
        document.getElementById("iFrame").innerHTML
        ='<iframe src="OneByWu.html" width= "980px" height= "200px"></iframe>';
    } else if(cho == 2) {
        document.getElementById("iFrame").innerHTML
        ='<iframe src="OneByHe.html" width= "980px" height= "200px"></iframe>';
    } else if(cho == 3) {
        document.getElementById("iFrame").innerHTML
        ='<iframe src="OneByLiu.html" width= "980px" height= "200px"></iframe>';
    } else if(cho == 4) {
        document.getElementById("iFrame").innerHTML
        ='<iframe src="OneByWei.html" width= "980px" height= "200px"></iframe>';
    } else if(cho == 5) {
        document.getElementById("iFrame").innerHTML
        ='<iframe src="https://cn.bing.com/" width= "980px" height= "200px"></iframe>';
    }
}