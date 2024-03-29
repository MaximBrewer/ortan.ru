<?= $header; ?><?= $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" data-toggle="tooltip" title="<?= $button_save; ?>" class="btn btn-primary" id="submit-forms">
          <i class="fa fa-save"></i></button>
        <a href="<?= $cancel; ?>" data-toggle="tooltip" title="<?= $button_cancel; ?>" class="btn btn-default">
          <i class="fa fa-reply"></i></a>
      </div>
      <h1><?= $heading_title; ?></h1>
      <ul class="breadcrumb">
          <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li>
              <a href="<?= $breadcrumb['href']; ?>"><?= $breadcrumb['text']; ?></a>
            </li>
          <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="prmn-cmngr-settings">
      <div id="warning" class="alert alert-danger hidden"><i class="fa fa-exclamation-circle"></i>
        <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <div id="success" class="alert alert-success hidden"><i class="fa fa-exclamation-circle"></i>
        <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>

      <ul id="tabs" class="nav nav-tabs">
        <li>
          <a href="#tab-general" data-toggle="tab"><?= $tab_general; ?></a>
        </li>
        <li>
          <a href="#tab-redirects" data-toggle="tab" data-url="<?= $url_redirects ?>"><?= $tab_redirects; ?></a>
        </li>
        <li>
          <a href="#tab-popups" data-toggle="tab" data-url="<?= $url_popups ?>"><?= $tab_popup; ?></a>
        </li>
        <li>
          <a href="#tab-messages" data-toggle="tab" data-url="<?= $url_messages ?>"><?= $tab_messages; ?></a>
        </li>
        <li>
          <a href="#tab-currencies" data-toggle="tab" data-url="<?= $url_currencies ?>"><?= $tab_currencies; ?></a>
        </li>
        <li>
          <a href="#tab-customer-group" data-toggle="tab" data-url="<?= $url_customer_group ?>"><?= $tab_groups; ?></a>
        </li>
        <li>
          <a href="#tab-zone-fias" data-toggle="tab" data-url="<?= $url_zone_fias ?>"><?= $tab_regions; ?></a>
        </li>
        <li>
          <a href="#tab-license" data-toggle="tab" data-url="<?= $url_license ?>">
          <?php if ($valid_license) { ?>
            <?= $tab_license; ?>
          <?php } else { ?>
            <span class="text-danger"><?= $tab_license; ?></span>
          <?php } ?>
          </a>
        </li>
        <li>
          <a href="#tab-support" data-toggle="tab" data-url="<?= $url_support ?>"><?= $tab_support; ?></a>
        </li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane" id="tab-general"><?= $general ?></div>
        <div class="tab-pane" id="tab-redirects"><?= $text_loading ?>...</div>
        <div class="tab-pane" id="tab-popups"><?= $text_loading ?>...</div>
        <div class="tab-pane" id="tab-messages"><?= $text_loading ?>...</div>
        <div class="tab-pane" id="tab-currencies"><?= $text_loading ?>...</div>
        <div class="tab-pane" id="tab-customer-group"><?= $text_loading ?>...</div>
        <div class="tab-pane" id="tab-zone-fias"><?= $text_loading ?>...</div>
        <div class="tab-pane" id="tab-license"><?= $text_loading ?>...</div>
        <div class="tab-pane" id="tab-support"><?= $text_loading ?>...</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
    function prmnAlert(content) {
        var alert = $('#prmn-alert');
        alert.find('.modal-body').html(content);
        alert.modal('show');
    }

    function saveTab(index) {
        var tabs = $('.tab-pane');

        if (index >= tabs.length) {
            $('#success').removeClass('hidden').find('span').text('<?= $text_success ?>');
            $('#submit-forms').removeAttr('disabled');
            return;
        }

        var tab = tabs.eq(index);
        var form = tab.find('form.main-form');
        if (form.length) {
            window[form.data('submit')](function(result) {
                if (result) {
                    saveTab(index + 1);
                } else {
                    $('#submit-forms').removeAttr('disabled');
                }
            });
        } else {
            saveTab(index + 1);
        }
    }

    function openTabSupport() {
        $('#tabs a[href="#tab-support"]').tab('show');
    }

    var xhr;
    $(function() {
        $('#tabs').find('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
            var tab = $($(this).attr('href'));
            if (!tab.find('div').length) {
                tab.load($(this).data('url'), function() {
                    tab.find('[data-toggle="tooltip"]').tooltip({container: 'body', html: true});
                });
            }
        });

         $('#tabs a<?= $valid_license ? ':first' : '[href="#tab-license"]' ?>').tab('show');

        $('#submit-forms').click(function() {
            $('#warning, #success').addClass('hidden').find('span').text('');
            $(this).attr('disabled', 'disabled');
            saveTab(0);
        });

        $('form').submit(function(e) {
            e.preventDefault();
        });

        $(document).on('focus', '.row-fias-name', function() {
            if (!$(this).data('autocomplete')) {
                var el = $(this);
                el.prmnAutocomplete({
                    'source': '<?= $url_search; ?>&short=' + (el.data('short') ? 1 : 0),
                    'select': function(item) {
                        el.val(item.name);
                        el.siblings('.row-fias-id').val(item.value);
                    }
                });
                el.data('autocomplete', true);
                el.siblings('ul.dropdown-menu').css({'maxHeight': 300, 'overflowY': 'auto', 'overflowX': 'hidden'});
            }
        });
    });
    //--></script>
<?= $footer; ?>
