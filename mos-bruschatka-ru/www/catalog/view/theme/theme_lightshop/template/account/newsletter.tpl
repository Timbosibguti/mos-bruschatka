<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
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
			
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
				<div class="form-box">
					<div class="checkout">
						<div class="checkout__input-row">
							<div class="checkout__radio-box form-group">
								<span class="checkout__input-box-title"><?php echo $entry_newsletter; ?></span>
								<div class="checkout__radio-item">
									<input name="newsletter" id="newsletter0" type="radio" value="0" <?php echo $newsletter == 0 ? 'checked="checked"' : ''?>>
										<label for="newsletter0"><?php echo $text_no; ?></label>
								</div>	
								<div class="checkout__radio-item">
									<input name="newsletter" id="newsletter1" type="radio" value="1" <?php echo $newsletter == 1 ? 'checked="checked"' : ''?>>
									<label for="newsletter1"><?php echo $text_yes; ?></label>
								</div>						
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
<?php echo $footer; ?></body></html>
