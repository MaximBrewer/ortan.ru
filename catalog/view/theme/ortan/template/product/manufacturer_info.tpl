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


<section class="catalog">
  <div class="row">
    <div>
      <div class="catalog__container container">
        <?php echo $content_top; ?>


        <div class="catalog__filter filter">
          <?php echo $column_left; ?>
        </div>
        <div class="catalog__goods goodsin">
          <div class="goodsin__top">
            <h1 class="goodsin__heading"><?php echo $heading_title; ?></h1>
            <div class="goodsin__selectWrapper">
              <select id="input-sort" class="goodsin__select" onchange="if(this.value) location = this.value;">
                <?php foreach ($sorts as $sorts) { ?>
                  <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                    <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                  <?php } else { ?>
                    <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                  <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <ul class="goodsin__list">
            <?php foreach ($products as $product) { ?>
              <li class="goodsin__wrapper">
                <div class="goodsin__inem productin">
                  <?php include(DIR_TEMPLATE . 'ortan/template/common/product_tizer.tpl'); ?>
                </div>
              </li>
            <?php } ?>

          </ul>
          <?php echo $pagination; ?>
        </div>
      </div>
      <?php echo $content_bottom; ?>
    </div>
  </div>
</section>
<?php if (isset($recently_viewed) && !empty($recently_viewed)) { ?>
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
<section class="seenText">
  <div class="seenText__container container">
    <?php echo $description; ?>
  </div>
</section>
<?php echo $footer; ?>