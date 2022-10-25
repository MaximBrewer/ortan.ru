<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <?php if (isset($city_page)) { ?><a class="btn btn-info" href="<?php echo $city_page; ?>" target="_blank" data-toggle="tooltip" title="Смотреть"><i class="fa fa-eye"></i></a><?php } ?>
        <button type="submit" form="form-product" data-toggle="tooltip" title="Сохранить" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="Отменить" class="btn btn-default"><i class="fa fa-reply"></i></a>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> Добавление/редактирование города</h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-product" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab">Общиее</a></li>
            <li><a href="#tab-data" data-toggle="tab">Данные</a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-general">
              <ul class="nav nav-tabs" id="language">
                <?php foreach ($languages as $language) { ?>
                  <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                <?php } ?>
              </ul>
              <div class="tab-content">
                <?php foreach ($languages as $language) { ?>
                  <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-city<?php echo $language['language_id']; ?>">Город</label>
                      <div class="col-sm-10">
                        <input type="text" name="city_description[<?php echo $language['language_id']; ?>][city]" value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['city'] : ''; ?>" placeholder="Город" id="input-city<?php echo $language['language_id']; ?>" class="form-control" />
                        <?php if (isset($error_city[$language['language_id']])) { ?>
                          <div class="text-danger"><?php echo $error_city[$language['language_id']]; ?></div>
                        <?php } ?>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-address_city<?php echo $language['language_id']; ?>">Город</label>
                      <div class="col-sm-10">
                        <input type="text" name="city_description[<?php echo $language['language_id']; ?>][address_city]" value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['address_city'] : ''; ?>" placeholder="Город" id="input-address_city<?php echo $language['language_id']; ?>" class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-address_zip<?php echo $language['language_id']; ?>">Город(е)</label>
                      <div class="col-sm-10">
                        <input type="text" name="city_description[<?php echo $language['language_id']; ?>][address_city2]" value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['address_city2'] : ''; ?>" placeholder="Город" id="input-address_city2<?php echo $language['language_id']; ?>" class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-address_city2<?php echo $language['language_id']; ?>">Индекс</label>
                      <div class="col-sm-10">
                        <input type="text" name="city_description[<?php echo $language['language_id']; ?>][address_zip]" value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['address_zip'] : ''; ?>" placeholder="Город" id="input-address_zip<?php echo $language['language_id']; ?>" class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-full<?php echo $language['language_id']; ?>">Полностью</label>
                      <div class="col-sm-10">
                        <textarea name="city_description[<?php echo $language['language_id']; ?>][full]" placeholder="Полностью" id="input-full<?php echo $language['language_id']; ?>" data-lang="<?php echo $lang; ?>" class="form-control "><?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['full'] : ''; ?></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-address<?php echo $language['language_id']; ?>">Адрес</label>
                      <div class="col-sm-10">
                        <textarea name="city_description[<?php echo $language['language_id']; ?>][address]" placeholder="Адрес" id="input-address<?php echo $language['language_id']; ?>" data-lang="<?php echo $lang; ?>" class="form-control "><?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['address'] : ''; ?></textarea>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-schedule<?php echo $language['language_id']; ?>">Расписание</label>
                      <div class="col-sm-10">
                        <textarea name="city_description[<?php echo $language['language_id']; ?>][schedule]" placeholder="Расписание" id="input-schedule<?php echo $language['language_id']; ?>" data-lang="<?php echo $lang; ?>" class="form-control "><?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['schedule'] : ''; ?></textarea>
                      </div>
                    </div>
                  </div>
                <?php } ?>
              </div>
            </div>
            <div class="tab-pane" id="tab-data">

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-main">В основном списке</label>
                <div class="col-sm-10">
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" name="main" value="1" <?php echo $main ? "checked=\"checked\"" : "" ?> />
                    </label>
                  </div>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-sort">Сортировка</label>
                <div class="col-sm-10">
                  <input type="text" name="sort" value="<?php echo $sort; ?>" placeholder="Сортировка" id="input-sort" class="form-control" />
                  <?php if ($error_sort) { ?>
                    <div class="text-danger"><?php echo $error_sort; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-phone">Телефон</label>
                <div class="col-sm-10">
                  <input type="text" name="phone" value="<?php echo $phone; ?>" placeholder="Телефон" id="input-phone" class="form-control" />
                  <?php if ($error_phone) { ?>
                    <div class="text-danger"><?php echo $error_phone; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-add_phone">Доп. телефон</label>
                <div class="col-sm-10">
                  <input type="text" name="add_phone" value="<?php echo $add_phone; ?>" placeholder="Доп. телефон" id="input-add_phone" class="form-control" />
                  <?php if ($error_add_phone) { ?>
                    <div class="text-danger"><?php echo $error_add_phone; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-email">E-mail</label>
                <div class="col-sm-10">
                  <input type="text" name="email" value="<?php echo $email; ?>" placeholder="E-mail" id="input-email" class="form-control" />
                  <?php if ($error_email) { ?>
                    <div class="text-danger"><?php echo $error_email; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-add_email">Доп. e-mail</label>
                <div class="col-sm-10">
                  <input type="text" name="add_email" value="<?php echo $add_email; ?>" placeholder="Доп. e-mail" id="input-add_email" class="form-control" />
                  <?php if ($error_add_email) { ?>
                    <div class="text-danger"><?php echo $error_add_email; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-whatsapp">WhatsApp</label>
                <div class="col-sm-10">
                  <input type="text" name="whatsapp" value="<?php echo $whatsapp; ?>" placeholder="WhatsApp" id="input-whatsapp" class="form-control" />
                  <?php if ($error_whatsapp) { ?>
                    <div class="text-danger"><?php echo $error_whatsapp; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-telegram">Telegram</label>
                <div class="col-sm-10">
                  <input type="text" name="telegram" value="<?php echo $telegram; ?>" placeholder="Telegram" id="input-telegram" class="form-control" />
                  <?php if ($error_telegram) { ?>
                    <div class="text-danger"><?php echo $error_telegram; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-viber">Viber</label>
                <div class="col-sm-10">
                  <input type="text" name="viber" value="<?php echo $viber; ?>" placeholder="Viber" id="input-viber" class="form-control" />
                  <?php if ($error_viber) { ?>
                    <div class="text-danger"><?php echo $error_viber; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-geo_lat">Широта</label>
                <div class="col-sm-10">
                  <input type="text" name="geo_lat" value="<?php echo $geo_lat; ?>" placeholder="Широта" id="input-geo_lat" class="form-control" />
                  <?php if ($error_geo_lat) { ?>
                    <div class="text-danger"><?php echo $error_geo_lat; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-geo_lon">Долгота</label>
                <div class="col-sm-10">
                  <input type="text" name="geo_lon" value="<?php echo $geo_lon; ?>" placeholder="Долгота" id="input-geo_lon" class="form-control" />
                  <?php if ($error_geo_lon) { ?>
                    <div class="text-danger"><?php echo $error_geo_lon; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-show_map">Показывать карту</label>
                <div class="col-sm-10">
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" name="show_map" value="1" <?php echo $show_map ? "checked=\"checked\"" : "" ?> />
                    </label>
                  </div>
                </div>
              </div>

            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    <!--
    $('#language a:first').tab('show');
    $('#option a:first').tab('show');
    //
    -->
  </script>
</div>
<?php echo $footer; ?>