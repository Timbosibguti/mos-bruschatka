				<div class="account-form">
					<div class="account-form__col account-form__col--register">
						<span class="account__title"><?php echo $text_new_customer; ?></span>
						<div class="account-form__checkout js-custom-scroll">
							<p><?php echo $text_checkout; ?></p>
							<p> 
								<input type="radio" name="account" id="account-register" value="register" <?php echo $account == 'register' ? 'checked="checked"' : ''?> />
								<label for="account-register"><?php echo $text_register; ?></label>
								<?php if ($checkout_guest) { ?>
								<input type="radio" name="account" id="account-guest" value="guest" <?php echo $account == 'guest' ? 'checked="checked"' : ''?> />
								<label for="account-guest"><?php echo $text_guest; ?></label>
								<?php } ?>
							</p>
							<p><?php echo $text_register_account; ?></p>
						</div>
			
					<div class="checkout__button-box">
						<button type="button" class="btn btn--transparent" id="button-account"><?php echo $button_continue; ?><svg class="icon-arrow-long-right"><use xlink:href="#arrow-long-right"></use></svg></button>
					</div>	
					</div>
					<div class="account-form__col">
						<span class="account__title"><?php echo $text_returning_customer; ?></span>
							<div class="account__input-box">
								<input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email"  required>
							</div>
							<div class="account__input-box account__input-box--pass">
								<input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" required>
								<a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
							</div>
							<div class="account__check-box">
								<input type="checkbox" id="checkbox1">
								<label for="checkbox1"><?php echo $text_account_check; ?></label>
							</div>
							<button type="button" value="<?php echo $button_login; ?>" id="button-login" class="btn"><?php echo $button_login; ?></button>	
					</div>
				</div>