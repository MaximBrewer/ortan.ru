<?php if ($option['color']) { ?>
  <div class="ocf-color" style="background-color: #<?php echo $value['color']; ?>;"></div>
<?php } ?>

<?php if ($option['image']) { ?>
  <div class="ocf-image" style="background-image: url(<?php echo $value['image']; ?>);"></div>
<?php } ?>


<?php if ($option['name'] == 'Размер') { ?>

<?php if ($value['selected']) { ?>
  <label id="v-<?php echo $value['id']; ?>" class="ocf-selected size__item" data-option-id="<?php echo $option['option_id']; ?>">
    <input type="<?php echo $option['type']; ?>" name="ocf[<?php echo $option['option_id']; ?>]" value="<?php echo $value['params']; ?>" checked="checked" class="ocf-target size__checkbox filter__input" autocomplete="off" />
    <span class="size__checkName"><?php echo $value['name']; ?>
      <?php if ($show_counter) { ?>
        <small class="badge"></small>
      <?php } ?></span>
  </label>
<?php } else if ($value['count']) { ?>
  <label id="v-<?php echo $value['id']; ?>" data-option-id="<?php echo $option['option_id']; ?>" class="size__item">
    <input type="<?php echo $option['type']; ?>" name="ocf[<?php echo $option['option_id']; ?>]" value="<?php echo $value['params']; ?>" class="ocf-target size__checkbox filter__input" autocomplete="off" />
    <span class="size__checkName"><?php echo $value['name']; ?>
      <?php if ($show_counter) { ?>
        <small class="badge"><?php echo $value['count']; ?></small>
      <?php } ?></span>
  </label>
<?php } else { ?>
  <label id="v-<?php echo $value['id']; ?>" class="disabled size__item" data-option-id="<?php echo $option['option_id']; ?>">
    <input type="<?php echo $option['type']; ?>" name="ocf[<?php echo $option['option_id']; ?>]" value="" disabled="disabled" class="ocf-target size__checkbox filter__input" autocomplete="off" />
    <span class="size__checkName"><?php echo $value['name']; ?>
      <?php if ($show_counter) { ?>
        <small class="badge">0</small></span>
  <?php } ?>
  </label>
<?php } ?>

<?php } else { ?>

  <?php if ($value['selected']) { ?>
    <label id="v-<?php echo $value['id']; ?>" class="ocf-selected manufacturers__item filter__label" data-option-id="<?php echo $option['option_id']; ?>">
      <input type="<?php echo $option['type']; ?>" name="ocf[<?php echo $option['option_id']; ?>]" value="<?php echo $value['params']; ?>" checked="checked" class="ocf-target manufacturers__checkbox filter__input" autocomplete="off" />
      <span class="manufacturers__checkName filter__check"><?php echo $value['name']; ?>
        <?php if ($show_counter) { ?>
          <small class="badge"></small>
        <?php } ?></span>
    </label>
  <?php } else if ($value['count']) { ?>
    <label id="v-<?php echo $value['id']; ?>" data-option-id="<?php echo $option['option_id']; ?>" class="manufacturers__item filter__label">
      <input type="<?php echo $option['type']; ?>" name="ocf[<?php echo $option['option_id']; ?>]" value="<?php echo $value['params']; ?>" class="ocf-target manufacturers__checkbox filter__input" autocomplete="off" />
      <span class="manufacturers__checkName filter__check"><?php echo $value['name']; ?>
        <?php if ($show_counter) { ?>
          <small class="badge"><?php echo $value['count']; ?></small>
        <?php } ?></span>
    </label>
  <?php } else { ?>
    <label id="v-<?php echo $value['id']; ?>" class="disabled manufacturers__item filter__label" data-option-id="<?php echo $option['option_id']; ?>">
      <input type="<?php echo $option['type']; ?>" name="ocf[<?php echo $option['option_id']; ?>]" value="" disabled="disabled" class="ocf-target manufacturers__checkbox filter__input" autocomplete="off" />
      <span class="manufacturers__checkName filter__check"><?php echo $value['name']; ?>
        <?php if ($show_counter) { ?>
          <small class="badge">0</small></span>
    <?php } ?>
    </label>
  <?php } ?>

<?php  } ?>