<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<div class="alerts">
<?php if ($success) { ?>
	<div class="alert alert--green">
		<span class="alert__text">
			<?php echo $success; ?>
		</span>
		<a href="#" class="alert__close">x</a>
	</div>
<?php } ?>
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
	<div id="sidebar-mob-btn"></div>
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="col-sm-<?php echo $col; ?>">
			<div class="row">
				<?php if ($addresses) { ?>
					<?php foreach ($addresses as $result) { ?>
						<div class="col-md-4 col-sm-6">
							<div class="acc-addresses">
							<a href="<?php echo $result['delete']; ?>" class="acc-addresses__delete" title="<?php echo $button_delete; ?>">
										<svg class="icon-cross">
											<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#cross"></use>
										</svg>
									</a>
								<p><?php echo $result['address']; ?></p>
								<a href="<?php echo $result['update']; ?>" class="btn btn--sm"><?php echo $button_edit; ?></a>
							</div>
						</div>
					<?php } ?>
				<?php } else { ?>
				<div class="col-sm-12"><p><?php echo $text_empty; ?></p></div>
				<?php } ?>
				<div class="col-sm-12">		
						<div class="checkout__button-box">
							<a href="<?php echo $back; ?>" class="btn btn--empty"><?php echo $button_back; ?></a>
							<a href="<?php echo $add; ?>" class="btn btn--transparent"><?php echo $button_new_address; ?></a>
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
