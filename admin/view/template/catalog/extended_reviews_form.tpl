<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-review" data-toggle="tooltip" title="<?php echo $button_save; ?>"
          class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i
            class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach($breadcrumbs as $_key => $breadcrumb) { ?> 
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-review"
          class="form-horizontal">
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-author"><?php echo $entry_author; ?></label>
            <div class="col-sm-10">
              <input type="text" name="author" value="<?php echo $author; ?>" placeholder="<?php echo $entry_author; ?>" id="input-author"
                class="form-control" />
              <?php if ($error_author) { ?>
              <div class="text-danger"><?php echo $error_author; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Email</label>
            <div class="col-sm-10">
              <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $text_customer_email; ?>"
                class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $text_customer_alert; ?></label>
            <div class="col-sm-10">
              <label class="fresh-check">
                <input type="checkbox" name="alert" value="1" <?php echo (($alert) ? ('checked="checked"') : ('')); ?> /><span></span>
              </label>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-product"><span data-toggle="tooltip"
                title="<?php echo $help_product; ?>"><?php echo $entry_product; ?></span></label>
            <div class="col-sm-10">
              <input type="text" name="product" value="<?php echo $product; ?>" placeholder="<?php echo $entry_product; ?>"
                id="input-product" class="form-control" />
              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
              <?php if ($error_product) { ?>
              <div class="text-danger"><?php echo $error_product; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $text_purchased; ?></label>
            <div class="col-sm-10">
              <label class="fresh-check">
                <input type="checkbox" name="purchased" value="1" <?php echo (($purchased) ? ('checked="checked"') : ('')); ?> /><span></span>
              </label>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-text"><?php echo $entry_text; ?></label>
            <div class="col-sm-10">
              <textarea name="text" cols="60" rows="8" placeholder="<?php echo $entry_text; ?>" id="input-text"
                class="form-control"><?php echo $text; ?></textarea>
              <?php if ($error_text) { ?>
              <div class="text-danger"><?php echo $error_text; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_rating; ?></label>
            <div class="col-sm-10">
              <label class="radio-inline">
                <?php if ($rating == 1) { ?>
                <input type="radio" name="rating" value="1" checked="checked" />
                1
                <?php } else { ?>
                <input type="radio" name="rating" value="1" />
                1
                <?php } ?>
              </label>
              <label class="radio-inline">
                <?php if ($rating == 2) { ?>
                <input type="radio" name="rating" value="2" checked="checked" />
                2
                <?php } else { ?>
                <input type="radio" name="rating" value="2" />
                2
                <?php } ?>
              </label>
              <label class="radio-inline">
                <?php if ($rating == 3) { ?>
                <input type="radio" name="rating" value="3" checked="checked" />
                3
                <?php } else { ?>
                <input type="radio" name="rating" value="3" />
                3
                <?php } ?>
              </label>
              <label class="radio-inline">
                <?php if ($rating == 4) { ?>
                <input type="radio" name="rating" value="4" checked="checked" />
                4
                <?php } else { ?>
                <input type="radio" name="rating" value="4" />
                4
                <?php } ?>
              </label>
              <label class="radio-inline">
                <?php if ($rating == 5) { ?>
                <input type="radio" name="rating" value="5" checked="checked" />
                5
                <?php } else { ?>
                <input type="radio" name="rating" value="5" />
                5
                <?php } ?>
              </label>
              <?php if ($error_rating) { ?>
              <div class="text-danger"><?php echo $error_rating; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-text-plus"><?php echo $text_plus; ?></label>
            <div class="col-sm-10">
              <input type="text" name="plus" value="<?php echo $plus; ?>" placeholder="<?php echo $text_plus; ?>" id="input-text-plus"
                class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-text-minus"><?php echo $text_minus; ?></label>
            <div class="col-sm-10">
              <input type="text" name="minus" value="<?php echo $minus; ?>" placeholder="<?php echo $text_minus; ?>" id="input-text-minus"
                class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-rating-plus"><?php echo $text_likes; ?></label>
            <div class="col-sm-2">
              <input type="text" name="likes" value="<?php echo $likes; ?>" id="input-rating-plus" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-rating-minus"><?php echo $text_dislikes; ?></label>
            <div class="col-sm-2">
              <input type="text" name="dislikes" value="<?php echo $dislikes; ?>" id="input-rating-minus" class="form-control" />
            </div>
          </div>
          <div class="form-group review-media">
            <label class="col-sm-2 control-label" for="review-images-thumbnails"><?php echo $text_images; ?></label>
            <div class="col-sm-10">
              <ul class="thumbnails reviews-thumbnails" id="review-images-thumbnails">
                <?php $image_row = 0; ?>
                <?php if(!empty($review_images)) { ?>
                <?php foreach($review_images as $_key => $image) { ?> 
                <li class="image-additional" id="image-row<?php echo $image_row; ?>"><a href="" id="thumb-image<?php echo $image_row; ?>"
                    data-toggle="image" class="img-thumbnail">
                    <img src="<?php echo $image['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="review_image[<?php echo $image_row; ?>][image]" value="<?php echo $image['image']; ?>"
                    id="input-image<?php echo $image_row; ?>">
                  <input type="hidden" name="review_image[<?php echo $image_row; ?>][thumb]" value="<?php echo $image['thumb']; ?>"
                    id="input-thumb<?php echo $image_row; ?>">
                  <button type="button" onclick="$('#image-row<?php echo $image_row; ?>').remove();" data-toggle="tooltip"
                    title="<?php echo $text_delete_image; ?>" class="btn btn-delete"><i
                      class="fa fa-minus-circle"></i><?php echo $text_delete; ?></button></li>
                <?php $image_row = ($image_row + 1); ?>
                <?php } ?>
                <?php } ?>
              </ul>
              <button type="button" onclick="addImage();" data-toggle="tooltip" title="<?php echo $text_images_add; ?>"
                style="margin-left:5px" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-videos"><?php echo $text_videos; ?></label>
            <div class="col-sm-10">
              <input type="text" name="videos" value="<?php echo $videos; ?>" placeholder="<?php echo $text_videos; ?>" id="input-videos"
                class="form-control" />
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="admin-name"><?php echo $text_admin_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="admin_name" value="<?php echo $admin_name; ?>" placeholder="<?php echo $text_admin_name; ?>"
                id="admin-name" class="form-control" />
            </div>
            <label class="col-sm-2 control-label" for="input-admin-reply"><?php echo $text_admin_answer; ?></label>
            <div class="col-sm-10">
              <textarea name="admin_reply" cols="60" rows="8" placeholder="<?php echo $text_admin_answer; ?>"
                id="input-admin-reply" class="form-control"><?php echo $admin_reply; ?></textarea>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $text_review_bonus; ?></label>
            <div class="col-sm-10">
              <label class="fresh-check">
                <input type="checkbox" name="bonus" value="1" <?php echo (($bonus) ? ('checked="checked"') : ('')); ?> /><span></span>
              </label>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-date-added"><?php echo $entry_date_added; ?></label>
            <div class="col-sm-3">
              <div class="input-group datetime">
                <input type="text" name="date_added" value="<?php echo $date_added; ?>" placeholder="<?php echo $entry_date_added; ?>"
                  data-date-format="YYYY-MM-DD HH:mm:ss" id="input-date-added" class="form-control" />
                <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <input type="hidden" name="customer_id" value="<?php echo $customer_id; ?>">
          <input type="hidden" name="images" value="<?php echo $images; ?>">
          <input type="hidden" name="alert_success" value="<?php echo $alert_success; ?>">
          <input type="hidden" name="language_id" value="<?php echo $language_id; ?>">
          <input type="hidden" name="admin_alert_success" value="<?php echo $admin_alert_success; ?>">
        </form>
      </div>
    </div>
  </div>
</div>
  <script>
    var image_row = <?php echo $image_row; ?>;

    function addImage() {
      html = '<li class="image-additional" id="image-row' + image_row + '">';
      html += '  <a href="" id="thumb-image' + image_row +
        '"data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="review_image[' +
        image_row + '][image]" value="" id="input-image' + image_row + '" /><input type="hidden" name="review_image[' +
        image_row + '][thumb]" value="" id="input-thumb' + image_row + '" />';
      html += '  <button type="button" onclick="$(\'#image-row' + image_row +
        '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-delete"><i class="fa fa-minus-circle"></i> <?php echo $text_delete; ?></button>';
      html += '</li>';
      $('.reviews-thumbnails').append(html);
      image_row++;
    }
  </script>
  <script type="text/javascript">
    <!--
    $('.datetime').datetimepicker({
      pickDate: true,
      pickTime: true
    });
    //
    -->
  </script>
  <script type="text/javascript">
    <!--
    $('input[name=\'product\']').autocomplete({
      'source': function (request, response) {
        $.ajax({
          url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +
            encodeURIComponent(request),
          dataType: 'json',
          success: function (json) {
            response($.map(json, function (item) {
              return {
                label: item['name'],
                value: item['product_id']
              }
            }));
          }
        });
      },
      'select': function (item) {
        $('input[name=\'product\']').val(item['label']);
        $('input[name=\'product_id\']').val(item['value']);
      }
    });
    //
    -->
  </script>
<style>
  .reviews-thumbnails .img-thumbnail {
    padding: 0;
    border: 0;
    overflow: hidden;
    border-radius: 4px 4px 0 0
  }
</style>
<?php echo $footer; ?>