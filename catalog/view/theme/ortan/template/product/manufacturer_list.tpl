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
  <div class="catalog__container container">
    <div>
      <h1><?php echo $heading_title; ?></h1>
      <?php if ($categories) { ?>
        <p><strong><?php echo $text_index; ?></strong>
          <?php foreach ($categories as $category) { ?>
            &nbsp;&nbsp;&nbsp;<a href="index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><?php echo $category['name']; ?></a>
          <?php } ?>
        </p>
        <?php foreach ($categories as $category) { ?>
          <h2 id="<?php echo $category['name']; ?>"><?php echo $category['name']; ?></h2>
          <?php if ($category['manufacturer']) { ?>
            <?php foreach (array_chunk($category['manufacturer'], 4) as $manufacturers) { ?>
              <div class="row">
                <?php foreach ($manufacturers as $manufacturer) { ?>
                  <div class="col-sm-3"><a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a></div>
                <?php } ?>
              </div>
            <?php } ?>
          <?php } ?>
        <?php } ?>
      <?php } else { ?>
        <p><?php echo $text_empty; ?></p>
        <div class="buttons clearfix">
          <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
        </div>
      <?php } ?>
      <?php echo $content_bottom; ?>
    </div>
    <?php echo $column_right; ?>
  </div>
</section>
<?php echo $footer; ?>