<div class="header__currencies <?php echo count($currencies) < 2 ? 'header__currencies--hide' : ''?>">
	<div class="header__select">
	<span class="account__title"><?php echo $text_currency; ?></span>
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-currency">
			<span class="select select--header select--squer select--transparent">
				<select data-placeholder="" class="select select--header  select--transparent">
				<option>&nbsp;</option>
					<?php foreach ($currencies as $currency) { ?>
						<?php if ($currency['code'] == $code) { ?>
						<option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['symbol_left']; ?><?php echo $currency['symbol_right']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_left']; ?><?php echo $currency['symbol_right']; ?></option>
						<?php } ?>
					<?php } ?>
				
				</select>
			</span>
		<input type="hidden" name="code" value="">
		<input type="hidden" name="redirect" value="<?php echo $redirect; ?>">			
		</form>	
	</div>
</div>
