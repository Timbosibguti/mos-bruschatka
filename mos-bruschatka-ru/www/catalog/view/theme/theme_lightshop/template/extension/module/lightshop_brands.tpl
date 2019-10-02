		<!-- brands -->
		
		<div class="brands">
			<div class="container">
				<h2><?php echo $title; ?></h2>
				<div class="brands-slider js-slider-brands">
		    <?php foreach ($banners as $banner1) { ?>
				<?php foreach ($banner1 as $banner) { ?>
					<div class="brands-slider__item">
						<?php if ($banner['link']) { ?>
						<a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>"></a>
						<?php } else { ?>
						<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
						<?php } ?>
					</div>
				<?php } ?>
  		    <?php } ?>
				</div>
			</div>
		</div>