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
<section class="authorization authorization_profile">
  <div class="authorization__container container">
    <div class="authorization_prof">
      <div class="authorization__forms delivery">
        <div class="authForm__wrapper_bg ">
          <div class="delivery__wrapper">
            <h1><?php echo $heading_title; ?></h1>
            <br />
            <?php echo $text_message; ?>
            <br /><a href="<?php echo $continue; ?>" class="btn btn_red"><?php echo $button_continue; ?></a>

          </div>
        </div>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
</section>
<?php echo $footer; ?>
<?php
  if (!empty($bitrix24_push)) {
    echo $bitrix24_push;
  }
  if (!empty($ym_script)) {
    echo $ym_script;
  }
?>