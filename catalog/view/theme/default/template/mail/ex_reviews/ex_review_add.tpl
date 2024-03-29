<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
<head>
<link rel="stylesheet" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><?php echo $text_review_title; ?></title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000;background: #e5e5e5;min-height: 500px;">
<div style="max-width: 640px;margin: 20px auto;background: #ffffff;">
    <div style="background: #e5e5e5;padding: 10px;">
        <a style="display: block;text-align: center;" href="<?php echo $store_url; ?>" title="<?php echo $store_name; ?>"><img style="max-width:320px;" src="<?php echo $logo; ?>" alt="<?php echo $store_name; ?>"/></a>
    </div>
    <div style="padding: 10px;">
        <p style="margin-top: 0px; margin-bottom: 20px;font-size: 15px;"><?php echo $text_hello; ?></p>

        <p style="margin-top: 0px; margin-bottom: 20px;font-size: 15px;"><?php echo $text_review; ?></p>

        <table>
            <tr>
                <th><a href="<?php echo $product['link']; ?>"><img src="<?php echo $product['image']; ?>" style="max-width: 100px;width: auto;max-height: 100px;height: auto;display: block;margin: 0 auto;"/></a></th>
                <th><a style="color: #3e77aa;margin: 0 0 0 20px;padding: 0;text-decoration: none;font-weight: 400;font-family: Arial,Helvetica,sans-serif;font-size: 17px;line-height: 20px;text-align: left;display: block;" href="<?php echo $product['link']; ?>"><?php echo $product['name']; ?></a></th>
            </tr>
        </table>
        <p style="margin-top: 0px; margin-bottom: 20px;color: #777777"><?php echo $text; ?></p>
        <?php if (($text_bonus && $customer_id > 0)) { ?>
        <p style="margin-top: 0px; margin: 20px 0;font-size: 15px;"><?php echo $text_bonus; ?></p>
        <p style="margin-top: 0px; margin-bottom: 20px;font-size: 15px;"><?php echo $text_more_info; ?></p>
        <?php } else { ?>
        <a href="<?php echo $product['link']; ?>" style="margin: 0 auto 30px;display: block;width: 150px;height: 40px;line-height: 40px;background: #17a944;text-align: center;border-radius: 4px;color: #fff;text-decoration: none;font-size: 16px;"><?php echo $text_more; ?></a>
        <?php } ?>
    </div>

    <div style="width: 100%;">
        <table style="width:100%;border-top: 2px solid #efefef;"><tr>
            <th style="width:50%;height:40px"><?php echo $store_name; ?></th>
            <?php if ($store_phone) { ?>
<th><?php echo $store_phone; ?></th><?php } ?>
        </tr></table>
    </div>

</div>
</body>
</html>
