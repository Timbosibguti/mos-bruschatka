<?php if ($error_warning) { ?>
	<div class="alert alert--red">
		<span class="alert__text">
			<?php echo $error_warning; ?>
		</span>
	</div>
<?php } ?>
<?php if ($shipping_methods) { ?>
<h3 class="checkout__h3"><?php echo $text_lightshop_ship; ?></h3>

<?php echo $st4_col ? '' : '<div class="checkout__input-row">'?>
<?php foreach ($shipping_methods as $shipping_method) { ?>
<?php echo $st4_col ? '<div class="checkout__input-row">' : ''?>
		<div class="checkout__radio-box" <?php echo $st4_col ? 'style="width: 100%;"' : ''?>>
			<?php if ($st4_title_status) { ?>
			<span class="checkout__input-box-title"><?php echo $shipping_method['title']; ?></span>
			<?php } ?>
			<?php if (!$shipping_method['error']) { ?>
				<?php foreach ($shipping_method['quote'] as $quote) { ?>
					<div class="checkout__radio-item">
						<?php if ($quote['code'] == $shipping_code || !$shipping_code) { ?>
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
<?php echo $st4_col ? '</div>' : ''?>
<?php } ?>
<?php echo $st4_col ? '' : '</div>'?>
<?php } ?>

<?php if ($payment_methods) { ?>
<h3 class="checkout__h3"><?php echo $text_lightshop_pay; ?></h3>
<?php echo $st4_col ? '' : '<div class="checkout__input-row">'?>
<?php foreach ($payment_methods as $payment_method) { ?>
<?php echo $st4_col ? '<div class="checkout__input-row">' : ''?>
		<div class="checkout__radio-box" <?php echo $st4_col ? 'style="width: 100%;"' : ''?>>
			<?php if ($st4_title_status) { ?>
			<span class="checkout__input-box-title"><?php echo $payment_method['title']; ?></span>
			<?php } ?>
					<div class="checkout__radio-item">
						<?php if ($payment_method['code'] == $payment_code || !$payment_code) { ?>
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
<?php echo $st4_col ? '</div>' : ''?>
<?php } ?>
<?php echo $st4_col ? '' : '</div>'?>
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

<?php echo $payment; ?>
<script type="text/javascript"><!--	

$('#button-confirm').bindFirst('click', function(e) { 
	
	if($("#agree").prop("checked") == false){
		e.preventDefault();
		$('.alerts').empty();
		$('.alerts').append($('<div class="alert alert--red"><span class="alert__text"> <?php echo $error_agree; ?></span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
		alertClose();
		e.stopImmediatePropagation();
		return ;
	}
});	
//--></script>