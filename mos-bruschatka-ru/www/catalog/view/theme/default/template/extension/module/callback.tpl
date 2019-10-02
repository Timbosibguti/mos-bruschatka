<div>
	<div class="popup-simple__inner">
		<form class="data-callback">
			<h3><?php echo $sendthis; ?></h3>
			<input type="text" placeholder="* <?php echo $namew; ?>" name="name">
			<input type="text" placeholder="* <?php echo $phonew; ?>" name="phone">
			<textarea rows="5" placeholder="<?php echo $comment; ?>" name="comment"></textarea>
			<?php echo $captcha; ?>
			<button type="button" class="btn contact-send"><?php echo $sendw; ?></button>
			<?php if ($text_lightshop_pdata) { ?>
			<div class="popup-simple__inner-personal-data"><?php echo $text_lightshop_pdata; ?></div>
			<?php } ?>
		</form>
	</div>
</div>