<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                <button type="button" data-toggle="tooltip" title="<?php echo $button_copy; ?>" class="btn btn-default" onclick="$('#form-city').attr('action', '<?php echo $copy; ?>').submit()"><i class="fa fa-copy"></i></button>
                <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-city').submit() : false;"><i class="fa fa-trash-o"></i></button>
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
                <h3 class="panel-title"><i class="fa fa-list"></i> Города</h3>
            </div>
            <div class="panel-body">
                <div class="well">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label" for="input-name">Город</label>
                                <input type="text" name="filter_city" value="<?php echo $filter_city; ?>" placeholder="Город" id="input-name" class="form-control" />
                            </div>
                            <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-filter"></i> поиск</button>
                        </div>
                    </div>
                </div>
                <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-city">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                            <tr>
                                <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                                <td>Город</td>
                                <td>Полностью</td>
                                <td></td>
                            </tr>
                            </thead>
                            <tbody>
                            <?php if ($cities) { ?>
                                <?php foreach ($cities as $city) { ?>
                                    <tr>
                                        <td class="text-center"><?php if (in_array($city['city_id'], $selected)) { ?>
                                                <input type="checkbox" name="selected[]" value="<?php echo $city['city_id']; ?>" checked="checked" />
                                            <?php } else { ?>
                                                <input type="checkbox" name="selected[]" value="<?php echo $city['city_id']; ?>" />
                                            <?php } ?></td>
                                        <td class="text-left"><?php echo $city['city']; ?></td>
                                        <td class="text-left"><?php echo $city['full']; ?></td>
                                        <td class="text-right"><a href="<?php echo $city['edit']; ?>" data-toggle="tooltip" title="Редакировать" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                                    </tr>
                                <?php } ?>
                            <?php } else { ?>
                                <tr>
                                    <td class="text-center" colspan="all">Нет результатов</td>
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
        $('#button-filter').on('click', function() {
            var url = 'index.php?route=extension/module/citychooser&token=<?php echo $token; ?>';

            var filter_city = $('input[name=\'filter_city\']').val();

            if (filter_city) {
                url += '&filter_city=' + encodeURIComponent(filter_city);
            }
            location = url;
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
                $('input[name=\'filter_city\']').val(item['label']);
            }
        });
    </script>
</div>
<?php echo $footer; ?>
