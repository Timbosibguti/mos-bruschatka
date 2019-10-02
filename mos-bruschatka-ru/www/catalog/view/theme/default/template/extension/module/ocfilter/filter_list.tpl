<?php if ($show_options_limit > 0 && count($options) > $show_options_limit) { ?>
<?php $hidden_options = array_splice($options, $show_options_limit, count($options)); ?>
<?php } else { ?>
<?php $hidden_options = array(); ?>
<?php } ?>

<?php foreach ($options as $option) { ?>

<?php include 'filter_item.tpl'; ?>

<?php } ?>

<?php if ($hidden_options) { ?>
<?php if ($show_options) { ?>
<?php $hiddenClass = 'is-visible'; ?>
<?php } else { ?>
<?php $hiddenClass = 'is-hidden'; ?>
<?php } ?>
<div class="ocfilter-hidden-options">
  <?php foreach ($hidden_options as $option) { ?>

  <?php include 'filter_item.tpl'; ?>

  <?php } ?>
</div>
<?php } ?>


