<h2><?php echo $text_instruction; ?></h2>
<p><b><?php echo $text_description; ?></b></p>
<div class="well well-sm">
  <p><?php echo $bank; ?></p>
  <p><?php echo $text_payment; ?></p>
</div>
<div class="checkout__button-box">
  <div>
    <button type="button" class="btn" id="button-confirm"><?php echo $button_confirm; ?><svg class="icon-arrow-long-right"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#arrow-long-right"></use></svg></button>
  </div>
</div>
<script type="text/javascript"><!--
$('#button-confirm').on('click', function() {
	$.ajax({
		type: 'get',
		url: 'index.php?route=extension/payment/bank_transfer/confirm',
		cache: false,
		beforeSend: function() {
			$('#button-confirm').attr('disabled', 'disabled');
		},
		complete: function() {
			$('#button-confirm').removeAttr('disabled');
		},
		success: function() {
			location = '<?php echo $continue; ?>';
		}
	});
});
//--></script>
