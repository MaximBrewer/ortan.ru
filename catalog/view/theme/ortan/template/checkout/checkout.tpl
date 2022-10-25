<?php echo $header; ?>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<?php include("part_cart.tpl") ?>
<script>
    // Ordering Page =====================================
    // Show next Step

    $(document).on("click", ".cart__btn_next", function() {
        $.ajax({
            url: "index.php?route=checkout/checkout/info",
			dataType: 'html',
            type: "post",
            data: {
                fio: $('[name=fio]').val(),
                telephone: $('[name=telephone]').val(),
                email: $('[name=email]').val()
            },
            beforeSend: function() {
                $("#overlay").show();
            },
            complete: function() {
                $("#overlay").hide();
            },
            success: function(html) {
                $("#ordering").html(html);
                $('html, body').animate({
                    scrollTop: $('.cart.step2').offset().top - $('.header__container').outerHeight() - 10
                }, 'slow');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(
                    thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText
                );
                $("#overlay").hide();
            },
        });
    });

    $(document).on('change', '[name=city]', function() {
        $.ajax({
            url: 'index.php?route=checkout/checkout',
            dataType: 'json',
            method: "POST",
            data: {
                city: $('[name=city]').val(),
                address: $('[name=address]').val(),
                zone: $('[name=zone]').val(),
                silent: 1,
            },
            beforeSend: function() {
                $("#overlay").show();
            },
            success: function(html) {
                refreshShipping();
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                $("#overlay").hide();
            }
        });
    })

    function updateShippingMethod() {
        $('#shipping-method .alert').remove();
        $('#shipping-method .warning').remove();
        $.ajax({
            url: 'index.php?route=checkout/shipping_method/save',
            dataType: 'json',
            method: "POST",
            data: {
                shipping_method: $('#shipping-method input:checked').val(),
                comment: $('textarea[name=comment]').val()
            },
            success: function(data) {
                if (data.error) {
                    if (data.error.warning) {
                        $("#shipping-method").append('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + data.error.warning + '</div>');
                        $("#overlay").hide();
                    }
                } else refreshPayment()
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                $("#overlay").hide();
            }
        });
    }

    function updatePaymentMethod(refresh) {
        $.ajax({
            url: 'index.php?route=checkout/payment_method/save',
            dataType: 'html',
            method: "POST",
            data: {
                payment_method: $('#payment-method input:checked').val(),
                comment: $('textarea[name=comment]').val(),
                agree: 'on',
            },
            success: function(html) {
                refreshConfirm()
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                $("#overlay").hide();
            }
        });
    }

    $(document).on('change', '[name=shipping_method]', function() {
        $("#overlay").show();
        $('#payment-method').html('');
        $('#confirm').html('');
        updateShippingMethod()
    })

    function refreshShipping() {
        $('#payment-method').html('');
        $('#confirm').html('');
        $.ajax({
            url: 'index.php?route=checkout/shipping_method',
            dataType: 'html',
            success: function(html) {
                $('#shipping-method').html(html);
                updateShippingMethod()
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                $("#overlay").hide();
            }
        });
    }

    function refreshPayment() {
        $('#confirm').html('');
        $.ajax({
            url: 'index.php?route=checkout/payment_method',
            dataType: 'html',
            success: function(html) {
                $('#payment-method').html(html);
                updatePaymentMethod(true)
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                $("#overlay").hide();
            }
        });
    }

    function refreshConfirm() {
        $.ajax({
            url: 'index.php?route=checkout/confirm',
            dataType: 'html',
            method: "POST",
            data: {
                shipping_method: $('input[name=shipping_method]:checked').val(),
                payment_method: $('input[name=payment_method]:checked').val(),
                comment: $('textarea[name=comment]').val()
            },
            success: function(html) {
                $('#confirm').html(html);
                $("#overlay").hide();
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                $("#overlay").hide();
            }
        });
    }
</script>
<?php echo $footer; ?>