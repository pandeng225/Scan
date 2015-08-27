$(function(){


    //主页宽屏banner---------------------------------------------
    $('.flexslider').flexslider({
        directionNav: true,
        pauseOnAction: false
    });

    //设置主页宽屏banner的位置---------------------------------------------
    function setNavList(){
        $('.navList_area').css({'position':'absolute','top':'0','left':$('#header').offset().left,'z-index':'4'})
    }
    setNavList();

    $(window).resize(function(){
        setNavList();
    })

    //设置showcast鼠标hover效果---------------------------------------------
    function showcast(){
        $('.showcast li').mouseenter(function(){
            $(this).children('img').animate({'bottom':'-20px'},'easeOutExpo')
        }).mouseleave(function(){
            $(this).children('img').animate({'bottom':'-40px'},'easeOutExpo')
        })

    }

    showcast();


    //设置抢购区域产品鼠标hover效果---------------------------------------------
    function flash_slide(){
        $('.flash_slide li img').mouseenter(function(){
            $(this).animate({'left':'10px'})
        }).mouseleave(function(){
            $(this).animate({'left':'0px'})
        })
    }

    flash_slide()


    //设置热销区域产品鼠标hover效果---------------------------------------------

    $('.hot_scale_list li').mouseover(function(){
        $(this).addClass('active')
    }).mouseout(function(){
        $(this).siblings().removeClass('active')
    })


    //设置二楼产品鼠标hover效果---------------------------------------------
    function sec_floor_small(){
        $('.sec_floor_small').mouseenter(function(){
            $(this).children('img').animate({'left':'10px'})
        }).mouseleave(function(){
            $(this).children('img').animate({'left':'0px'})
        })
    }
    sec_floor_small();


    //设置品牌产品鼠标hover效果---------------------------------------------
    function brand(){
        $('.brand a').mouseover(function(){

            $(this).animate({'top':'-4px'})
        }).mouseout(function(){

            $(this).animate({'top':'0'})

        })
    }

    brand()




    function move(){

        //显示左右切换图标--------------------------------------------
        $('.flash_slide-area').mouseenter(function(){

            $('.flash_prev').fadeIn()
            $('.flash_next').fadeIn()

        }).mouseleave(function(){

            $('.flash_prev').hide()
            $('.flash_next').hide()

        })

        //左右滚动--------------------------------------------

        var oneLiWidth=$('.flash_slide li').outerWidth()
        var totalWidth=Math.ceil(($('.flash_slide li').size())/2)*oneLiWidth
        $('.flash_prev').click(function(){
                $('.flash_slide').stop(true,true).animate({'left':'-='+oneLiWidth},500,'easeOutExpo')
            if(Math.abs(parseInt($('.flash_slide').css('left')))>=(Math.ceil(($('.flash_slide li').size())/2)-3)*oneLiWidth){
                $('.flash_slide').stop(true,true).animate({'left':0},500,'easeOutExpo')
            }

        })


        $('.flash_next').click(function(){
            if(parseInt($('.flash_slide').css('left'))>=0){
                $('.flash_slide:not(:animated)').stop(true,true).animate({'left':-(Math.ceil(($('.flash_slide li').size())/2)-3)*oneLiWidth},500,'easeOutExpo')
            }else{
                $('.flash_slide:not(:animated)').stop(true,true).animate({'left':'+='+oneLiWidth},500,'easeOutExpo')
            }



        })

    }

    move()



//回到顶部---------------------------------------------

    function goTop()
    {
        $(window).scroll(function() {

            if($(window).scrollTop()>100)
                $(".side_top").fadeIn(1000);
            else
                $(".side_top").fadeOut(1000);
        });

        $(".side_top").click(function() {
            $('body,html').animate({scrollTop:0},1000);
        });
    };

    goTop()






});

