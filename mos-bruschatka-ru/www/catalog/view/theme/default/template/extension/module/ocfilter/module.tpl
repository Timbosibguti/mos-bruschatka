<?php if ($options || $show_price) { ?>
<div class="ocfilter" id="ocfilter">
  <div class="list-group">
    <?php include 'selected_filter.tpl'; ?>

    <?php include 'filter_price.tpl'; ?>

    <?php include 'filter_list.tpl'; ?>
  </div>
</div>
<a href="<?php echo $link; ?>" class="btn btn--fluid"><svg class="icon icon--garbage" height="14" width="14"><use xlink:href="#iconGarbage"></use></svg>Очистить фильтр</a>
<?php } ?>