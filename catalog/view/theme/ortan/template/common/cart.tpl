<div id="cart">
  <span class="toprMenu__cartNum" data-loading-text="<?php echo $text_loading; ?>"><?php echo $text_items; ?></span>
  <a href="javascript:;" class="checkout-link"><svg width="20" height="18" viewBox="0 0 20 18" xmlns="http://www.w3.org/2000/svg" class="topMenu__icon">
    <path d="M6.44379 11.9298H6.4447C6.44547 11.9298 6.44623 11.9297 6.44699 11.9297H17.0703C17.3319 11.9297 17.5618 11.7562 17.6337 11.5047L19.9774 3.30161C20.0279 3.12476 19.9925 2.93463 19.8819 2.78784C19.7711 2.64105 19.5979 2.55469 19.4141 2.55469H5.09247L4.67362 0.669769C4.61395 0.401672 4.37622 0.210938 4.10156 0.210938H0.585938C0.262299 0.210938 0 0.473236 0 0.796875C0 1.12051 0.262299 1.38281 0.585938 1.38281H3.63159C3.70575 1.71683 5.63599 10.403 5.74707 10.9028C5.12436 11.1735 4.6875 11.7943 4.6875 12.5156C4.6875 13.4849 5.47608 14.2734 6.44531 14.2734H17.0703C17.394 14.2734 17.6563 14.0111 17.6563 13.6875C17.6563 13.3639 17.394 13.1016 17.0703 13.1016H6.44531C6.12229 13.1016 5.85938 12.8387 5.85938 12.5156C5.85938 12.1931 6.12137 11.9306 6.44379 11.9298ZM18.6372 3.72656L16.6283 10.7578H6.91529L5.35278 3.72656H18.6372Z" />
    <path d="M5.85938 16.0312C5.85938 17.0005 6.64795 17.7891 7.61719 17.7891C8.58643 17.7891 9.375 17.0005 9.375 16.0312C9.375 15.062 8.58643 14.2734 7.61719 14.2734C6.64795 14.2734 5.85938 15.062 5.85938 16.0312ZM7.61719 15.4453C7.94022 15.4453 8.20312 15.7082 8.20312 16.0312C8.20312 16.3543 7.94022 16.6172 7.61719 16.6172C7.29416 16.6172 7.03125 16.3543 7.03125 16.0312C7.03125 15.7082 7.29416 15.4453 7.61719 15.4453Z" />
    <path d="M14.1406 16.0312C14.1406 17.0005 14.9292 17.7891 15.8984 17.7891C16.8677 17.7891 17.6563 17.0005 17.6563 16.0312C17.6563 15.062 16.8677 14.2734 15.8984 14.2734C14.9292 14.2734 14.1406 15.062 14.1406 16.0312ZM15.8984 15.4453C16.2215 15.4453 16.4844 15.7082 16.4844 16.0312C16.4844 16.3543 16.2215 16.6172 15.8984 16.6172C15.5754 16.6172 15.3125 16.3543 15.3125 16.0312C15.3125 15.7082 15.5754 15.4453 15.8984 15.4453Z" />
  </svg></a>
  <?php if ($products || $vouchers) { ?>
    <div class="cartPopup">
      <h4 class="cartPopup__heading">корзина</h4>
      <div class="cartPopup__list">
        <ul>
          <?php foreach ($products as $product) { ?>
            <li class="cartPopup__item">
              <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="cartPopup__img" />
              <a href="<?php echo $product['href']; ?>" class="cartPopup__name"><?php echo $product['name']; ?></a>
              <div class="cartPopup__add">
                <button class="cartPopup__sign cartPopup__less" onclick="cart.updateAjax('<?php echo $product['cart_id']; ?>',<?php echo $product['quantity'] - $product['minimum']; ?>,true);">-</button>
                <span class="cartPopup__number"><?php echo $product['quantity']; ?></span>
                <button class="cartPopup__sign cartPopup__more" onclick="cart.updateAjax('<?php echo $product['cart_id']; ?>',<?php echo $product['quantity'] + $product['minimum']; ?>,true);">+</button>
              </div>
              <span class="cartPopup__price"><?php echo $product['total']; ?></span>
              <a href="javascript:;" onclick="cart.remove('<?php echo $product['cart_id']; ?>');">
                <img src="/catalog/view/theme/ortan/assets/images/icon-remove-red.svg" alt="icon remove" class="cartPopup__remove">
              </a>
            </li>
          <?php } ?>
        </ul>
      </div>
      <div class="cartPopup__bottom">
        <a href="<?php echo $checkout;?>" class="cartPopup__buy btn btn_red">оформить заказ</a>
        <div class="cartPopup__all">
          <div>
            <?php foreach ($totals as $total) { ?>
              <div><?php echo $total['title']; ?> <span><?php echo $total['text']; ?></span></div>
            <?php break; } ?>
          </div>
        </div>
      </div>
    </div>
  <?php } ?>