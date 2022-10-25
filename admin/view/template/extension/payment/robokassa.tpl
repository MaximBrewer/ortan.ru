<?php echo $header ?><?php echo $column_left ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-payment" data-toggle="tooltip" title="<?php echo $button_save ?>" class="btn btn-primary">
					<i class="fa fa-save"></i>
				</button>
				<a href="<?php echo $cancel ?>" data-toggle="tooltip" title="<?php echo $button_cancel ?>" class="btn btn-default">
					<i class="fa fa-reply"></i>
				</a>
			</div>
			<h1><?php echo $heading_title ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li>
					<a href="<?php echo $breadcrumb['href'] ?>"><?php echo $breadcrumb['text'] ?></a>
				</li>
			<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
			<div class="alert alert-danger">
				<i class="fa fa-exclamation-circle"></i> <?php echo $error_warning ?>
				<button type="button" class="close" data-dismiss="alert">
					&times;
				</button>
			</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="fa fa-pencil"></i> <?php echo $text_edit ?>
				</h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action ?>" method="post" enctype="multipart/form-data" id="form-payment" class="form-horizontal">
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="input-merch-login"><?php echo $entry_merch_login ?></label>
						<div class="col-sm-10">
							<input type="text" name="robokassa_login" value="<?php echo $robokassa_login ?>" placeholder="<?php echo $entry_merch_login ?>" id="input-merch-login" class="form-control" />
							<?php if ($error_merch_login) { ?>
								<div class="text-danger"><?php echo $error_merch_login ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="input-password_1"><?php echo $entry_password1 ?></label>
						<div class="col-sm-10">
							<input type="password" name="robokassa_password_1" value="<?php echo $robokassa_password_1 ?>" placeholder="<?php echo $entry_password1 ?>" id="input-password_1" class="form-control" />
							<?php if ($error_password1) { ?>
								<div class="text-danger"><?php echo $error_password1 ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="input-password_2"><?php echo $entry_password2 ?></label>
						<div class="col-sm-10">
							<input type="password" name="robokassa_password_2" value="<?php echo $robokassa_password_2 ?>" placeholder="<?php echo $entry_password2 ?>" id="input-password_2" class="form-control" />
							<?php if ($error_password2) { ?>
								<div class="text-danger"><?php echo $error_password2 ?></div>
							<?php } ?>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-test_password_1"><?php echo $entry_test_password1 ?></label>
						<div class="col-sm-10">
							<input type="password" name="robokassa_test_password_1" value="<?php echo $robokassa_test_password_1 ?>" placeholder="<?php echo $entry_test_password1 ?>" id="input-test_password_1" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-test_password_2"><?php echo $entry_test_password2 ?></label>
						<div class="col-sm-10">
							<input type="password" name="robokassa_test_password_2" value="<?php echo $robokassa_test_password_2 ?>" placeholder="<?php echo $entry_test_password2 ?>" id="input-test_password_2" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_result_url ?></label>
						<div class="col-sm-10">
							<div class="form-control"><?php echo $robokassa_result_url ?></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_success_url ?></label>
						<div class="col-sm-10">
							<div class="form-control"><?php echo $robokassa_success_url ?></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_fail_url ?></label>
						<div class="col-sm-10">
							<div class="form-control"><?php echo $robokassa_fail_url ?></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-status_id"><?php echo $entry_order_status ?></label>
						<div class="col-sm-10">
							<select name="robokassa_order_status_id" id="input-status_id" class="form-control">
								<?php foreach ($order_statuses as $order_status) { ?>
									<?php if ($order_status['order_status_id'] == $robokassa_order_status_id) { ?>
										<option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
									<?php } else { ?>
										<option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-order-test"><?php echo $entry_test ?></label>
						<div class="col-sm-10">
							<select name="robokassa_test" id="input-test" class="form-control">
								<?php if ($robokassa_test) { ?>
									<option value="1" selected="selected"><?php echo $text_yes ?></option>
									<option value="0"><?php echo $text_no ?></option>
								<?php } else { ?>
									<option value="1"><?php echo $text_yes ?></option>
									<option value="0" selected="selected"><?php echo $text_no ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-order-country">
							<?php echo $entry_country ?>
						</label>
						<div class="col-sm-10">
							<select name="robokassa_country" id="input-country" class="form-control">
								<?php if ($robokassa_country == 'RUB') { ?>
									<option value="RUB" selected="selected"><?php echo $text_ru ?></option>
									<option value="KZT"><?php echo $text_kz ?></option>
								<?php } elseif ($robokassa_country == 'KZT') { ?>
									<option value="RUB"><?php echo $text_ru ?></option>
									<option value="KZT" selected="selected"><?php echo $text_kz ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-order-fiscal">
							<span data-toggle="tooltip" title="<?php echo $help_fiscal ?>"><?php echo $entry_fiscal ?></span>
						</label>
						<div class="col-sm-10">
							<select name="robokassa_fiscal" id="input-fiscal" class="form-control">
								<?php if ($robokassa_fiscal) { ?>
									<option value="1" selected="selected"><?php echo $text_yes ?></option>
									<option value="0"><?php echo $text_no ?></option>
								<?php } else { ?>
									<option value="1"><?php echo $text_yes ?></option>
									<option value="0" selected="selected"><?php echo $text_no ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group hidden-fiscal" <?php if (!$robokassa_fiscal) { ?>style="display:none" <?php } ?>>
						<label class="col-sm-2 control-label" for="input-order-tax-type"><?php echo $entry_tax_type ?></label>
						<div class="col-sm-10">
							<select name="robokassa_tax_type" id="input-tax-type" class="form-control">
								<?php foreach ($robokassa_tax_type_list as $key => $value) { ?>
									<?php if ($robokassa_tax_type == $key) { ?>
										<option value="<?php echo $key ?>" selected="selected"><?php echo $value ?></option>
									<?php } else { ?>
										<option value="<?php echo $key ?>"><?php echo $value ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group hidden-fiscal" <?php if (!$robokassa_fiscal) { ?>style="display:none" <?php } ?>>
						<label class="col-sm-2 control-label" for="input-order-tax"><?php echo $entry_tax ?></label>
						<div class="col-sm-10">
							<select name="robokassa_tax" id="input-tax" class="form-control">
								<?php if ($robokassa_country == 'RUB') { ?>
									<?php foreach ($robokassa_tax_list as $key => $value) { ?>
										<?php if ($robokassa_tax == $key) { ?>
											<option value="<?php echo $key ?>" selected="selected"><?php echo $value ?></option>
										<?php } else { ?>
											<option value="<?php echo $key ?>"><?php echo $value ?></option>
										<?php } ?>
									<?php } ?>
								<?php } elseif ($robokassa_country == 'KZT') { ?>
									<?php foreach ($robokassa_tax_list_kz  as $key => $value) { ?>
										<?php if ($robokassa_tax == $key) { ?>
											<option value="<?php echo $key ?>" selected="selected"><?php echo $value ?></option>
										<?php } else { ?>
											<option value="<?php echo $key ?>"><?php echo $value ?></option>
										<?php } ?>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group hidden-fiscal" <?php if (!$robokassa_fiscal) { ?>style="display:none" <?php } ?>>
						<label class="col-sm-2 control-label" for="input-order-payment-method"><?php echo $entry_payment_method ?></label>
						<div class="col-sm-10">
							<select name="robokassa_payment_method" id="input-payment-method" class="form-control">
								<?php foreach ($robokassa_payment_method_list  as $key => $value) { ?>
									<?php if ($robokassa_payment_method == $key) { ?>
										<option value="<?php echo $key ?>" selected="selected"><?php echo $value ?></option>
									<?php } else { ?>
										<option value="<?php echo $key ?>"><?php echo $value ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group hidden-fiscal" <?php if (!$robokassa_fiscal) { ?>style="display:none" <?php } ?>>
						<label class="col-sm-2 control-label" for="input-order-payment-object"><?php echo $entry_payment_object ?></label>
						<div class="col-sm-10">
							<select name="robokassa_payment_object" id="input-payment-object" class="form-control">
								<?php foreach ($robokassa_payment_object_list  as $key => $value) { ?>
									<?php if ($robokassa_payment_object == $key) { ?>
										<option value="<?php echo $key ?>" selected="selected"><?php echo $value ?></option>
									<?php } else { ?>
										<option value="<?php echo $key ?>"><?php echo $value ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group hidden-fiscal" <?php if (!$robokassa_fiscal) { ?>style="display:none" <?php } ?>>
						<label class="col-sm-2 control-label" for="input-status_id-check2"><span data-toggle="tooltip" title="Если Вам необходимо отправлять второй чек, выберите статус заказа, при котором будет осуществлена отправка">Статус заказа второй чек</span></label>
						<div class="col-sm-10">
							<select name="robokassa_order_status_id_2check" id="input-status_id-check2" class="form-control">
								<option value="0">Не выбрано</option>
								<?php foreach ($order_statuses  as $order_status) { ?>
									<?php if ($order_status['order_status_id'] == $robokassa_order_status_id_2check) { ?>
										<option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
									<?php } else { ?>
										<option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone ?></label>
						<div class="col-sm-10">
							<select name="robokassa_geo_zone_id" id="input-geo-zone" class="form-control">
								<option value="0"><?php echo $text_all_zones ?></option>
								<?php foreach ($geo_zones as $geo_zone) { ?>
									<?php if ($geo_zone['geo_zone_id'] == $robokassa_geo_zone_id) { ?>
										<option value="<?php echo $geo_zone['geo_zone_id'] ?>" selected="selected"><?php echo $geo_zon['name'] ?></option>
									<?php } else { ?>
										<option value="<?php echo $geo_zone['geo_zone_id'] ?>"><?php echo $geo_zone['name'] ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status ?></label>
						<div class="col-sm-10">
							<select name="robokassa_status" id="input-status" class="form-control">
								<?php if ($robokassa_status) { ?>
									<option value="1" selected="selected"><?php echo $text_enabled ?></option>
									<option value="0"><?php echo $text_disabled ?></option>
								<?php } else { ?>
									<option value="1"><?php echo $text_enabled ?></option>
									<option value="0" selected="selected"><?php echo $text_disabled ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-status-iframe"><span data-toggle="tooltip" title="<?php echo $help_iframe ?>"><?php echo $entry_iframe ?></span></label>
						<div class="col-sm-10">
							<select name="robokassa_status_iframe" id="input-status-iframe" class="form-control">
								<?php if ($robokassa_status_iframe) { ?>
									<option value="1" selected="selected"><?php echo $text_enabled ?></option>
									<option value="0"><?php echo $text_disabled ?></option>
								<?php } else { ?>
									<option value="1"><?php echo $text_enabled ?></option>
									<option value="0" selected="selected"><?php echo $text_disabled ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order ?></label>
						<div class="col-sm-10">
							<input type="text" name="robokassa_sort_order" value="<?php echo $robokassa_sort_order ?>" placeholder="<?php echo $entry_sort_order ?>" id="input-sort-order" class="form-control" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_languages_map ?></label>
						<div class="col-sm-10">
							<?php foreach ($opencart_languages as $language) { ?>
								<div>
									<select class="form-control" name="robokassa_languages_map[<?php echo $language['language_id'] ?>]">
										<?php foreach ($robokassa_available_languages as $robokassa_language) { ?>
											<option <?php if ($robokassa_languages_map[$language['language_id']] == $robokassa_language) { ?>selected<?php } ?>><?php echo $robokassa_language ?></option>
										<?php } ?>
									</select>
								</div>
							<?php } ?>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	<?php if ($robokassa_country == 'KZT') { ?>
		$('#input-tax-type').attr('disabled', 'true');
		$('#input-status_id-check2').attr('disabled', 'true');
		$('#input-payment-object').attr('disabled', 'true');
		$('#input-payment-method').attr('disabled', 'true');
	<?php } ?>

	$('#input-country').on(
		'change',
		function() {
			if ($(this).val() == 'KZT') {
				$('.input-tax-type').hide();
				$('#input-tax-type').attr('disabled', 'true');
				$('.input-status_id-check2').hide();
				$('#input-status_id-check2').attr('disabled', 'true');
				$('.input-payment-object').hide();
				$('#input-payment-object').attr('disabled', 'true');
				$('.input-payment-method').hide();
				$('#input-payment-method').attr('disabled', 'true');
			} else {
				$('#input-tax-type').removeAttr('disabled');
				$('#input-status_id-check2').removeAttr('disabled');
				$('#input-payment-object').removeAttr('disabled');
				$('#input-payment-method').removeAttr('disabled');
			}
		}
	);

	$('#input-fiscal').on(
		'change',
		function() {

			if ($(this).val() == 1) {
				$('.hidden-fiscal').show();
				$('.hidden-fiscal').addClass('alert-warning');
			} else {
				$('.hidden-fiscal').hide();
			}

		}
	);
</script>
<?php echo $footer ?>