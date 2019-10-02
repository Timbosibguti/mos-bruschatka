		<!-- promo -->
		
		<div class="promo">
			<div class="container">
				<div class="row">
				
		    <?php foreach ($banners as $banner1) { ?>
				<?php foreach ($banner1 as $banner) { ?>
					<div class="col-md-<?php echo $banner['width']; ?> col-sm-<?php echo $banner['width']; ?> col-xs-12 ">
						<div class="promo__item <?php echo $banner['text_position']; ?> js-promo-item">
							<a href="<?php echo $banner['link']; ?>">
								<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
								<div class="promo__caption">
									<span class="promo__title"><?php echo $banner['text_big']; ?></span>
									<span class="promo__price"><?php echo $banner['text_small']; ?></span>
								</div>
							</a>	
						</div>
					</div>
				<?php } ?>
  		    <?php } ?>

				</div>
			</div>
		</div>