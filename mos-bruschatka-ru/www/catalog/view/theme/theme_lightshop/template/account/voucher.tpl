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
			<p><?php echo $text_description; ?></p>
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
			<div class="form-box">
				<div class="checkout">
					<div class="checkout__input-row">
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_to_name; ?></span>
							<input type="text" name="to_name" value="<?php echo $to_name; ?>" placeholder="<?php echo $entry_to_name; ?>" id="input-to_name" class="<?php echo $error_to_name ? 'error' : ''?>">
							<?php if ($error_to_name) { ?>
							<div class="checkout__input-box-error"><?php echo $error_to_name; ?></div>
							<?php } ?>
						</div>
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_to_email; ?></span>
							<input type="text" name="to_email" value="<?php echo $to_email; ?>" placeholder="<?php echo $entry_to_email; ?>" id="input-to_email" class="<?php echo $error_to_email ? 'error' : ''?>">
							<?php if ($error_to_email) { ?>
							<div class="checkout__input-box-error"><?php echo $error_to_email; ?></div>
							<?php } ?>
						</div>
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_from_name; ?></span>
							<input type="text" name="from_name" value="<?php echo $from_name; ?>" placeholder="<?php echo $entry_from_name; ?>" id="input-from_name" class="<?php echo $error_from_name ? 'error' : ''?>">
							<?php if ($error_from_name) { ?>
							<div class="checkout__input-box-error"><?php echo $error_from_name; ?></div>
							<?php } ?>
						</div>	
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_from_email; ?></span>
							<input type="text" name="from_email" value="<?php echo $from_email; ?>" placeholder="<?php echo $entry_from_email; ?>" id="input-from_email" class="<?php echo $error_from_email ? 'error' : ''?>">
							<?php if ($error_from_email) { ?>
							<div class="checkout__input-box-error"><?php echo $error_from_email; ?></div>
							<?php } ?>
						</div>	
					</div>
					<div class="checkout__radio">
						<div class="checkout__radio-box-row form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_theme; ?></span>
								<?php foreach ($voucher_themes as $i=> $voucher_theme) { ?>
									<?php if ($voucher_theme['voucher_theme_id'] == $voucher_theme_id) { ?>
									<div class="checkout__radio-item">
										<input name="voucher_theme_id" id="voucher_theme-<?php echo $voucher_theme['voucher_theme_id']; ?>-<?php echo $i; ?>" type="radio" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" checked="checked">
										<label for="voucher_theme-<?php echo $voucher_theme['voucher_theme_id']; ?>-<?php echo $i; ?>"><?php echo $voucher_theme['name']; ?></label>
									</div>
									<?php } else { ?>
									<div class="checkout__radio-item">
										<input name="voucher_theme_id" id="voucher_theme-<?php echo $voucher_theme['voucher_theme_id']; ?>-<?php echo $i; ?>" type="radio" value="<?php echo $voucher_theme['voucher_theme_id']; ?>">
										<label for="voucher_theme-<?php echo $voucher_theme['voucher_theme_id']; ?>-<?php echo $i; ?>"><?php echo $voucher_theme['name']; ?></label>
									</div>								
									<?php } ?>
								<?php } ?>
						<?php if ($error_theme) { ?>
						<div class="checkout__input-box-error"><?php echo $error_theme; ?></div>
						<?php } ?>						
						</div>					
					</div>
					<div class="checkout__textarea">
						<span class="checkout__input-box-title" title="<?php echo $help_message; ?>"><?php echo $entry_message; ?></span>
						<textarea name="message" placeholder="<?php echo $entry_message; ?>"><?php echo $message; ?></textarea>				
					</div>		
					<div class="checkout__input-row">
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required" title=""><?php echo $entry_amount; ?> (<?php echo $help_amount; ?>)</span>
							<input type="text" name="amount" value="<?php echo $amount; ?>" placeholder="<?php echo $entry_amount; ?>" id="input-amount" class="<?php echo $error_amount ? 'error' : ''?>">
							<?php if ($error_amount) { ?>
							<div class="checkout__input-box-error"><?php echo $error_amount; ?></div>
							<?php } ?>
						</div>					
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
					<?php if ($text_lightshop_pdata_checkbox) { ?>
					<div class="checkout__checkbox">
						<div class="checkout__checkbox-box-row">
							<div class="checkout__checkbox-item">
								<input name="pdata" id="pdata" type="checkbox" value="1" <?php echo $pdata ? 'checked="checked"' : ''?>>
								<label for="pdata"><?php echo $text_lightshop_pdata_checkbox; ?></label>
								<?php if ($error_pdata) { ?>
								<div class="checkout__input-box-error"><?php echo $error_pdata; ?></div>
								<?php } ?>	
							</div>	
						</div>					
					</div>	
					<?php } ?>	
					<div class="checkout__button-box">
						<button type="submit" class="btn btn--transparent"><?php echo $button_continue; ?></button>
					</div>					
				</div>	
			</div>	
			</form>
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	<?php echo $content_bottom; ?>
	</div>
</main>	
<?php echo $footer; ?></body></html>