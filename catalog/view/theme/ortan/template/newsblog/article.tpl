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
<section class="post">
  <div class="post__container container">
    <div class="post__top">
      <div class="post__top__author">
        <span>
          <img src="/catalog/view/theme/ortan/assets/images/blog/post-author.png" alt="">
        </span>
        <?php echo $author; ?>
      </div>
      <!-- <div class="post__top__time">
        Время на чтение: <span>7 минут</span>
      </div> -->
    </div>
    <h1 class="post__title"><?php echo $heading_title; ?></h1>
    <div class="post__meta">
      <div class="post__meta__left">
        <span>
          Поделиться
        </span>
        <script src="https://yastatic.net/share2/share.js"></script>
        <div class="ya-share2" data-curtain data-services="vkontakte,odnoklassniki,telegram,viber,whatsapp"></div>
      </div>
      <div class="post__meta__right">
        <span class="post__meta__date"><?php echo $date; ?>
        </span>
        <span class="post__meta__reviews">
          <?php echo $viewed; ?>
        </span>
        <span class="post__meta__comments">
          <?php echo $comments; ?>
        </span>
      </div>
    </div>

    <div class="post__content">
      <?php if ($images) { ?>
        <?php foreach ($images as $image) { ?>
          <img class="post__img-left" src="<?php echo $image['popup']; ?>" alt="">
        <?php
          break;
        } ?>
      <?php } ?>
      <?php echo $description; ?>
      <div class="post__content__clearfix"></div>
    </div>
  </div>
</section>
<?php if ($products && count($products)) { ?>
  <section class="bestsellers">
    <div class="container bestsellers__container">
      <div class="bestsellers__sliderI">
        <?php foreach ($products as $product) { ?>
          <div class="bestseller__wrapperSlide">
            <div class="bestsellers__slide product">
              <?php include(DIR_TEMPLATE . 'ortan/template/common/product_tizer.tpl'); ?>
            </div>
          </div>
        <?php } ?>
      </div>
      <div class="bestseller__mobileI">
        <div class="bestsellers__mobileDotsI"></div>
      </div>
    </div>
  </section>
<?php } ?>
<section class="post">
  <div class="post__container container">
    <?php echo $description2; ?>
    <?php if ($tags) { ?>
      <div class="post__tags">
        <?php for ($i = 0; $i < count($tags); $i++) { ?>
          <a href="<?php echo '#' //$tags[$i]['href']; ?>">#<?php echo $tags[$i]['tag']; ?></a>
        <?php } ?>
      </div>
    <?php } ?>
</section>

</div>

<?php if ($articles) { ?>

  <section class="carousel-posts">
    <div class="container">
      <div class="bestsellers__container">
        <div class="bestsellers__top">
          <h2 class="bestsellers__headiing">СТАТЬИ ПО ТЕМЕ</h2>
          <div class="bestsellers__line"></div>
          <div class="bestsellers__dots"></div>
        </div>
        <div class="bestsellers__slider">
          <?php foreach ($articles as $article) { ?>
            <div class="bestseller__wrapperSlide">
              <div class="blog__item">
                <?php include dirname(__FILE__) . '/_tizer.tpl'; ?>
              </div>
            </div>
          <?php } ?>
        </div>
        <div class="bestseller__mobile">
          <div class="bestsellers__mobileDots"></div>
        </div>
      </div>
    </div>
  </section>
<?php } ?>


<script type="text/javascript">
  $(document).ready(function() {
    $('.thumbnails').magnificPopup({
      type: 'image',
      delegate: 'a',
      gallery: {
        enabled: true
      }
    });
  });
</script>
<?php echo $footer; ?>