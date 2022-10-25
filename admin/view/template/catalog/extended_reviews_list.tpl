<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <?php if (isset($add)) { ?>
      <div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>"
          class="btn btn-primary"><i class="fa fa-plus"></i></a></div>
      <?php } ?>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <div class="well">
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="control-label" for="input-product"><?php echo $entry_product; ?></label>
                <input type="text" name="filter_product" value="<?php echo $filter_product; ?>" placeholder="<?php echo $entry_product; ?>"
                  id="input-product" class="form-control" />
              </div>
              <div class="form-group">
                <label class="control-label" for="input-author"><?php echo $entry_author; ?></label>
                <input type="text" name="filter_author" value="<?php echo $filter_author; ?>" placeholder="<?php echo $entry_author; ?>"
                  id="input-author" class="form-control" />
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="control-label" for="input-status"><?php echo $entry_status; ?></label>
                <select name="filter_status" id="input-status" class="form-control">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!$filter_status ) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
              <div class="form-group">
                <label class="control-label" for="input-date-added"><?php echo $entry_date_added; ?></label>
                <div class="input-group date">
                  <input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>"
                    placeholder="<?php echo $entry_date_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added"
                    class="form-control" />
                  <span class="input-group-btn">
                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-filter"></i>
                <?php echo $button_filter; ?></button>
            </div>
          </div>
        </div>
        <form action="" method="post" enctype="multipart/form-data" id="form-review">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td class="text-left"><?php if ($sort == 'pd.name') { ?>
                    <a href="<?php echo $sort_product; ?>" class="<?php echo mb_strtolower($order); ?>"><?php echo $column_product; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_product; ?>"><?php echo $column_product; ?></a>
                    <?php } ?>
</td>
                  <td class="text-left"><?php if ($sort == 'r.author') { ?>
                    <a href="<?php echo $sort_author; ?>" class="<?php echo mb_strtolower($order); ?>"><?php echo $column_author; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_author; ?>"><?php echo $column_author; ?></a>
                    <?php } ?>
</td>
                  <td class="text-right"><?php if ($sort == 'r.rating') { ?>
                    <a href="<?php echo $sort_rating; ?>" class="<?php echo mb_strtolower($order); ?>"><?php echo $column_rating; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_rating; ?>"><?php echo $column_rating; ?></a>
                    <?php } ?>
</td>
                  <td class="text-left"><?php if ($sort == 'r.status') { ?>
                    <a href="<?php echo $sort_status; ?>" class="<?php echo mb_strtolower($order); ?>"><?php echo $column_status; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                    <?php } ?>
</td>
                  <td class="text-center"><?php echo $column_type; ?></td>
                  <td class="text-left"><?php if ($sort == 'r.date_added') { ?>
                    <a href="<?php echo $sort_date_added; ?>" class="<?php echo mb_strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                    <?php } ?>
</td>
                  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($reviews) { ?>
                <?php foreach($reviews as $_key => $review) { ?> 
                <tr class="<?php echo (($review['status']) ? ('enabled') : ('disabled')); ?>">
                  <td class="text-left"><?php echo $review['name']; ?></td>
                  <td class="text-left"><?php echo $review['author']; ?></td>
                  <td class="text-right"><?php echo $review['rating']; ?></td>
                  <td class="text-left"><?php echo $review['status_text']; ?></td>
                  <td class="text-center">
                    <?php if ($review['childrens']) { ?>
                    <?php echo $review['type']; ?><span class="hide-answer" data-value="<?php echo $review['review_id']; ?>"><i
                        class="fa fa-angle-down"></i></span>
                    <?php } else { ?>
                    <?php echo $review['type']; ?>
                    <?php } ?>
                  </td>
                  <td class="text-left"><?php echo $review['date_added']; ?></td>
                  <td class="text-right"><a href="<?php echo $review['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>"
                      class="btn btn-primary"><i class="fa fa-pencil"></i></a>
                    <a href="<?php echo $review['delete']; ?>" data-toggle="tooltip" title="<?php echo $text_delete; ?>"
                      class="btn btn-danger"><i class="fa fa-trash-o"></i></a></td>
                </tr>
              <tbody id="review-answers-<?php echo $review['review_id']; ?>">
                <?php foreach($review['childrens'] as $_key => $children) { ?> 
                <tr class='review-answer <?php echo (($children['status']) ? ('enabled') : ('disabled')); ?>'>
                  <td class="text-left"></td>
                  <td class="text-left"><?php echo $children['author']; ?></td>
                  <td class="text-right"></td>
                  <td class="text-left"><?php echo $children['status_text']; ?></td>
                  <td class="text-center"><?php echo $children['type']; ?></td>
                  <td class="text-left"><?php echo $children['date_added']; ?></td>
                  <td class="text-right"><a href="<?php echo $children['edit']; ?>" data-toggle="tooltip"
                      title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
                    <a href="<?php echo $children['delete']; ?>" data-toggle="tooltip" title="<?php echo $text_delete; ?>"
                      class="btn btn-danger"><i class="fa fa-trash-o"></i></a></td>
                </tr>
                <?php } ?>
              </tbody>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="text-center" colspan="7"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    <!--
    $('#button-filter').on('click', function () {
      url = '<?php echo $url; ?>';

      var filter_product = $('input[name=\'filter_product\']').val();

      if (filter_product) {
        url += '&filter_product=' + encodeURIComponent(filter_product);
      }

      var filter_author = $('input[name=\'filter_author\']').val();

      if (filter_author) {
        url += '&filter_author=' + encodeURIComponent(filter_author);
      }

      var filter_status = $('select[name=\'filter_status\']').val();

      if (filter_status != '*') {
        url += '&filter_status=' + encodeURIComponent(filter_status);
      }

      var filter_date_added = $('input[name=\'filter_date_added\']').val();

      if (filter_date_added) {
        url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
      }

      location = url;
    });

    $('.hide-answer').on('click', function () {
      var val = $(this).data('value');
      $('#review-answers-' + val).toggle(100);
      $(this).toggleClass('rotated');
    });
    //
    -->
  </script>
  <script type="text/javascript">
    <!--
    $('.date').datetimepicker({
      pickTime: false
    });
    //
    -->
  </script>
</div>
<?php echo $footer; ?>