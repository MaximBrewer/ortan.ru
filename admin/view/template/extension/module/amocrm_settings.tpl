<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-module" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) : ?>
          <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php endforeach; ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) : ?>
      <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
    <?php endif; ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">

        <ul class="nav nav-tabs">
          <li class="active"><a href="#tab-conecting" data-toggle="tab">Подключение</a></li>
          <li><a href="#tab-leads" data-toggle="tab"><?php echo $entry_amo_leads; ?></a></li>
          <li><a href="#tab-task" data-toggle="tab"><?php echo $entry_amo_task; ?></a></li>
          <li><a href="#tab-setting" data-toggle="tab"><?php echo $entry_amo_setting; ?></a></li>
          <li><a href="#tab-setting-other" data-toggle="tab"><?php echo $entry_amo_setting_other; ?></a></li>
        </ul>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-module" class="form-horizontal">
          <div class="tab-content">
            <div class="tab-pane active" id="tab-conecting">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                <div class="col-sm-10">
                  <script class="amocrm_oauth" data-client-id='5c0c2976-1d1d-445a-9baf-712c04e1ec39' charset="utf-8" data-name="Opencart amocrm" data-description="Интеграция АмоCRM opencart 3.x" data-redirect_uri="<?php echo $redirect_url; ?>" data-secrets_uri="<?php echo $secrets_url; ?>" data-scopes="crm,notifications" data-title="<?php echo $entry_name; ?>" data-compact="false" data-class-name="className" data-color="default" data-state="state" data-error-callback="functionName" data-mode="popup" src="https://www.amocrm.ru/auth/button.min.js"></script>
                  <input type="hidden" name="name" value="amocrm">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_referer; ?></label>
                <div class="col-sm-10">
                  <input type="text" disabled name="referer" value="<?php echo $referer; ?>" placeholder="<?php echo $entry_referer; ?>" id="input-name" class="form-control" />
                  <input type="hidden" name="secret_key" value="DE6lN0PFLzOWA1Mb0qjlJgBjFnFoXmzju7qy08hpitPFPQ4do7EoCFO22O1iPi3Z"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="status" disabled id="input-status" class="form-control">
                    <?php if ($status) : ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php else : ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php endif; ?>
                  </select>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-leads">
              <fieldset>
                <legend><?php echo $entry_amo_leads; ?></legend>
                <table id="leads" class="table table-striped table-bordered table-hover">
                  <thead>
                    <tr>
                      <td class="text-left"><?php echo $entry_shop_columns; ?></td>
                      <td class="text-left"><?php echo $entry_amo_columns; ?></td>
                      <td></td>
                    </tr>
                  </thead>
                  <tbody>
                    <?php $nc = 0; ?>
                    <?php foreach ($leads as $lead) : ?>
                      <tr id="leads-row<?php echo $inc; ?>">
                        <td class="text-left" style="width: 20%;">
                          <select name="leads[<?php echo $inc; ?>][shop_columns]" class="form-control">
                            <optgroup label="Заказ">
                              <?php foreach ($leads_rows_shops as $lead_row_shop) : ?>
                                <option value="<?php echo $lead_row_shop; ?>" <?php if ($lead['shop_columns'] == $lead_row_shop) : ?> selected <?php endif; ?>><?php echo $lead_row_shop; ?></option>
                              <?php endforeach; ?>
                            </optgroup>';
                          </select>
                        </td>
                        <td class="text-left">
                          <select name="leads[<?php echo $inc; ?>][amo_columns]" class="form-control">
                            <optgroup label="Поля AmoCRM">
                              <?php foreach ($amo_fileds as $amo_filed) : ?>
                                <option value="<?php echo $amo_filed['id']; ?>" <?php if ($lead['amo_columns'] == $amo_filed['id']) : ?> selected <?php endif; ?>><?php echo $amo_filed['name']; ?></option>
                              <?php endforeach; ?>
                            </optgroup>';
                          </select>


                        </td>

                        <td class="text-right"><button type="button" onclick="$('#leads-row<?php echo $inc; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>

                      </tr>
                      <?php ++$inc; ?>
                    <?php endforeach; ?>
                  </tbody>

                  <tfoot>
                    <tr>
                      <td colspan="2"></td>
                      <td class="text-right"><button type="button" onclick="addLeads();" data-toggle="tooltip" title="<?php echo $button_attribute_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                    </tr>
                  </tfoot>
                </table>
              </fieldset>
              <fieldset>
                <legend><?php echo $entry_amo_contacts; ?></legend>


                <table id="contacts" class="table table-striped table-bordered table-hover">
                  <thead>
                    <tr>
                      <td class="text-left"><?php echo $entry_shop_columns; ?></td>
                      <td class="text-left"><?php echo $entry_amo_columns; ?></td>
                      <td></td>
                    </tr>
                  </thead>
                  <tbody>
                    <?php $nc = 0; ?>
                    <?php foreach ($contacts as $contact) : ?>

                      <tr id="contacts-row<?php echo $inc; ?>">
                        <td class="text-left" style="width: 20%;">
                          <select name="contacts[<?php echo $inc; ?>][shop_columns]" class="form-control">
                            <optgroup label="Заказ">
                              <?php foreach ($leads_rows_shops as $lead_row_shop) : ?>
                                <option value="<?php echo $lead_row_shop; ?>" <?php if ($contact['shop_columns'] == $lead_row_shop) : ?> selected <?php endif; ?>><?php echo $lead_row_shop; ?></option>
                              <?php endforeach; ?>
                            </optgroup>';
                          </select>
                        </td>
                        <td class="text-left">
                          <?php /* <input type="text" class="form-control" name="contacts[<?php echo $inc;?>][amo_columns]" placeholder="<?php echo $entry_amo_columns;?>" value="<?php echo $contact['amo_columns']; ?>" /> */ ?>

                          <select name="contacts[<?php echo $inc; ?>][amo_columns]" class="form-control">
                            <optgroup label="Поля AmoCRM">
                              <?php foreach ($amo_fileds_contacts as $amo_filed) : ?>
                                <option value="<?php echo $amo_filed['id']; ?>" <?php if ($contact['amo_columns'] == $amo_filed['id']) : ?> selected <?php endif; ?>><?php echo $amo_filed['name']; ?></option>
                              <?php endforeach; ?>
                            </optgroup>';
                          </select>


                        </td>
                        </td>

                        <td class="text-right"><button type="button" onclick="$('#contacts-row<?php echo $inc; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>

                      </tr>
                      <?php ++$inc; ?>
                    <?php endforeach; ?>
                  </tbody>

                  <tfoot>
                    <tr>
                      <td colspan="2"></td>
                      <td class="text-right"><button type="button" onclick="addContacts();" data-toggle="tooltip" title="<?php echo $button_attribute_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                    </tr>
                  </tfoot>
                </table>
              </fieldset>
            </div>
            <div class="tab-pane" id="tab-task">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_amo_task_create; ?></label>
                <div class="col-sm-10">
                  <select class="form-control" name="task[status]">
                    <option <?php if ($task['status'] == 1) : ?> selected <?php endif; ?> value="1"><?php echo $entry_amo_task_on; ?></option>
                    <option <?php if ($task['status'] == 0) : ?> selected <?php endif; ?> value="0"><?php echo $entry_amo_task_off; ?></option>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_amo_task_user_id; ?></label>
                <div class="col-sm-10">

                  <select name="task[responsible_user_id]" class="form-control">
                    <optgroup label="Пользователи">
                      <option <?php if ($task['responsible_user_id'] == "") : ?> selected <?php endif; ?> value="">По умолчанию</option>
                    </optgroup>
                    <optgroup label="Пользователи">
                      <?php foreach ($amo_users as $amo_user) : ?>
                        <option value="<?php echo $amo_user['id']; ?>" <?php if ($amo_user['id'] == $task['responsible_user_id']) : ?> selected <?php endif; ?>><?php echo $amo_user['name']; ?></option>
                      <?php endforeach; ?>
                    </optgroup>';
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_amo_task_time; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="task[time]" value="<?php echo $task['time']; ?>" placeholder="<?php echo $entry_amo_task_time; ?>" id="input-name" class="form-control" />
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_amo_task_text; ?></label>
                <div class="col-sm-10">
                  <textarea name="task[text]" class="form-control"><?php echo $task['text']; ?></textarea>
                </div>
              </div>




            </div>

            <div class="tab-pane" id="tab-setting">

              <table id="setting" class="table table-striped table-bordered table-hover">
                <thead>
                  <tr>
                    <td class="text-left">Статус заказа</td>
                    <td class="text-left"><?php echo $entry_amo_columns; ?></td>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($order_status as $order_statuse) : ?>
                    <tr>
                      <td class="text-left"><?php echo $order_statuse['name']; ?></td>
                      <td class="text-left">
                        <select name="order_status[<?php echo $order_statuse['order_status_id']; ?>]" class="form-control">
                          <optgroup label="По умолчанию">
                            <option value="">Не выбрано</option>
                          </optgroup>
                          <?php foreach ($amo_fileds_selects as $amo_fileds_select) : ?>
                            <optgroup label="<?php echo $amo_fileds_select['name']; ?>">
                              <?php foreach ($amo_fileds_select['values'] as $value) : ?>
                                <option <?php if ($value['selected'] == attribute(order_shop_status, order_statuse . order_status_id)) : ?> selected <?php endif; ?> value="<?php echo $amo_fileds_select['id']; ?>|<?php echo $value['id']; ?>"><?php echo $value['value'] ?></option>
                              <?php endforeach; ?>
                            </optgroup>
                          <?php endforeach; ?>
                        </select>
                      </td>
                    </tr>
                  <?php endforeach; ?>
                </tbody>
              </table>
            </div>
            <div class="tab-pane" id="tab-setting-other">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_amo_other_options; ?></label>
                <div class="col-sm-10">
                  <select class="form-control" name="other[status]">
                    <option <?php if ($other['status'] == 1) : ?> selected <?php endif; ?> value="1"><?php echo $entry_amo_task_on; ?></option>
                    <option <?php if ($other['status'] == 0) : ?> selected <?php endif; ?> value="0"><?php echo $entry_amo_task_off; ?></option>
                  </select>
                </div>
              </div>
            </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  var leads_row = <?php echo $leads_count; ?>;

  function addLeads() {
    html = '<tr id="leads-row' + leads_row + '">';
    html += '<td class="text-left" style="width: 20%;"> <select name="leads[' + leads_row + '][shop_columns]" class="form-control">';
    html += '<optgroup label="Заказ">';
    <?php foreach ($leads_rows_shops as $lead_row_shop) : ?>
      html += '<option value="<?php echo $lead_row_shop; ?>"><?php echo $lead_row_shop; ?></option>';
    <?php endforeach; ?>
    html += '</optgroup>';
    html += '</select></td>';
    html += '  <td class="text-left">';

    html += '<select name="leads[' + leads_row + '][amo_columns]" class="form-control">';
    html += '<optgroup label="Поля AmoCRM">';
    <?php foreach ($amo_fileds as $amo_filed) : ?>
      html += '<option value="<?php echo $amo_filed['id']; ?>"><?php echo $amo_filed['name']; ?></option>';
    <?php endforeach; ?>
    html += '</optgroup>';
    html += '</select></td>';


    // html += '     <input type="text" class="form-control" name="leads[' + leads_row + '][amo_columns]" placeholder="<?php echo $entry_amo_columns; ?>" value="" />';
    html += '  </td>';
    html += '  <td class="text-right"><button type="button" onclick="$(\'#leads-row' + leads_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
    html += '</tr>';

    $('#leads tbody').append(html);
    leads_row++;
  }



  var contacts_row = <?php echo $contacts_count; ?>;

  function addContacts() {
    html = '<tr id="leads-row' + contacts_row + '">';
    html += '<td class="text-left" style="width: 20%;"> <select name="contacts[' + contacts_row + '][shop_columns]" class="form-control">';
    html += '<optgroup label="Заказ">';
    <?php foreach ($leads_rows_shops as $lead_row_shop) : ?>
      html += '<option value="<?php echo $lead_row_shop; ?>"><?php echo $lead_row_shop; ?></option>';
    <?php endforeach; ?>
    html += '</optgroup>';
    html += '</select></td>';
    html += '  <td class="text-left">';

    html += '<select name="contacts[' + contacts_row + '][amo_columns]" class="form-control">';
    html += '<optgroup label="Поля AmoCRM">';
    <?php foreach ($amo_fileds_contacts as $amo_filed) : ?>
      html += '<option value="<?php echo $amo_filed['id']; ?>"><?php echo $amo_filed['name']; ?></option>';
    <?php endforeach; ?>
    html += '</optgroup>';
    html += '</select></td>';

    // html += '     <input type="text" class="form-control" name="contacts[' + contacts_row + '][amo_columns]" placeholder="<?php echo $entry_amo_columns; ?>" value="" />';
    html += '  </td>';
    html += '  <td class="text-right"><button type="button" onclick="$(\'#contacts-row' + contacts_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
    html += '</tr>';

    $('#contacts tbody').append(html);
    contacts_row++;
  }
</script>
<?php echo $footer; ?>