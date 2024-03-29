<div class="prmn-cmngr-settings__block">
  <form action="<?= $action_general; ?>" class="main-form for-general-form" data-submit="saveGeneral">
    <div class="form-group form-inline">
      <label><?= $entry_status; ?></label>
      <select name="status" class="form-control">
        <option value="1"<?= $status ? ' selected="selected"' : '' ?>><?= $text_enabled; ?></option>
        <option value="0"<?= !$status ? ' selected="selected"' : '' ?>><?= $text_disabled; ?></option>
      </select>
    </div>
    <div class="form-group">
      <label class="control-label">
        <input name="setting[use_geoip]" value="1" type="checkbox"<?= !empty($settings['use_geoip']) ? ' checked="checked"' : ''; ?>>
        <?= $entry_use_geoip; ?>
      </label>
    </div>
    <div class="form-group">
      <label class="control-label">
        <input name="setting[use_ajax]" value="1" type="checkbox"<?= !empty($settings['use_ajax']) ? ' checked="checked"' : ''; ?>>
        <?= $entry_use_ajax; ?>
      </label>
    </div>
    <div class="form-group form-inline">
      <label class="control-label"><?= $entry_default_city; ?></label>
      <div class="input-group" style="margin-right: 10px;">
        <input id="field-default-city-name" type="text" name="" class="row-fias-name form-control"
             value="<?= !empty($settings['default_city_name']) ? $settings['default_city_name'] : '' ?>"/>
        <i class="fa fa-remove clear-input-btn" onclick="$('#field-default-city-name, #field-default-city').val('');" title="<?= $button_clear; ?>"></i>
        <input id="field-default-city" type="hidden" name="setting[default_city]"
             value="<?= !empty($settings['default_city']) ? $settings['default_city'] : '' ?>" class="row-fias-id"/>
      </div>

      <label class="control-label"><?= $entry_use_default_city ?></label>
      <select name="setting[use_default_city]" class="form-control">
        <?php foreach ($use_default_city_values as $key => $value) { ?>
          <option value="<?= $key; ?>"<?= $use_default_city === $key ? ' selected' : ''; ?>><?= $value; ?></option>
        <?php } ?>
      </select>
    </div>
    <div class="form-group">
      <label class="control-label">
        <input name="setting[use_fullname_city]" value="1" type="checkbox"<?= !empty($settings['use_fullname_city']) ? ' checked="checked"' : ''; ?>>
        <?= $entry_use_fullname_city; ?>
      </label>
    </div>
    <div class="form-group">
      <label class="control-label">
        <input name="setting[replace_blanks]" value="1" type="checkbox"<?= !empty($settings['replace_blanks']) ? ' checked="checked"' : ''; ?>>
        <?= $entry_replace_blanks; ?>
      </label>
    </div>
    <div class="form-group">
      <label class="control-label">
        <input name="setting[not_fill_fields]" value="1" type="checkbox"<?= !empty($settings['not_fill_fields']) ? ' checked="checked"' : ''; ?>>
        <?= $entry_not_fill_fields; ?>
      </label>
    </div>
    <div class="form-group">
      <label class="control-label">
        <input name="setting[integration_simple]" value="1" type="checkbox"<?= !empty($settings['integration_simple']) ? ' checked="checked"' : ''; ?>>
        <?= $entry_integration_simple; ?>
      </label>
    </div>
    <div class="form-group">
      <label class="control-label">
        <input name="setting[replace_input_city]" value="1" type="checkbox"<?= !empty($settings['replace_input_city']) ? ' checked="checked"' : ''; ?>>
        <?= $entry_replace_input_city; ?>
      </label>
    </div>
  </form>
</div>
<div id="container-bases"></div>

<div class="modal" tabindex="-1" role="dialog" id="prmn-alert">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4><?= $heading_title ?></h4>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><?= $button_close ?></button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  function prmnStep(action, step) {
      $.ajax({
          url: '<?= $url_base_action ?>',
          type: 'get',
          dataType: 'json',
          data: {action: action, step: step},
          success: function(json) {
              if (json.success) {
                  if (json['next_step']) {
                      if (json['btn_text']) {
                          prmnAlert(json['btn_text'] + '...');
                      }

                      if (json['iteration'] !== undefined) {
                          if (action.indexOf('iteration=') > 0) {
                              action = action.replace(/iteration=\d+/, 'iteration=' + json['iteration']);
                          } else {
                              action += ',iteration=' + json['iteration'];
                          }
                      }

                      prmnStep(action, json['next_step']);
                  } else {
                      prmnAlert('<p class="text-success">' + json.text + '</p>');
                      $('#container-bases').load('<?= $url_bases ?>');
                  }
              } else {
                  prmnAlert('<p class="text-danger">' + json.error + '</p>');
              }
          },
          error: function(xhr, ajaxOptions, thrownError) {
              prmnAlert(thrownError + "<br>" + xhr.statusText + "<br>" + xhr.responseText);
          }
      });
  }

  function saveGeneral(callback) {
      var form = $('#tab-general').find('form');
      var data = '';
      $('.for-general-form :input').each(function() {
          var el = $(this);
          if (el.attr('name')) {
              var value = el.is(':checkbox') ? (el.is(':checked') ? 1 : 0) : el.val();
              data += encodeURIComponent(el.attr('name')) + '=' + value + '&';
          }
      });

      $.post(form.attr('action'), data,
          function(json) {
              if (json.warning) {
                  $('#warning').removeClass('hidden').find('span').text(json.warning);
                  $('#tabs').find('a[href="#tab-general"]').tab('show');
              }

              if (json.license) {
                  $('#alert-license').addClass('hidden');
              } else {
                  $('#alert-license').removeClass('hidden');
              }

              if (callback) {
                  callback.call(this, !json.warning);
              }
          }, 'json');
  }

    $('#container-bases')
        .load('<?= $url_bases ?>')
        .on('click', '.base-action', function() {
            var btn = $(this);
            btn.attr('disabled', 'disabled');
            prmnAlert(btn.data('text'));
            prmnStep(btn.data('action'), btn.data('step'));
        });
</script>