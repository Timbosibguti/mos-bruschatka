<form action="<?php echo $action; ?>" method="post" id="checkout">
  <input type="hidden" name="operation_xml" value="<?php echo $xml; ?>">
  <input type="hidden" name="signature" value="<?php echo $signature; ?>">
  <div class="checkout__button-box">
    <div>
      <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary" />
    </div>
  </div>
</form>
<script type="text/javascript"><!--
$('#button-confirm').on('click', function() { 
	$.ajax({
		type: 'get',
		url: 'index.php?route=extension/payment/liqpay/confirm',
		cache: false,
		beforeSend: function() {
			$('#button-confirm').attr('disabled', 'disabled');
		},
		complete: function() {
			$('#button-confirm').removeAttr('disabled');
		},
		success: function() {
			document.forms['checkout'].submit();
		}
	});
});
//--></script>
