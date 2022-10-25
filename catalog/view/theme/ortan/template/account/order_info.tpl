<?php echo $header; ?>


<div class="breadcrumbs">
  <div class="container">
    <ul class="breadcrumbs__list">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li class="breadcrumbs__item"><a href="<?php echo $breadcrumb['href']; ?>" class="breadcrumbs__link"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
</div>


<section class="authorization authorization_main">
  <div class="authorization__container container">
    <h1 class="authorization__heading innerHeading"><?php echo $heading_title; ?></h1>
    <div class="authorization_prof">
      <div class="authorization__forms">
        <table class="table table-bordered table-hover">
          <thead>
            <tr>
              <td class="text-left" colspan="2"><?php echo $text_order_detail; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="text-left" style="width: 50%;"><?php if ($invoice_no) { ?>
                  <b><?php echo $text_invoice_no; ?></b> <?php echo $invoice_no; ?><br />
                <?php } ?>
                <b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?><br />
                <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?>
              </td>
              <td class="text-left" style="width: 50%;"><?php if ($payment_method) { ?>
                  <b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br />
                <?php } ?>
                <?php if ($shipping_method) { ?>
                  <b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
                <?php } ?>
              </td>
            </tr>
          </tbody>
        </table>
        <table class="table table-bordered table-hover">
          <thead>
            <tr>
              <td class="text-left" style="width: 50%; vertical-align: top;"><?php echo $text_payment_address; ?></td>
              <?php if ($shipping_address) { ?>
                <td class="text-left" style="width: 50%; vertical-align: top;"><?php echo $text_shipping_address; ?></td>
              <?php } ?>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="text-left"><?php echo $payment_address; ?></td>
              <?php if ($shipping_address) { ?>
                <td class="text-left"><?php echo $shipping_address; ?></td>
              <?php } ?>
            </tr>
          </tbody>
        </table>
        <div class="table-responsive">
          <table class="table table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-left"><?php echo $column_name; ?></td>
                <td class="text-left"><?php echo $column_model; ?></td>
                <td class="text-right"><?php echo $column_quantity; ?></td>
                <td class="text-right"><?php echo $column_price; ?></td>
                <td class="text-right"><?php echo $column_total; ?></td>
                <?php if ($products) { ?>
                  <td style="width: 20px;"></td>
                <?php } ?>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product) { ?>
                <tr>
                  <td class="text-left"><?php echo $product['name']; ?>
                    <?php foreach ($product['option'] as $option) { ?>
                      <br />
                      &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                    <?php } ?>
                  </td>
                  <td class="text-left"><?php echo $product['model']; ?></td>
                  <td class="text-right"><?php echo $product['quantity']; ?></td>
                  <td class="text-right" style="white-space: nowrap;"><?php echo $product['price']; ?></td>
                  <td class="text-right" style="white-space: nowrap;"><?php echo $product['total']; ?></td>
                  <td class="text-right" style="white-space: nowrap;">
                    <?php if ($product['reorder']) { ?>
                      <a href="<?php echo $product['reorder']; ?>" data-toggle="tooltip" title="<?php echo $button_reorder; ?>">
                        <svg width="24" height="22" viewBox="0 0 20 18" xmlns="http://www.w3.org/2000/svg">
                          <path d="M6.44379 11.9298H6.4447C6.44547 11.9298 6.44623 11.9297 6.44699 11.9297H17.0703C17.3319 11.9297 17.5618 11.7562 17.6337 11.5047L19.9774 3.30161C20.0279 3.12476 19.9925 2.93463 19.8819 2.78784C19.7711 2.64105 19.5979 2.55469 19.4141 2.55469H5.09247L4.67362 0.669769C4.61395 0.401672 4.37622 0.210938 4.10156 0.210938H0.585938C0.262299 0.210938 0 0.473236 0 0.796875C0 1.12051 0.262299 1.38281 0.585938 1.38281H3.63159C3.70575 1.71683 5.63599 10.403 5.74707 10.9028C5.12436 11.1735 4.6875 11.7943 4.6875 12.5156C4.6875 13.4849 5.47608 14.2734 6.44531 14.2734H17.0703C17.394 14.2734 17.6563 14.0111 17.6563 13.6875C17.6563 13.3639 17.394 13.1016 17.0703 13.1016H6.44531C6.12229 13.1016 5.85938 12.8387 5.85938 12.5156C5.85938 12.1931 6.12137 11.9306 6.44379 11.9298ZM18.6372 3.72656L16.6283 10.7578H6.91529L5.35278 3.72656H18.6372Z"></path>
                          <path d="M5.85938 16.0312C5.85938 17.0005 6.64795 17.7891 7.61719 17.7891C8.58643 17.7891 9.375 17.0005 9.375 16.0312C9.375 15.062 8.58643 14.2734 7.61719 14.2734C6.64795 14.2734 5.85938 15.062 5.85938 16.0312ZM7.61719 15.4453C7.94022 15.4453 8.20312 15.7082 8.20312 16.0312C8.20312 16.3543 7.94022 16.6172 7.61719 16.6172C7.29416 16.6172 7.03125 16.3543 7.03125 16.0312C7.03125 15.7082 7.29416 15.4453 7.61719 15.4453Z"></path>
                          <path d="M14.1406 16.0312C14.1406 17.0005 14.9292 17.7891 15.8984 17.7891C16.8677 17.7891 17.6563 17.0005 17.6563 16.0312C17.6563 15.062 16.8677 14.2734 15.8984 14.2734C14.9292 14.2734 14.1406 15.062 14.1406 16.0312ZM15.8984 15.4453C16.2215 15.4453 16.4844 15.7082 16.4844 16.0312C16.4844 16.3543 16.2215 16.6172 15.8984 16.6172C15.5754 16.6172 15.3125 16.3543 15.3125 16.0312C15.3125 15.7082 15.5754 15.4453 15.8984 15.4453Z" class="topMenu__icon"></path>
                        </svg>
                      </a>
                    <?php } ?>
                    <?php /*
                    <a href="<?php echo $product['return']; ?>" data-toggle="tooltip" title="<?php echo $button_return; ?>" class="btn btn-danger"><i class="fa fa-reply"></i></a>
                    */ ?>
                  </td>
                </tr>
              <?php } ?>
              <?php foreach ($vouchers as $voucher) { ?>
                <tr>
                  <td class="text-left"><?php echo $voucher['description']; ?></td>
                  <td class="text-left"></td>
                  <td class="text-right">1</td>
                  <td class="text-right"><?php echo $voucher['amount']; ?></td>
                  <td class="text-right"><?php echo $voucher['amount']; ?></td>
                  <?php if ($products) { ?>
                    <td></td>
                  <?php } ?>
                </tr>
              <?php } ?>
            </tbody>
            <tfoot>
              <?php foreach ($totals as $total) { ?>
                <tr>
                  <td colspan="3"></td>
                  <td class="text-right"><b><?php echo $total['title']; ?></b></td>
                  <td class="text-right"><?php echo $total['text']; ?></td>
                  <?php if ($products) { ?>
                    <td></td>
                  <?php } ?>
                </tr>
              <?php } ?>
            </tfoot>
          </table>
        </div>
        <?php if ($comment) { ?>
          <table class="table table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-left"><?php echo $text_comment; ?></td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="text-left"><?php echo $comment; ?></td>
              </tr>
            </tbody>
          </table>
        <?php } ?>
        <?php if ($histories) { ?>
          <h3><?php echo $text_history; ?></h3>
          <table class="table table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-left"><?php echo $column_date_added; ?></td>
                <td class="text-left"><?php echo $column_status; ?></td>
                <td class="text-left"><?php echo $column_comment; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ($histories) { ?>
                <?php foreach ($histories as $history) { ?>
                  <tr>
                    <td class="text-left"><?php echo $history['date_added']; ?></td>
                    <td class="text-left"><?php echo $history['status']; ?></td>
                    <td class="text-left"><?php echo $history['comment']; ?></td>
                  </tr>
                <?php } ?>
              <?php } else { ?>
                <tr>
                  <td colspan="3" class="text-center"><?php echo $text_no_results; ?></td>
                </tr>
              <?php } ?>
            </tbody>
          </table>
        <?php } ?>
        <div class="buttons clearfix">
          <a href="<?php echo $continue; ?>" class="btn btn_red"><?php echo $button_continue; ?></a>
        </div>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>



  <?php if ($success) { ?>
    <div class="productm__addToCart productm__addToCart_red" style="display: flex;"><svg class="productm__addOk" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M19.9184 2.8527L7.51783 15.2533C7.40861 15.3625 7.23175 15.3625 7.12278 15.2533L0.0817287 8.21196C-0.0272429 8.10325 -0.0272429 7.92639 0.0817287 7.81716L1.79261 6.10628C1.90184 5.99731 2.07869 5.99731 2.18766 6.10628L7.32056 11.2389L17.8127 0.746768C17.9222 0.637796 18.0985 0.637796 18.2078 0.746768L19.9184 2.45765C20.0276 2.56662 20.0276 2.74322 19.9184 2.8527Z" fill="white"></path>
      </svg>
      <p class="productm__addInfo"><?php echo $success; ?></p><svg class="productm__addClose" width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="white"></path>
      </svg>
    </div>
  <?php } ?>
  <?php if ($error_warning) { ?>
    <div class="productm__addToCart productm__addToCart_red" style="display: flex;"><svg class="productm__addOk" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M19.9184 2.8527L7.51783 15.2533C7.40861 15.3625 7.23175 15.3625 7.12278 15.2533L0.0817287 8.21196C-0.0272429 8.10325 -0.0272429 7.92639 0.0817287 7.81716L1.79261 6.10628C1.90184 5.99731 2.07869 5.99731 2.18766 6.10628L7.32056 11.2389L17.8127 0.746768C17.9222 0.637796 18.0985 0.637796 18.2078 0.746768L19.9184 2.45765C20.0276 2.56662 20.0276 2.74322 19.9184 2.8527Z" fill="white"></path>
      </svg>
      <p class="productm__addInfo"><?php echo $error_warning; ?></p><svg class="productm__addClose" width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="white"></path>
      </svg>
    </div>
  <?php } ?>
  <?php echo $footer; ?>