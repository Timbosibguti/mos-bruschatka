<div id="slideshow<?php echo $module; ?>" class="owl-carousel" style="opacity: 1;">
  <?php foreach ($banners as $banner) { ?>
  <div class="item" style="text-align: center;">
    <?php if ($banner['link']) { ?>
    <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
    <?php } else { ?>
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
    <?php } ?>
  </div>
  <?php } ?>
</div>
<script>
function ocSlideshowOwl() {
	$('#slideshow<?php echo $module; ?>').owlCarousel({
		items: 6,
		autoPlay: 3000,
		singleItem: true,
		navigation: false,
		pagination: true
	});
}
document.addEventListener('DOMContentLoaded', ocSlideshowOwl);
</script>