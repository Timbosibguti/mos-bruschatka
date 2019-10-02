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
			<p><?php echo $text_email; ?></p>
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
			<div class="form-box">
			<div class="checkout">
				<div class="checkout__input-row">					
					<div class="checkout__input-box form-group">
						<span class="checkout__input-box-title required"><?php echo $entry_email; ?></span>
						<input type="password" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email">
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