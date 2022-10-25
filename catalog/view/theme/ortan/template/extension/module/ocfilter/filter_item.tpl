<?php if ($option['type'] == 'slide' || $option['type'] == 'slide_dual') { ?>
  <div class="catalog__range range">
    <p class="range__about">
      <span class="range__text">По цене: от <b><span class="range__numbers range__numbers_from" id="left-value-<?php echo $option['option_id']; ?>"><?php echo $option['slide_value_min_get']; ?></span></b>₽ до <b><span class="range__numbers range__numbers_to" id="right-value-<?php echo $option['option_id']; ?>"><?php echo $option['slide_value_max_get']; ?></span></b>₽ </span>
    </p>
    <?php include 'filter_slider_item.tpl'; ?>
    <input type="text" class="range__input" name="my_range" value="" />
  </div>
<?php } elseif ($option['selectbox']) { ?>
<?php } elseif ($option['name'] == 'Размер') { ?>
  <div class="filter__size size">
    <div class="size__top">
      <p class="filter__name"><?php echo $option['name']; ?>:</p>
      <div class="sizes_wrapper"></div>
    </div>
    <div class="size__form">
      <?php include 'value_list.tpl'; ?>
    </div>
  </div>
<?php } else { ?>
  <div class="filter__manufacturers manufacturers" id="option-<?php echo $option['option_id']; ?>">
    <p class="filter__name"><?php echo $option['name']; ?>:</p>
    <div class="manufacturers__form">
      <?php include 'value_list.tpl'; ?>
    </div>
  </div>
<?php } ?>