<?php if ($selecteds) { ?>
<div class="list-group-item selected-options js-ocf-selected-options">
  <?php foreach ($selecteds as $option) { ?>
  <span class="ocfilter-option">
    <!--<span><?php echo $option['name']; ?>:</span>-->
    <?php foreach ($option['values'] as $value) { ?>
    <button type="button" onclick="location = '<?php echo $value['href']; ?>';" class="ocfilter__selecteded-option-btn"><?php echo $value['name']; ?> <span class="icon-close">x</span></button>
    <?php } ?>
  </span>
  <?php } ?>
</div>
<?php } ?>