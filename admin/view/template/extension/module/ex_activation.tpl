<?php echo ($header . $column_left); ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i
            class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
    </div>
  </div>
  <div class="container-fluid">

    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="extended_reviews_key"
      class="form-horizontal">
      <?php if ($error_license) { ?>
      <div class="alert"><i class="fa fa-exclamation-circle"></i> <?php echo $error_license; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <div class="col-md-offset-3 col-md-5 col-sm-12">
        <label for="input-text-plus"><?php echo $text_entry_key; ?></label>
        <div class="input-group">
          <input type="text" name="ex_reviews_key" value="" placeholder="<?php echo $text_entry_key; ?>" id="key"
            class="form-control">
          <span class="input-group-btn"> <button id="save-settings" type="submit" form="extended_reviews_key"
              data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i
                class="fa fa-save"></i><?php echo $text_license_key_save; ?></button></span>
        </div>
      </div>
    </form>

  </div>
</div>
<?php echo $footer; ?>