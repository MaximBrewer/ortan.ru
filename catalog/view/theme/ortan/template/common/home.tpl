<?php echo $header; ?>
<?php include(__DIR__ . "/home.categories.tpl");?>
<?php include(__DIR__ . "/home.adv.tpl");?>
<!-- <?php echo $content_top; ?> -->
<?php include(__DIR__ . "/home.gender.tpl");?>

<?php if($products && count($products)) { ?>
<section class="bestsellers">
  <div class="container bestsellers__container">
    <div class="bestsellers__top">
      <a href="https://<?= $lang_link ?>tovary/podarki1/" class="bestsellers__headiing">ПОДАРКИ</a>
      <div class="bestsellers__line"></div>
      <div class="bestsellers__dotsp"></div>
    </div>
    <div class="bestsellers__sliderp">
      <?php foreach ($products as $product) { ?>
        <div class="bestseller__wrapperSlide">
          <div class="bestsellers__slide product">
            <?php include(DIR_TEMPLATE . 'ortan/template/common/product_tizer.tpl'); ?>
          </div>
        </div>
      <?php } ?>
    </div>
    <div class="bestseller__mobilep">
      <div class="bestsellers__mobileDotsp"></div>
    </div>
  </div>
</section>
<?php } ?>

<?php if($products2 && count($products)) { ?>
<section class="bestsellers">
  <div class="container bestsellers__container">
    <div class="bestsellers__top">
      <a href="https://<?= $lang_link ?>bestseller/" class="bestsellers__headiing">БЕСТСЕЛЛЕРЫ</a>
      <div class="bestsellers__line"></div>
      <div class="bestsellers__dotsI"></div>
    </div>
    <div class="bestsellers__sliderI">
      <?php foreach ($products2 as $product) { ?>
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
<section class="faq">
  <div class="container faq__container">
    <div class="faq__col">
      <div class="faq__title">
        часто задаваемые вопросы
      </div>

      <ul>
        <li><a href="/o-magazine/">
          <span>1</span>
          Где можно посмотреть товары?
        </a></li>
        <li><a href="/delivery/">
          <span>2</span>
          Как производится оплата?
        </a></li>
        <li><a href="/delivery/">
          <span>3</span>
           Если не подойдет товар, что делать?
        </a></li>
        <li><a href="/garantii/">
          <span>4</span>
          Какая гарантия на товары?
        </a></li>
      </ul>
    </div>

    <?php include(DIR_TEMPLATE . 'ortan/template/common/home.reviews.tpl'); ?>
  </div>
</section>

<?php echo $content_bottom; ?>
<?php echo $footer; ?>
