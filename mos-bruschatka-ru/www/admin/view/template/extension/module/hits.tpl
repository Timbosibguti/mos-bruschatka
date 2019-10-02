<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-hits" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-hits" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_module_css_class; ?></label>
            <div class="col-sm-10">
              <input type="text" name="module_css_class" value="<?php echo $module_css_class; ?>" placeholder="<?php echo $entry_module_css_class ?>" id="input-module_css_class" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-limit">Показать кнопку скачать прайс-лист</label>
            <div class="col-sm-10">
              <input type="checkbox" name="show_button" class="form-control" <?php echo $show_button ? 'checked="checked"' : ''; ?> />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td>Форма</td>
                <td>CSS Класс картинки</td>
                <td>Товары</td>
                <td>Удалить</td>
              </tr>
            </thead>
            <tbody id="hits-filters">
              <?php if($hits) { ?>
                <?php foreach ($hits as $row => $hit) { ?>
                <tr id="hits-filter<?php echo $row; ?>" data-row="<?php echo $row; ?>">
                  <td>
                    <select name="hits[<?php echo $row; ?>][option_value]" class="form-control">
                      <option value="<?php echo $hit['option_value']; ?>"><?php echo $hit['option_name']; ?></option>
                      <?php foreach ($options as $option) { ?>
                      <option value="<?php echo $option['option_value']; ?>"><?php echo $option['option_name']; ?></option>
                      <?php } ?>
                    </select>
                  </td>
                  <td><input type="text" name="hits[<?php echo $row; ?>][classname]" value="<?php echo $hit['classname']; ?>" class="form-control" placeholder="icon-image" /></td>
                  <td>
                    <input type="text" name="product_name" value="" placeholder="<?php echo $entry_product; ?>" id="input-product" class="form-control" />
                    <div id="hits-product" class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php if($hit['products']) { ?>
                      <?php foreach ($hit['products'] as $product) { ?>
                      <div id="hits-product<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
                       <input type="hidden" name="hits[<?php echo $row; ?>][products][]" value="<?php echo $product['product_id']; ?>" />
                      <?php } ?>
                    <?php } ?>
                  </td>
                  <td class="text-left"><button type="button" onclick="$('#hits-filter<?php echo $row; ?>, .tooltip').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                </tr>
                <?php } ?>
              <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td class="text-right" colspan="4"><button type="button" onclick="addNewFilter()" data-toggle="tooltip" title="Добавить фильтр" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
              </tr>
            </tfoot>
          </table>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
    $(document).on('focus', 'input[name=\'product_name\']', function() {
      var $self = $(this);
      var currentRow = $(this).closest('tr').data('row');

      $(this).autocomplete({
        source: function(request, response) {
          $.ajax({
            url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
            dataType: 'json',
            success: function(json) {
              response($.map(json, function(item) {
                return {
                  label: item['name'],
                  value: item['product_id']
                }
              }));
            }
          });
        },
        select: function(item) {
          $self.siblings('input[name=\'product_name\']').val('');
          $('#hits-product' + item['value']).remove();
          $self.siblings('#hits-product').append('<div id="hits-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="hits[' + currentRow + '][products][]" value="' + item['value'] + '" /></div>');
        }
      });
    });
    $(document).delegate('.fa-minus-circle', 'click', function() {
      $(this).parent().remove();
    });
//--></script></div>
<script>var hitsRow = <?php echo $hits ? count($hits) : 0; ?></script>
<script>
  function addNewFilter() {
    html = '<tr id="hits-filter' + hitsRow + '" data-row="' + hitsRow + '">' +
                '<td>' +
                  '<select name="hits[' + hitsRow + '][option_value]" class="form-control">' +
                    '<?php foreach ($options as $option) { ?>' +
                    '<option value="<?php echo $option['option_value']; ?>"><?php echo $option['option_name']; ?></option>' +
                    '<?php } ?>' +
                  '</select>' +
                '</td>' +
                '<td>' +
                '<input type="text" name="hits[' + hitsRow + '][classname]" value="" placeholder="icon-image" class="form-control" />' +
                '</td>' +
                '<td>' +
                  '<input type="text" name="product_name" value="" data-row="' + hitsRow + '" placeholder="<?php echo $entry_product; ?>" id="input-product" class="form-control" />' +
                  '<div id="hits-product" class="well well-sm" style="height: 150px; overflow: auto;">' +
                '</td>' +
                '<td class="text-left"><button type="button" onclick="$(\'#hits-filter' + hitsRow + ', .tooltip\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>' +
              '</tr>';
      $('#hits-filters').append(html);
      hitsRow++;
  }
</script>
<?php echo $footer; ?>
