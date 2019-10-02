<script src="//www.google.com/recaptcha/api.js?hl=<?php echo $lang; ?>"></script>
		<?php if (substr($route, 0, 9) == 'checkout/') { ?>
		<!-- captcha for checkout -->
		<div class="checkout__input-row">
			<div class="checkout__captcha-box">
					<div id="input-payment-captcha" class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
					<?php if ($error_captcha) { ?>
					<div class="checkout__input-box-error"><?php echo $error_captcha; ?></div>
					<?php } ?>
			</div>	
		</div>
		<?php } elseif ($route == 'information/contact' || $route == 'product/product' ) { ?>
		<!-- captcha for popup -->
		<div class="popup-simple__inner-captcha">
			<div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
			<?php if ($error_captcha) { ?>
			<div class="popup-simple__inner-error-text"><?php echo $error_captcha; ?></div>
			<?php } ?>
		</div>
		<?php } else { ?>
		<!-- captcha for gray input -->
		<div class="checkout__input-row">
			<div class="checkout__captcha-box">
					<div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
					<?php if ($error_captcha) { ?>
					<div class="checkout__input-box-error"><?php echo $error_captcha; ?></div>
					<?php } ?>
			</div>	
		</div>
		<?php } ?>