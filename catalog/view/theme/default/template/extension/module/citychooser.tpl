<div class="pull-left">
  <div class="btn-group">
    <a  data-toggle="modal" data-target="#cityChooser" class="btn btn-link dropdown-toggle">
    <span class="hidden-xs hidden-sm hidden-md"><?php echo $city['city'];?> <i class="fa fa-caret-down"></i></span>
    </a>
  </div>
</div>
<div class="modal" tabindex="-1" role="dialog" id="cityChooser">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Выберите город</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-city">
          <div class="row">
            <?php foreach ($cities as $city) { ?>
            <div class="col-xs-12 col-md-6 col-lg-4 col-xl-3"><a class="city-select" href="javascript:;" name="<?php echo $city['city_id']; ?>"><?php echo $city['city']; ?></a></div>
            <?php } ?>
          </div>
          <br/>
          <div class="form-group">
            <input class="form-control" name="filter_city" value="">
          </div>
          <input type="hidden" name="city_id" value="" />
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
        </form>
      </div>
    </div>
  </div>
</div>
<script>
$(document).ready(function() {
	$('#form-city .city-select').on('click', function(e) {
		e.preventDefault();
		$('#form-city input[name=\'city_id\']').val($(this).attr('name'));
		$('#form-city').submit();
	});

  $('input[name=\'filter_city\']').autocomplete({
    'source': function(request, response) {
      $.ajax({
        url: 'index.php?route=extension/module/citychooser/autocomplete&token=<?php echo $token; ?>&filter_city=' +  encodeURIComponent(request),
        dataType: 'json',
        success: function(json) {
          response($.map(json, function(item) {
            return {
              label: item['city'],
              value: item['city_id']
            }
          }));
        }
      });
    },
    'select': function(item) {
      $('#form-city input[name=\'city_id\']').val(item['value']);
      $('#form-city').submit();
    }
  });
});
</script>