<div class="well well-sm">
  <p>
    <?php echo $text_instruction; ?><br /><br />
    <?php echo $text_printpay; ?><br /><br />
    <?php echo $text_payment; ?><br /><br />
    <?php if ($text_order_history) { ?>
    <?php echo $text_order_history; ?><br /><br />
    <?php } ?>
    <?php echo $text_payment_comment; ?>
  </p>
</div>
<div class="checkout__button-box">
  <div>
    <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary" />
  </div>
</div>
<script type="text/javascript"><!--
$('#button-confirm').on('click', function() {
  $.ajax({
    type: 'get',
    url: 'index.php?route=extension/payment/sberbank_transfer/confirm',
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
