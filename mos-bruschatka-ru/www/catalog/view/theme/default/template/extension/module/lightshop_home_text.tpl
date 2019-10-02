<div class="home-text">
	<div class="container">
	<div class="row">
	<?php if ($img) { ?>
		<div class="col-sm-4">	
			<div class="home-text__img"><img src="<?php echo $img; ?>" alt="<?php echo $heading_title; ?>"></div>
		</div>
	<?php } ?>
		<div class="col-sm-<?php echo $img ? '8' : '12'?>">
			<?php if($heading_title) { ?>
			<h1 class="home-text__title"><?php echo $heading_title; ?></h1>
			<?php } ?>
			<div class="home-text__content"><?php echo $html; ?></div>
		</div>
	</div>
	</div>
</div>
