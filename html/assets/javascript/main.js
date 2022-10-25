jQuery(function() {

    // Menu Custom Scrollbar 
    if($(window).width() > 1400) {
        // $(".mainMenu").mCustomScrollbar();
    }
    $(".manufacturers__form").mCustomScrollbar();
    $(".cartPopup__list").mCustomScrollbar();

    // $(window).on('resize',function() {
    //     var width = $(window).width();
    //     if(width > 1400) {
    //         $(".mainMenu").mCustomScrollbar();
    //         $(".cartPopup__list").mCustomScrollbar();
    //         $(".manufacturers__form").mCustomScrollbar();
    //     } else {
    //         $(".mainMenu").mCustomScrollbar('destroy');
    //         $(".cartPopup__list").mCustomScrollbar('destroy');
    //         $(".manufacturers__form").mCustomScrollbar();
    //     }
    // });


    $('.nav__arrow').on('click', function(e) {
      $(this).toggleClass('active');
      $(this).parent().toggleClass('active');
    });


    // 
    $('.catalog__filterMobile').on('click', function() {
      $('.catalog__filter').toggleClass('filter__mobile');
      $(this).toggleClass('filter__opacity');
    });


    // Show Search form
    $('.topMenu__item_search').on('click', function() {
        $('.search__wrapper').slideToggle(300);
    });


    //Show/Hide popup City popup Form
    $('.city__close').on('click', function() {
        $('.city').hide(300);
    });
    $('.header__location').on('click', function() {
        $('.city').show(300);
        $('.popup').show(300);
        $('.popup__wrapper').hide();
    });
    
    $('.popup__overlay, .popup__close, .city__close').on('click', function() {
      $('.popup').hide(300);
      $('.city').hide(300);
      $('.popup__wrapper').hide(300);
      $('.callBack').hide(300);
    });
    $('.opbtn__buy').on('click', function() {
      $('.popup').show(300);
      $('.city').hide();
      $('.popup__wrapper').show(300);
    });
    $('.contacts__back').on('click', function() {
      $('.callBack').show(300);
      $('.city').hide();
      $('.popup__wrapper').hide();
      $('.popup').show(300);
    });

    $('.popup__submit').on('click', function(e) {
      e.preventDefault();
      $('.popupForm').hide();
      $('.popup__thanks').show();
    });


    // Mobile Menu
    $('.header__mobileMenu_show').on('click', function() {
        $('.header__nav').show();
        $('.header__mobileMenu_close').show();
        $(this).hide();
    });

    $('.header__mobileMenu_close').on('click', function() {
        $('.header__nav').hide();
        $('.header__mobileMenu_show').show();
        $(this).hide();
    });

    $('.goodsin__tags__btn').on('click', function(){
      $('.goodsin__tags').toggleClass('goodsin__tags_collapse');
    })
    // Sliders

          $('.goodsin__slider-top').slick(
        {
            // infinite: true,
            slidesToShow: 6,
            slidesToScroll: 1,
            arrows: true,
            dots: false,

            freeMode: false,
            nextArrow: '<img src="assets/images/icon-slideRight-dark.svg" class="goodsin__slider-top__nav goodsin__slider-top__nav_next"/>',
            prevArrow: '<img src="assets/images/icon-slideLeft-dark.svg" class="goodsin__slider-top__nav goodsin__slider-top__nav_prev"/>',
            responsive: [
                {
                  breakpoint: 900,
                  settings: {
                    slidesToShow: 5,
                  }
                },
                {
                  breakpoint: 770,
                  settings: {
                    slidesToShow: 3,
                  }
                },
                 {
                  breakpoint: 500,
                  settings: {
                    slidesToShow: 2,
                  }
                },
              ]
    });
    $('.header__slider').slick(
        {
            infinite: true,
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: false,
            dots: true,
        }
    );

    $('.compSlider').slick(
        {
            infinite: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            arrows: true,
            dots: false,
            nextArrow: '<img src="assets/images/icon-slideRight-dark.svg" class="bestsellers__nav bestsellers__nav_next"/>',
            prevArrow: '<img src="assets/images/icon-slideLeft-dark.svg" class="bestsellers__nav bestsellers__nav_prev"/>',
            responsive: [
              {
                breakpoint: 1300,
                settings: {
                  dots: true,
                  slidesToShow: 3,
                  // appendArrows: '.bestseller__mobile',
                  appendDots: '.bestsellers__mobileDots'
                }
              },
              {
                breakpoint: 900,
                settings: {
                  dots: true,
                  slidesToShow: 2,
                  // appendArrows: '.bestseller__mobile',
                  appendDots: '.bestsellers__mobileDots'
                }
              },
              {
                breakpoint: 600,
                settings: {
                  dots: true,
                  slidesToShow: 1,
                  // appendArrows: '.bestseller__mobile',
                  appendDots: '.bestsellers__mobileDots'
                }
              },
            ]
          }
    );

    $('.bestsellers__slider').slick(
        {
            // infinite: true,
            slidesToShow: 4,
            slidesToScroll: 1,
            arrows: true,
            dots: true,
            freeMode: false,
            appendDots: '.bestsellers__dots',
            nextArrow: '<img src="assets/images/icon-slideRight-dark.svg" class="bestsellers__nav bestsellers__nav_next"/>',
            prevArrow: '<img src="assets/images/icon-slideLeft-dark.svg" class="bestsellers__nav bestsellers__nav_prev"/>',
            responsive: [
                {
                  breakpoint: 1300,
                  settings: {
                    slidesToShow: 3,
                    appendArrows: '.bestseller__mobile',
                    appendDots: '.bestsellers__mobileDots'
                  }
                },
                {
                  breakpoint: 900,
                  settings: {
                    slidesToShow: 2,
                    appendArrows: '.bestseller__mobile',
                    appendDots: '.bestsellers__mobileDots'
                  }
                },
                {
                  breakpoint: 600,
                  settings: {
                    slidesToShow: 1,
                    appendArrows: '.bestseller__mobile',
                    appendDots: '.bestsellers__mobileDots'
                  }
                },
              ]
    });

    $('.shouldLike__slider').slick(
        {
            infinite: true,
            slidesToShow: 4,
            slidesToScroll: 1,
            arrows: true,
            dots: true,
            freeMode: false,
            appendDots: '.shouldLike__mobileDots',
            nextArrow: '<img src="assets/images/icon-slideRight-dark.svg" class="bestsellers__nav bestsellers__nav_next"/>',
            prevArrow: '<img src="assets/images/icon-slideLeft-dark.svg" class="bestsellers__nav bestsellers__nav_prev"/>',
            responsive: [
                {
                  breakpoint: 1300,
                  settings: {
                    slidesToShow: 3,
                    appendArrows: '.shouldLike__mobile',
                    appendDots: '.shouldLike__mobileDots'
                  }
                },
                {
                  breakpoint: 900,
                  settings: {
                    slidesToShow: 2,
                    appendArrows: '.shouldLike__mobile',
                    appendDots: '.shouldLike__mobileDots'
                  }
                },
                {
                  breakpoint: 600,
                  settings: {
                    slidesToShow: 1,
                    appendArrows: '.shouldLike__mobile',
                    appendDots: '.shouldLike__mobileDots'
                  }
                },
              ]
    });

    $('.sameProd__slider').slick(
        {
            infinite: true,
            slidesToShow: 4,
            slidesToScroll: 1,
            arrows: true,
            dots: true,
            freeMode: false,
            appendDots: '.sameProd__mobileDots',
            nextArrow: '<img src="assets/images/icon-slideRight-dark.svg" class="bestsellers__nav bestsellers__nav_next"/>',
            prevArrow: '<img src="assets/images/icon-slideLeft-dark.svg" class="bestsellers__nav bestsellers__nav_prev"/>',
            responsive: [
                {
                  breakpoint: 1300,
                  dots: true,
                  settings: {
                    slidesToShow: 3,
                    appendArrows: '.sameProd__mobile',
                    appendDots: '.sameProd__mobileDots'
                  }
                },
                {
                  breakpoint: 900,
                  settings: {
                    slidesToShow: 2,
                    dots: true,
                    appendArrows: '.sameProd__mobile',
                    appendDots: '.sameProd__mobileDots'
                  }
                },
                {
                  breakpoint: 600,
                  settings: {
                    slidesToShow: 1,
                    dots: true,
                    appendArrows: '.sameProd__mobile',
                    appendDots: '.sameProd__mobileDots'
                  }
                },
              ]
    });

    $('.goods__slider').slick(
        {
            infinite: true,
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: true,
            dots: true,
            freeMode: false,
            appendDots: '.goods__dots',
            nextArrow: '<img src="assets/images/icon-slideRight-light.svg" class="goods__nav goods__nav_next"/>',
            prevArrow: '<img src="assets/images/icon-slideLeft-light.svg" class="goods__nav goods__nav_prev"/>',
            responsive: [
                {
                  breakpoint: 1301,
                  settings: {
                    appendArrows: '.goods__menu',
                  }
                },
                {
                  breakpoint: 991,
                  settings: {
                    appendArrows: '.goods__menu',
                    nextArrow: '<img src="assets/images/icon-slideRight-dark.svg" class="goods__nav goods__nav_next"/>',
                    prevArrow: '<img src="assets/images/icon-slideLeft-dark.svg" class="goods__nav goods__nav_prev"/>',
                  }
                }
              ]
        }
    );

    $('.pMain').slick(
      {
          infinite: true,
          slidesToShow: 1,
          slidesToScroll: 1,
          arrows: false,
          dots: false,
          asNavFor: '.pThumb',
          responsive: [
            {
              breakpoint: 600,
              settings: {
                slidesToShow: 1,
                arrows: true,
                dots: true,
                nextArrow: '<img src="assets/images/icon-slideRight-dark.svg" class="goods__nav goods__nav_next"/>',
                prevArrow: '<img src="assets/images/icon-slideLeft-dark.svg" class="goods__nav goods__nav_prev"/>',
                appendArrows: '.productm__mobile',
                appendDots: '.productm__mobileDots'
              }
            },
          ]
      }
    );

    $('.pThumb').slick(
      {
          infinite: true,
          slidesToShow: 3,
          slidesToScroll: 1,
          arrows: true,
          dots: false,
          asNavFor: '.pMain',
          focusOnSelect: true,
          nextArrow: '<img src="assets/images/icon-slideRight-dark.svg" class="pThumb__arrow pThumb__arrow_next"/>',
          prevArrow: '<img src="assets/images/icon-slideLeft-dark.svg" class="pThumb__arrow pThumb__arrow_prev"/>',
      }
    );



// Catalog Page

if( $('#catalogPage').length ) {
  var from = $('.range__numbers_from');
        var to = $('.range__numbers_to');

        $(".range__input").ionRangeSlider({
            type: "double",
            min: 0,
            max: 50000,
            from: 1500,
            to: 45000,
            onChange: function (data) {
                from.text(data.from);
                to.text(data.to);
            },
        });

        from.text('1500');
        to.text ('45000');

        // Style Select
        setTimeout(function() {
          $('.goodsin__select').styler();
        }, 100);
}



  // Product Page

  $('.prcolor__item').on('click', function() {
    $('.prcolor__item').removeClass('active');
    $(this).addClass('active');
  });


  $(".prtabs .prtabs__tab").click(function() {
    $(".prtabs .prtabs__tab").removeClass("active").eq($(this).index()).addClass("active");
    $(".prtabs__item").hide().eq($(this).index()).fadeIn();
  }).eq(0).addClass("active");


  $('.opbtn__addCart, .pruduct__add ').on('click', function() {
    $('.productm__addToCart').fadeOut(300);
    $('.productm__addToCart_red').fadeIn(300);
    $('.productm__addToCart_red').css({'display': 'flex'});
  });

  $('.opbtn__img_like, .product__icon_like').on('click', function() {
    $('.productm__addToCart').fadeOut(300);
    $('.productm__addToCart_white').fadeIn(300);
    $('.productm__addToCart_white').css({'display': 'flex'});
  });

  $('.opbtn__img_comp, .product__icon_comp').on('click', function() {
    $('.productm__addToCart').fadeOut(300);
    $('.productm__addToCart_comparison').fadeIn(300);
    $('.productm__addToCart_comparison').css({'display': 'flex'});
  });

  $('.productm__addClose, .productm__addOk').on('click', function() {
    $('.productm__addToCart').fadeOut(300);
  });


  // Read More/Less
  $('.tabs__show').on('click', function() {
    $(this).prev('.tabs__more').addClass('show');
    $(this).remove();
  });



  // Ordering Page =====================================
  // Show next Step

  $('.cart__btn_next').on('click', function() {
    $('.cart__top_2').removeClass('cart__top_2');
    $('.cart__form_2').show(300);
    $(this).prop('disabled', true);
    $('html').animate({ scrollTop: $('.cart__form_2').offset().top }, 300);
    $('body').animate({ scrollTop: $('.cart__form_2').offset().top }, 300);
  });




  // Profile Page ========================================
  // Toggle Profile Sections


  let urlHash = window.location.hash;
  let afterHash = '.' + urlHash.replace(/\#/g, '');

  // console.log(afterHash);
  // if(window.location.href.includes('profile.html' && urlHash)) {
  //   $('.profile__part').hide();
  //   $(urlHash).show();
  //   $('.authForm__item').removeClass('active');
  //   $(afterHash).addClass('active');
  // }

  if(window.location.href.includes('profile.html') && window.location.hash.length !== 0) {
      $('.profile__part').hide();
      $(afterHash).show();
      $('.authForm__item').removeClass('active');
      $('.favorites-profile').addClass('active');
      $('.authorization__heading').text($('.favorites-profile').text());
    }



  $('.authForm__item').on('click', function() {
    if($(this).hasClass('active')) return;
    if($(window).width() < 1200) {
      $('.authForm__list').hide();
    }
    $('.authForm__item').removeClass('active');
    $('.authorization__heading').text($(this).text());
    $(this).addClass('active');
    $('.profile__part').hide();
    $('.profile__part').eq($(this).index()).slideDown(400);
  });

  $('.authForm__userMenu').on('click', function() {
    $('.authForm__list').toggle(300);
  });

});
