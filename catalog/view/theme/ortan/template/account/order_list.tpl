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

        <?php if ($orders) { ?>
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td class="text-right"><?php echo $column_order_id; ?></td>
                  <td class="text-left"><?php echo $column_customer; ?></td>
                  <td class="text-right"><?php echo $column_product; ?></td>
                  <td class="text-left"><?php echo $column_status; ?></td>
                  <td class="text-right"><?php echo $column_total; ?></td>
                  <td class="text-left"><?php echo $column_date_added; ?></td>
                  <td></td>
                </tr>
              </thead>
              <tbody>
                <?php foreach ($orders as $order) { ?>
                  <tr>
                    <td class="text-right">#<?php echo $order['order_id']; ?></td>
                    <td class="text-left"><?php echo $order['name']; ?></td>
                    <td class="text-right"><?php echo $order['products']; ?></td>
                    <td class="text-left"><?php echo $order['status']; ?></td>
                    <td class="text-right"><?php echo $order['total']; ?></td>
                    <td class="text-left"><?php echo $order['date_added']; ?></td>
                    <td class="text-center"><?php if (!empty($order['ocstore_payeer_onpay'])) { ?>
                        <a rel="nofollow" onclick="location='<?php echo $order['ocstore_payeer_onpay']; ?>'" data-toggle="tooltip" title="<?php echo $button_ocstore_payeer_onpay; ?>" class="btn btn_red">$</a>&nbsp;&nbsp;<?php } ?>
                        <a href="<?php echo $order['view']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>">
                          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" style="width:2rem;height:2rem;">
                            <path d="m496.4,243.1c-63.9-78.7-149.3-122.1-240.4-122.1-91.1,0-176.5,43.4-240.4,122.1-6.1,7.5-6.1,18.2 0,25.7 63.9,78.8 149.3,122.2 240.4,122.2 91.1,0 176.5-43.4 240.4-122.1 6.1-7.5 6.1-18.3 0-25.8zm-240.4,79.8c-36.9,0-66.9-30-66.9-66.9 0-36.9 30-66.9 66.9-66.9 36.9,0 66.9,30 66.9,66.9 0,36.9-30,66.9-66.9,66.9zm-197.8-66.9c37.8-42.2 82.9-71.1 131.5-84.9-25.2,19.7-41.5,50.4-41.5,84.9 0,34.4 16.2,65.1 41.5,84.9-48.6-13.8-93.6-42.7-131.5-84.9zm264.1,84.9c25.2-19.7 41.5-50.4 41.5-84.9 0-34.4-16.2-65.1-41.5-84.9 48.6,13.8 93.7,42.7 131.5,84.9-37.9,42.2-82.9,71.1-131.5,84.9z" />
                          </svg>
                        </a>
                    </td>
                  </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
          <div class="row">
            <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
            <div class="col-sm-6 text-right"><?php echo $results; ?></div>
          </div>
        <?php } else { ?>
          <p><?php echo $text_empty; ?></p>
        <?php } ?>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
</section>
<?php echo $footer; ?>