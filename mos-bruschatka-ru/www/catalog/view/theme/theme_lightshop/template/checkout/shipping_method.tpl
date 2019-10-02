<?php if ($error_warning) { ?>
	<div class="alert alert--red">
		<span class="alert__text">
			<?php echo $error_warning; ?>
		</span>
	</div>
<?php } ?>
<?php if ($shipping_methods) { ?>
<?php foreach ($shipping_methods as $shipping_method) { ?>
<div class="checkout__input-row">
		<div class="checkout__radio-box">
			<span class="checkout__input-box-title"><?php echo $shipping_method['title']; ?></span>
			<?php if (!$shipping_method['error']) { ?>
				<?php foreach ($shipping_method['quote'] as $quote) { ?>
					<div class="checkout__radio-item">
						<?php if ($quote['code'] == $code || !$code) { ?>
						<?php $code = $quote['code']; ?>
						<input name="shipping_method" id="shipping_method-<?php echo $quote['code']; ?>" type="radio" value="<?php echo $quote['code']; ?>" checked="checked">
						<?php } else { ?>
						<input name="shipping_method" id="shipping_method-<?php echo $quote['code']; ?>" type="radio" value="<?php echo $quote['code']; ?>">
						<?php } ?>
						<label for="shipping_method-<?php echo $quote['code']; ?>">
							<?php echo $quote['title']; ?> (<?php echo $quote['text']; ?>)
							<?php if (isset($quote['description'])) { ?>
							<div class="shipping-method__description"><?php echo $quote['description']; ?></div>
							<?php } ?>
						</label>
					</div>
				<?php } ?>	
				<?php } else { ?>
				<div class="alert alert--red">
					<span class="alert__text">
						<?php echo $shipping_method['error']; ?>
					</span>
				</div>
				<?php } ?>
		</div>	
</div>	
<?php } ?>
<?php } ?>
<div class="checkout__textarea">
	<span class="checkout__input-box-title"><?php echo $text_comments; ?></span>
	<textarea name="comment" placeholder="<?php echo $text_comments; ?>"><?php echo $comment; ?></textarea>				
</div>
<div class="checkout__button-box">
	<a href="#" class="btn btn--empty" id="button-shipping-method-b"><?php echo $button_back; ?></a>
	<button type="button" class="btn btn--transparent" id="button-shipping-method"><?php echo $button_continue; ?><svg class="icon-arrow-long-right"><use xlink:href="#arrow-long-right"></use></svg></button>
</div>