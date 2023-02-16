jQuery(function () {
  $('.faq .filter__input').on('change', function () {
    window.location.href = $(this).closest('a').attr('href');
  })
  $(document).mouseup(function (e) {
    if (!$(e.target).closest("#search").length) {
      $('#search').css({
        'display': 'none'
      });
    }
  });
  $('.js-open-callback').on('click', function () {
    $('body').addClass('callback-open');
    $(document).mouseup(function (e) {
      if (!$(e.target).closest(".modal-dialog").length) {
        $('#feedBackModal').hide();
        $('body').removeClass('callback-open');
      }
      if ($(e.target).closest(".city__close").length) {
        $('#feedBackModal').hide();

        $('body').removeClass('callback-open');

      }
    });

  });

  // Menu Custom Scrollbar
  if ($(window).width() > 990) {
    $(".mainMenu").mCustomScrollbar();
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

  $(".nav__arrow").on("click", function (e) {
    e.stopPropagation();
    e.preventDefault();
    $(this).toggleClass("active");
    $(this).closest(".nav__item_submenu").toggleClass("active");
  });

  //
  $(".catalog__filterMobile").on("click", function () {
    $(".catalog__filter").toggleClass("filter__mobile");
    $(this).toggleClass("filter__opacity");
  });

  // Show Search form
  $(".topMenu__item_search").on("click", function () {
    $(".search__wrapper").slideToggle(300);
  });


  $(document).on("touchstart click", ".checkout-link", function (e) {
    if (e.type != "touchstart") {
      location.href = 'checkout/';
    }
  });

  //Show/Hide popup City popup Form
  // $(".city__close").on("click", function () {
  //   $(".city").hide(300);
  // });
  // $(".header__location").on("click", function () {
  //   $(".city").show(300);
  //   $(".popup").show(300);
  //   $(".popup__wrapper").hide();
  // });

  // $(".popup__overlay, .popup__close, .city__close").on("click", function () {
  //   $(".popup").hide(300);
  //   $(".city").hide(300);
  //   $(".popup__wrapper").hide(300);
  //   $(".callBack").hide(300);
  // });
  // $(".opbtn__buy").on("click", function () {
  //   $(".popup").show(300);
  //   $(".city").hide();
  //   $(".popup__wrapper").show(300);
  // });

  // $(".contacts__back").on("click", function () {
  //   $(".callBack").show(300);
  //   $(".city").hide();
  //   $(".popup__wrapper").hide();
  //   $(".popup").show(300);
  // });
  // Mobile Menu

  $(".header__mobileMenu_show").on("click", function () {
    $(".header__nav").show();
    $(".header__mobileMenu_close").show();
    $(this).hide();
  });

  $(".header__mobileMenu_close").on("click", function () {
    $(".header__nav").hide();
    $(".header__mobileMenu_show").show();
    $(this).hide();
  });

  // Sliders
  $(".header__slider").slick({
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    dots: true,
    autoplay: true,
    autoplaySpeed: 5000,
    pauseOnHover: true,
  });

  $(".header__slider").on(
    "beforeChange",
    function (event, count, currentSlide, nextSlide) {
      $("#slick-slide0" + nextSlide).data("dark")
        ? $("body").addClass("innerPage")
        : $("body").removeClass("innerPage");
    }
  );

  $(".compSlider").slick({
    infinite: false,
    slidesToShow: 4,
    slidesToScroll: 1,
    arrows: true,
    dots: false,
    nextArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="bestsellers__nav bestsellers__nav_next"/>',
    prevArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="bestsellers__nav bestsellers__nav_prev"/>',
    responsive: [
      {
        breakpoint: 1300,
        settings: {
          dots: true,
          slidesToShow: 3,
          // appendArrows: '.bestseller__mobile',
          appendDots: ".bestsellers__mobileDots",
        },
      },
      {
        breakpoint: 900,
        settings: {
          dots: true,
          slidesToShow: 2,
          // appendArrows: '.bestseller__mobile',
          appendDots: ".bestsellers__mobileDots",
        },
      },
      {
        breakpoint: 600,
        settings: {
          dots: true,
          slidesToShow: 1,
          // appendArrows: '.bestseller__mobile',
          appendDots: ".bestsellers__mobileDots",
        },
      },
    ],
  });

  $(".bestsellers__slider").slick({
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 1,
    arrows: true,
    dots: true,
    freeMode: false,
    appendDots: ".bestsellers__dots",
    nextArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="bestsellers__nav bestsellers__nav_next"/>',
    prevArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="bestsellers__nav bestsellers__nav_prev"/>',
    responsive: [
      {
        breakpoint: 1300,
        settings: {
          slidesToShow: 3,
          appendArrows: ".bestseller__mobile",
          appendDots: ".bestsellers__mobileDots",
        },
      },
      {
        breakpoint: 900,
        settings: {
          slidesToShow: 2,
          appendArrows: ".bestseller__mobile",
          appendDots: ".bestsellers__mobileDots",
        },
      },
      {
        breakpoint: 600,
        settings: {
          slidesToShow: 1,
          appendArrows: ".bestseller__mobile",
          appendDots: ".bestsellers__mobileDots",
        },
      },
    ],
  });

  $(".bestsellers__sliderI").slick({
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 1,
    arrows: true,
    dots: true,
    freeMode: false,
    appendDots: ".bestsellers__dotsI",
    nextArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="bestsellers__nav bestsellers__nav_next"/>',
    prevArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="bestsellers__nav bestsellers__nav_prev"/>',
    responsive: [
      {
        breakpoint: 1300,
        settings: {
          slidesToShow: 3,
          appendArrows: ".bestseller__mobileI",
          appendDots: ".bestsellers__mobileDotsI",
        },
      },
      {
        breakpoint: 900,
        settings: {
          slidesToShow: 2,
          appendArrows: ".bestseller__mobileI",
          appendDots: ".bestsellers__mobileDotsI",
        },
      },
      {
        breakpoint: 600,
        settings: {
          slidesToShow: 1,
          appendArrows: ".bestseller__mobileI",
          appendDots: ".bestsellers__mobileDotsI",
        },
      },
    ],
  });


  $(".bestsellers__sliderp").slick({
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 1,
    arrows: true,
    dots: true,
    freeMode: false,
    appendDots: ".bestsellers__dotsp",
    nextArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="bestsellers__nav bestsellers__nav_next"/>',
    prevArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="bestsellers__nav bestsellers__nav_prev"/>',
    responsive: [
      {
        breakpoint: 1300,
        settings: {
          slidesToShow: 3,
          appendArrows: ".bestseller__mobilep",
          appendDots: ".bestsellers__mobileDotsp",
        },
      },
      {
        breakpoint: 900,
        settings: {
          slidesToShow: 2,
          appendArrows: ".bestseller__mobilep",
          appendDots: ".bestsellers__mobileDotsp",
        },
      },
      {
        breakpoint: 600,
        settings: {
          slidesToShow: 1,
          appendArrows: ".bestseller__mobilep",
          appendDots: ".bestsellers__mobileDotsp",
        },
      },
    ],
  });


  $(".shouldLike__slider").slick({
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 1,
    arrows: true,
    dots: true,
    freeMode: false,
    appendDots: ".shouldLike__mobileDots",
    nextArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="bestsellers__nav bestsellers__nav_next"/>',
    prevArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="bestsellers__nav bestsellers__nav_prev"/>',
    responsive: [
      {
        breakpoint: 1300,
        settings: {
          slidesToShow: 3,
          appendArrows: ".shouldLike__mobile",
          appendDots: ".shouldLike__mobileDots",
        },
      },
      {
        breakpoint: 900,
        settings: {
          slidesToShow: 2,
          appendArrows: ".shouldLike__mobile",
          appendDots: ".shouldLike__mobileDots",
        },
      },
      {
        breakpoint: 600,
        settings: {
          slidesToShow: 1,
          appendArrows: ".shouldLike__mobile",
          appendDots: ".shouldLike__mobileDots",
        },
      },
    ],
  });

  $(".sameProd__slider").slick({
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 1,
    arrows: true,
    dots: true,
    freeMode: false,
    appendDots: ".sameProd__mobileDots",
    nextArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="bestsellers__nav bestsellers__nav_next"/>',
    prevArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="bestsellers__nav bestsellers__nav_prev"/>',
    responsive: [
      {
        breakpoint: 1300,
        dots: true,
        settings: {
          slidesToShow: 3,
          appendArrows: ".sameProd__mobile",
          appendDots: ".sameProd__mobileDots",
        },
      },
      {
        breakpoint: 900,
        settings: {
          slidesToShow: 2,
          dots: true,
          appendArrows: ".sameProd__mobile",
          appendDots: ".sameProd__mobileDots",
        },
      },
      {
        breakpoint: 600,
        settings: {
          slidesToShow: 1,
          dots: true,
          appendArrows: ".sameProd__mobile",
          appendDots: ".sameProd__mobileDots",
        },
      },
    ],
  });

  $(".goods__slider").slick({
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: true,
    dots: true,
    freeMode: false,
    appendDots: ".goods__dots",
    nextArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-light.svg" class="goods__nav goods__nav_next"/>',
    prevArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-light.svg" class="goods__nav goods__nav_prev"/>',
    responsive: [
      {
        breakpoint: 1301,
        settings: {
          appendArrows: ".goods__menu",
        },
      },
      {
        breakpoint: 991,
        settings: {
          appendArrows: ".goods__menu",
          nextArrow:
            '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="goods__nav goods__nav_next"/>',
          prevArrow:
            '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="goods__nav goods__nav_prev"/>',
        },
      },
    ],
  });

  $(".pMain").slick({
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    dots: false,
    asNavFor: ".pThumb",
    responsive: [
      {
        breakpoint: 600,
        settings: {
          slidesToShow: 1,
          arrows: true,
          dots: true,
          nextArrow:
            '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="goods__nav goods__nav_next"/>',
          prevArrow:
            '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="goods__nav goods__nav_prev"/>',
          appendArrows: ".productm__mobile",
          appendDots: ".productm__mobileDots",
        },
      },
    ],
  });

  $(".pThumb").slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 1,
    arrows: true,
    dots: false,
    asNavFor: ".pMain",
    focusOnSelect: true,
    nextArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="pThumb__arrow pThumb__arrow_next"/>',
    prevArrow:
      '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="pThumb__arrow pThumb__arrow_prev"/>',
  });

  // Catalog Page

  if ($("#catalogPage").length) {
    setTimeout(function () {
      $(".goodsin__select").styler();
    }, 100);
  }

  // Product Page

  $(".prcolor__item").on("click", function () {
    $(".prcolor__item").removeClass("active");
    $(this).addClass("active");
  });

  $(".prtabs .prtabs__tab")
    .click(function () {
      $(".prtabs .prtabs__tab")
        .removeClass("active")
        .eq($(this).index())
        .addClass("active");
      $(".prtabs__item").hide().eq($(this).index()).fadeIn();
    })
    .eq(0)
    .addClass("active");

  $(".opbtn__addCart, .pruduct__add ").on("click", function () {
    $(".productm__addToCart").fadeOut(300);
    $(".productm__addToCart_red").fadeIn(300);
    $(".productm__addToCart_red").css({ display: "flex" });
  });

  $(".opbtn__img_like, .product__icon_like").on("click", function () {
    $(".productm__addToCart").fadeOut(300);
    $(".productm__addToCart_white").fadeIn(300);
    $(".productm__addToCart_white").css({ display: "flex" });
  });

  $(".opbtn__img_comp, .product__icon_comp").on("click", function () {
    $(".productm__addToCart").fadeOut(300);
    $(".productm__addToCart_comparison").fadeIn(300);
    $(".productm__addToCart_comparison").css({ display: "flex" });
  });

  $(document).on("click", ".productm__addClose, .productm__addOk", function () {
    $(".productm__addToCart").fadeOut(300);
  });

  // Read More/Less
  $(".tabs__show").on("click", function () {
    $(this).prev(".tabs__more").addClass("show");
    $(this).remove();
  });

  // Profile Page ========================================
  // Toggle Profile Sections

  let urlHash = window.location.hash;
  let afterHash = "." + urlHash.replace(/\#/g, "");

  // console.log(afterHash);
  // if(window.location.href.includes('profile.html' && urlHash)) {
  //   $('.profile__part').hide();
  //   $(urlHash).show();
  //   $('.authForm__item').removeClass('active');
  //   $(afterHash).addClass('active');
  // }

  if (
    window.location.href.includes("profile.html") &&
    window.location.hash.length !== 0
  ) {
    $(".profile__part").hide();
    $(afterHash).show();
    $(".authForm__item").removeClass("active");
    $(".favorites-profile").addClass("active");
    $(".authorization__heading").text($(".favorites-profile").text());
  }

  $(".authForm__userMenu").on("click", function () {
    $(".authForm__list").toggle(300);
  });



  // dialog button

  $('.dialogBtn__close').on('click', function () {
    $('.dialogBtn__textBox').fadeOut(100)
  })

  if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
    $(window).scroll(function () {
      $('.dialogBtn').fadeOut(100);
    });

    $('.dialogBtn__textBox').hide();
    $('.dialogBtn').addClass('mobile');

    // extension:
    $.fn.scrollEnd = function (callback, timeout) {
      $(this).on('scroll', function () {
        var $this = $(this);
        if ($this.data('scrollTimeout')) {
          clearTimeout($this.data('scrollTimeout'));
        }
        $this.data('scrollTimeout', setTimeout(callback, timeout));
      });
    };

    // how to call it (with a 1000ms timeout):
    $(window).scrollEnd(function () {
      $('.dialogBtn').fadeIn(100);
    }, 1500);
  }



  // РАСКОММЕТИРОВАТЬ ДЛЯ ВКЛЮЧЕНИЯ ПОПАПА ПОДАРКА ДО 582 СТРОКИ ВКЛЮЧИТЕЛЬНО. ОСТАЛЬНОЙ КОД В FOOTER.TPL
  //   const giftModalTarget = document.querySelector('[data-target="#giftModal"]');
  // const days = '259200000';
  //             if (+(localStorage.getItem('gift-modal')) + +days < Date.now()) {
  //                 localStorage.removeItem('gift-modal');
  //             }
  //             if (localStorage.getItem('gift-modal') === null) {
  //               setTimeout(function(){
  //                giftModalTarget.click();
  //     localStorage.setItem('gift-modal', Date.now());
  //   }, 3000);
  //             }
  // $('[data-fancy="sizes"]').fancybox({
  //   afterLoad: function (instance, current) {
  //     current.$image.attr('alt', 'Таблица размеров');
  //   }
  // });
});
