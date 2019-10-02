<div id="banner<?php echo $module; ?>" class="bannermod__banmain">
  <?php foreach ($banners as $banner) { ?>
  <div class="bannermod__list-item">
    <?php if ($banner['link']) { ?>
    <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="bannermod__img" /></a>
    <?php } else { ?>
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="bannermod__img" />
    <?php } ?>
  </div>
  <?php } ?>
</div>


