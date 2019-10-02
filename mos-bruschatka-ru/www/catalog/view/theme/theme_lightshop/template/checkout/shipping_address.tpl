<form class="form-horizontal">
	<?php if ($addresses) { ?>
	<div class="checkout__radio">
			<div class="checkout__radio-box-row">
				<div class="checkout__radio-item">
					<input name="shipping_address" id="shipping_address-existing" type="radio" value="existing" checked="checked">
					<label for="shipping_address-existing"><?php echo $text_address_existing; ?></label>
				</div>	
			</div>	
	</div>	
	<div id="shipping-existing">
		<div class="checkout__input-row">
			<div class="checkout__input-box">
				<div class="select">
					<select name="address_id" class="select--squer select">
						<?php foreach ($addresses as $address) { ?>
						<?php if ($address['address_id'] == $address_id) { ?>
						<option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
						<?php } ?>
						<?php } ?>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="checkout__radio">
			<div class="checkout__radio-box-row">
				<div class="checkout__radio-item">
					<input name="shipping_address" id="shipping_address-new" type="radio" value="new">
					<label for="shipping_address-new"><?php echo $text_address_new; ?></label>
				</div>	
			</div>	
	</div>
	<?php } ?>

<div id="shipping-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
	<div class="checkout__input-row">
		<?php foreach ($allCustomFields as $fieldName) { ?>
			<div <?php echo !${'entry_'.$fieldName.'_show'} ? 'style="display:none"' : ''; ?> class="checkout__input-box form-group">
				<span  class="checkout__input-box-title <?php echo ${'entry_'.$fieldName.'_required'} ? 'required' : ''; ?>"><?php echo ${'entry_'.$fieldName}; ?></span>
				<?php if ($fieldName == 'country') { ?>
					<div class="select">
						<select name="country_id" id="input-shipping-country" class="select--squer select select-checkout" data-placeholder="<?php echo $entry_country; ?>">
							<option value=""><?php echo $text_select; ?></option>
							<?php foreach ($countries as $country) { ?>
							<?php if ($country['country_id'] == $country_id) { ?>
							<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
							<?php } else { ?>
							<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
							<?php } ?>
							<?php } ?>
						</select>
					</div>
				<?php } elseif($fieldName == 'zone') { ?>	
						<div class="select">
							<select name="zone_id" id="input-shipping-zone" class="select--squer select select-checkout" data-placeholder="<?php echo $entry_zone; ?>"></select>
						</div>	
				<?php } else { ?>				
					<input type="text" name="<?php echo $fieldName; ?>" value="<?php echo ${$fieldName}; ?>" placeholder="<?php echo ${'entry_'.$fieldName}; ?>" id="input-shipping-<?php echo str_replace('_','-',$fieldName); ?>">
				<?php } ?>
			</div>	
		<?php } ?>
		<?php foreach ($custom_fields as $custom_field) { ?>
		<?php if ($custom_field['location'] == 'address') { ?>
		<?php if ($custom_field['type'] == 'select') { ?>
			<div id="shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
				<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
				<div class="select">
				<select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="select--squer select select-checkout" data-placeholder="<?php echo $text_select; ?>">
					<option value=""><?php echo $text_select; ?></option>
					<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
					<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
					<?php } ?>		
				</select>
				</div>
			</div>	
		<?php } ?>
		<?php if ($custom_field['type'] == 'radio') { ?>
			<div id="shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__radio-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
				<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?> <?php echo ($custom_field['required'] ? 'required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
				<div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
				<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
					<div class="checkout__radio-item">
						<input name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="radio" value="<?php echo $custom_field_value['custom_field_value_id']; ?>">
						<label for="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></label>
					</div>
				<?php } ?>	
				</div>
			</div>	
		<?php } ?>
		<?php if ($custom_field['type'] == 'checkbox') { ?>
			<div id="shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__checkbox-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
				<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?> <?php echo ($custom_field['required'] ? 'required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
				<div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
				<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
					<div class="checkout__checkbox-item">
						<input name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="checkbox" value="<?php echo $custom_field_value['custom_field_value_id']; ?>">
						<label for="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></label>
					</div>
				<?php } ?>
				</div>
			</div>	
		<?php } ?>
		<?php if ($custom_field['type'] == 'text') { ?>
			<div id="shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
				<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
				<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" >
			</div>	
		<?php } ?>
		<?php if ($custom_field['type'] == 'textarea') { ?>
		<div id="shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__textarea-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
			<textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" ><?php echo $custom_field['value']; ?></textarea>
		</div>	
		<?php } ?>
		<?php if ($custom_field['type'] == 'file') { ?>
		<div id="shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__file-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
			
			<button type="button" id="button-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="btn"><?php echo $button_upload; ?></button>
			<input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
		</div>	
		<?php } ?>
		<?php if ($custom_field['type'] == 'date') { ?>
		<div id="shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
			<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
			<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" data-date-format="YYYY-MM-DD" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="date">
		</div>	
		<?php } ?>
		<?php if ($custom_field['type'] == 'time') { ?>
		<div id="shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
			<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
			<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" data-date-format="HH:mm" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="time">
		</div>	
		<?php } ?>
		<?php if ($custom_field['type'] == 'datetime') { ?>
		<div id="shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
			<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
			<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="datetime">
		</div>	
		<?php } ?>
		<?php } ?>
		<?php } ?>	
	</div>
</div>
	<div class="checkout__button-box">
		<a href="#" class="btn btn--empty" id="button-shipping-address-b"><?php echo $button_back; ?></a>
		<button type="button" class="btn btn--transparent" id="button-shipping-address"><?php echo $button_continue; ?><svg class="icon-arrow-long-right"><use xlink:href="#arrow-long-right"></use></svg></button>
	</div>	
</form>
<script>
ocDateTimepicker();
initCustomSelect($('#collapse-shipping-address select'));

$('input[name=\'shipping_address\']').on('change', function() {
	if (this.value == 'new') {
		$('#shipping-existing').slideUp(200);
		$('#shipping-new').slideDown(200);
		$('#collapse-shipping-address select').multiselect('refresh');
	} else {
		$('#shipping-existing').slideDown(200);
		$('#shipping-new').slideUp(200);
	}
});

// Sort the custom fields
$('#collapse-shipping-address .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#collapse-shipping-address .form-group').length-2) {
		$('#collapse-shipping-address .form-group').eq(parseInt($(this).attr('data-sort'))+2).before(this);
	}

	if ($(this).attr('data-sort') > $('#collapse-shipping-address .form-group').length-2) {
		$('#collapse-shipping-address .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') == $('#collapse-shipping-address .form-group').length-2) {
		$('#collapse-shipping-address .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('#collapse-shipping-address .form-group').length-2) {
		$('#collapse-shipping-address .form-group:first').before(this);
	}
});

$('#collapse-shipping-address button[id^=\'button-shipping-custom-field\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
			clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).attr('disabled', 'disabled');
				},
				complete: function() {
					$(node).removeAttr('disabled');
				},
				success: function(json) {
					$(node).parent().find('.checkout__input-box-error').remove();

					if (json['error']) {
						$(node).parent().find('input[name^=\'custom_field\']').after('<div class="checkout__input-box-error">' + json['error'] + '</div>');
					}

					if (json['success']) {						
						$('.alerts').append($('<div class="alert alert--green"><span class="alert__text"> ' + json['success'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
						alertClose();
						
						$(node).parent().find('input[name^=\'custom_field\']').val(json['code']);
					}
				},
				
				
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});

$('#collapse-shipping-address select[name=\'country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#collapse-shipping-address select[name=\'zone_id\']').multiselect('disable');
		},
		complete: function() {
			$('#collapse-shipping-address select[name=\'zone_id\']').multiselect('enable');
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#collapse-shipping-address input[name=\'postcode\']').parent().parent().addClass('required');
			} else {
				$('#collapse-shipping-address input[name=\'postcode\']').parent().parent().removeClass('required');
			}

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['zone'] && json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
					html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
						html += ' selected="selected"';
					}

					html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			$('#collapse-shipping-address select[name=\'zone_id\']').html(html).multiselect('refresh');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#collapse-shipping-address select[name=\'country_id\']').trigger('change');
</script>