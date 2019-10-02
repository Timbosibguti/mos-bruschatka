		<!-- categories -->
		
		<div class="categories-min">
			<div class="container">
				<div class="categories-min__wrapper js-categories-min">
				<div class="col-md-<?php echo $column; ?> col-sm-6 col-xs-12 js-categories-sizer"></div>
				<?php foreach ($banners as $banner1) { ?>
					<?php foreach ($banner1 as $banner) { ?>
						<div class="<?php echo $banner['width'] > 400 ? 'col-md-' . $column*2  : 'col-md-' . $column ?> col-sm-6 col-xs-12 js-categories-item">
							<div class="categories-min__item <?php echo $banner['height'] > 300 ? 'categories-min__item--large' : '' ; echo $banner['full'] ? ' categories-min__item--full-img' : ''?>">
							<?php if ($banner['link']) { ?>
								<a href="<?php echo $banner['link']; ?>">
									<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
									<span class="categories-min__item-caption"><?php echo $banner['title']; ?></span>
								</a>
							<?php } else { ?>
									<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
									<span class="categories-min__item-caption"><?php echo $banner['title']; ?></span>				
							<?php } ?>
							</div>
						</div>
					<?php } ?>
				<?php } ?>
				</div>	
			</div>
		</div>