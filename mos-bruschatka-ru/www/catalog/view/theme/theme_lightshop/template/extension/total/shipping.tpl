<li class="tabs__list-item js-tab">
	<a href="#" class="tabs__link">
		<?php echo $text_lightshop_shipping; ?><svg class="icon-chevron-top"><use xlink:href="#chevron-small-left"></use></svg>
	</a>
</li>
<div class="tabs-content js-tab-content js-tab-descr">
	<div class="tabs-content__title js-tab-title">
		<a href="#" class="tabs-content__title-link">
			<?php echo $text_lightshop_shipping; ?><svg class="icon-chevron-top"><use xlink:href="#chevron-small-left"></use></svg>
		</a>
	</div>
	<div class="tabs-content__inner  js-tab-inner">
		<div class="checkout">
			<div class="checkout__input-row">
				<div class="checkout__input-box checkout__input-box--inline">
					<span class="checkout__input-box-title"><?php echo $entry_country; ?></span>
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
				</div>
				<div class="checkout__input-box checkout__input-box--inline">
					<span class="checkout__input-box-title"><?php echo $entry_zone; ?></span>
					<div class="select">
						<select name="zone_id" id="input-zone" class="select--squer select select-checkout" data-placeholder="<?php echo $entry_zone; ?>"></select>
					</div>
				</div>
				<div class="checkout__input-box checkout__input-box--inline">
					<span class="checkout__input-box-title"><?php echo $entry_postcode; ?></span>
					<input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-postcode" class="checkout__input-box-title">		
				</div>
			</div>
			<div class="checkout__button-box">
				<button type="button" id="button-quote" class="btn btn--transparent"><?php echo $button_quote; ?><svg class="icon-arrow-long-right"><use xlink:href="#arrow-long-right"></use></svg></button>
			</div>
		</div>
	</div>
<input type="hidden" name="fix_text_shipping_method" value="<?php echo $text_shipping_method; ?>" />	
<input type="hidden" name="fix_shipping_method" value="<?php echo $shipping_method; ?>" />	
<input type="hidden" name="fix_text_select" value="<?php echo $text_select; ?>" />	
<input type="hidden" name="fix_zone_id" value="<?php echo $zone_id; ?>" />	
<input type="hidden" name="fix_button_shipping" value="<?php echo $button_shipping; ?>" />	
<input type="hidden" name="fix_text_none" value="<?php echo $text_none; ?>" />	
</div>