<form action="<?php echo $payment_url ?>" method="post" id="form-robokassa">
    <input type="hidden" name="MerchantLogin" value="<?php echo $robokassa_login ?>" />
    <input type="hidden" name="OutSum" value="<?php echo $out_summ ?>" />
    <input type="hidden" name="InvId" value="<?php echo $inv_id ?>" />
    <input type="hidden" name="Description" value="<?php echo $order_desc ?>" />
    <?php if ($robokassa_fiscal) { ?>
        <input type="hidden" name="Receipt" value="<?php echo $receipt ?>" />
    <?php } ?>
    <input type="hidden" name="SignatureValue" value="<?php echo $crc ?>" />
    <input type="hidden" name="Shp_item" value="1" />
    <input type="hidden" name="Shp_label" value="official_opencart" />

    <?php if ($robokassa_test) { ?>
        <input type="hidden" name="IsTest" value="1" />
    <?php } ?>
    <input type="hidden" name="IncCurrLabel" value="" />
    <input type="hidden" name="Culture" value="<?php echo $culture ?>" />
    <div class="buttons">
        <div class="pull-right">
            <button type="submit" value="<?php echo $button_confirm ?>" class="cart__btn cart__btn_buy btn btn_red" >Оплатить</button>
        </div>
    </div>
</form>