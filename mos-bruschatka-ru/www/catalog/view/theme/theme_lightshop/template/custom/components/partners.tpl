<div class="section section--highlight partners">
	<div class="container container--constraint">
		<div class="h2 mb-35">Наши партнёры</div>
		<div class="partners__slideshow-imgs js-partners-slideshow-imgs">
			<?php foreach($thumbs as $thumb) { ?>
			<div class="partners__item-imgs" >
				<img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $thumb; ?>" alt="" class="partners__item-img" />
			</div>
			<?php } ?>
		</div>
	</div>
</div>

