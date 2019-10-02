  <?php if (isset($error)) { ?>
    <div class="alert alert-danger">Payment Error: <?php echo $error; ?></div>
  <?php } else { ?>

  <?php if (isset($text_testing)) { ?>
    <div class="alert alert-warning"><?php echo $text_testing; ?></div>
  <?php } ?>

  <div class="checkout__button-box">
    <div>
      <input type="button" value="<?php echo $button_pay; ?>" id="button-confirm" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
    </div>
  </div>

<script src="https://secure.ewaypayments.com/scripts/eCrypt.js"></script>
<script type="text/javascript">//<!--

	/**
	 * eWAY Rapid IFrame config object.
	 */
	var eWAYConfig = {
		sharedPaymentUrl: "<?php echo $SharedPaymentUrl; ?>"
	};

	/**
	 * eWAY Rapid IFrame callback
	 */
	function resultCallback(result, transactionID, errors) {
		if (result == "Complete") {
			window.location.href = "<?php echo $callback; ?>";
		} else if (result == "Error") {
			$('#button-confirm').removeAttr('disabled');
			alert("There was a problem completing the payment: " + result);
		} else {
			$('#button-confirm').removeAttr('disabled');
		}
	}

	$('#button-confirm').bind('click', function() {
		$('#button-confirm').attr('disabled', 'disabled');
		eCrypt.showModalPayment(eWAYConfig, resultCallback);
	});

//--></script>

<?php } ?>