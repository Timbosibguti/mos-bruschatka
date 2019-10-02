<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="content">
	<div class="container">
	<?php echo $content_top; ?>
		<div class="breadcrumbs breadcrumbs--sm-pad">
			<ul class="breadcrumb__list">
			<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i == 0) { ?>
				<li class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
				<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>		
			<?php } else { ?>
				<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><span><?php echo $breadcrumb['text']; ?></span></li>		
			<?php } ?>
			<?php } ?> 			
			</ul>
		</div>
    <h1 class="content__title"><?php echo $heading_title; ?></h1>
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="col-sm-<?php echo $col; ?>">
			<div id="sidebar-mob-btn"></div>
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

			<div class="form-box">
			<div class="checkout">
				<div class="checkout__input-row">	
		<?php foreach ($allCustomFields as $fieldName) { ?>
			<div <?php echo !${'entry_'.$fieldName.'_show'} ? 'style="display:none"' : ''; ?> class="checkout__input-box form-group">
				<span  class="checkout__input-box-title <?php echo ${'entry_'.$fieldName.'_required'} ? 'required' : ''; ?>"><?php echo ${'entry_'.$fieldName}; ?></span>
				<?php if ($fieldName == 'country') { ?>
					<div class="select">
						<select name="country_id" id="input-country" class="select--squer select select-checkout" data-placeholder="<?php echo $entry_country; ?>">
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
							<select name="zone_id" id="input-zone" class="select--squer select select-checkout" data-placeholder="<?php echo $entry_zone; ?>"></select>
						</div>	
				<?php } else { ?>				
					<input type="text" name="<?php echo $fieldName; ?>" value="<?php echo ${$fieldName}; ?>" placeholder="<?php echo ${'entry_'.$fieldName}; ?>" id="input-<?php echo str_replace('_','-',$fieldName); ?>">
					<?php if (${'error_'.$fieldName}) { ?>
						<div class="checkout__input-box-error"><?php echo ${'error_'.$fieldName}; ?></div>
					<?php } ?>
				<?php } ?>
			</div>	
		<?php } ?>		

					<?php foreach ($custom_fields as $custom_field) { ?>
					<?php if ($custom_field['location'] == 'account') { ?>
					<?php if ($custom_field['type'] == 'select') { ?>
					<div class="checkout__input-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<div class="select">
						<select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="select--squer select select-checkout" data-placeholder="<?php echo $text_select; ?>">
							<option value=""><?php echo $text_select; ?></option>
							<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
							<?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
							<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
							<?php } else { ?>
							<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
							<?php } ?>
							<?php } ?>						
						</select>
						</div>
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'radio') { ?>
						<div class="checkout__radio-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
							<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? 'required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
								<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
									<?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
									<div class="checkout__radio-item">
										<input name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="radio" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked">
										<label for="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></label>
									</div>
									<?php } else { ?>
									<div class="checkout__radio-item">
										<input name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="radio" value="<?php echo $custom_field_value['custom_field_value_id']; ?>">
										<label for="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></label>
									</div>								
									<?php } ?>
								<?php } ?>
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>							
						</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'checkbox') { ?>
						<div class="checkout__checkbox-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
							<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? 'required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
								<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
									<?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
									<div class="checkout__checkbox-item">
										<input name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="checkbox" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked">
										<label for="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></label>
									</div>
									<?php } else { ?>
									<div class="checkout__checkbox-item">
										<input name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="checkbox" value="<?php echo $custom_field_value['custom_field_value_id']; ?>">
										<label for="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></label>
									</div>								
									<?php } ?>
								<?php } ?>
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>								
						</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'text') { ?>
					<div class="checkout__input-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class=" <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'textarea') { ?>
					<div class="checkout__textarea-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class=" <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>"><?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'file') { ?>
					<div class="checkout__file-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						
						<button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn"><?php echo $button_upload; ?></button>
						<input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
						

						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'date') { ?>
					<div class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" data-date-format="YYYY-MM-DD" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="date  <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'time') { ?>
					<div class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" data-date-format="HH:mm" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="time  <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'datetime') { ?>
					<div class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" data-date-format="YYYY-MM-DD HH:mm" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="datetime  <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php } ?>
					<?php } ?>	
					<div class="checkout__radio-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_default; ?></span>
						<div class="checkout__radio-item">
							<input name="default" id="default0" type="radio" value="0" <?php echo $default == 0 ? 'checked="checked"' : ''?>>
								<label for="default0"><?php echo $text_no; ?></label>
						</div>	
						<div class="checkout__radio-item">
							<input name="default" id="default1" type="radio" value="1" <?php echo $default == 1 ? 'checked="checked"' : ''?>>
							<label for="default1"><?php echo $text_yes; ?></label>
						</div>						
					</div>	
				</div>				
				<div class="checkout__button-box">
					<a href="<?php echo $back; ?>" class="btn btn--empty"><?php echo $button_back; ?></a>
					<button type="submit" class="btn btn--transparent"><?php echo $button_continue; ?><svg class="icon-arrow-long-right"><use xlink:href="#arrow-long-right"></use></svg></button>
				</div>
			</div>
			</div>
			<input type="hidden" name="fix_text_select" value="<?php echo $text_select; ?>" />	
			<input type="hidden" name="fix_zone_id" value="<?php echo $zone_id; ?>" />			
			<input type="hidden" name="fix_text_none" value="<?php echo $text_none; ?>" />
			</form>
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	<?php echo $content_bottom; ?>
	</div>
</main>	
<?php echo $footer; ?>
<script>
$('.form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('.form-group').length-2) {
		$('.form-group').eq(parseInt($(this).attr('data-sort'))+2).before(this);
	}

	if ($(this).attr('data-sort') > $('.form-group').length-2) {
		$('.form-group:last').after(this);
	}

	if ($(this).attr('data-sort') == $('.form-group').length-2) {
		$('.form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('.form-group').length-2) {
		$('.form-group:first').before(this);
	}
});

$('button[id^=\'button-custom-field\']').on('click', function() {
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
						$(node).parent().find('input').after('<div class="checkout__input-box-error">' + json['error'] + '</div>');
					}

					if (json['success']) {						
						$('.alerts').append($('<div class="alert alert--green"><span class="alert__text"> ' + json['success'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
						alertClose();
						
						$(node).parent().find('input').val(json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
</script>
</body></html>