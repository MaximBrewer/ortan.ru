<div class="product__top">
    <div class="product__top_inner <?php if ($product['special'] && $product['novelty'] && $product['bestseller']) { ?>w-full<?php } ?>">
        <?php if ($product['special']) { ?><p class="product__label product__label_red">РАСПРОДАЖА</p><?php } ?>
        <?php if ($product['novelty']) { ?><p class="product__label product__label_green">НОВИНКА</p><?php } ?>
        <?php if ($product['bestseller']) { ?><p class="product__label">БЕСТСЕЛЛЕР</p><?php } ?>
    </div>
    <?php if (!isset($hide_icons) || !$hide_icons) { ?>
        <div class="product__icons" <?php if ($product['special'] && $product['novelty'] && $product['bestseller']) { ?>style="width:100%;margin-top:10px;" <?php } ?>>
            <a href="/wishlist" data-wishlist="<?php echo $product['product_id']; ?>">
                <svg class="product__icon product__icon_like" title="В закладки" width="23" height="20" viewBox="0 0 23 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <g>
                        <path d="M11.194 19.9485C10.8753 19.9485 10.568 19.833 10.3285 19.6232C9.42411 18.8324 8.55214 18.0892 7.78282 17.4337L7.77889 17.4302C5.52339 15.5082 3.57567 13.8483 2.22049 12.2131C0.705604 10.3851 0 8.65196 0 6.75856C0 4.91897 0.63079 3.22183 1.77605 1.97955C2.93498 0.722585 4.52519 0.030304 6.25427 0.030304C7.5466 0.030304 8.73012 0.438874 9.77187 1.24457C10.2976 1.65126 10.7742 2.14899 11.194 2.72957C11.614 2.14899 12.0904 1.65126 12.6163 1.24457C13.6581 0.438874 14.8416 0.030304 16.1339 0.030304C17.8628 0.030304 19.4532 0.722585 20.6121 1.97955C21.7574 3.22183 22.388 4.91897 22.388 6.75856C22.388 8.65196 21.6826 10.3851 20.1677 12.2129C18.8125 13.8483 16.865 15.508 14.6098 17.4299C13.8391 18.0865 12.9658 18.8309 12.0593 19.6236C11.82 19.833 11.5126 19.9485 11.194 19.9485Z" fill="none" />
                    </g>
                    <path d="M11.194 19.9485C10.8753 19.9485 10.568 19.833 10.3285 19.6232C9.42411 18.8324 8.55214 18.0892 7.78282 17.4337L7.77889 17.4302C5.52339 15.5082 3.57567 13.8483 2.22049 12.2131C0.705604 10.3851 0 8.65196 0 6.75856C0 4.91897 0.63079 3.22183 1.77605 1.97955C2.93498 0.722585 4.52519 0.030304 6.25427 0.030304C7.5466 0.030304 8.73012 0.438874 9.77187 1.24457C10.2976 1.65126 10.7742 2.14899 11.194 2.72957C11.614 2.14899 12.0904 1.65126 12.6163 1.24457C13.6581 0.438874 14.8416 0.030304 16.1339 0.030304C17.8628 0.030304 19.4532 0.722585 20.6121 1.97955C21.7574 3.22183 22.388 4.91897 22.388 6.75856C22.388 8.65196 21.6826 10.3851 20.1677 12.2129C18.8125 13.8483 16.865 15.508 14.6098 17.4299C13.8391 18.0865 12.9658 18.8309 12.0593 19.6236C11.82 19.833 11.5126 19.9485 11.194 19.9485ZM6.25427 1.34176C4.89584 1.34176 3.64793 1.8839 2.74009 2.86843C1.81875 3.86783 1.31129 5.24931 1.31129 6.75856C1.31129 8.351 1.90313 9.77519 3.23013 11.3763C4.51272 12.924 6.42046 14.5498 8.62934 16.4322L8.63344 16.4356C9.40566 17.0938 10.281 17.8398 11.1921 18.6365C12.1087 17.8383 12.9854 17.091 13.7592 16.4319C15.9679 14.5494 17.8755 12.924 19.1581 11.3763C20.4849 9.77519 21.0767 8.351 21.0767 6.75856C21.0767 5.24931 20.5693 3.86783 19.6479 2.86843C18.7403 1.8839 17.4922 1.34176 16.1339 1.34176C15.1388 1.34176 14.2252 1.65809 13.4184 2.28188C12.6995 2.83803 12.1987 3.54107 11.9051 4.033C11.7541 4.28596 11.4883 4.43695 11.194 4.43695C10.8997 4.43695 10.6339 4.28596 10.4829 4.033C10.1895 3.54107 9.68869 2.83803 8.96959 2.28188C8.16287 1.65809 7.24922 1.34176 6.25427 1.34176Z" fill="#323031" />
                </svg>
            </a>
            <a href="/compare-products" data-compare="<?php echo $product['product_id']; ?>">
                <svg class="product__icon product__icon_comp" width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <g>
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M1.06667 10.9333V18.9333H3.46667V10.9333H1.06667Z" fill="none" />
                    </g>
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M1.06667 10.9333V18.9333H3.46667V10.9333H1.06667ZM0.8 9.86667C0.358172 9.86667 0 10.2248 0 10.6667V19.2C0 19.6418 0.358172 20 0.8 20H3.73333C4.17516 20 4.53333 19.6418 4.53333 19.2V10.6667C4.53333 10.2248 4.17516 9.86667 3.73333 9.86667H0.8Z" fill="#323031" />
                    <g>
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M7.46669 1.06667V18.9333H9.86669V1.06667H7.46669Z" fill="none" />
                    </g>
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M7.46669 1.06667V18.9333H9.86669V1.06667H7.46669ZM7.20002 0C6.7582 0 6.40002 0.358173 6.40002 0.8V19.2C6.40002 19.6418 6.7582 20 7.20002 20H10.1334C10.5752 20 10.9334 19.6418 10.9334 19.2V0.8C10.9334 0.358172 10.5752 0 10.1334 0H7.20002Z" fill="#323031" />
                    <g>
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M13.6 5.33333V18.9333H16V5.33333H13.6Z" fill="none" />
                    </g>
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M13.6 5.33333V18.9333H16V5.33333H13.6ZM13.3333 4.26666C12.8915 4.26666 12.5333 4.62484 12.5333 5.06666V19.2C12.5333 19.6418 12.8915 20 13.3333 20H16.2667C16.7085 20 17.0667 19.6418 17.0667 19.2V5.06666C17.0667 4.62483 16.7085 4.26666 16.2667 4.26666H13.3333Z" fill="#323031" />
                </svg>
            </a>
        </div>
    <?php } ?>
</div>
<a href="<?php echo $product['href']; ?>" class="product__imgWrapper">
    <img src="<?php echo $product['thumb']; ?>" alt="product image" class="product__img">
    <div class="product__openFancy btn btn_red" data-product_id="<?php echo $product['product_id']; ?>"></div>
</a>
<?php if (!$product['special']) { ?>
    <div class="product__info">
        <span class="product__price"><?php echo $product['price']; ?></span>
    </div>
    <a href="<?php echo $product['href']; ?>" class="product__nameBox" title="<?php echo $product['name']; ?>">
        <h4 class="product__name"><?php echo $product['name']; ?></h4>
        <span class="pruduct__about"><?php if($product['model']):?>Артикул: <b><?php echo $product['model']; ?></b><?php endif;?></span>
    </a>
<?php } else { ?>
    <div class="product__info">
        <span class="product__price"><?php echo $product['special']; ?></span>
        <span class="product__has"><?php echo $product['stock_status']; ?></span>
    </div>
    <span class="product__oldPrice"><?php echo $product['price']; ?></span>
    <a href="<?php echo $product['href']; ?>" class="product__nameBox" title="<?php echo $product['name']; ?>">
        <h4 class="product__name"><?php echo $product['name']; ?></h4>
        <span class="pruduct__about"><?php if($product['model']):?>Артикул: <b><?php echo $product['model']; ?></b><?php endif;?></span>
    </a>
<?php } ?>
<button class="pruduct__add seen__add seen__add btn" onclick="cart.add('<?php echo $product['product_id']; ?>', 1);">В КОРЗИНУ</button>