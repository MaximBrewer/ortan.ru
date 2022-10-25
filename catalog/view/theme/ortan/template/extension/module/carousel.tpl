<section class="goods">
  <div class="goods__navs"></div>
  <div class="container">
    <div class="goods__slider" id="carousel<?php echo $module; ?>">
      <?php foreach ($banners as $banner) { ?>
        <div class="goods__slide">
          <div class="goods__wrapper"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="goods__img goods__img_big"></div>
          <div class="goods__container">
            <?php if ($banner['link']) { ?>
              <a href="<?php echo $banner['link']; ?>" class="goods__btn btn">СМОТРЕТЬ ТОВАР</a>
            <?php } ?>
          </div>
        </div>
      <?php } ?>
    </div>
  </div>
  <div class="goods__menu">
    <div class="goods__dots"></div>
  </div>
</section>