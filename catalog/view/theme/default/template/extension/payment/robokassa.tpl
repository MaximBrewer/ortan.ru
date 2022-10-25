<?php if ($robokassa_status_iframe) { ?>
    <script type="text/javascript" src="https://auth.robokassa.ru/Merchant/bundle/robokassa_iframe.js"></script>
    <div class="buttons">
        <div class="pull-right">
            <input type="submit" value="<?php echo $button_confirm ?>" class="btn btn-primary" onclick="Robokassa.StartPayment({MerchantLogin: '<?php echo $robokassa_login ?>',    OutSum: '<?php echo $out_summ ?>', InvId: '<?php echo $inv_id ?>', Description: '<?php echo $order_desc ?>', <?php if ($out_summ_currency) { ?> OutSumCurrency: '<?php echo $out_summ_currency ?>', <?php } ?> <?php if ($robokassa_fiscal) { ?> Receipt: '<?php echo $receipt ?>', <?php } ?> SignatureValue: '<?php echo $crc ?>', Shp_item: '1', Shp_label: 'official_opencart', Culture: '<?php echo $culture ?>'})">
        </div>
    </div>
<?php } else { ?>
    <form action="<?php echo $payment_url ?>" method="post">
        <input type="hidden" name="MerchantLogin" value="<?php echo $robokassa_login ?>" />
        <input type="hidden" name="OutSum" value="<?php echo $out_summ ?>" />
        <input type="hidden" name="InvId" value="<?php echo $inv_id ?>" />
        <input type="hidden" name="Description" value="<?php echo $order_desc ?>" />

        <?php if ($out_summ_currency) { ?>
            <input type="hidden" name="OutSumCurrency" value="<?php echo $out_summ_currency ?>" />
        <?php } ?>
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
                <input type="submit" value="<?php echo $button_confirm ?>" class="btn btn-primary" />
            </div>
        </div>
    </form>
<?php } ?>