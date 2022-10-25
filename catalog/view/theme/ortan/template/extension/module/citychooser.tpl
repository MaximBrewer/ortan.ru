<div class="pull-left regions">
    <div class="btn-group">
        <button class="btn btn-link dropdown-toggle" data-toggle="dropdown">
            <span class="hidden-xs hidden-sm hidden-md"><?php echo $city['city']; ?></span>
        </button>
        <form class="city__form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-city">
            <input type="hidden" name="set_city_code" value="" />
            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
            <ul class="dropdown-menu">
                <?php foreach ($cities as $c) { ?>
                    <li>
                        <a href="javascript:;" class="city-select" name="<?php echo $c['city_code']; ?>"><?php echo $c['city']; ?></a>
                    </li>
                <?php } ?>
            </ul>
        </form>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        $('#form-city .city-select').on('click', function(e) {
            e.preventDefault();
            $('#form-city input[name=\'redirect\']').val(location.href);
            $('#form-city input[name=\'set_city_code\']').val($(this).attr('name'));
            $('#form-city').submit();
        });

        // $('input[name=\'filter_city\']').autocomplete({
        //     'source': function(request, response) {
        //         $.ajax({
        //             url: 'index.php?route=extension/module/citychooser/autocomplete&filter_city=' + encodeURIComponent(request),
        //             dataType: 'json',
        //             success: function(json) {
        //                 response($.map(json, function(item) {
        //                     return {
        //                         label: item['city'],
        //                         value: item['city_code']
        //                     }
        //                 }));
        //             }
        //         });
        //     },
        //     'select': function(item) {
        //         $('#form-city input[name=\'city_code\']').val(item['value']);
        //         $('#form-city').submit();
        //     }
        // });
    });
</script>
<?php /*
<a class="header__location" data-toggle="modal" data-target="#cityChooser"><?php echo $city['city']; ?></a>
<div class="modal fade" tabindex="-1" role="dialog" id="cityChooser">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="city-modal">
                <div class="city__close" data-dismiss="modal" aria-label="Close">
                    <svg width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg" class="city__icon">
                        <path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="#323031" />
                    </svg>
                </div>

                <h4 class="city__heading">Выберите ваш город</h4>
                <form class="city__form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-city">
                    <div class="city__wrapper">
                        <input placeholder="Введите название Вашего города" class="city__input" name="filter_city">
                    </div>
                    <ul class="city__list">
                        <?php foreach ($cities as $c) { ?>
                            <li class="city__item"><a href="javascript:" class="city__link city__link_active city-select" name="<?php echo $c['city_code']; ?>"><?php echo $c['city']; ?></a></li>
                        <?php } ?>
                    </ul>
                    <div class="city__now">Сейчас выбран: <span><?php echo $city['city']; ?></span></div>
                    <input type="hidden" name="city_code" value="" />
                    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                </form>
            </div>
        </div>
    </div>
</div>
*/