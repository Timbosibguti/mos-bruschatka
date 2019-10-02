<!--<div class="checkout__button-box">
  <div>
    <button type="button" class="btn" id="button-confirm"><?php echo $button_confirm; ?><svg class="icon-arrow-long-right"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#arrow-long-right"></use></svg></button>
  </div>
</div>
-->
<div class="checkout__button-box">
	<button type="button" class="btn" id="button-confirm"><?php echo $button_confirm; ?><svg class="icon-arrow-long-right"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#arrow-long-right"></use></svg></button>
</div>
<script type="text/javascript"><!--
$('#button-confirm').on('click', function() {
	$.ajax({
		type: 'get',
		url: 'index.php?route=extension/payment/cod/confirm',
		cache: false,
		beforeSend: function() {
			//$('#button-confirm').attr('disabled', 'disabled');
			$('#button-confirm').attr('disabled', 'disabled');
		},
		complete: function() {
			//$('#button-confirm').removeAttr('disabled');
			$('#button-confirm').removeAttr('disabled');
		},
		success: function() {
			location = '<?php echo $continue; ?>';
		}
	});
});
//--></script>
