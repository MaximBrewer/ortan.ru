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
<section class="blog">
  <div class="blog__container container">
    <h1 class="blog__heading innerHeading"><?php echo $heading_title; ?></h1>
    <ul class="blog__grid">
      <?php foreach ($articles as $article) { ?>
        <li class="blog__item">
          <?php include dirname(__FILE__) . '/_tizer.tpl'; ?>
        </li>
      <?php } ?>
    </ul>
    <!-- <button class="blog__btn-big">
      Показать еще
    </button> -->
    <?php echo $pagination; ?>
  </div>
</section>
<?php echo $footer; ?>