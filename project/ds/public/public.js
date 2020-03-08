/*2020/3/5
* 作者：王青高
* 功能：{公共关闭弹窗}
* 参数：
* {DOM:ele} dom元素
* {String:_class} 类名
*/
class public_com {
    constructor() {}
    closeMask(ele, _class) {
        let _dom = document.getElementById(ele);
        _dom.classList.remove(_class);
    }
    openAlert(ele, _class) {
        let _dom = document.getElementById(ele);
        _dom.classList.add(_class);
    }
}
window._public_com =  new public_com();
/* 2020-3-8 0008
* 作者：王青高
* 功能：{} 屏幕顶部是否显示：userInfoTitle元素
* 参数：{}
*/
function isUserInfoTitle_table() {
    let url = window.location.hash;
    console.log(url);
    if(url === '#index') {
        _public_com.closeMask('userInfoTitle', '_active');
    } else {
        _public_com.openAlert('userInfoTitle', '_active');
    }
}

/* 2020-3-8 0008
* 作者：王青高
* 功能：{} 封装监听url事件
* 参数：{}
*/
class Router{
    constructor() {
    }
    _refresh() {
        console.log(location.hash.slice(1)); // 获取到相应的hash值
        // 如果存在hash值则执行判断，否则设置hash值为/
        if(location.hash.slice(1)) {
            isUserInfoTitle_table();
        }
    }
    _init () {
        window.addEventListener('load', this._refresh.bind(this), false);
        window.addEventListener('hashchange', this._refresh.bind(this), false);
    }
}
window._Router =  new Router();