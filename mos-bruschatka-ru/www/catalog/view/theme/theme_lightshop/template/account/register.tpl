<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<div class="alerts">
<?php if ($error_warning) { ?>
	<div class="alert alert--red">
		<span class="alert__text">
			<?php echo $error_warning; ?>
		</span>
		<a href="#" class="alert__close">x</a>
	</div>
<?php } ?>
</div>
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
			<p><?php echo $text_account_already; ?></p>
			<div class="form-box">
			<div class="checkout">
				<div id="account">
				<div class="checkout__input-row">
					<div class="checkout__radio-box form-group" style="display: <?php echo (count($customer_groups) > 1 ? 'inline-block' : 'none'); ?>;">
							<span class="checkout__input-box-title required"><?php echo $entry_customer_group; ?></span>
								<?php foreach ($customer_groups as $i=> $customer_group) { ?>
									<?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
									<div class="checkout__radio-item">
										<input name="customer_group_id" id="customer_group-<?php echo $customer_group['customer_group_id']; ?>-<?php echo $i; ?>" type="radio" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked">
										<label for="customer_group-<?php echo $customer_group['customer_group_id']; ?>-<?php echo $i; ?>"><?php echo $customer_group['name']; ?></label>
									</div>
									<?php } else { ?>
									<div class="checkout__radio-item">
										<input name="customer_group_id" id="customer_group-<?php echo $customer_group['customer_group_id']; ?>-<?php echo $i; ?>" type="radio" value="<?php echo $customer_group['customer_group_id']; ?>">
										<label for="customer_group-<?php echo $customer_group['customer_group_id']; ?>-<?php echo $i; ?>"><?php echo $customer_group['name']; ?></label>
									</div>								
									<?php } ?>
								<?php } ?>					
					</div>								
	<?php foreach ($allCustomFields as $fieldName) { ?>
		<div <?php echo !${'entry_'.$fieldName.'_show'} ? 'style="display:none"' : ''; ?> class="checkout__input-box form-group">
			<span  class="checkout__input-box-title <?php echo ${'entry_'.$fieldName.'_required'} ? 'required' : ''; ?>"><?php echo ${'entry_'.$fieldName}; ?></span>
			<?php if ($fieldName == 'country') { ?>
				<div class="select">
					<select name="country_id" id="input-payment-country" class="select--squer select select-checkout" data-placeholder="<?php echo $entry_country; ?>">
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
						<select name="zone_id" id="input-payment-zone" class="select--squer select select-checkout" data-placeholder="<?php echo $entry_zone; ?>"></select>
					</div>	
			<?php } else { ?>				
				<input type="text" name="<?php echo $fieldName; ?>" value="<?php echo ${$fieldName}; ?>" placeholder="<?php echo ${'entry_'.$fieldName}; ?>" id="input-payment-<?php echo str_replace('_','-',$fieldName); ?>">
			<?php } ?>
				<?php if (${'error_'.$fieldName}) { ?>
						<div class="checkout__input-box-error"><?php echo ${'error_'.$fieldName}; ?></div>
				<?php } ?>
		</div>	
	<?php } ?>
					<?php foreach ($custom_fields as $custom_field) { ?>
					<?php if ($custom_field['location'] == 'account') { ?>
					<?php if ($custom_field['type'] == 'select') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<div class="select">
						<select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="select--squer select select-checkout" data-placeholder="<?php echo $text_select; ?>">
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
						<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__radio-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
							<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? 'required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
								<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
									<?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
									<div class="checkout__radio-item">
										<input name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="radio" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked">
										<label for="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></label>
									</div>
									<?php } else { ?>
									<div class="checkout__radio-item">
										<input name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="radio" value="<?php echo $custom_field_value['custom_field_value_id']; ?>">
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
						<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__checkbox-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
							<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? 'required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
								<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
									<?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
									<div class="checkout__checkbox-item">
										<input name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="checkbox" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked">
										<label for="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></label>
									</div>
									<?php } else { ?>
									<div class="checkout__checkbox-item">
										<input name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="checkbox" value="<?php echo $custom_field_value['custom_field_value_id']; ?>">
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
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class=" <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'textarea') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__textarea-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class=" <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>"><?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'file') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__file-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						
						<button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn"><?php echo $button_upload; ?></button>
						<input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
						

						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'date') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" data-date-format="YYYY-MM-DD" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="date  <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'time') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" data-date-format="HH:mm" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="time  <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'datetime') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" data-date-format="YYYY-MM-DD HH:mm" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="datetime  <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php } ?>
					<?php } ?>	
				</div>	
				</div>	
				<div id="address">	
				<div class="checkout__input-row">

					<?php foreach ($custom_fields as $custom_field) { ?>
					<?php if ($custom_field['location'] == 'address') { ?>
					<?php if ($custom_field['type'] == 'select') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<div class="select">
						<select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="select--squer select select-checkout" data-placeholder="<?php echo $text_select; ?>">
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
						<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__radio-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
							<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? 'required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
								<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
									<?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
									<div class="checkout__radio-item">
										<input name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="radio" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked">
										<label for="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></label>
									</div>
									<?php } else { ?>
									<div class="checkout__radio-item">
										<input name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="radio" value="<?php echo $custom_field_value['custom_field_value_id']; ?>">
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
						<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__checkbox-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
							<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? 'required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
								<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
									<?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
									<div class="checkout__checkbox-item">
										<input name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="checkbox" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked">
										<label for="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></label>
									</div>
									<?php } else { ?>
									<div class="checkout__checkbox-item">
										<input name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="custom_field[<?php echo $custom_field['custom_field_id']; ?>]-<?php echo $custom_field_value['custom_field_value_id']; ?>" type="checkbox" value="<?php echo $custom_field_value['custom_field_value_id']; ?>">
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
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class=" <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'textarea') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__textarea-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class=" <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>"><?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'file') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__file-box form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						
						<button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn"><?php echo $button_upload; ?></button>
						<input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
						

						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'date') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" data-date-format="YYYY-MM-DD" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="date  <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'time') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" data-date-format="HH:mm" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="time  <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php if ($custom_field['type'] == 'datetime') { ?>
					<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="checkout__input-box form-group custom-field " data-sort="<?php echo $custom_field['sort_order']; ?>">
						<span class="checkout__input-box-title <?php echo ($custom_field['required'] ? ' required' : ''); ?>"><?php echo $custom_field['name']; ?></span>
						<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" data-date-format="YYYY-MM-DD HH:mm" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="datetime  <?php echo isset($error_custom_field[$custom_field['custom_field_id']]) ? 'error' : ''?>">
						<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						<div class="checkout__input-box-error"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
						<?php } ?>
					</div>					
					<?php } ?>
					<?php } ?>
					<?php } ?>	
				</div>	
				</div>	
				<h3 class="checkout__h3"><?php echo $text_your_password; ?></h3>
				<div class="checkout__input-row">					
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title required"><?php echo $entry_password; ?></span>
						<input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="<?php echo $error_password ? 'error' : ''?>">
						<?php if ($error_password) { ?>
						<div class="checkout__input-box-error"><?php echo $error_password; ?></div>
						<?php } ?>
					</div>
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title required"><?php echo $entry_confirm; ?></span>
						<input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="<?php echo $error_confirm ? 'error' : ''?>">
						<?php if ($error_confirm) { ?>
						<div class="checkout__input-box-error"><?php echo $error_confirm; ?></div>
						<?php } ?>
					</div>					
				</div>					
				<h3 class="checkout__h3"><?php echo $text_newsletter; ?></h3>
				<div class="checkout__radio-row">
					<div class="checkout__radio-box-row form-group">
						<span class="checkout__input-box-title"><?php echo $entry_newsletter; ?></span>
						<div class="checkout__radio-item">
							<input name="newsletter" id="newsletter-0" type="radio" value="0" <?php echo $newsletter == 0 ? 'checked="checked"' : ''?>>
								<label for="newsletter-0"><?php echo $text_no; ?></label>
						</div>	
						<div class="checkout__radio-item">
							<input name="newsletter" id="newsletter-1" type="radio" value="1" <?php echo $newsletter == 1 ? 'checked="checked"' : ''?>>
							<label for="newsletter-1"><?php echo $text_yes; ?></label>
						</div>						
					</div>					
				</div>	
				<?php echo $captcha; ?>
				<?php if ($text_agree) { ?>
				<div class="checkout__checkbox">
						<div class="checkout__checkbox-box-row">
							<div class="checkout__checkbox-item">
								<input name="agree" id="agree" type="checkbox" value="1" <?php echo $agree ? 'checked="checked"' : ''?>>
								<label for="agree"><?php echo $text_agree; ?></label>
							</div>					
						</div>					
				</div>	
				<?php } ?>

				<div class="checkout__button-box">
						<button type="submit" id="submitreg" class="btn btn--transparent"><?php echo $button_continue; ?></button>
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
// Sort the custom fields
$('#account .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#account .form-group').length) {
		$('#account .form-group').eq($(this).attr('data-sort')).before(this);
	}

	if ($(this).attr('data-sort') > $('#account .form-group').length) {
		$('#account .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') == $('#account .form-group').length) {
		$('#account .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('#account .form-group').length) {
		$('#account .form-group:first').before(this);
	}
});

$('#address .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#address .form-group').length) {
		$('#address .form-group').eq($(this).attr('data-sort')).before(this);
	}

	if ($(this).attr('data-sort') > $('#address .form-group').length) {
		$('#address .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') == $('#address .form-group').length) {
		$('#address .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('#address .form-group').length) {
		$('#address .form-group:first').before(this);
	}
});

$('input[name=\'customer_group_id\']').on('click', function() {
	window.location.href ='index.php?route=account/register&customer_group_id=' + this.value;
//	$('#submitreg').trigger('click');
});

$('input[name=\'customer_group_id\']:checked').trigger('change');

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