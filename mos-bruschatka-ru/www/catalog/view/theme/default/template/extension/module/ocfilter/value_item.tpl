<?php if ($option['color']) { ?>
<div class="ocf-color" style="background-color: #<?php echo $value['color']; ?>;"></div>
<?php } ?>

<?php if ($option['image']) { ?>
<div class="ocf-image" style="background-image: url(<?php echo $value['image']; ?>);"></div>
<?php } ?>

<?php if ($value['selected']) { ?>
<a href="<?php echo $value['href']; ?>" class="text-normal ocf-selected ocf-value-link js-ocf-value-link">
  <?php echo $value['name']; ?>
  <?php if($option['image'] || $show_counter) { ?>
  <div class="ocf-indicator">
    <?php if ($option['image']) { ?>
    <span class="ocf-img"><img src="<?php echo $value['image']; ?>" alt="" width="20" height="20" /></span>
    <?php } ?>
    <?php if ($show_counter) { ?>
    <small class="ocf-counter"><?php echo $value['count']; ?></small>
    <?php } ?>
  </div>
  <?php } ?>
</a>
<?php } else if ($value['count'] > 1) { ?>
<a href="<?php echo $value['href']; ?>" class="text-normal ocf-value-link js-ocf-value-link">
  <?php echo $value['name']; ?>
  <?php if($option['image'] || $show_counter) { ?>
  <div class="ocf-indicator">
    <?php if ($option['image']) { ?>
    <span class="ocf-img"><img src="<?php echo $value['image']; ?>" alt="" width="20" height="20" /></span>
    <?php } ?>
    <?php if ($show_counter) { ?>
    <small class="ocf-counter"><?php echo $value['count']; ?></small>
    <?php } ?>
  </div>
  <?php } ?>
</a>
<?php } else { ?>
<a href="javascript:void(0);" class="text-normal ocf-disabled ocf-value-link">
  <?php echo $value['name']; ?>
  <?php if($option['image'] || $show_counter) { ?>
  <div class="ocf-indicator">
    <?php if ($option['image']) { ?>
    <span class="ocf-img"><img src="<?php echo $value['image']; ?>" alt="" width="20" height="20" /></span>
    <?php } ?>
    <?php if ($show_counter) { ?>
    <small class="ocf-counter"><?php echo $value['count']; ?></small>
    <?php } ?>
  </div>
  <?php } ?>
</a>
<?php } ?>