<!-- main-slider -->	

	<div class="main-slider">
		<div  class="container arrows-container" <?php echo $scale ? 'style="top: ' . round($scale/2, 5) .'vw;"' : ''?>></div>
		<div class="main-slider__inner js-slider-main">
		    <?php foreach ($banners as $i=> $banner1) { ?>
				<?php foreach ($banner1 as $banner) { ?>
					<?php if ($img_link) { ?>
					<div class="main-slider__item main-slider__item--banner-<?php echo $i; ?>" <?php echo $scale ? 'style="height: '. round($scale, 5).'vw; padding: 0;"' : ''?>>
					<?php echo $banner['link'] ? '<a href="'  . $banner['link'] . '">' : ''?>
						<div class="main-slider__img">
							<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['slider_text']; ?>">
						</div>
						<?php if (!$scale) { ?>
						<div class="container">
							<h2 class="js-slider-main-title"><?php echo $banner['slider_text']; ?></h2>
							<?php if ($banner['link'] && $banner['btn_text']) { ?>
								<a href="<?php echo $banner['link']; ?>" class="btn btn-blue"><?php echo $banner['btn_text']; ?></a>
							<?php } ?>
						</div>
						<?php } ?>
					<?php echo $banner['link'] ? '</a>' : ''?>
					</div>
					<?php } else { ?>
					<div class="main-slider__item main-slider__item--banner-<?php echo $i; ?>" <?php echo $scale ? 'style="height: '. round($scale, 5).'vw; padding: 0;"' : ''?>>
						<div class="main-slider__img">
							<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['slider_text']; ?>">
						</div>
						<?php if (!$scale) { ?>
						<div class="container">
							<h2 class="js-slider-main-title"><?php echo $banner['slider_text']; ?></h2>
							<?php if ($banner['link'] && $banner['btn_text']) { ?>
								<a href="<?php echo $banner['link']; ?>" class="btn btn-blue"><?php echo $banner['btn_text']; ?></a>
							<?php } ?>
						</div>
						<?php } ?>
					</div>
					<?php } ?>
				<?php } ?>
  		    <?php } ?>
		</div>
	<input type="hidden" name="main_slider_autoplay_speed" value="<?php echo $autoplay*1000; ?>">	
	<input type="hidden" name="main_slider_speed" value="<?php echo $speed*100; ?>">	
	</div>

