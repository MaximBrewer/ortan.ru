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
    <div class="<?php echo $class; ?>">
      <div class="catalog__container container">
        <?php echo $content_top; ?>


        <div class="catalog__filter filter">
          <?php echo $column_left; ?>
        </div>
        <div class="catalog__goods goodsin">

          <div class="goodsin__top">
            <h1 class="goodsin__heading"><?php echo $heading_title; ?></h1>
        
          <?php if(!empty($categories)) { ?>
          <div class="subcategory-links v-mobile">
              <div class="size__form">
              <?php foreach ($categories as $category) { ?>
              <a href="<?php echo $category['href']; ?>" class="size__checkName" style="text-decoration:none;"><?php echo $category['name']; ?></a>
              <?php } ?>
          </div>
          </div>
          <?php } ?>
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
                  <?php include(DIR_TEMPLATE . '/ortan/template/common/product_tizer.tpl'); ?>
                </div>
              </li>
            <?php /*
              <div class="product-layout product-list col-xs-12">
                <div class="product-thumb">
                  <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
                  <div>
                    <div class="caption">
                      <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                      <p><?php echo $product['description']; ?></p>
                      <?php if ($product['price']) { ?>
                        <p class="price">
                          <?php if (!$product['special']) { ?>
                            <?php echo $product['price']; ?>
                          <?php } else { ?>
                            <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                          <?php } ?>
                          <?php if ($product['tax']) { ?>
                            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                          <?php } ?>
                        </p>
                      <?php } ?>
                      <?php if ($product['rating']) { ?>
                        <div class="rating">
                          <?php for ($i = 1; $i <= 5; $i++) { ?>
                            <?php if ($product['rating'] < $i) { ?>
                              <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                            <?php } else { ?>
                              <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                            <?php } ?>
                          <?php } ?>
                        </div>
                      <?php } ?>
                    </div>
                    <div class="button-group">
                      <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
                      <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
                      <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
                    </div>
                  </div>
                </div>
              </div>
                            <?php*/ } ?>

          </ul>
          <?php echo $pagination; ?>
        </div>
      </div>
      <?php echo $content_bottom; ?>
    </div>
  </div>
</section>
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
<?php if ($maybe_interesting && !empty($maybe_interesting)) { ?>
  <section class="bestsellers sameProd">
    <div class="container bestsellers__container">
      <h4 class="shouldLike__headiing seen__heading">Возможно, Вас заинтересует</h4>
      <div class="sameProd__slider">
        <?php foreach ($maybe_interesting as $product) { ?>
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
<section class="seenText">
    <div class="seenText__container container">
        <?php echo $description; ?>
    </div>
</section>
<?php if ($sizes) { ?>
  <script>
    $('.sizes_wrapper').html('<a data-fancybox="sizes" href="<?php echo $sizes; ?>" alt="<?php echo $sizesalt ?? ""; ?>" class="size__link">Таблица размеров</a>');
  </script>
<?php } ?>
<?php echo $footer; ?>
