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


<section class="authorization authorization_main">
  <div class="authorization__container container">
    <h1 class="authorization__heading innerHeading"><?php echo $heading_title; ?></h1>
    <p><?php echo $text_error; ?></p>
  </div>
</section>
<?php echo $footer; ?>