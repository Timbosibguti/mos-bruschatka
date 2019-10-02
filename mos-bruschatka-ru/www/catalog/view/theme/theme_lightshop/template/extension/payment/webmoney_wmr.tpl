<form action="<?php echo $action ?>" method="post" id="checkout">
    <?php foreach ($params as $key => $value) { ?>
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
    <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary" />
  </div>
<script type="text/javascript"><!--
    $(document).delegate('#button-confirm', 'click', function() {
        $.ajax({
            type: 'get',
            url: '<?php echo $confirm; ?>',
            beforeSend: function() {
                $('#button-confirm').attr('disabled', true);
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
</div>
