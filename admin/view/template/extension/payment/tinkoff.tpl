<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>"
                        class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"
                   class="btn btn-default"><i class="fa fa-reply"></i></a>
            </div>

            <h1><?php echo $heading_title; ?></h1>

            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>

    <div class="container-fluid">
        <?php if (isset($error_warning)) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>

        <div class="panel panel-default">
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form"
                      class="form-horizontal">

                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <div class="form-group  required">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_terminal_key"><?php echo $terminal_key_label; ?></label>

                                <div class="col-sm-10">
                                    <input type="text" name="tinkoff_terminal_key"
                                           value="<?php echo $tinkoff_terminal_key; ?>" class="form-control"/>
                                    <?php if (isset($error['terminal_key'])) { ?>
                                    <span class="error"><?php echo $error['terminal_key']; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group  required">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_secret_key"><?php echo $secret_key_label; ?></label>

                                <div class="col-sm-10">
                                    <input type="text" name="tinkoff_secret_key"
                                           value="<?php echo $tinkoff_secret_key; ?>" class="form-control"/>
                                    <?php if (isset($error['tinkoff_secret_key'])) { ?>
                                    <span class="error"><?php echo $error['tinkoff_secret_key']; ?></span>
                                    <?php } ?>
                                </div>
                            </div>

                            <!-- order statuses -->
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_order_status_authorized"><?php echo $status_authorized; ?></label>
                                <div class="col-sm-10">
                                    <select name="tinkoff_order_status_authorized" id="tinkoff_order_status_authorized"
                                            class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $tinkoff_order_status_authorized) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"
                                                selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_order_status_completed"><?php echo $status_completed; ?></label>

                                <div class="col-sm-10">
                                    <select name="tinkoff_order_status_completed" id="tinkoff_order_status_completed"
                                            class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $tinkoff_order_status_completed) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"
                                                selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_order_status_canceled"><?php echo $status_canceled; ?></label>

                                <div class="col-sm-10">
                                    <select name="tinkoff_order_status_canceled" id="tinkoff_order_status_canceled"
                                            class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $tinkoff_order_status_canceled) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"
                                                selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_order_status_rejected"><?php echo $status_rejected; ?></label>

                                <div class="col-sm-10">
                                    <select name="tinkoff_order_status_rejected" id="tinkoff_order_status_rejected"
                                            class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $tinkoff_order_status_rejected) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"
                                                selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_order_status_refunded"><?php echo $status_refunded; ?></label>

                                <div class="col-sm-10">
                                    <select name="tinkoff_order_status_refunded" id="tinkoff_order_status_refunded"
                                            class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $tinkoff_order_status_refunded) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"
                                                selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_status"><?php echo $status_label; ?></label>

                                <div class="col-sm-10">
                                    <select name="tinkoff_status" class="form-control">
                                        <?php if ($tinkoff_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_enabled_taxation"><?php echo $tinkoff_enabled_taxation_label; ?></label>

                                <div class="col-sm-10">
                                    <input type="checkbox" name="tinkoff_enabled_taxation"
                                           onclick="showTinkoffTaxation(this.checked)"
                                           class="form-control" id="checked" <?php echo ($tinkoff_enabled_taxation) ? 'checked' : '' ?>
                                    >
                                </div>
                            </div>

                            <div class="form-group table-line" id="tinkoffTaxation">
                                <div class="table-line" id="tinkoffTaxation">
                                    <label class="col-sm-2 control-label"
                                           for="tinkoff_taxation"><?php echo $taxation_label; ?></label>
                                    <div class="col-sm-10">
                                        <select name="tinkoff_taxation" class="form-control">
                                            <?php foreach ($tinkoff_taxations as $code=>$taxation) { ?>
                                            <option value="<?php echo $code?>"
                                            <?php if ($tinkoff_taxation == $code) { ?>selected="selected"<?php } ?>
                                            > <?php echo $taxation?> </option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group table-line" id="tinkoffTaxation">
                                <div class="table-line " id="tinkoffTaxation">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_email_company"><?php echo $tinkoff_email_company_label; ?></label>

                                <div class="col-sm-10">
                                    <input type="text" name="tinkoff_email_company"
                                           value="<?php echo $tinkoff_email_company; ?>" class="form-control"/>
                                    <?php if (isset($error['tinkoff_email_company'])) { ?>
                                    <span class="error"><?php echo $error['tinkoff_email_company']; ?></span>
                                    <?php } ?>
                                </div>
                                </div>
                            </div>
                            <div class="form-group table-line" id="tinkoffTaxation">
                                <div class="table-line " id="tinkoffTaxation">
                                    <label class="col-sm-2 control-label"
                                           for="tinkoff_payment_method"><?php echo $payment_method; ?></label>
                                    <div class="col-sm-10">
                                        <select name="tinkoff_payment_method" id="tinkoff_payment_method"
                                                class="form-control">
                                            <?php foreach ($payment_method_list as $key => $code) { ?>
                                            <option value="<?php echo $key?>"
                                            <?php if ($tinkoff_payment_method == $key) { ?>selected="selected"<?php } ?>
                                            > <?php echo $code?> </option><?php } ?>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group table-line" id="tinkoffTaxation">
                                <div class="table-line " id="tinkoffTaxation">
                                    <label class="col-sm-2 control-label"
                                           for="tinkoff_payment_object"><?php echo $payment_object; ?></label>
                                    <div class="col-sm-10">
                                        <select name="tinkoff_payment_object" class="form-control">
                                            <?php foreach ($payment_object_list as $key => $code) { ?>
                                            <option value="<?php echo $key?>"
                                            <?php if ($tinkoff_payment_object == $key) { ?>selected="selected"<?php } ?>
                                            > <?php echo $code?> </option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="tinkoff_payment_language"><?php echo $payment_language_label; ?></label>
                                <div class="col-sm-10">
                                    <select name="tinkoff_payment_language" class="form-control">
                                        <?php foreach ($tinkoff_languages as $code=>$language) { ?>
                                        <option value="<?php echo $code?>"
                                        <?php if ($tinkoff_payment_language == $code) { ?>selected="selected"<?php } ?>
                                        > <?php echo $language?> </option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>
<script>
    function showTinkoffTaxation(checked) {
        var tinkoffTaxation = document.getElementsByClassName('table-line');
        [].forEach.call(tinkoffTaxation, function (item) {
            if (checked) {
                item.classList.remove('hidden');
            }
            else {
                item.classList.add('hidden');
            }
        })
    }

    window.onload = function() {
        var checked = document.getElementById('checked').checked;
        this.showTinkoffTaxation(checked);
    }
</script>
<style>
    .hidden {
        display: none;
    }

</style>