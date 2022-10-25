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
<section class="delivery authorization">
  <div class="row">
    <?php echo $column_left;
    if ($column_left && $column_right) {
      $class = 'col-sm-6';
    } elseif ($column_left || $column_right) {
      $class = 'col-sm-9';
    } else {
      $class = 'col-sm-12';
    } ?>
    <div class="delivery__container container" class="<?php echo $class; ?>">
      <?php echo $content_top; ?>
      <h1 class="delivery__heading innerHeading"><?php echo $heading_title; ?></h1>
      <div class="delivery__wrapper">
        <?php echo $description; ?>
      </div>
    </div>
    <?php echo $column_right; ?>
  </div>
</section>
<?php echo $content_bottom; ?>
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
              <?php include(DIR_TEMPLATE . '/ortan/template/common/product_tizer.tpl'); ?>
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
<?php echo $footer; ?>