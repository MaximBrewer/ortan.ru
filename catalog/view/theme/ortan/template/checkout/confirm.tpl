<?php if (!isset($redirect)) { ?>

  <div class="table-responsive">
    <table class="table table-bordered table-hover">
      <tfoot>
        <?php foreach ($totals as $total) { ?>
          <tr>
            <td colspan="4" class="text-right"><strong>
			<?php echo str_replace("Бесплатная доставка", "Стоимость доставки будет рассчитана менеджером", $total['title']); ?>:
			<?php // echo $total['title']; ?>
			</strong></td>
            <td class="text-right"><?php echo $total['text']; ?></td>
          </tr>
        <?php } ?>
      </tfoot>
    </table>
  </div>
  <div class="cart__steps">
    <div class="popup__check">
      <input id="popup__check2" type="checkbox" class="popup__checkbox" name="agree" checked="checked">
      <label for="popup__check2" class="popup__labelCheck"></label>
      <span class="popup__info">
        Соглашаюсь на
        <a href="/privacy/" class="popup__term">Обработку персональных данных</a>
      </span>
    </div>
    <span class="cart__step">Шаг 2 из 2</span>
    <input type="hidden" name="confirm" value="1" />
    <button type="submit" class="cart__btn cart__btn_buy btn btn_red">оформить заказ</button>
    <?php //echo $payment; ?>
  </div>
<?php } else { ?>
  <script type="text/javascript">
    location = '<?php echo $redirect; ?>';
  </script>
<?php } ?>