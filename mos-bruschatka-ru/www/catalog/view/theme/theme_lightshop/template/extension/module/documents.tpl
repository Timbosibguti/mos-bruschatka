<div class="section <?php echo $classname; ?> documents">
	<div class="container container--constraint">
		<?php if($entry_title) { ?>
		<div class="h2 documents__h2"><?php echo $entry_title; ?></div>
		<?php } ?>
		<div class="documents__cards">
			<?php foreach($images as $image) { ?>
			<a href="javascript:void(0);" class="documents__card" data-src="<?php echo $image['popup']; ?>" data-fancybox="docs">
				<img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $image['thumb']; ?>" alt="" />
			</a>
			<?php } ?>
		</div>
	</div>
</div>