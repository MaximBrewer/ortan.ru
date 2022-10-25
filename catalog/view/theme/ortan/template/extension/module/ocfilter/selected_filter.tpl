<?php if ($selecteds) { ?>
<div class="list-group-item selected-options">
  <?php foreach ($selecteds as $option) { ?>
  <div class="ocfilter-option">
    <span><?php echo $option['name']; ?>:</span>
    <?php foreach ($option['values'] as $value) { ?>
    <a onclick="location = '<?php echo $value['href']; ?>';" style="padding: 1px 4px;"><i class="fa fa-times"></i> <?php echo $value['name']; ?></a>
    <?php } ?>
  </div>
  <?php } ?>
	<?php $count = count($selecteds); $selected = $selecteds; $first = array_shift($selected); ?>
  <?php if ($count > 1 || count($first['values']) > 1) { ?>
  <a onclick="location = '<?php echo $link; ?>';" style="border-radius: 0;"><i class="fa fa-times-circle"></i> <?php echo $text_cancel_all; ?></a>
  <?php } ?>
</div>
<?php } ?>