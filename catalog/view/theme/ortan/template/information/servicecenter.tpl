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
<section class="servicecenter">
  <div class="row">
    <?php echo $column_left;
    if ($column_left && $column_right) {
      $class = 'col-sm-6';
    } elseif ($column_left || $column_right) {
      $class = 'col-sm-9';
    } else {
      $class = 'col-sm-12';
    } ?>
    <div class="servicecenter__container container" class="<?php echo $class; ?>">
      <?php echo $content_top; ?>
      <div class="servicecenter__top">
        <h1 class="servicecenter__heading innerHeading"><?php echo $heading_title; ?></h1>
      </div>
      <div class="servicecenter__wrapper">
        <?php echo $description; ?>
      </div>
    </div>
    <?php echo $column_right; ?>
  </div>
</section>
<?php echo $content_bottom; ?>

<?php echo $footer; ?>