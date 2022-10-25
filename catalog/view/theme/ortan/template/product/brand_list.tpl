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

<section class="brands">
  <div class="container">
      <h1><?php echo $heading_title; ?></h1>
      <?php if ($brands) { ?>
        <ul class="brands__goodsin__list goodsin__list">
          <?php foreach ($brands as $brand) { ?>
            <li class="goodsin__wrapper">
              <div class="goodsin__inem productin">
                <a href="<?php echo $brand['href']; ?>" class="product__imgWrapper">
                  <img src="<?php echo $brand['thumb']; ?>" alt="<?php echo htmlspecialchars($brand['name']); ?>" class="product__img" />
                </a>
              </div>
            </li>
          <?php } ?>
        </ul>
      <?php } else { ?>
        <p><?php echo $text_empty; ?></p>
      <?php } ?>
  </div>
</section>
<?php echo $footer; ?>