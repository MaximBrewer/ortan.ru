<?php if ($options || $show_price) { ?>

    <img src="/catalog/view/theme/ortan/assets/images/icon-filter.svg" alt="filter" class="catalog__filterMobile">
  <div class="catalog__filter filter" id="ocfilter">
    <div class="hidden" id="ocfilter-button">
      <button class="btn1 disabled" data-loading-text="<i class='fa fa-refresh fa-spin'></i> Загрузка.."></button>
    </div>
    <p class="filter__heading">ФИЛЬТРЫ ТОВАРОВ: </p>


    <?php //include 'selected_filter.tpl'; ?>

    <?php include 'filter_price.tpl'; ?>

    <?php include 'filter_list.tpl'; ?>

    <div class="filter__menu">
      <button class="filter__show btn disabled">Показать</button>
      <button onclick="location = '<?php echo $link; ?>';"  class="filter__reset btn">Сбросить</button>
    </div>

  </div>

  <script type="text/javascript">
    $(function() {
      var options = {
        mobile: false,
        php: {
          searchButton: <?php echo $search_button; ?>,
          showPrice: <?php echo $show_price; ?>,
          showCounter: <?php echo $show_counter; ?>,
          manualPrice: <?php echo $manual_price; ?>,
          link: '<?php echo $link; ?>',
          path: '<?php echo $path; ?>',
          params: '<?php echo $params; ?>',
          index: '<?php echo $index; ?>'
        },
        text: {
          show_all: '<?php echo $text_show_all; ?>',
          hide: '<?php echo $text_hide; ?>',
          load: '<?php echo $text_load; ?>',
          any: '<?php echo $text_any; ?>',
          select: '<?php echo $button_select; ?>'
        }
      };

      if (options.mobile) {
        $('.ocf-offcanvas-body').html($('#ocfilter').remove().get(0).outerHTML);
      }

      $('[data-toggle="offcanvas"]').on('click', function(e) {
        $(this).toggleClass('active');
        $('body').toggleClass('modal-open');
        $('.ocfilter-mobile').toggleClass('active');
      });

      setTimeout(function() {
        $('#ocfilter').ocfilter(options);
      }, 1);
    });
  </script>
<?php } ?>