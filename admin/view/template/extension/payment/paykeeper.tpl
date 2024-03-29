<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-liqpay" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-liqpay" class="form-horizontal">
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-merchant"><?php echo $entry_paykeeperserver; ?></label>
            <div class="col-sm-10">
              <input type="text" name="paykeeperserver" value="<?php echo $paykeeperserver; ?>" placeholder="<?php echo $entry_paykeeperserver; ?>" id="input-merchant" class="form-control" />
              <?php if ($error_paykeeperserver) { ?>
              <div class="text-danger"><?php echo $error_paykeeperserver; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-signature"><?php echo $entry_paykeepersecret; ?></label>
            <div class="col-sm-10">
              <input type="text" name="paykeepersecret" value="<?php echo $paykeepersecret; ?>" placeholder="<?php echo $entry_paykeepersecret; ?>" id="input-signature" class="form-control" />
              <?php if ($error_paykeepersecret) { ?>
              <div class="text-danger"><?php echo $error_paykeepersecret; ?></div>
              <?php } ?>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
            <div class="col-sm-10">
              <select name="paykeeper_order_status_id" id="input-order-status" class="form-control">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $paykeeper_order_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_force_discounts_check; ?> </label>
            <div class="col-sm-10">
              <select name="paykeeper_force_discounts_check" id="input-status" class="form-control">
                <?php if ($paykeeper_force_discounts_check) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
            <div class="col-sm-10">
            <br><i><?php echo $entry_force_discounts_check_description; ?></i>
            </div>
          </div>
		  <?php /* <div class="form-group">
            <label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
            <div class="col-sm-10">
              <select name="paykeeper_geo_zone_id" id="input-geo-zone" class="form-control">
                <option value="0"><?php echo $text_all_zones; ?></option>
                <?php foreach ($geo_zones as $geo_zone) { ?>
                <?php if ($geo_zone['geo_zone_id'] == $paykeeper_geo_zone_id) { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div> */?>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="paykeeper_status" id="input-status" class="form-control">
                <?php if ($paykeeper_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
		  <?php
              if (isset($_SERVER['HTTPS']) && ($_SERVER['HTTPS'] == 'on' || $_SERVER['HTTPS'] == 1) ||
        isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') 
        {
            $pageURL = 'https://';
        }
        else 
        {
            $pageURL = 'http://';
        }

		  ?>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-callback"><?php echo $entry_callback; ?></label>
            <div class="col-sm-10">
              <input type="text" name="paykeepercallback" value="<?php echo $pageURL.$_SERVER['SERVER_NAME'].'/index.php?route=extension/payment/paykeeper/callback'; ?>" readonly="readonly" class="form-control" id="input-callback" />
            </div>
          </div>
		  
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-success_link"><?php echo $entry_success_link; ?></label>
            <div class="col-sm-10">
              <input type="text" name="paykeepersuccess_link" value="<?php echo $pageURL.$_SERVER['SERVER_NAME'].'/index.php?route=extension/payment/paykeeper/success'; ?>" readonly="readonly" class="form-control" id="input-success_link" />
            </div>
          </div>
		  
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-failed_link"><?php echo $entry_failed_link; ?></label>
            <div class="col-sm-10">
              <input type="text" name="paykeeperfailed_link" value="<?php echo $pageURL.$_SERVER['SERVER_NAME'].'/index.php?route=extension/payment/paykeeper/failed'; ?>" readonly="readonly" class="form-control" id="input-failed_link" />
            </div>
          </div>
		  
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-10">
              <input type="text" name="paykeeper_sort_order" value="<?php echo $paykeeper_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>



