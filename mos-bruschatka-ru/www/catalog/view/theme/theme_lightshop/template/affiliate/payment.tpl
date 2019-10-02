<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="content">
	<div class="container">
	<?php echo $content_top; ?>
		<div class="breadcrumbs breadcrumbs--sm-pad <?php echo $col < 12 ? '' : 'breadcrumbs--center'?>">
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
	<h2 class="content__title <?php echo $col < 12 ? '' : 'content__title--center'?>"><?php echo $heading_title; ?></h2>
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="<?php echo $col < 12 ? 'col-sm-' . $col : 'col-sm-10 col-sm-offset-1' ?>">
			<div id="sidebar-mob-btn"></div>
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
			<div class="form-box">
			<div class="checkout">
				<h3 class="checkout__h3"><?php echo $text_your_payment; ?></h3>
				<div class="checkout__input-row">
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_tax; ?></span>
						<input type="text" name="tax" value="<?php echo $tax; ?>" placeholder="<?php echo $entry_tax; ?>" id="input-tax">
					</div>				
					<div class="checkout__radio-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_payment; ?></span>
						<div class="checkout__radio-item">
							<input name="payment" id="payment-1" type="radio" value="cheque" <?php echo $payment == 'cheque' ? 'checked="checked"' : ''?>>
							<label for="payment-1"><?php echo $text_cheque; ?></label>
						</div>	
						<div class="checkout__radio-item">
							<input name="payment" id="payment-2" type="radio" value="paypal" <?php echo $payment == 'paypal' ? 'checked="checked"' : ''?>>
							<label for="payment-2"><?php echo $text_paypal; ?></label>
						</div>	
						<div class="checkout__radio-item">
							<input name="payment" id="payment-3" type="radio" value="bank" <?php echo $payment == 'bank' ? 'checked="checked"' : ''?>>
							<label for="payment-3"><?php echo $text_bank; ?></label>
						</div>						
					</div>					
				</div>					
				<div class="checkout__input-row payment" id="payment-cheque">		
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_cheque; ?></span>
						<input type="text" name="cheque" value="<?php echo $cheque; ?>" placeholder="<?php echo $entry_cheque; ?>" id="input-cheque">
					</div>	
				</div>				
				<div class="checkout__input-row payment" id="payment-paypal">		
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_paypal; ?></span>
						<input type="text" name="paypal" value="<?php echo $paypal; ?>" placeholder="<?php echo $entry_paypal; ?>" id="input-paypal">
					</div>	
				</div>
				<div class="checkout__input-row payment" id="payment-bank">		
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_bank_name; ?></span>
						<input type="text" name="bank_name" value="<?php echo $bank_name; ?>" placeholder="<?php echo $entry_bank_name; ?>" id="input-bank_name">
					</div>		
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_bank_branch_number; ?></span>
						<input type="text" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>" placeholder="<?php echo $entry_bank_branch_number; ?>" id="input-bank_branch_number">
					</div>		
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_bank_swift_code; ?></span>
						<input type="text" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>" placeholder="<?php echo $entry_bank_swift_code; ?>" id="input-bank_swift_code">
					</div>			
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_bank_account_name; ?></span>
						<input type="text" name="bank_account_name" value="<?php echo $bank_account_name; ?>" placeholder="<?php echo $entry_bank_account_name; ?>" id="input-bank_account_name">
					</div>			
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_bank_account_number; ?></span>
						<input type="text" name="bank_account_number" value="<?php echo $bank_account_number; ?>" placeholder="<?php echo $entry_bank_account_number; ?>" id="input-bank_account_number">
					</div>	
				</div>	
				<div class="checkout__button-box">
					<a href="<?php echo $back; ?>" class="btn btn--empty"><?php echo $button_back; ?></a>
					<button type="submit" class="btn btn--transparent"><?php echo $button_continue; ?><svg class="icon-arrow-long-right"><use xlink:href="#arrow-long-right"></use></svg></button>
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
<?php echo $footer; ?>
<script>
$('input[name=\'payment\']').on('change', function() {
	$('.payment').hide();

	$('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');
</script>
</body></html>