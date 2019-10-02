<h2><?php echo $text_instruction; ?></h2>
<div class="well well-sm">
  <p><b><?php echo $text_payable; ?></b></p>
  <p><?php echo $payable; ?></p>
  <b><?php echo $text_address; ?></b><br />
  <p><?php echo $address; ?></p>
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
		url: 'index.php?route=extension/payment/cheque/confirm',
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
