<?php if($products && count($products)) { ?>
<section class="bestsellers">
  <div class="container bestsellers__container">
    <div class="bestsellers__top">
      <h2 class="bestsellers__headiing">БЕСТСЕЛЛЕРЫ</h2>
      <div class="bestsellers__line"></div>
      <div class="bestsellers__dotsI"></div>
    </div>
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