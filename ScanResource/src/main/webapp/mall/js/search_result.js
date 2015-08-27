/**
 * Created by Administrator on 2014/12/22 0022.
 */

$(function() {

    //设置导航列表hover效果---------------------------------------------
    var navTimer;
    $('.navList').mouseenter(function () {

        clearTimeout(navTimer);
        $('.list_area').slideDown();
        $('.navList h1 span').removeClass('m-icon-angle-down');
        $('.navList h1 span').addClass('m-icon-angle-up');


    }).mouseleave(function () {
        clearTimeout(navTimer);
        navTimer=setTimeout(function(){
            $('.list_area').slideUp();
            $('.navList h1 span').removeClass('m-icon-angle-up');
            $('.navList h1 span').addClass('m-icon-angle-down');
        },400);


    })


    //设置热销区域产品鼠标hover效果---------------------------------------------

    $('.hot_scale_list li').mouseover(function () {
        $(this).addClass('active')
    }).mouseout(function () {
        $(this).siblings().removeClass('active')
    })


})


