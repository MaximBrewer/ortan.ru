<?php echo $header; ?>

<div class="breadcrumbs">
  <div class="container">
    <ul class="breadcrumbs__list">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li class="breadcrumbs__item"><a href="<?php echo $breadcrumb['href']; ?>" class="breadcrumbs__link"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
</div>
<?php include(DIR_TEMPLATE . 'ortan/template/product/_product.tpl'); ?>
<?php if ($products && !empty($products)) { ?>
  <section class="bestsellers shouldLike">
    <div class="container bestsellers__container">
      <h4 class="shouldLike__headiing seen__heading">ВАМ ТАКЖЕ МОЖЕТ ПОНРАВИТЬСЯ</h4>
      <div class="shouldLike__slider">
        <?php foreach ($products as $product) { ?>
          <div class="bestseller__wrapperSlide">
            <div class="bestsellers__slide product">
              <?php include(DIR_TEMPLATE . 'ortan/template/common/product_tizer.tpl'); ?>
            </div>
          </div>
        <?php } ?>
      </div>
      <div class="shouldLike__mobile"> 
        <div class="shouldLike__mobileDots"></div>
      </div>
    </div>
  </section>
<?php } ?>
<?php if ($catsp && !empty($catsp)) { ?>
  <section class="bestsellers sameProd">
    <div class="container bestsellers__container">
      <h4 class="shouldLike__headiing seen__heading">ПОХОЖИЕ ТОВАРЫ</h4>
      <div class="sameProd__slider">
        <?php foreach ($catsp as $product) { ?>
          <div class="bestseller__wrapperSlide">
            <div class="bestsellers__slide product">
              <?php include(DIR_TEMPLATE . 'ortan/template/common/product_tizer.tpl'); ?>
            </div>
          </div>
        <?php } ?>
      </div>
      <div class="sameProd__mobile">
        <div class="sameProd__mobileDots"></div>
      </div>
    </div>
  </section>
<?php } ?>
<?php if ($recently_viewed && !empty($recently_viewed)) { ?>
  <section class="bestsellers seen">
    <div class="container bestsellers__container">
      <div class="bestsellers__top">
        <h4 class="bestsellers__headiing seen__heading">просмотренные товары</h4>
        <div class="bestsellers__line"></div>
        <div class="bestsellers__dots"></div>
      </div>
      <div class="bestsellers__slider">
        <?php foreach ($recently_viewed as $product) { ?>
          <div class="bestseller__wrapperSlide">
            <div class="bestsellers__slide product">
              <?php include(DIR_TEMPLATE . 'ortan/template/common/product_tizer.tpl'); ?>
            </div>
          </div>
        <?php } ?>
      </div>
      <div class="bestseller__mobile">
        <div class="bestsellers__mobileDots"></div>
      </div>
    </div>
  </section>
<?php } ?>
<?php echo $ldjson; ?>
<script type="text/javascript">
  document.addEventListener('DOMContentLoaded', function() {
    $('select[name=\'recurring_id\'], input[name="quantity"]').change(function() {
      $.ajax({
        url: 'index.php?route=product/product/getRecurringDescription',
        type: 'post',
        data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
        dataType: 'json',
        beforeSend: function() {
          $('#recurring-description').html('');
        },
        success: function(json) {
          $('.alert, .text-danger').remove();

          if (json['success']) {
            $('#recurring-description').html(json['success']);
          }
        }
      });
    });
    $('#button-cart').on('click', function() {
      $.ajax({
        url: 'index.php?route=checkout/cart/add',
        type: 'post',
        data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
        dataType: 'json',
        beforeSend: function() {
          // $('#button-cart').button('loading');
        },
        complete: function() {
          // $('#button-cart').button('reset');
        },
        success: function(json) {
          $('.alert, .text-danger, .productm__addToCart').remove();
          $('.form-group').removeClass('has-error');

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
            //   scrollTop: 0
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
    // $('.date').datetimepicker({
    //   pickTime: false
    // });

    // $('.datetime').datetimepicker({
    //   pickDate: true,
    //   pickTime: true
    // });

    // $('.time').datetimepicker({
    //   pickDate: false
    // });

    $('button[id^=\'button-upload\']').on('click', function() {
      var node = this;

      $('#form-upload').remove();

      $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

      $('#form-upload input[name=\'file\']').trigger('click');

      if (typeof timer != 'undefined') {
        clearInterval(timer);
      }

      timer = setInterval(function() {
        if ($('#form-upload input[name=\'file\']').val() != '') {
          clearInterval(timer);

          $.ajax({
            url: 'index.php?route=tool/upload',
            type: 'post',
            dataType: 'json',
            data: new FormData($('#form-upload')[0]),
            cache: false,
            contentType: false,
            processData: false,
            beforeSend: function() {
              // $(node).button('loading');
            },
            complete: function() {
              // $(node).button('reset');
            },
            success: function(json) {
              $('.text-danger').remove();

              if (json['error']) {
                $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
              }

              if (json['success']) {
                alert(json['success']);

                $(node).parent().find('input').val(json['code']);
              }
            },
            error: function(xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
          });
        }
      }, 500);
    });

    $('#review').delegate('.pagination a', 'click', function(e) {
      e.preventDefault();

      $('#review').fadeOut('slow');

      $('#review').load(this.href);

      $('#review').fadeIn('slow');
    });

    $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

    $('#button-review').on('click', function() {
      $.ajax({
        url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
        type: 'post',
        dataType: 'json',
        data: $("#form-review").serialize(),
        beforeSend: function() {
          // $('#button-review').button('loading');
        },
        complete: function() {
          // $('#button-review').button('reset');
        },
        success: function(json) {
          $('.alert-success, .alert-danger').remove();

          if (json['error']) {
            $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
          }

          if (json['success']) {
            $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

            $('input[name=\'name\']').val('');
            $('textarea[name=\'text\']').val('');
            $('input[name=\'rating\']:checked').prop('checked', false);
          }
        }
      });
      grecaptcha.reset();
    });

    $(document).ready(function() {
      var hash = window.location.hash;
      if (hash) {
        var hashpart = hash.split('#');
        var vals = hashpart[1].split('-');
        for (i = 0; i < vals.length; i++) {
          $('#product').find('select option[value="' + vals[i] + '"]').attr('selected', true).trigger('select');
          $('#product').find('input[type="radio"][value="' + vals[i] + '"]').attr('checked', true).trigger('click');
          $('#product').find('input[type="checkbox"][value="' + vals[i] + '"]').attr('checked', true).trigger('click');
        }
      }


      <?php if ($youtube) { ?>
        // $.getJSON('https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&id=<?php echo $youtube ?>&key=AIzaSyBV0eSZxQOn3OEf0oRCIXeAF04y2T8-A60', function(data) {
        //   $("#videoName").text(data.items[0].snippet.title ?? "");
        //   $("#videoText").text((data.items[0].statistics.viewCount ?? "") + ' просмотров');
        //   console.log(data)
        // });
      <?php } ?>
    })
  })
</script>
<?php echo $footer; ?>