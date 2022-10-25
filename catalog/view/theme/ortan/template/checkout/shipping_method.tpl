<?php if ($error_warning) { ?>
  <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods) { ?>
  <p class="p-text-shipping"><?php echo $text_shipping_method; ?></p>
  <?php foreach ($shipping_methods as $shipping_method) { ?>
    <p><strong><?php echo str_replace("Бесплатная доставка", "Доставка", $shipping_method['title']); ?></strong></p>
    <?php if (!$shipping_method['error']) { ?>
      <?php foreach ($shipping_method['quote'] as $quote) { ?>
        <div class="radio">
          <label>
            <?php if ($quote['code'] == $code || !$code) { ?>
              <?php $code = $quote['code']; ?>
              <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" checked="checked" />
            <?php } else { ?>
              <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" />
            <?php } ?>
            <?php $desc = $quote['title'] . ' - ' . $quote['text'];?>
            <?php echo str_replace("Бесплатная доставка - 0 ₽", "Стоимость доставки будет рассчитана менеджером", $desc); ?>
  <?php /*CDEK OCMOD START*/ if (isset($quote['description'])) { ?>
  <?php echo $quote['description']; ?>
  <?php } /*CDEK OCMOD END*/ ?>
          </label>
        </div>
      <?php } ?>
    <?php } else { ?>
      <div class="alert alert-danger"><?php echo $shipping_method['error']; ?></div>
    <?php } ?>
  <?php } ?>
<?php } ?>