// JavaScript Document
//user info
$(function(){
 $(".user").hover(function(){
	   $(this).css("background-color","#f8f8f8");
	   $(".user-btlink").slideDown(300);
	   //$(this).children().removeClass().addClass('hover-up');	   
	 },function(){
		 $(this).css("background-color","#eeeeee");
		 $(".user-btlink").hide(); 
		//$(this).children().removeClass().addClass('hover-down');
	});
	
    $('.user-btlink').hover(function(){
        /*保持图标向上*/
       // $('#li-'+num).children().removeClass().addClass('hover-up');
	    $(".user").css("background-color","#f8f8f8");
        $(this).show();
    },function(){
		
        $(this).slideUp(50);
		//$('#li-'+num).children().removeClass().addClass('hover-down');
		$(".user").css("background-color","#eeeeee");
    });
})

//menu
$(document).ready(function(){
    $(".pro-order").hover(function(){
        $(".pro-order-list").slideDown(300);
    },function(){
        $(".pro-order-list").hide();
    });
    $('.pro-order-list').hover(function(){
        $(this).show();
    },function(){
        $(this).slideUp(200);
       
    });

    $(".order").hover(function(){
        $(".order-list").slideDown(300);
    },function(){
        $(".order-list").hide();
    });
    $('.order-list').hover(function(){
        $(this).show();
    },function(){
        $(this).slideUp(200);
       
    });
});

//tab
$(function(){
	$(".tabmenu .item").each(function(index){
		$(this).click(function(){
			$(".item").removeClass("curr-item");
			$(this).addClass("curr-item");						
			$(".curr-tabcont").removeClass("curr-tabcont");
			$(".tabcont").eq(index).addClass("curr-tabcont");						
		});
	});
})

//order list effect
$(function(){
	$(".order-detail-box").each(function(){
		$(this).click(function(){
			$(".curr-detail-box").removeClass("curr-detail-box");
			$(this).addClass("curr-detail-box");
			$(".curr-order").removeClass("curr-order");
			$(this).parent().parent().addClass("curr-order");
		});
	});
})

//slide down and up
$(function(){
	$(".shutopt").click(function(){//当点击黄色块触发silideToggle
		$(".hiddebox").slideToggle(100);
		$(this).toggleClass("openopt"); return false;//触发后然后改变小图标方向，css在.active定义的
	});
})

//selbox
$(function(){
	$(".selbox").each(function(){
		$(this).hover(function(){//当点击黄色块触发silideToggle
			$(this).find(".sellist").slideToggle(100);
			$(this).toggleClass("selbox-down"); return false;//触发后然后改变小图标方向，css在.active定义的
		},function(){
			$(this).find(".sellist").slideToggle(100);
			$(this).toggleClass("selbox-down"); return false;//触发后然后改变小图标方向，css在.active定义的
		});
	});
})

//table
$(function(){
	$(".data-table tr").each(function(){
		$(this).hover(function(){
			$(this).addClass("hover");
		},function(){
			$(this).removeClass("hover");
	  });
	});
})

//person info edit

$(function(){
	$(".person-info li").each(function(){
		$(this).hover(function(){
			$(this).addClass("edit-info");
			$(this).find(".m-txt").css({"border":"1px solid #fff","color":"#000"});
			$(this).find(".editicon").show();
		},function(){
			$(this).removeClass("edit-info");
			$(this).find(".m-txt").css("border","1px solid #fff");
			$(this).find(".editicon").hide();
	  });
	});
	

})