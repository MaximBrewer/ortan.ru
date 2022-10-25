<div class="header__slider" id="slideshow<?php echo $module; ?>">
  <?php foreach ($banners as $banner) { ?>
    <div class="mainSlider__slide" data-dark="<?php echo $banner['dark']; ?>">
      <?php if ($banner['link']) { ?>
        <a href="<?php echo $banner['link']; ?>">
          <img class="mainSlider__img" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>">
        </a>
      <?php } else { ?>
        <img class="mainSlider__img" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>">
      <?php } ?>
    </div>
  <?php } ?>
</div>
<div class="header__socials">
  <div class="header__line"></div>
  <a rel="nofollow" target="_blank" href="<?php echo $config['config_social_youtube']; ?>" class="header__social header__social_youtube">YOUTUBE</a>
  <a rel="nofollow" target="_blank" href="<?php echo $config['config_social_instagram']; ?>" class="header__social header__social_instagram">INSTAGRAM</a>
  <div class="header__line"></div>
</div>