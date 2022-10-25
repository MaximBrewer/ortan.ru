<?php echo $header;
$hide_icons = true; ?>
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
    <div class="authorization_prof">
      <div class="authorization__forms">
        <?php if ($products) { ?>
          <ul class="goodsin__list">
            <?php foreach ($products as $product) { ?>
              <li class="goodsin__wrapper">
                <div class="goodsin__inem productin">
                  <a href="<?php echo $product['remove']; ?>" data-toggle="tooltip" title="<?php echo $button_remove; ?>" style="display:block;border-radius:50%;float:right;border:2px solid white;background-color:white;position:relative;z-index:4">
                    <svg width="2rem" height="2rem" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" style="display:block;">
                      <path d="m256 0c-141.164062 0-256 114.835938-256 256s114.835938 256 256 256 256-114.835938 256-256-114.835938-256-256-256zm0 0" fill="#f44336" />
                      <path d="m350.273438 320.105469c8.339843 8.34375 8.339843 21.824219 0 30.167969-4.160157 4.160156-9.621094 6.25-15.085938 6.25-5.460938 0-10.921875-2.089844-15.082031-6.25l-64.105469-64.109376-64.105469 64.109376c-4.160156 4.160156-9.621093 6.25-15.082031 6.25-5.464844 0-10.925781-2.089844-15.085938-6.25-8.339843-8.34375-8.339843-21.824219 0-30.167969l64.109376-64.105469-64.109376-64.105469c-8.339843-8.34375-8.339843-21.824219 0-30.167969 8.34375-8.339843 21.824219-8.339843 30.167969 0l64.105469 64.109376 64.105469-64.109376c8.34375-8.339843 21.824219-8.339843 30.167969 0 8.339843 8.34375 8.339843 21.824219 0 30.167969l-64.109376 64.105469zm0 0" fill="#fafafa" />
                    </svg></a>
                  <?php include(DIR_TEMPLATE . 'ortan/template/common/product_tizer.tpl'); ?>
                </div>
              </li>
            <?php } ?>
          </ul>
        <?php } else { ?>
          <p><?php echo $text_empty; ?></p>
        <?php } ?>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
</section>
<?php echo $footer; ?>