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

<section id="content">
  <div class="container sitemap-navigation">
    <div class="goodsin__pagination">
      <ul class="goodsin__pages">
        <?php foreach ($sitemaps as $key => $sitemap) {
          $href = $key ? "index.php?route=common/sitemap&sitemap=$key" : "index.php?route=common/sitemap";
        ?>
          <?php if ($sitemap['current']) { ?>
            <li class="goodsin__page active"><span><?php echo $key + 1; ?></span></li>
          <?php } else { ?>
            <li class="goodsin__page"><a href="<?php echo $href; ?>"><?php echo $key + 1; ?></a></li>
          <?php } ?>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container">
    <ul>
      <?php foreach ($map as $item) { ?>
        <li><a href="<?php echo $item['href']; ?>"><?php echo $item['title']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
</section>
<?php echo $footer; ?>