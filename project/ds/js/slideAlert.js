;(function ($) {

    'use strict';

    var opt = {
        // jquery 对象
        "element": null,
        // 可填的参数是 top,bottom,left,right,alert,tips
        "type": "bottom",
        // 模态框中的内容
        "content": "",
        // 类型为tips时，自动关闭时间
        "time":'1500',
        // 全部销毁
        "destroy": function () {
            modal.closeAll();
        },
        // 关闭modal
        close: function () {
          modal.close();
        },
        // 打开alert 前调用
        "beforeOpen": function () {},
        // 打开alert 后调用
        "afterOpen": function () {},
        // 关闭前调用
        "beforeClose": function () {},
        // 关闭 alert 之后调用
        "afterClose": function () {},
    };

    var $modal = null,
        $shadow = null,
        $content = null,
        $tips = null;

    var html =
        "<div id='J-jq-sd-alert' class='sd-alert'>" +
        "   <div id='J-sd-alert-shadow' class='sd-shadow'></div>" +
        "   <div class='sd-content'>" +
        "       <div id='J-sd-content'></div>" +
        "       <div id='J-sd-tips'></div>" +
        "   </div>"+
        "</div>";

    var tips_flag = false;

    var modal = {
        showModal:function(type){
            tips_flag && this.closetips();
            if(type === 'tips'){
                tips_flag = true;
                this.tips(type);
                setTimeout(function () {
                    this.closetips();
                    tips_flag = false;
                }.bind(this), opt.time);
            } else {
                $modal.data('data-type', type);
                $content.html(opt.content).parent().removeClass('sd-'+type+'-hide').addClass('sd-'+type+'-show');
            }
            opt.afterOpen();
        },
        tips: function(type){
            $tips.html(opt.content).removeClass('sd-'+type+'-hide').addClass('sd-'+type+'-show');
        },
        close: function(){
            opt.beforeClose();
            var type = $modal.data('data-type');
            !!type ? this.closeModal(type): this.closeAll();
            setTimeout(function () {
                $content.html('').parent()
                    .removeClass('sd-bottom-hide sd-top-hide sd-left-hide sd-right-hide sd-alert-hide sd-tips-hide');
                $modal.hide();
                $shadow.hide();
                $('body').removeClass('overflowHide');
                opt.afterClose();
            }, 300);

        },
        closetips:function(){
            $tips.html('').removeClass('sd-tips-hide sd-tips-show');
        },
        closeAll: function(){
            $modal.prop('outerHTML', '');
        },
        closeModal: function(type){
            $content.parent().removeClass('sd-'+type+'-show').addClass('sd-'+type+'-hide');
        },
        valid: function (element, option) {
            var canPass = true;
            element[0].nodeType !== 1 && (canPass = false, console.error("请传入合适的jquery选择器"));
            if(!option.type || "top,bottom,left,right,alert,tips".indexOf(option.type.trim()) < 0){
                canPass = false;
                console.error("invalid option.type");
            }
            return canPass;
        }
    };

    var init= function (option) {
        option.type = option.type.trim();
        opt = $.extend({}, opt, option);
        // 添加dom和遮罩层
        if(!$modal){
            $('body').addClass('overflowHide').append($('<div></div>')).children().last().prop('outerHTML', html);
            $modal = $('#J-jq-sd-alert');
            $shadow = $('#J-sd-alert-shadow');
            $content = $('#J-sd-content');
            $tips = $('#J-sd-tips');
        } else {
            $('body').addClass('overflowHide');
            $modal.show();
        }
        opt.type !== 'tips' && $shadow.show();
    };
    var addEvent= function () {
        $shadow.off('click.sd').on('click.sd', function (event) {
            modal.close();
        }).off('touchmove').on('touchmove', function (event) {
            event.preventDefault();
        });
    };
    $.fn.slideAlert = function (option) {
        if(!modal.valid(this, option)){
            return false;
        }
        option.element = this;
        init(option);
        addEvent();
        opt.beforeOpen();
        modal.showModal(opt.type);
        return opt;
    }
}($));