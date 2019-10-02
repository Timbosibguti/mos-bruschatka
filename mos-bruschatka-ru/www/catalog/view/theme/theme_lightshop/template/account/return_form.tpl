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
					<h3 class="checkout__h3"><?php echo $text_order; ?></h3>
					<div class="checkout__input-row">			
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_firstname; ?></span>
							<input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="<?php echo $error_firstname ? 'error' : ''?>">
							<?php if ($error_firstname) { ?>
							<div class="checkout__input-box-error"><?php echo $error_firstname; ?></div>
							<?php } ?>
						</div>	
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_lastname; ?></span>
							<input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="<?php echo $error_lastname ? 'error' : ''?>">
							<?php if ($error_lastname) { ?>
							<div class="checkout__input-box-error"><?php echo $error_lastname; ?></div>
							<?php } ?>
						</div>
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_email; ?></span>
							<input type="email" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="checkout__input-box-title <?php echo $error_email ? 'error' : ''?>">
							<?php if ($error_email) { ?>
							<div class="checkout__input-box-error"><?php echo $error_email; ?></div>
							<?php } ?>
						</div>					
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_telephone; ?></span>
							<input type="tel" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class=" <?php echo $error_telephone ? 'error' : ''?>">
							<?php if (!$error_telephone) { ?>
							<div class="checkout__input-box-error"><?php echo $error_telephone; ?></div>
							<?php } ?>
						</div>
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_order_id; ?></span>
							<input type="text" name="order_id" value="<?php echo $order_id; ?>" placeholder="<?php echo $entry_order_id; ?>" id="input-order_id" class=" <?php echo $error_order_id ? 'error' : ''?>">
							<?php if (!$error_order_id) { ?>
							<div class="checkout__input-box-error"><?php echo $error_order_id; ?></div>
							<?php } ?>
						</div>	
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title"><?php echo $entry_date_ordered; ?></span>
							<input type="text" name="date_ordered" data-date-format="YYYY-MM-DD" value="<?php echo $date_ordered; ?>" placeholder="<?php echo $entry_date_ordered; ?>" id="input-date_ordered" class="date">
						</div>					
					</div>					
					<h3 class="checkout__h3"><?php echo $text_product; ?></h3>
					<div class="checkout__input-row">
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_product; ?></span>
							<input type="text" name="product" value="<?php echo $product; ?>" placeholder="<?php echo $entry_product; ?>" id="input-product" class="<?php echo $error_product ? 'error' : ''?>">
							<?php if ($error_product) { ?>
							<div class="checkout__input-box-error"><?php echo $error_product; ?></div>
							<?php } ?>
						</div>					
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_model; ?></span>
							<input type="text" name="model" value="<?php echo $model; ?>" placeholder="<?php echo $entry_model; ?>" id="input-model" class="<?php echo $error_product ? 'error' : ''?>">
							<?php if ($error_model) { ?>
							<div class="checkout__input-box-error"><?php echo $error_model; ?></div>
							<?php } ?>
						</div>					
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title"><?php echo $entry_quantity; ?></span>
							<input type="text" name="quantity" value="<?php echo $quantity; ?>" placeholder="<?php echo $entry_quantity; ?>" id="input-quantity" class="<?php echo $error_product ? 'error' : ''?>">
						</div>	
						
						<div class="checkout__radio-box form-group">
							<span class="checkout__input-box-title"><?php echo $entry_opened; ?></span>
							<div class="checkout__radio-item">
								<input name="opened" id="opened-0" type="radio" value="0" <?php echo $opened == 0 ? 'checked="checked"' : ''?>>
									<label for="opened-0"><?php echo $text_no; ?></label>
							</div>	
							<div class="checkout__radio-item">
								<input name="opened" id="opened-1" type="radio" value="1" <?php echo $opened == 1 ? 'checked="checked"' : ''?>>
								<label for="opened-1"><?php echo $text_yes; ?></label>
							</div>						
						</div>						
					</div>					
					
					<div class="checkout__radio">
						<div class="checkout__radio-box-row form-group">
							<span class="checkout__input-box-title required"><?php echo $entry_reason; ?></span>
								<?php foreach ($return_reasons as $i=> $return_reason) { ?>
									<?php if ($return_reason['return_reason_id'] == $return_reason_id) { ?>
									<div class="checkout__radio-item">
										<input name="return_reason_id" id="return_reason-<?php echo $return_reason['return_reason_id']; ?>-<?php echo $i; ?>" type="radio" value="<?php echo $return_reason['return_reason_id']; ?>" checked="checked">
										<label for="return_reason-<?php echo $return_reason['return_reason_id']; ?>-<?php echo $i; ?>"><?php echo $return_reason['name']; ?></label>
									</div>
									<?php } else { ?>
									<div class="checkout__radio-item">
										<input name="return_reason_id" id="return_reason-<?php echo $return_reason['return_reason_id']; ?>-<?php echo $i; ?>" type="radio" value="<?php echo $return_reason['return_reason_id']; ?>">
										<label for="return_reason-<?php echo $return_reason['return_reason_id']; ?>-<?php echo $i; ?>"><?php echo $return_reason['name']; ?></label>
									</div>								
									<?php } ?>
								<?php } ?>
						<?php if ($error_reason) { ?>
						<div class="checkout__input-box-error"><?php echo $error_reason; ?></div>
						<?php } ?>						
						</div>					
					</div>
					<div class="checkout__textarea">
						<span class="checkout__input-box-title"><?php echo $entry_fault_detail; ?></span>
						<textarea name="comment" placeholder="<?php echo $entry_fault_detail; ?>"><?php echo $comment; ?></textarea>				
					</div>		
					<?php echo $captcha; ?>		

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
						<a href="<?php echo $back; ?>" class="btn btn--empty"><?php echo $button_back; ?></a>
						<button type="submit" class="btn btn--transparent"><?php echo $button_submit; ?></button>
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
