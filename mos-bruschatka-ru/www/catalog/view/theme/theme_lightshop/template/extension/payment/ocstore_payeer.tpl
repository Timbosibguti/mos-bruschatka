<?php 
/**
 * Support:
 * https://opencartforum.com/user/3463-shoputils/
 * http://opencart.shoputils.ru/?route=information/contact
 * 
*/
?>
<?php if ($instruction) { ?>
  <div class="well well-sm"><p><?php echo $instruction; ?></p></div>
<?php } ?>
<form action="<?php echo $action ?>" method="get" id="checkout">
    <?php foreach ($parameters as $key => $value) { ?>
      <?php if (is_array($value)) { ?>
        <?php foreach ($value as $val) { ?>
          <input type="hidden" name="<?php echo $key; ?>" value="<?php echo $val; ?>"/>
        <?php } ?>
      <?php } else { ?>
        <input type="hidden" name="<?php echo $key; ?>" value="<?php echo $value; ?>"/>
      <?php } ?>
    <?php } ?>
</form>
<div class="checkout__button-box">
  <div>
    <button type="button" class="btn" id="button-confirm"><?php echo $button_confirm; ?><svg class="icon-arrow-long-right"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#arrow-long-right"></use></svg></button>
  </div>
<script type="text/javascript"><!--
$('#button-confirm').on('click', function() {
        $.ajax({
            type: 'get',
            url: 'index.php?route=extension/payment/ocstore_payeer/confirm',
            beforeSend: function() {
                $('#button-confirm').attr('disabled', true);
                $('#button-confirm').attr('disabled', 'disabled');
            },
            complete: function() {
                $('#button-confirm').removeAttr('disabled');
            },
            success: function() {
              <?php if ($pay_status) { ?>
                document.forms['checkout'].submit();
              <?php } else { ?>
                location = '<?php echo $continue; ?>';
              <?php } ?>
           }
        });
    });
//--></script>
</div>