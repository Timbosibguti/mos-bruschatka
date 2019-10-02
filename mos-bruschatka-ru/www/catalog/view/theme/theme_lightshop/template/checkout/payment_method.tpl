<?php if ($error_warning) { ?>
	<div class="alert alert--red">
		<span class="alert__text">
			<?php echo $error_warning; ?>
		</span>
	</div>
<?php } ?>
<?php if ($payment_methods) { ?>
<?php foreach ($payment_methods as $payment_method) { ?>
<div class="checkout__input-row">
		<div class="checkout__radio-box">
			<span class="checkout__input-box-title"><?php echo $payment_method['title']; ?></span>

					<div class="checkout__radio-item">
						<?php if ($payment_method['code'] == $code || !$code) { ?>
						<?php $code = $payment_method['code']; ?>
						<input name="payment_method" id="payment_method-<?php echo $payment_method['code']; ?>" type="radio" value="<?php echo $payment_method['code']; ?>" checked="checked">
						<?php } else { ?>
						<input name="payment_method" id="payment_method-<?php echo $payment_method['code']; ?>" type="radio" value="<?php echo $payment_method['code']; ?>">
						<?php } ?>
						<label for="payment_method-<?php echo $payment_method['code']; ?>">
							<?php echo $payment_method['title']; ?>
							<?php if ($payment_method['terms']) { ?>
							(<?php echo $payment_method['terms']; ?>)
							<?php } ?>							
							<?php if (isset($payment_method['description'])) { ?>
							<div class="payment-method__description"><?php echo $payment_method['description']; ?></div>
							<?php } ?>
						</label>
					</div>
		</div>	
</div>	
<?php } ?>
<?php } ?>
<div class="checkout__textarea">
	<span class="checkout__input-box-title"><?php echo $text_comments; ?></span>
	<textarea name="comment" placeholder="<?php echo $text_comments; ?>"><?php echo $comment; ?></textarea>				
</div>
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
	<a href="#" class="btn btn--empty" id="button-payment-method-b"><?php echo $button_back; ?></a>
	<button type="button" class="btn btn--transparent" id="button-payment-method"><?php echo $button_continue; ?><svg class="icon-arrow-long-right"><use xlink:href="#arrow-long-right"></use></svg></button>
</div>