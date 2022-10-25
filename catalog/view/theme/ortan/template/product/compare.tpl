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

<?php if ($success) { ?>
  <div class="productm__addToCart productm__addToCart_red" style="display: flex;"><svg class="productm__addOk" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M19.9184 2.8527L7.51783 15.2533C7.40861 15.3625 7.23175 15.3625 7.12278 15.2533L0.0817287 8.21196C-0.0272429 8.10325 -0.0272429 7.92639 0.0817287 7.81716L1.79261 6.10628C1.90184 5.99731 2.07869 5.99731 2.18766 6.10628L7.32056 11.2389L17.8127 0.746768C17.9222 0.637796 18.0985 0.637796 18.2078 0.746768L19.9184 2.45765C20.0276 2.56662 20.0276 2.74322 19.9184 2.8527Z" fill="white"></path>
    </svg>
    <p class="productm__addInfo"><?php echo $success; ?></p><svg class="productm__addClose" width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="white"></path>
    </svg>
  </div>
<?php } ?>

<section class="authorization comparison">
  <div class="authorization__container container">
    <div class="comparison__top">
      <h1 class="comparison__heading innerHeading"><?php echo $heading_title; ?></h1>
      <!-- <button class="comparison__clear btn">Очистить список</button> -->
    </div>
    <?php if ($products) { ?>
      <?php
      $ops = array();
      foreach ($products as $product) {
        if ($product['options'] && count($product['options'])) {
          foreach ($product['options'] as $option) {
            $ops[$option['option_id']] = $option['name'];
          }
        }
      } ?>
      <div class="comparison__slider compSlider">
        <?php foreach ($products as $product) { ?>
          <div class="compSlider__slide">
            <div class="compSlider__wrapper">
              <div class="compSlider__imgWrapper">
                <img src="<?php echo $product['thumb']; ?>" alt="product" class="compSlider__img">
              </div>
              <div class="product__info">
                <span class="product__price"><?php if ($product['special']) { ?><?php echo $product['special']; ?><?php } else { ?><?php echo $product['price']; ?><?php } ?></span>
                <span class="product__has">В наличии</span>
              </div>
              <?php if ($product['special']) { ?><span class="product__oldPrice"><?php echo $product['price']; ?></span><?php } ?>
              <a href="<?php echo $product['href']; ?>" class="product__nameBox" title="<?php echo $product['name']; ?>">
                <h4 class="product__name"><?php echo $product['name']; ?></h4>
                <span class="pruduct__about">Артикул: <?php echo $product['sku']; ?></span>
              </a>
              <a href="<?php echo $product['remove']; ?>" class="compSlider__remove pruduct__add btn">Убрать из сравнения</a>
              <div class="compSlider__info">
                <?php if ($product['options'] && count($product['options'])) { ?>
                  <?php foreach ($ops as $option_id => $option_name) {
                    $option = false;
                    foreach ($product['options'] as $o) {
                      if ($option_id == $o['option_id']) $option = $o;
                    }
                    if ($option) { ?>
                      <div class="compSlider__feature">
                        <p class="compSlider__featureName"><?php echo $option['name']; ?></p>
                        <p class="compSlider__description">
                          <?php
                          switch ($option['type']) {
                            case 'select':
                            case 'radio':
                            case 'checkbox':
                              foreach ($option['product_option_value'] as $key => $option_value) {
                                if ($key) echo ', ';
                                if ($option['keyword'] && $option_value['keyword']) {
                                  echo '<a href="/tovary/' . $option['keyword'] . '/' . $option_value['keyword'] . '/' . '" style="white-space:nowrap">' . $option_value['name'] . '</a>';
                                } else {
                                  echo '<span style="white-space:nowrap">' . $option_value['name'] . '</span>';
                                }
                              }
                              break;
                            default:
                              echo $option['value'];
                              break;
                          } ?></p>
                      </div>
                    <?php } else { ?>
                      <div class="compSlider__feature">
                        <p class="compSlider__featureName"><?php echo $option_name; ?></p>
                        <p class="compSlider__description">--</p>
                      </div>
                    <?php } ?>
                  <?php } ?>
                <?php } else { ?>
                  <div class="compSlider__feature">Характеристики товара отсутствуют
                  </div>
                <?php } ?>
              </div>
            </div>
          </div>
        <?php } ?>
      </div>
      <div class="bestseller__mobile">
        <div class="bestsellers__mobileDots"></div>
      </div>
    <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
    <?php } ?>
  </div>
</section>
<?php echo $footer; ?>