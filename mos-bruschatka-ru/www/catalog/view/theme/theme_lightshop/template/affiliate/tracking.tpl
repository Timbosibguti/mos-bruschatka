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
			<p><?php echo $text_description; ?></p>
			<div class="form-box">
				<div class="checkout">
					<div class="checkout__textarea">
						<span class="checkout__input-box-title"><?php echo $entry_code; ?></span>
						<textarea id="input-code" placeholder="<?php echo $entry_code; ?>"><?php echo $code; ?></textarea>				
					</div>		
				
					<div class="checkout__input-row">
						<div class="checkout__input-box form-group">
							<span class="checkout__input-box-title"><?php echo $entry_generator; ?></span>
							<input type="text" name="product" value="" placeholder="<?php echo $entry_generator; ?>" id="input-generator">
						</div>
					</div>
					<div class="checkout__textarea">
						<span class="checkout__input-box-title"><?php echo $entry_link; ?></span>
						<textarea id="input-link" placeholder="<?php echo $entry_link; ?>"></textarea>				
					</div>		
					<div class="checkout__button-box">
						<button type="submit" class="btn btn--transparent"><?php echo $button_continue; ?></button>
					</div>				
				</div>	
			</div>
 		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>
	<?php echo $content_bottom; ?>
	</div>
</main>	
<?php echo $footer; ?></body></html>