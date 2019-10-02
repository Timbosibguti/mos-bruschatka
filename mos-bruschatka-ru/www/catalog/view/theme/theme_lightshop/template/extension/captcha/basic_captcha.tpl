		<?php if (substr($route, 0, 9) == 'checkout/') { ?>
		<!-- captcha for checkout -->
		<div class="checkout__input-row">
			<div class="checkout__captcha-box">
				<span class="checkout__input-box-title required"><?php echo $text_captcha; ?></span>
					<div class="basic-captcha">
						<div class="basic-captcha__input">
							<input type="text" name="captcha" class="input-payment-captcha" placeholder="<?php echo $entry_captcha; ?>">
						</div>
						<div class="basic-captcha__img">
							<img src="index.php?route=extension/captcha/basic_captcha/captcha" alt="" />
						</div>
					</div>
					<?php if ($error_captcha) { ?>
					<div class="checkout__input-box-error"><?php echo $error_captcha; ?></div>
					<?php } ?>
			</div>	
		</div>
		<?php } elseif ($route == 'information/contact' || $route == 'product/product' ) { ?>
		<!-- captcha for popup -->
		<div class="popup-simple__inner-captcha">
			<div class="basic-captcha">
				<div class="basic-captcha__input">
					<input type="text" name="captcha" class="input-captcha" placeholder="<?php echo $entry_captcha; ?>">
				</div>
				<div class="basic-captcha__img">
					<img src="index.php?route=extension/captcha/basic_captcha/captcha" alt="" />
				</div>
			</div>
			<?php if ($error_captcha) { ?>
			<div class="popup-simple__inner-error-text"><?php echo $error_captcha; ?></div>
			<?php } ?>
		</div>
		<?php } else { ?>
		<!-- captcha for gray input -->
		<div class="checkout__input-row">
			<div class="checkout__captcha-box">
				<span class="checkout__input-box-title required"><?php echo $text_captcha; ?></span>
					<div class="basic-captcha">
						<div class="basic-captcha__input">
							<input type="text" name="captcha" class="input-captcha" placeholder="<?php echo $entry_captcha; ?>">
						</div>
						<div class="basic-captcha__img">
							<img src="index.php?route=extension/captcha/basic_captcha/captcha" alt="" />
						</div>
					</div>
					<?php if ($error_captcha) { ?>
					<div class="checkout__input-box-error"><?php echo $error_captcha; ?></div>
					<?php } ?>
			</div>	
		</div>
		<?php } ?>