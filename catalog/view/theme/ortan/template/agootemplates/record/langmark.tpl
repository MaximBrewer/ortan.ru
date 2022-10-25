<?php if (count($languages) > 1) { ?>
    <div class="pull-left regions">
        <div class="btn-group">
            <button class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                <?php foreach ($languages as $language) { ?>
                    <?php if ($language['current']) { ?>
                        <span class="hidden-xs hidden-sm hidden-md"><?php echo $language['name']; ?></span>
                    <?php } ?>
                <?php } ?>
            </button>
            <ul class="dropdown-menu">
                <?php foreach ($languages as $language) { ?>
                    <li>
                        <a href="<?php echo $language['url']; ?>
                        <?php if ($language['current']) {
                            echo '#';
                        } ?>">
                            <?php echo $language['name']; ?></a>
                    </li>
                <?php } ?>
            </ul>
        </div>
    </div>
<?php } ?>