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
				<h3 class="checkout__h3"><?php echo $text_your_details; ?></h3>
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
						<span class="checkout__input-box-title"><?php echo $entry_fax; ?></span>
						<input type="text" name="fax" value="<?php echo $fax; ?>" placeholder="<?php echo $entry_fax; ?>" id="input-fax" class="">
					</div>
				</div>
				<h3 class="checkout__h3"><?php echo $text_your_address; ?></h3>
				<div class="checkout__input-row">
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_company; ?></span>
						<input type="text" name="company" value="<?php echo $company; ?>" placeholder="<?php echo $entry_company; ?>" id="input-company">
					</div>
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_website; ?></span>
						<input type="text" name="website" value="<?php echo $website; ?>" placeholder="<?php echo $entry_website; ?>" id="input-website">
					</div>
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title required"><?php echo $entry_address_1; ?></span>
						<input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $entry_address_1; ?>" id="input-address_1" class="<?php echo $error_address_1 ? 'error' : ''?>">
						<?php if ($error_address_1) { ?>
						<div class="checkout__input-box-error"><?php echo $error_address_1; ?></div>
						<?php } ?>
					</div>	
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title"><?php echo $entry_address_2; ?></span>
						<input type="text" name="address_2" value="<?php echo $address_2; ?>" placeholder="<?php echo $entry_address_2; ?>" id="input-address_2">
					</div>	
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title required"><?php echo $entry_city; ?></span>
						<input type="text" name="city" value="<?php echo $city; ?>" placeholder="<?php echo $entry_city; ?>" id="input-city" class="<?php echo $error_city ? 'error' : ''?>">
						<?php if ($error_city) { ?>
						<div class="checkout__input-box-error"><?php echo $error_city; ?></div>
						<?php } ?>
					</div>					
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title required"><?php echo $entry_postcode; ?></span>
						<input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-postcode" class="<?php echo $error_postcode ? 'error' : ''?>">
						<?php if ($error_postcode) { ?>
						<div class="checkout__input-box-error"><?php echo $error_postcode; ?></div>
						<?php } ?>
					</div>							
					<div class="checkout__input-box form-group checkout__input-box--inline">
						<span class="checkout__input-box-title required"><?php echo $entry_country; ?></span>
						<div class="select">
							<select name="country_id" id="input-country" class="select--squer <?php echo $error_country ? 'error' : ''?> select select-checkout" data-placeholder="<?php echo $entry_country; ?>">
							  <option value=""><?php echo $text_select; ?></option>
							  <?php foreach ($countries as $country) { ?>
							  <?php if ($country['country_id'] == $country_id) { ?>
							  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
							  <?php } else { ?>
							  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
							  <?php } ?>
							  <?php } ?>
							</select>				
						</div>
							<?php if ($error_country) { ?>
							<div class="checkout__input-box-error"><?php echo $error_country; ?></div>
							<?php } ?>					
					</div>					
					<div class="checkout__input-box form-group checkout__input-box--inline">
						<span class="checkout__input-box-title required"><?php echo $entry_zone; ?></span>
						<div class="select">
							<select name="zone_id" id="input-zone" class="select--squer <?php echo $error_zone ? 'error' : ''?> select select-checkout" data-placeholder="<?php echo $entry_zone; ?>"></select>
						</div>
							<?php if ($error_zone) { ?>
							<div class="checkout__input-box-error"><?php echo $error_zone; ?></div>
							<?php } ?>	
					</div>
				</div>
				<div class="checkout__button-box">
					<a href="<?php echo $back; ?>" class="btn btn--empty"><?php echo $button_back; ?></a>
					<button type="submit" class="btn btn--transparent"><?php echo $button_continue; ?><svg class="icon-arrow-long-right"><use xlink:href="#arrow-long-right"></use></svg></button>
				</div>
			</div>
			</div>
			</form>
			<input type="hidden" name="fix_text_select" value="<?php echo $text_select; ?>">	
			<input type="hidden" name="fix_zone_id" value="<?php echo $zone_id; ?>">			
			<input type="hidden" name="fix_text_none" value="<?php echo $text_none; ?>">				
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>
	<?php echo $content_bottom; ?>
	</div>
</main>	
<?php echo $footer; ?></body></html>