<?php if ($show_price) { ?>
  <div class="catalog__range range">
    <p class="range__about">
      <span class="range__text">По цене: от <b><span class="range__numbers range__numbers_from" id="price-from"><?php echo $min_price_get; ?></span></b>₽ до <b><span class="range__numbers range__numbers_to" id="price-to"><?php echo $max_price_get; ?></span></b>₽ </span>
    </p>
    <div id="scale-price" class="scale ocf-target" data-option-id="p" data-start-min="<?php echo $min_price_get; ?>" data-start-max="<?php echo $max_price_get; ?>" data-range-min="<?php echo $min_price; ?>" data-range-max="<?php echo $max_price; ?>" data-element-min="#price-from" data-element-max="#price-to" data-control-min="#min-price-value" data-control-max="#max-price-value"></div>
  </div>
<?php } ?>