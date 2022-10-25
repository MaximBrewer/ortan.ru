<?php $is_ajax = true; ?>
<div class="productAjax">
    <div class="modal-body">
        <div class="city__close" data-dismiss="modal" aria-label="Close">
            <svg width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg" class="city__icon">
                <path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="#323031"></path>
            </svg>
        </div>
        <?php include(DIR_TEMPLATE . 'ortan/template/product/_product.tpl'); ?>
    </div>
</div>
<script type="text/javascript">
    $(".productAjax .prtabs .prtabs__tab")
        .click(function() {
            $(".productAjax .prtabs .prtabs__tab")
                .removeClass("active")
                .eq($(this).index())
                .addClass("active");
            $(".productAjax .prtabs__item").hide().eq($(this).index()).fadeIn();
        })
        .eq(0)
        .addClass("active");



    $('.productAjax #button-cart').on('click', function() {
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: $('.productAjax #product input[type=\'text\'], .productAjax #product input[type=\'hidden\'], .productAjax #product input[type=\'radio\']:checked, .productAjax #product input[type=\'checkbox\']:checked, .productAjax #product select, .productAjax #product textarea'),
            dataType: 'json',
            beforeSend: function() {
                // $('#button-cart').button('loading');
            },
            complete: function() {
                // $('#button-cart').button('reset');
            },
            success: function(json) {
                $('.alert, .text-danger, .productm__addToCart').remove();
                $('.productAjax .form-group').removeClass('has-error');

                if (json['error']) {
                    if (json['error']['option']) {
                        for (i in json['error']['option']) {

                            $('body').prepend('<div class="productm__addToCart productm__addToCart_red" style="display: flex;"><svg class="productm__addOk" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M19.9184 2.8527L7.51783 15.2533C7.40861 15.3625 7.23175 15.3625 7.12278 15.2533L0.0817287 8.21196C-0.0272429 8.10325 -0.0272429 7.92639 0.0817287 7.81716L1.79261 6.10628C1.90184 5.99731 2.07869 5.99731 2.18766 6.10628L7.32056 11.2389L17.8127 0.746768C17.9222 0.637796 18.0985 0.637796 18.2078 0.746768L19.9184 2.45765C20.0276 2.56662 20.0276 2.74322 19.9184 2.8527Z" fill="white"></path></svg><p class="productm__addInfo">' + json['error']['option'][i] + '</p><svg class="productm__addClose" width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="white"></path></svg></div>');

                            // var element = $('#input-option' + i.replace('_', '-'));

                            // if (element.parent().hasClass('input-group')) {
                            //   element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            // } else {
                            //   element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            // }
                        }
                    }

                    if (json['error']['recurring']) {
                        $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
                    }

                    // Highlight any found errors
                    $('.text-danger').parent().addClass('has-error');
                }

                if (json['success']) {
                    $('body').prepend('<div class="productm__addToCart productm__addToCart_red" style="display: flex;"><svg class="productm__addOk" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M19.9184 2.8527L7.51783 15.2533C7.40861 15.3625 7.23175 15.3625 7.12278 15.2533L0.0817287 8.21196C-0.0272429 8.10325 -0.0272429 7.92639 0.0817287 7.81716L1.79261 6.10628C1.90184 5.99731 2.07869 5.99731 2.18766 6.10628L7.32056 11.2389L17.8127 0.746768C17.9222 0.637796 18.0985 0.637796 18.2078 0.746768L19.9184 2.45765C20.0276 2.56662 20.0276 2.74322 19.9184 2.8527Z" fill="white"></path></svg><p class="productm__addInfo">' + json['success'] + '</p><svg class="productm__addClose" width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="white"></path></svg></div>');
                    setTimeout(function() {
                        $(".productm__addToCart").fadeOut(function() {
                            $(".productm__addToCart").remove();
                        })
                    }, 3000)

                    // $('html, body').animate({
                    //     scrollTop: 0
                    // }, 'slow');

                    $('#cart').load('index.php?route=common/cart/info', function() {
                        $(".cartPopup__list").mCustomScrollbar();
                    });

                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
        ym('53398495','reachGoal','korzina');
    });

    <?php if ($youtube) { ?>
        // $.getJSON('https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&id=<?php echo $youtube ?>&key=AIzaSyBV0eSZxQOn3OEf0oRCIXeAF04y2T8-A60', function(data) {
        //     $("#videoName").text(data.items[0].snippet.title ?? "");
        //     $("#videoText").text((data.items[0].statistics.viewCount ?? "") + ' просмотров');
        //     console.log(data)
        // });
    <?php } ?>
    $(function() {
        setTimeout(function() {
            $(".productAjax .pMain").slick({
                infinite: true,
                slidesToShow: 1,
                slidesToScroll: 1,
                arrows: false,
                dots: false,
                asNavFor: ".productAjax .pThumb",
                responsive: [{
                    breakpoint: 600,
                    settings: {
                        slidesToShow: 1,
                        arrows: true,
                        dots: true,
                        nextArrow: '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="goods__nav goods__nav_next"/>',
                        prevArrow: '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="goods__nav goods__nav_prev"/>',
                        appendArrows: ".productAjax .productm__mobile",
                        appendDots: ".productAjax .productm__mobileDots",
                    },
                }, ],
            });

            $(".productAjax .pThumb").slick({
                infinite: true,
                slidesToShow: 3,
                slidesToScroll: 1,
                arrows: true,
                dots: false,
                asNavFor: ".productAjax .pMain",
                focusOnSelect: true,
                nextArrow: '<img src="/catalog/view/theme/ortan/assets/images/icon-slideRight-dark.svg" class="pThumb__arrow pThumb__arrow_next"/>',
                prevArrow: '<img src="/catalog/view/theme/ortan/assets/images/icon-slideLeft-dark.svg" class="pThumb__arrow pThumb__arrow_prev"/>',
            });

        }, 500)
    })
</script>


<script>
    <?php if ($ex_reviews['settings']['status']) { ?>
        $('<?php echo $ex_reviews['settings']['selector']; ?>Ajax').html('<div id="ex-reviewAjax"></div>');
        $('#ex-reviewAjax').load('index.php?route=product/extended_reviews/review&product-id=<?php echo $product_id; ?>');
        $('#ex-reviewAjax').delegate('.pagination a', 'click', function(e) {
            e.preventDefault();
            $('#ex-reviewAjax').load(this.href);
        });
    <?php } ?>
</script>