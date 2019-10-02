<?php if ($show_price) { ?>
<div class="ocfilter-option">
  <div class="ocfilter-option-name prices">
    <p><?php echo $text_price; ?></p>
    <div class="ocf-prices-range">
      <div class="ocf-min-price">
        от: <input type="number" min="<?php echo $min_price; ?>" max="<?php echo $max_price; ?>" class="ocf-min-price-value" id="ocfMinPrice" value="<?php echo $min_price_get; ?>" /><?php echo $symbol_right; ?>
      </div>
      <hr />
      <div class="ocf-max-price">
          до: <input type="number" min="<?php echo $min_price; ?>" max="<?php echo $max_price; ?>" class="ocf-max-price-value" id="ocfMaxPrice" value="<?php echo $max_price_get; ?>" /><?php echo $symbol_right; ?>
      </div>
    </div>
	</div>

  <div class="ocfilter-option-values slide-prices">
    <div id="ocfPriceScale"></div>
  </div>
</div>

<script>
	$('#ocfPriceScale').slider({
		range: true,
		min: <?php echo $min_price; ?>,
		max: <?php echo $max_price; ?>,
		values: [<?php echo $min_price_get; ?>, <?php echo $max_price_get; ?>],
	});
</script>
<?php } ?>