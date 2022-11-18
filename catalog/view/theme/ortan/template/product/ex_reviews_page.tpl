<?php echo $header; ?>
<script src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
<div class="breadcrumbs">
  <div class="container">
    <ul class="breadcrumbs__list">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li class="breadcrumbs__item"><a href="<?php echo $breadcrumb['href']; ?>" class="breadcrumbs__link"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
</div>
<section class="review ordering" x-data="xData">
  <div class="review__container container">
    <div class="review__summary">
      <div class="flex-vc">
        <div class="review__summary__value">
          <?= $review_total_all_text; ?>
        </div>
        <div class="review__stars review__stars--big">
          <div class="review__stars__bg" style="width: <?= $rating_percent * 100 / 5; ?>%"></div>
        </div>
      </div>
      <div class="review__description">
        На основании оценок
      </div>
      <div class="review__stat">
        <div class="flex-vc">
          <label>
            <input type="checkbox" class="filter__input" autocomplete="off" data-value="5" <?php if (in_array(5, $rating_checked)) echo "checked"; ?>>
            <span class="filter__check"></span>
          </label>
          <div class="review__stars">
            <div class="review__stars__bg" style="width: 100%;"></div>
          </div>
          <div class="review__stat__line">
            <div class="review__stat__line__bg" style="width: <?= 100 * $review_total_5 / $review_total_all; ?>%"></div>
          </div>
          <div class="review__stat__value">
            <?= $review_total_5; ?>
          </div>
        </div>

        <div class="flex-vc">
          <label>
            <input type="checkbox" class="filter__input" autocomplete="off" data-value="4" <?php if (in_array(4, $rating_checked)) echo "checked"; ?>>
            <span class="filter__check"></span>
          </label>
          <div class="review__stars">
            <div class="review__stars__bg" style="width: 80%;"></div>
          </div>
          <div class="review__stat__line">
            <div class="review__stat__line__bg" style="width: <?= 100 * $review_total_4 / $review_total_all; ?>%"></div>
          </div>
          <div class="review__stat__value">
            <?= $review_total_4; ?>
          </div>
        </div>

        <div class="flex-vc">
          <label>
            <input type="checkbox" class="filter__input" autocomplete="off" data-value="3" <?php if (in_array(3, $rating_checked)) echo "checked"; ?>>
            <span class="filter__check"></span>
          </label>
          <div class="review__stars">
            <div class="review__stars__bg" style="width: 60%;"></div>
          </div>
          <div class="review__stat__line">
            <div class="review__stat__line__bg" style="width: <?= 100 * $review_total_3 / $review_total_all; ?>%"></div>
          </div>
          <div class="review__stat__value">
            <?= $review_total_3; ?>
          </div>
        </div>

        <div class="flex-vc">
          <label>
            <input type="checkbox" class="filter__input" autocomplete="off" data-value="2" <?php if (in_array(2, $rating_checked)) echo "checked"; ?>>
            <span class="filter__check"></span>
          </label>
          <div class="review__stars">
            <div class="review__stars__bg" style="width: 40%;"></div>
          </div>
          <div class="review__stat__line">
            <div class="review__stat__line__bg" style="width: <?= 100 * $review_total_2 / $review_total_all; ?>%"></div>
          </div>
          <div class="review__stat__value">
            <?= $review_total_2; ?>
          </div>
        </div>

        <div class="flex-vc">
          <label>
            <input type="checkbox" class="filter__input" autocomplete="off" data-value="1" <?php if (in_array(1, $rating_checked)) echo "checked"; ?>>
            <span class="filter__check"></span>
          </label>
          <div class="review__stars">
            <div class="review__stars__bg" style="width: 20%;"></div>
          </div>
          <div class="review__stat__line">
            <div class="review__stat__line__bg" style="width: <?= 100 * $review_total_1 / $review_total_all; ?>%"></div>
          </div>
          <div class="review__stat__value">
            <?= $review_total_1; ?>
          </div>
        </div>

      </div>



      <?php if ($logged) : ?>
        <button type="button" class="btn review__btn review-answer-button" x-on:click="show=true">ОСТАВИТЬ ОТЗЫВ</button>
      <?php else : ?>
        <a href="/login/" class="btn review__btn">ОСТАВИТЬ ОТЗЫВ</a>
      <?php endif; ?>


    </div>

    <div class="review-answer-container" id="review_answer_container<?php echo $review['review_id']; ?>">
      <template x-if="success">
        <p class="success" x-text="success"></p>
      </template>
      <div class="ex-hidden" id="hidden-popups" x-bind:style="show ? {display:'block'} : {display:'none'}">
        <form class="form-horizontal" id="form-answer-review" x-ref="form" x-on:submit.prevent="sendReview" action="index.php?route=product/extended_reviews/write" method="POST">
          <input type="hidden" name="rating" x-model="rating" />
          <input type="hidden" x-model="product_id" name="product_id" />

          <div class="autocomplete-wr">
            <label class="control-label" for="input-review">Товар</label>
            <template x-if="product_name">
              <strong x-text="product_name"></strong>
            </template>
            <input type="text" name="filter_name" value="" placeholder="Наименование" x-model="query" class="form-control" autocomplete="off">
            <small>Начните ввод и выберите из выпадающего списка</small>
            <template x-if="products.length">
              <div class="p-list">
                <template x-for="p in products">
                  <div class="border-b px-2 py-2" x-text="p.name" x-on:click="product_id=p.product_id;product_name=p.name;query=''"> </div>
                </template>
              </div>
            </template>
          </div>

          <div class="flex">
            <?php for ($i = 1; $i < 6; $i++) : ?>
              <div class="mr-1 w-7.5 h-7.5 cursor-pointer" x-bind:class="hoverRating < <?php echo $i; ?> ? 'text-gray' : 'text-gold'" x-on:mouseover="hoverRating=<?php echo $i; ?>" x-on:click="rating=<?php echo $i; ?>">
                <svg version="1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36">
                  <path fill="currentColor" d="M17.1 5.4 13.9 14l-9.2.3c-1.3.1-1.3 1.2-.6 1.8l7.2 5.7-2.5 8.8c-.4 1.1.7 1.6 1.5 1.1l7.6-5.1 7.6 5.1c.6.4 1.8.2 1.5-1.1l-2.5-8.8 7.2-5.7c.8-.7.8-1.7-.6-1.8l-9-.3L19 5.4c-.5-1.1-1.5-1.1-1.9 0z" />
                </svg>
              </div>
            <?php endfor; ?>
          </div>

          <div class="ex-form">
            <label class="control-label" for="input-review"><?php echo $text_comment; ?></label>
            <textarea name="text" rows="5" id="input-answer-review" class="form-control"></textarea>
          </div>
          <div class="ex-form">
            <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
            <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-answer-name" class="form-control" />
          </div>
          <?php echo $captcha; ?>
          <template x-if="error">
            <p class="error" x-text="error"></p>
          </template>
          <div class="ex-form-buttons">
            <button type="button" x-on:click="show=false" class="ex-btn ex-cancel"><?php echo $text_cancel; ?></button>
            <button type="submit" class="opbtn__buy btn" id="button-answer-review" data-loading-text="<?php echo $text_loading; ?>"><?php echo $leave_feedback; ?></button>
          </div>
        </form>
      </div>
    </div>
    <div class="review__top comparison__top">
      <?php if ($heading_title) { ?>
        <h1 class="comparison__heading innerHeading"><?php echo $heading_title; ?></h1>
      <?php } ?>
    </div>
    <?php if ($reviews) { ?>
      <ul class="review__wrapper">
        <?php foreach ($reviews as $_key => $review) { ?>
          <li class="review__item">
            <div class="review__img">
              <a href="<?php echo $review['prod_href']; ?>"><img src="<?php echo $review['prod_thumb']; ?>" alt="<?php echo $review['prod_name']; ?>" title="<?php echo $review['prod_name']; ?>" class="img-responsive" /></a>
            </div>
            <div class="review__info">
              <div class="review__data">
                <div class="review__left">
                  <a href="<?php echo $review['prod_href']; ?>" class="review__name"><?php echo $review['prod_name']; ?></a>
                  <div class="prtesti__item prtesti__item_review">
                    <div class="prtesti__top">
                      <div class="prtesti__stars prtesti__left">
                        <?php if ($review['rating'] != 0) { ?>
                          <?php $i = 1; ?>
                          <?php foreach (range($i, 5) as $_key => $i) { ?>
                            <?php if ($review['rating'] < $i) { ?>
                              <img src="/catalog/view/theme/ortan/assets/images/rating-star-gray.svg" alt="star" class="prtesti__img">
                            <?php } else { ?>
                              <img src="/catalog/view/theme/ortan/assets/images/rating-star-gold.svg" alt="star" class="prtesti__img">
                            <?php } ?>
                          <?php } ?>
                        <?php } ?>
                      </div>
                      <span class="prtesti__name"><?php echo $review['author']; ?></span>
                    </div>
                    <div class="prtesti__data">
                      <span class="prtesti__time prtesti__left"><?php echo $review['date_added']; ?></span>
                      <span class="prtesti__time"><?php echo $review['time_added']; ?></span>
                    </div>
                  </div>
                </div>
                <?php if (!empty($review['images'])) { ?>
                  <ul class="review__thumbs">
                    <?php foreach ($review['images'] as $image) { ?>
                      <li class="review__thumb">
                        <a data-fancybox="gallery1" href="<?php echo $image['popup']; ?>" class="review__thumbLink">
                          <img src="<?php echo $image['thumb']; ?>" alt="thumbnail product">
                          <div class="review__thumbHover">
                            <img src="/catalog/view/theme/ortan/assets/images/icon-zoom.svg" alt="show pruduct">
                          </div>
                        </a>
                      </li>
                    <?php } ?>
                  </ul>
                <?php } ?>
              </div>
              <div class="prtesti__text">
                <div class="ex-comment-text">
                  <?php echo $review['text']; ?>
                  <?php if (isset($settings['limitations'])) { ?>
                    <?php if ($review['plus']) { ?>
                      </span>
                      <div class='ex-plus'><?php echo $text_plus; ?> </div>
                      <?php echo $review['plus']; ?>
                    <?php } ?>
                    <?php if ($review['minus']) { ?>
                      <div class='ex-minus'><?php echo $text_minus; ?> </div><span><?php echo $review['minus']; ?>
                        </p>
                      <?php } ?>
                    <?php } ?>
                </div>
              </div>
            </div>
          </li>
        <?php } ?>
      </ul>
      <?php if (isset($pagination)) { ?>
        <?php echo $pagination; ?>
      <?php } ?>
    <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
    <?php } ?>
  </div>
</section>














<!-- media-add-popup -->
<div class="ex-hidden" id="hidden-popups" x-bind:class="">
  <form class="form-horizontal" id="form-answer-review">
    <input type="hidden" value="5" name="rating" x-model="rating" />

    <div class="flex">
      <?php for ($i = 1; $i < 6; $i++) : ?>
        <div class="mr-1 w-7.5 h-7.5 cursor-pointer" x-bind:class="hoverRating < <?php echo $i; ?> ? 'text-gray' : 'text-gold'" x-on:mouseover="hoverRating=<?php echo $i; ?>" x-on:click="rating=<?php echo $i; ?>">
          <svg version="1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36">
            <path fill="currentColor" d="M17.1 5.4 13.9 14l-9.2.3c-1.3.1-1.3 1.2-.6 1.8l7.2 5.7-2.5 8.8c-.4 1.1.7 1.6 1.5 1.1l7.6-5.1 7.6 5.1c.6.4 1.8.2 1.5-1.1l-2.5-8.8 7.2-5.7c.8-.7.8-1.7-.6-1.8l-9-.3L19 5.4c-.5-1.1-1.5-1.1-1.9 0z" />
          </svg>
        </div>
      <?php endfor; ?>
    </div>

    <div class="ex-form">
      <label class="control-label" for="input-review"><?php echo $text_comment; ?></label>
      <textarea name="text" rows="5" id="input-answer-review" class="form-control"></textarea>
    </div>
    <div class="ex-form">
      <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
      <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-answer-name" class="form-control" />
    </div>
    <?php echo $captcha; ?>
    <div class="ex-form-buttons">
      <button type="button" class="ex-btn ex-cancel" id="review-cancel-button"><?php echo $text_cancel; ?></button>
      <button type="button" class="opbtn__buy btn" id="button-answer-review" data-loading-text="<?php echo $text_loading; ?>"><?php echo $leave_feedback; ?></button>
    </div>
  </form>
</div>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    <?php if ((isset($settings['magn']) &&  !isset($settings['fancy']))) { ?>
      addMagnific('.all-reviews-thumbnails');
      addMagnific('.ex-photo-thumbnails');
      addMagnificVideo('.popup-youtube');
    <?php } ?>
    addDrag('ex-drag');
  });

  function showMore(link) {
    $('.show-more-block').remove();
    $('.pagination-block').remove();
    $('.ex-reviews-box').append($('<div>').load(link + ' .ex-reviews-stack', function() {
      addDrag('ex-drag');
      <?php if (isset($settings['magn']) &&  !isset($settings['fancy'])) { ?>
        addMagnific('.all-reviews-thumbnails');
        addMagnific('.ex-photo-thumbnails');
        addMagnificVideo('.popup-youtube');
      <?php } ?>
    }));
  }
</script>

<script>

</script>
<script>
  var xData = {
    rating: 5,
    hoverRating: 5,
    show: false,
    query: '',
    error: '',
    success: '',
    product_name: '',
    product_id: '',
    products: [],
    timeout: 0,
    sendReview() {
      var that = this;
      if (!this.product_id) {
        this.error = 'Необходимо выбрать товар!';
        return
      }
      jQuery.ajax({
          processData: false,
          contentType: false,
          method: "POST",
          url: this.$refs.form.action + '&product_id=' + this.product_id,
          data: new FormData(this.$refs.form)
        })
        .done(function(data) {
          if (data.error) that.error = data.error
          else {
            that.product_name = ''
            that.product_id = ''
            that.products = []
            that.query = ''
            that.show = false
            that.$refs.form.reset()
            that.success = data.success
            setTimeout(function(){
              location.reload()
            }, 1500)
          }
        })
    },
    autocomplete(query) {
      var that = this;
      if (!query || query.length < 3) {
        that.products = [];
        this.error = ''
        return
      }
      clearTimeout(timeout)
      var timeout = setTimeout(function() {
        jQuery.ajax({
            method: "GET",
            url: '/index.php?route=product/product/autocomplete',
            data: {
              filter_name: query
            }
          })
          .done(function(data) {
            that.products = data
          })
      }, 1000)
    },
    init() {
      var that = this;
      this.$watch('query', function(value) {
        that.autocomplete(value)
      })
    },
  }

  document.addEventListener('DOMContentLoaded', function() {
    $('.filter__input').on('change', function() {
      var r = [];
      $('.filter__input').each(function() {
        if ($(this).prop('checked')) {
          r.push($(this).data('value'))
        }
      })
      var url = new URL(window.location.href);
      url.searchParams.set('rating', r.join(','))
      window.location.href = url.href
    })

  });
</script>
<style type="text/css">
  .reviews-sign {
    overflow: hidden;
  }

  .ex-reviews-page {
    font-size: <?php echo $settings['main']['font-size']; ?>px !important;
    font-weight: <?php echo $settings['main']['font-weight']; ?> !important;
  }

  .ex-image-additional a {
    height: <?php echo $settings['all_thumb_height']; ?>px !important;
    width: <?php echo $settings['all_thumb_width']; ?>px !important;
    border-radius: <?php echo $settings['all_border_radius_photo']; ?>px !important;
  }

  .ex-image-additional a .image-crop {
    height: <?php echo ($settings['all_thumb_height'] * 1.8); ?>px !important;
    width: <?php echo ($settings['all_thumb_width'] * 1.8); ?>px !important;
  }

  .ex-image-additional a .imgbb {
    height: <?php echo $settings['all_thumb_height']; ?>px !important;
    width: <?php echo $settings['all_thumb_width']; ?>px !important;
  }

  .ex-video-thumbnails img {
    height: <?php echo $settings['all_video_thumb_height']; ?>px !important;
    width: <?php echo $settings['all_video_thumb_width']; ?>px !important;
  }

  .ex-video-thumbnails a {
    height: <?php echo $settings['all_video_thumb_height']; ?>px !important;
    width: <?php echo $settings['all_video_thumb_width']; ?>px !important;
    border-radius: <?php echo $settings['all_border_radius_video']; ?>px !important;
  }

  .ex-btn {
    border-radius: <?php echo $settings['button']['border-radius']; ?>px !important;
    padding: <?php echo $settings['button']['padding-y']; ?>px <?php echo $settings['button']['padding-x']; ?>px !important;
    font-size: <?php echo $settings['button']['font-size']; ?>px !important;
    text-transform: <?php echo (isset($settings['button']['uppercase']) ? ('uppercase') : ('none')); ?> !important;
    border: <?php echo $settings['button']['border']; ?>px solid !important;
    font-weight: <?php echo $settings['button']['font-weight']; ?> !important;
    transition: all .<?php echo $settings['button']['transition']; ?>s ease-in-out !important;
    min-width: <?php echo $settings['button']['min-width']; ?>px !important;
  }

  .ex-select {
    border-radius: <?php echo $settings['button']['border-radius']; ?>px !important;
    padding: <?php echo $settings['button']['padding-y']; ?>px <?php echo $settings['button']['padding-x']; ?>px !important;
    font-size: <?php echo $settings['button']['font-size']; ?>px !important;
    text-transform: <?php echo (isset($settings['button']['uppercase']) ? ('uppercase') : ('none')); ?> !important;
  }

  .ex-accept {
    <?php if ($settings['accept']['gradient']) { ?>background: linear-gradient(<?php echo $settings['accept']['gradient']; ?>, #<?php echo $settings['accept']['background']; ?>, #<?php echo $settings['accept']['background2']; ?>) !important;
    <?php } else { ?>background: #<?php echo $settings['accept']['background']; ?> !important;
    <?php } ?>color: #<?php echo $settings['accept']['text']; ?> !important;
    border-color: #<?php echo $settings['accept']['border_color']; ?> !important;
  }

  .ex-accept:hover {
    <?php if ($settings['accept']['hover_gradient']) { ?>background: linear-gradient(<?php echo $settings['accept']['hover_gradient']; ?>, #<?php echo $settings['accept']['background_h']; ?>, #<?php echo $settings['accept']['background2_h']; ?>) !important;
    <?php } else { ?>background: #<?php echo $settings['accept']['background_h']; ?> !important;
    <?php } ?>color: #<?php echo $settings['accept']['text_h']; ?> !important;
    border-color: #<?php echo $settings['accept']['border_color_h']; ?> !important;
  }

  .ex-cancel {
    <?php if ($settings['cancel']['gradient']) { ?>background: linear-gradient(<?php echo $settings['cancel']['gradient']; ?>, #<?php echo $settings['cancel']['background']; ?>, #<?php echo $settings['cancel']['background2']; ?>) !important;
    <?php } else { ?>background: #<?php echo $settings['cancel']['background']; ?> !important;
    <?php } ?>color: #<?php echo $settings['cancel']['text']; ?> !important;
    border-color: #<?php echo $settings['cancel']['border_color']; ?> !important;
  }

  .ex-cancel:hover {
    <?php if ($settings['cancel']['hover_gradient']) { ?>background: linear-gradient(<?php echo $settings['cancel']['hover_gradient']; ?>, #<?php echo $settings['cancel']['background_h']; ?>, #<?php echo $settings['cancel']['background2_h']; ?>) !important;
    <?php } else { ?>background: #<?php echo $settings['cancel']['background_h']; ?> !important;
    <?php } ?>color: #<?php echo $settings['cancel']['text_h']; ?> !important;
    border-color: #<?php echo $settings['cancel']['border_color_h']; ?> !important;
  }

  .ex-light {
    <?php if ($settings['light']['gradient']) { ?>background: linear-gradient(<?php echo $settings['light']['gradient']; ?>, #<?php echo $settings['light']['background']; ?>, #<?php echo $settings['light']['background2']; ?>) !important;
    <?php } else { ?>background: #<?php echo $settings['light']['background']; ?> !important;
    <?php } ?>color: #<?php echo $settings['light']['text']; ?> !important;
    border-color: #<?php echo $settings['light']['border_color']; ?> !important;
    fill: #<?php echo $settings['light']['text']; ?> !important;
  }

  .ex-light:hover {
    <?php if ($settings['light']['hover_gradient']) { ?>background: linear-gradient(<?php echo $settings['light']['hover_gradient']; ?>, #<?php echo $settings['light']['background_h']; ?>, #<?php echo $settings['light']['background2_h']; ?>) !important;
    <?php } else { ?>background: #<?php echo $settings['light']['background_h']; ?> !important;
    <?php } ?>color: #<?php echo $settings['light']['text_h']; ?> !important;
    border-color: #<?php echo $settings['light']['border_color_h']; ?> !important;
    fill: #<?php echo $settings['light']['text_h']; ?> !important;
  }

  .review-container {
    background: #<?php echo $settings['box']['background']; ?>;
    color: #<?php echo $settings['box']['color']; ?>;
    border-radius: <?php echo $settings['box']['border-radius']; ?>px;
    border: <?php echo $settings['box']['border']; ?>px solid #<?php echo $settings['box']['border-color']; ?>;
    <?php echo (isset($settings['box']['shadow']) ? ('box-shadow: none;') : ('')); ?>
  }

  .review-title-container,
  .review-answer-title-container {
    color: #<?php echo $settings['box_header']['color']; ?>;
    font-size: <?php echo $settings['main']['font-size-name']; ?>px !important;
    line-height: <?php echo $settings['main']['font-size-name'] + 4; ?>px !important;
  }

  .review-title-container,
  .review-answer-title-container::before {
    background: #<?php echo $settings['box_header']['background']; ?>;
  }

  .ex-form .form-control {
    border-radius: <?php echo $settings['form']['input-border-radius']; ?>px !important;
  }

  @media(min-width: 768px) {
    .review-childrens-container {
      margin-left: <?php echo $settings['product_thumb_width']; ?>px;
    }
  }

  .autocomplete-wr {
    display: flex;
    flex-direction: column;

  }

  .autocomplete-wr .p-list {
    border: 1px solid #323031;
    border-radius: 2px;
    max-height: 300px;
    overflow-y: auto;
    color: #000;
    font-size: 13px;
    line-height: 18px;
  }

  .autocomplete-wr .p-list>div {
    padding: .375rem .5rem;
    cursor: pointer
  }

  .autocomplete-wr .p-list>div:hover {
    background-color: #d9d9d9;
  }
</style>
<div style="position: absolute;	left: -9999px;">
  <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <symbol viewBox="0 0 512 511" id="ex-star">
      <path xmlns="http://www.w3.org/2000/svg" d="m510.652344 185.902344c-3.351563-10.367188-12.546875-17.730469-23.425782-18.710938l-147.773437-13.417968-58.433594-136.769532c-4.308593-10.023437-14.121093-16.511718-25.023437-16.511718s-20.714844 6.488281-25.023438 16.535156l-58.433594 136.746094-147.796874 13.417968c-10.859376 1.003906-20.03125 8.34375-23.402344 18.710938-3.371094 10.367187-.257813 21.738281 7.957031 28.90625l111.699219 97.960937-32.9375 145.089844c-2.410156 10.667969 1.730468 21.695313 10.582031 28.09375 4.757813 3.4375 10.324219 5.1875 15.9375 5.1875 4.839844 0 9.640625-1.304687 13.949219-3.882813l127.46875-76.183593 127.421875 76.183593c9.324219 5.609376 21.078125 5.097657 29.910156-1.304687 8.855469-6.417969 12.992187-17.449219 10.582031-28.09375l-32.9375-145.089844 111.699219-97.941406c8.214844-7.1875 11.351563-18.539063 7.980469-28.925781zm0 0"></path>
    </symbol>
    <symbol id="ex-photo-svg" viewBox="0 0 38 34">
      <path fill-rule="evenodd" clip-rule="evenodd" d="M27.994 32H4a4 4 0 0 1-4-4V4.008a4 4 0 0 1 4-4h23.992a4 4 0 0 1 4 4V28a4 4 0 0 1-3.998 4zm2.865-27.99a2.869 2.869 0 0 0-2.865-2.865H4A2.869 2.869 0 0 0 1.135 4.01V28A2.869 2.869 0 0 0 4 30.866h23.992A2.869 2.869 0 0 0 30.859 28V4.008v.002z"></path>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M17 20l-5-5-7 7v-2l7-7 5 5 4-4 7 7v2l-7-7-4 4z"></path>
      <path d="M30.5 34a7.5 7.5 0 1 0 0-15 7.5 7.5 0 0 0 0 15z"></path>
      <path d="M30.5 23a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0v-6a.5.5 0 0 1 .5-.5z" fill="#fff"></path>
      <path d="M27.5 26h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1 0-1z" fill="#fff"></path>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M21.5 12a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm0-4a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3z"></path>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M4 4h24v20H4V4zm1 1h22v18H5V5z"></path>
    </symbol>
    <symbol viewBox="0 0 38 34" id="ex-video-svg">
      <path fill-rule="evenodd" clip-rule="evenodd" d="M27.994 32H4a4 4 0 0 1-4-4V4.01a4 4 0 0 1 4-4h23.992a4 4 0 0 1 4 4V28a4 4 0 0 1-3.998 4zm2.865-27.99a2.869 2.869 0 0 0-2.865-2.867H4A2.869 2.869 0 0 0 1.135 4.01V28A2.873 2.873 0 0 0 4 30.87h23.992A2.873 2.873 0 0 0 30.857 28V4.01h.002zM24.02 26.7a64.388 64.388 0 0 1-7.958.3c-2.375 0-5.978-.06-7.362-.18-2.7-.24-2.462-3.57-2.581-6.35.001-1.427.122-2.852.36-4.26.541-2.32 2.042-2.02 4.206-2.14.23 0 1.92-.06 5.285-.06 4.983.06 6.546 0 7.926.24 2.1.3 1.925 3.63 2.044 6.19-.063 3.02-.076 4.43-.779 5.37-.276.41-.676.722-1.141.89zM11.945 15.98H7.98v1.25H9.3v7.21h1.266v-7.21h1.379c.03-.416.03-.833 0-1.25zm3.544 2.2h-1.142v4.77c-.144.28-.41.476-.719.53a.255.255 0 0 1-.3-.23v-5.07h-1.141v5.19c0 .77.243 1.19.9 1.19.504-.09.954-.369 1.26-.78v.72h1.142v-6.32zm4.387 1.01a1.052 1.052 0 0 0-1.082-1.13 2.03 2.03 0 0 0-1.142.72v-2.75h-1.141v8.47h1.141v-.66c.319.447.831.715 1.38.72.72 0 .844-1.19.844-1.19v-4.18zm4.382 3.1h-1.141v.48s0 .71-.482.71a.636.636 0 0 1-.66-.71v-1.25h2.283v-1.73a1.573 1.573 0 0 0-1.623-1.67c-1.439 0-1.558.72-1.682 1.07a2.456 2.456 0 0 0-.119.6v2.98a1.73 1.73 0 0 0 1.861 1.79 1.68 1.68 0 0 0 1.5-1.19 3.61 3.61 0 0 0 .063-1.08zm-3.92-10.61c-.318.392-.76.664-1.252.77a.826.826 0 0 1-.894-.94V6.128h1.132v5.023s-.059.3.358.3a1.05 1.05 0 0 0 .656-.54V6.128h1.131v6.263h-1.131v-.71zm-4.521.75a3.267 3.267 0 0 1-.438.01 1.536 1.536 0 0 1-1.179-.7 2.06 2.06 0 0 1-.3-.94V7.842c0-.178.059-.59.059-.59a1.65 1.65 0 0 1 1.34-1.154 1.63 1.63 0 0 1 .526 0c.637.09 1.165.54 1.352 1.156 0 0 .059.413.059.591v2.958a2.063 2.063 0 0 1-.3.94c-.249.388-.66.64-1.119.688zm-.246-5.357s-.6-.06-.6.77V10.8a.56.56 0 0 0 .6.65.526.526 0 0 0 .536-.65V7.842s.06-.769-.536-.769zm-3.277 5.258H11.1V8.96L9.494 4h1.311l.893 3.251L12.591 4h1.252l-1.549 4.961v3.37zm10.823 7.46a.685.685 0 0 0-.541-.66.672.672 0 0 0-.6.66v.77h1.142v-.77h-.001zm-4.864-.66a.863.863 0 0 0-.541.24v3.88a.76.76 0 0 0 .541.23.506.506 0 0 0 .481-.53v-3.16a.54.54 0 0 0-.481-.66z"></path>
      <path d="M30.5 34a7.5 7.5 0 1 0 0-15 7.5 7.5 0 0 0 0 15z"></path>
      <path d="M30.5 23a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0v-6a.5.5 0 0 1 .5-.5z" fill="#fff"></path>
      <path d="M27.5 26h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1 0-1z" fill="#fff"></path>
    </symbol>
    <symbol id="ex-trash" viewBox="0 0 512 512">
      <g>
        <path d="m424 64h-88v-16c0-26.467-21.533-48-48-48h-64c-26.467 0-48 21.533-48 48v16h-88c-22.056 0-40 17.944-40 40v56c0 8.836 7.164 16 16 16h8.744l13.823 290.283c1.221 25.636 22.281 45.717 47.945 45.717h242.976c25.665 0 46.725-20.081 47.945-45.717l13.823-290.283h8.744c8.836 0 16-7.164 16-16v-56c0-22.056-17.944-40-40-40zm-216-16c0-8.822 7.178-16 16-16h64c8.822 0 16 7.178 16 16v16h-96zm-128 56c0-4.411 3.589-8 8-8h336c4.411 0 8 3.589 8 8v40c-4.931 0-331.567 0-352 0zm313.469 360.761c-.407 8.545-7.427 15.239-15.981 15.239h-242.976c-8.555 0-15.575-6.694-15.981-15.239l-13.751-288.761h302.44z" />
        <path d="m256 448c8.836 0 16-7.164 16-16v-208c0-8.836-7.164-16-16-16s-16 7.164-16 16v208c0 8.836 7.163 16 16 16z" />
        <path d="m336 448c8.836 0 16-7.164 16-16v-208c0-8.836-7.164-16-16-16s-16 7.164-16 16v208c0 8.836 7.163 16 16 16z" />
        <path d="m176 448c8.836 0 16-7.164 16-16v-208c0-8.836-7.164-16-16-16s-16 7.164-16 16v208c0 8.836 7.163 16 16 16z" />
      </g>
    </symbol>
    <symbol id="ex-thumb" viewBox="0, 0, 400,400" version="1.1">
      <g id="svgg">
        <path id="path0" d="M181.557 42.708 C 178.182 47.865,174.197 59.754,172.701 69.128 C 170.624 82.143,163.677 93.273,143.324 116.198 L 116.667 146.222 116.667 239.778 C 116.667 360.805,106.942 350.000,215.870 350.000 C 315.166 350.000,304.598 356.200,339.300 277.588 C 389.110 164.749,382.881 150.000,285.417 150.000 C 249.896 150.000,220.854 149.531,220.878 148.958 C 220.903 148.385,223.716 138.712,227.128 127.463 C 240.084 84.756,234.486 50.953,212.583 39.626 C 195.909 31.004,188.751 31.715,181.557 42.708 M38.333 155.000 C 31.250 162.083,31.250 337.917,38.333 345.000 C 44.802 351.469,71.865 351.469,78.333 345.000 C 85.417 337.917,85.417 162.083,78.333 155.000 C 75.583 152.250,66.583 150.000,58.333 150.000 C 50.083 150.000,41.083 152.250,38.333 155.000 " stroke="none"></path>
      </g>
    </symbol>
    <symbol viewBox="0 0 57 40" id="ex-youtube">
      <path fill="#ff1818" d="M28.537 0C21.938 0 15.326.2 8.715.6 1.702 1 .701 6.5.301 11.9c-.4 5.4-.4 10.8 0 16.2S1.702 39 8.715 39.4c13.123.8 26.347.8 39.57 0 7.012-.4 8.014-5.9 8.414-11.3.4-5.4.4-10.8 0-16.2-.4-5.4-1.402-10.9-8.414-11.3C41.724.2 35.135 0 28.537 0zm-6.098 11l16.329 8.5L22.439 28V11z"></path>
      <path fill="#fff" d="M22.439 11.002l16.3 8.5-16.3 8.5v-17z"></path>
    </symbol>
    <symbol id="ex-reply" viewBox="0 0 24 24">
      <path d="m10 7.002v-4.252c0-.301-.181-.573-.458-.691-.276-.117-.599-.058-.814.153l-8.5 8.25c-.146.141-.228.335-.228.538s.082.397.228.538l8.5 8.25c.217.21.539.269.814.153.277-.118.458-.39.458-.691v-4.25h1.418c4.636 0 8.91 2.52 11.153 6.572l.021.038c.134.244.388.39.658.39.062 0 .124-.007.186-.023.332-.085.564-.384.564-.727 0-7.774-6.257-14.114-14-14.248z" />
    </symbol>
    <symbol version="1.1" id="ex-cart" x="0px" y="0px" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve">
      <g>
        <path d="M394.667,0c-64,0-117.333,53.333-117.333,117.333s53.333,117.333,117.333,117.333S512,181.333,512,117.333S458.667,0,394.667,0z M467.2,83.2l-85.333,85.333c-2.133,2.133-6.4,2.133-8.533,2.133c-2.133,0-6.4,0-8.533-2.133l-42.667-42.667c-4.267-4.267-4.267-10.667,0-14.933s10.667-4.267,14.933,0l34.133,34.133l76.8-76.8c4.267-4.267,10.667-4.267,14.933,0C469.333,70.4,469.333,78.933,467.2,83.2z" />
      </g>
      <g>
        <circle cx="394.667" cy="458.667" r="53.333" />
      </g>
      <g>
        <circle cx="181.333" cy="458.667" r="53.333" />
      </g>
      <g>
        <path d="M471.467,236.8c-2.133,0-6.4,0-10.667,2.133C441.6,249.6,418.133,256,394.667,256C317.867,256,256,194.133,256,117.333c0-6.4-4.267-10.667-10.667-10.667H96L85.333,51.2c-2.133-4.267-6.4-8.533-10.667-8.533h-64C4.267,42.667,0,46.933,0,53.333C0,59.733,4.267,64,10.667,64h55.467l51.2,260.267C125.867,358.4,155.733,384,192,384h245.333c6.4,0,10.667-4.267,10.667-10.667c0-6.4-4.267-10.667-10.667-10.667H192c-17.067,0-34.133-8.533-42.667-23.467L460.8,296.533c4.267,0,8.533-4.267,8.533-8.533l6.4-40.533C475.733,243.2,475.733,238.933,471.467,236.8z" />
      </g>
    </symbol>
    <symbol id="ex-check" viewBox="0 0 512 512">
      <g>
        <path d="m256 0c-141.49 0-256 114.5-256 256 0 141.49 114.5 256 256 256 141.49 0 256-114.5 256-256 0-141.49-114.5-256-256-256zm-60.914 363.99s-88.422-88.458-94.778-94.802c-14.139-14.139-14.139-37.147 0-51.274 14.175-14.175 37.099-14.175 51.274 0l57.244 57.244c7.118 7.118 18.67 7.069 25.728-.085l125.69-127.502c14.127-14.332 37.208-14.429 51.455-.181 14.03 14.03 14.115 36.942.181 51.081-136.493 138.486-162.414 165.507-162.414 165.507-14.985 14.984-39.383 14.997-54.38.012z" />
      </g>
    </symbol>
    <symbol id="ex-pencil" viewBox="0 0 469.336 469.336">
      <g>
        <g>
          <g>
            <path d="M347.878,151.357c-4-4.003-11.083-4.003-15.083,0L129.909,354.414c-2.427,2.429-3.531,5.87-2.99,9.258     c0.552,3.388,2.698,6.307,5.76,7.84l16.656,8.34v28.049l-51.031,14.602l-51.51-51.554l14.59-51.075h28.025l8.333,16.67     c1.531,3.065,4.448,5.213,7.833,5.765c0.573,0.094,1.146,0.135,1.708,0.135c2.802,0,5.531-1.105,7.542-3.128L317.711,136.26     c2-2.002,3.125-4.712,3.125-7.548c0-2.836-1.125-5.546-3.125-7.548l-39.229-39.263c-2-2.002-4.708-3.128-7.542-3.128h-0.021     c-2.844,0.01-5.563,1.147-7.552,3.159L45.763,301.682c-0.105,0.107-0.1,0.27-0.201,0.379c-1.095,1.183-2.009,2.549-2.487,4.208     l-18.521,64.857L0.409,455.73c-1.063,3.722-0.021,7.736,2.719,10.478c2.031,2.033,4.75,3.128,7.542,3.128     c0.979,0,1.958-0.136,2.927-0.407l84.531-24.166l64.802-18.537c0.195-0.056,0.329-0.203,0.52-0.27     c0.673-0.232,1.262-0.61,1.881-0.976c0.608-0.361,1.216-0.682,1.73-1.146c0.138-0.122,0.319-0.167,0.452-0.298l219.563-217.789     c2.01-1.991,3.146-4.712,3.156-7.558c0.01-2.836-1.115-5.557-3.125-7.569L347.878,151.357z" />
            <path d="M456.836,76.168l-64-64.054c-16.125-16.139-44.177-16.17-60.365,0.031l-39.073,39.461     c-4.135,4.181-4.125,10.905,0.031,15.065l108.896,108.988c2.083,2.085,4.813,3.128,7.542,3.128c2.719,0,5.427-1.032,7.51-3.096     l39.458-39.137c8.063-8.069,12.5-18.787,12.5-30.192S464.899,84.237,456.836,76.168z" />
          </g>
        </g>
      </g>
    </symbol>
    <symbol viewBox="0 0 19 21" id="ex-more">
      <path fill-rule="evenodd" clip-rule="evenodd" d="M8.827.118c-.27-.203-.74-.135-.943.134-.202.27-.202.741.135.943l1.14.874a9.134 9.134 0 00-3.363.743c-2.29 1.01-4.11 2.83-5.052 5.187-.943 2.358-.876 4.917.067 7.208a9.106 9.106 0 002.83 3.705c.201.202.336.202.47.202.203 0 .405-.068.54-.27.202-.27.202-.74-.135-.943-1.078-.808-1.886-1.953-2.425-3.166-.876-1.953-.876-4.176-.068-6.197.809-2.021 2.358-3.57 4.312-4.446 1.024-.41 2.086-.664 3.188-.673L8.49 4.766c-.202.269-.202.74.135.943.067.067.202.067.337.067.202 0 .404-.067.539-.27l1.953-2.56c.202-.269.202-.74-.134-.942L8.827.118zm9.364 7.814c-.135-.337-.54-.472-.876-.337-.337.135-.472.539-.337.876.135.269.27.606.337.943.067.202.337.404.606.404h.202c.337-.135.54-.472.472-.809-.135-.404-.27-.74-.404-1.077zm-.607 3.974c0 .539-.134 1.078-.27 1.617-.066.337.136.74.473.808.067.135.134.135.202.135.269 0 .538-.202.673-.472.135-.606.27-1.28.27-1.953a.733.733 0 00-.607-.741.79.79 0 00-.74.606zm-3.166 6.063c.741-.54 1.348-1.213 1.886-2.021.203-.337.607-.405.944-.202.336.202.404.606.202.943a10.516 10.516 0 01-2.223 2.357c-.135.068-.27.135-.405.135-.202 0-.404-.067-.538-.27-.203-.269-.135-.74.134-.942zm-7.342 1.28c-.337-.135-.741.067-.876.471-.135.404.067.741.472.876.943.27 1.886.404 2.829.404a9.45 9.45 0 002.762-.404c.337-.135.539-.472.471-.876-.134-.337-.471-.539-.876-.471a8.263 8.263 0 01-4.782 0z"></path>
    </symbol>
    <symbol viewBox="0 0 16 16" id="ex-sort">
      <path d="M3.931 1.61v-.241l.17.17 1.747 1.74a.525.525 0 00.743-.002l.07.07-.07-.07a.525.525 0 00-.002-.743l.07-.07-.07.07L4.667.62A1.762 1.762 0 003.412.1c-.474 0-.92.184-1.255.52L.253 2.536l-.071-.07.07.07a.525.525 0 00.745.74l.07.07-.07-.07L2.71 1.553l.171-.172V14.6l-.17-.17-1.715-1.708a.523.523 0 00-.743.001.525.525 0 00.001.743l-.07.07.07-.07 1.923 1.915c.335.335.78.519 1.254.519.475 0 .92-.184 1.255-.52l1.905-1.916.071.07-.07-.07a.525.525 0 10-.746-.74l-1.744 1.755-.17.171V1.61zm11.444 9.553h-6.25a.525.525 0 100 1.05h6.25a.525.525 0 100-1.05zm0-6.325a.525.525 0 100-1.05h-6.25a.525.525 0 100 1.05h6.25zm0 3.687a.525.525 0 100-1.05h-6.25a.525.525 0 100 1.05h6.25zm0 7.375a.525.525 0 100-1.05h-6.25a.525.525 0 100 1.05h6.25zm0-14.75a.525.525 0 100-1.05h-6.25a.525.525 0 100 1.05h6.25z"></path>
    </symbol>
  </svg>
</div>
<?php echo $footer; ?>