<?php echo $header; ?><?php echo $column_left; ?> 
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-featured" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-featured" class="form-horizontal">
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
				<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
				<div class="col-sm-2">
					<div class="btn-group on-off" data-toggle="buttons">
						<label class="btn btn-default btn-on <?php echo $status == 1 ? 'active' : '' ?>">
							<input value="1" type="radio" name="status" id="status-1" autocomplete="off" <?php echo $status == 1 ? 'checked' : '' ?>>Вкл.
						</label>
						<label class="btn btn-default btn-off <?php echo $status == 0 ? 'active' : '' ?>">
							<input value="0" type="radio" name="status" id="status-0" autocomplete="off" <?php echo $status == 0 ? 'checked' : '' ?>>Откл.
						</label>
					</div>
				</div>	
				
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">Шаблон вывода</label>
				<div class="col-sm-2">
					<select name="view" class="form-control">
							<option value="" <?php echo $view == '' ? 'selected="selected"' : '' ?>>Табы</option>
							<option value="1" <?php echo $view == '1' ? 'selected="selected"' : '' ?>>Слайдер</option>
							<option value="2" <?php echo $view == '2' ? 'selected="selected"' : '' ?>>Сетка</option>
					</select>
				</div>
			</div>	
			<div class="form-group cell-lim" style="display:none">
				<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Только для шаблона вывода - Табы, Сетка" data-original-title="Только для шаблона вывода - Табы">Товаров в строке</span></label>
				<div class="col-sm-2">
					<select name="tp_limit" class="form-control">
							<option value="3" <?php echo $tp_limit == 3 ? 'selected="selected"' : '' ?>>3</option>
							<option value="4" <?php echo $tp_limit == 4 ? 'selected="selected"' : '' ?>>4</option>
							<option value="5" <?php echo $tp_limit == 5 ? 'selected="selected"' : '' ?>>5</option>
					</select>
				</div>
			</div>	
			<div class="table">
				<table id="lightshop_product_tabs" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
					  <td class="text-left">Название блока товаров</td>
					  <td class="text-left">Источник товаров</td>
					  <td class="text-left">Сортировка товаров</td>
					  <td class="text-left">Лимит товаров</td>
					  <td class="text-left">Порядок сортировки</td>
					  <td></td>
					</tr>
				</thead>
				<tbody>
				<?php $lightshop_product_tabs_row = 0; ?>
				<?php foreach ($theme_lightshop_product_tabs as $lightshop_product_tabs_row => $product_tab) { ?>
					<tr id="lightshop_product_tabs-row<?php echo $lightshop_product_tabs_row; ?>">
					<td class="text-left">
                			    <?php foreach ($languages as $language) { ?>
						<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="Russian"></span>
							<input type="text" name="theme_lightshop_product_tabs[<?php echo $lightshop_product_tabs_row; ?>][description][<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($theme_lightshop_product_tabs[$lightshop_product_tabs_row]['description'][$language['language_id']]) ? $theme_lightshop_product_tabs[$lightshop_product_tabs_row]['description'][$language['language_id']]['name'] : ''; ?>" placeholder="Название" class="form-control">
						</div>
                			    <?php } ?>
					</td>
					<td class="text-left">
						<select id="target-<?php echo $lightshop_product_tabs_row; ?>-0" name="theme_lightshop_product_tabs[<?php echo $lightshop_product_tabs_row; ?>][target]" class="form-control master-select-target" for="<?php echo $lightshop_product_tabs_row; ?>">
                    							<?php foreach ($theme_lightshop_product_tabs_targets as $key => $target) { ?>
                  								  <?php if ($key == $theme_lightshop_product_tabs[$lightshop_product_tabs_row]['target']) { ?>
                								    <option value="<?php echo $key; ?>" selected="selected"><?php echo $target; ?></option>
              									  <?php } else { ?>
                 								    <option value="<?php echo $key; ?>"><?php echo $target; ?></option>
                 								   <?php } ?>

                    							<?php } ?>

						</select>
						<div id="select-target-<?php echo $lightshop_product_tabs_row; ?>-1" <?php if($product_tab['target'] != '1') { ?>style="display:none;"<?php } ?> class="well-table select-target-<?php echo $lightshop_product_tabs_row; ?>">			
						  <input type="text" name="product_name" value="" placeholder="<?php echo $entry_product; ?>" for="<?php echo $lightshop_product_tabs_row; ?>" id="input-product" class="form-control" />
						  <div id="featured-product-<?php echo $lightshop_product_tabs_row; ?>-1" class="well well-sm">
						  	<?php if(isset($products[$lightshop_product_tabs_row])) { ?>
								<?php foreach ($products[$lightshop_product_tabs_row] as $product) { ?>
								<div id="featured-product-<?php echo $lightshop_product_tabs_row; ?>-<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
								  <input type="hidden" name="theme_lightshop_product_tabs[<?php echo $lightshop_product_tabs_row; ?>][products][]" value="<?php echo $product['product_id']; ?>" />
								</div>
								<?php } ?>
							<?php } ?>
						  </div>						
						</div>	
						<div id="select-target-<?php echo $lightshop_product_tabs_row; ?>-2" <?php  if($product_tab['target'] != '2') { ?>style="display:none;"<?php } ?> class="well-table select-target-<?php echo $lightshop_product_tabs_row; ?>">			
						  <input type="text" name="category_name" value="" placeholder="<?php echo $entry_category; ?>" for="<?php echo $lightshop_product_tabs_row; ?>" id="input-category" class="form-control" />
						  <div id="featured-category-<?php echo $lightshop_product_tabs_row; ?>-2" class="well well-sm">
						  	<?php if (isset($categories[$lightshop_product_tabs_row])) { ?>
								<?php foreach ($categories[$lightshop_product_tabs_row] as $category) { ?>
								<div id="featured-category-<?php echo $lightshop_product_tabs_row; ?>-<?php echo $category['category_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $category['name']; ?>
								  <input type="hidden" name="theme_lightshop_product_tabs[<?php echo $lightshop_product_tabs_row; ?>][categories][]" value="<?php echo $category['category_id']; ?>" />
								</div>
								<?php } ?>
							<?php } ?>
						  </div>						
						</div>							
					</td>
					<td class="text-left">
						<select id="sortorder" name="theme_lightshop_product_tabs[<?php echo $lightshop_product_tabs_row; ?>][sortorder]" class="form-control">
							<?php foreach ($sorts as $key => $sortOrder) { ?>
                  				<?php if ($key == $theme_lightshop_product_tabs[$lightshop_product_tabs_row]['sortorder']) { ?>
                					<option value="<?php echo $key; ?>" selected="selected"><?php echo $sortOrder; ?></option>
              					<?php } else { ?>
                 					<option value="<?php echo $key; ?>" ><?php echo $sortOrder; ?></option>
                 				<?php } ?>

                    		<?php } ?>
						</select>
					</td>
					<td class="text-left"><input type="text" name="theme_lightshop_product_tabs[<?php echo $lightshop_product_tabs_row; ?>][limit]" value="<?php echo $theme_lightshop_product_tabs[$lightshop_product_tabs_row]['limit']; ?>" placeholder="Лимит товаров" class="form-control"></td>
					<td class="text-left"><input type="text" name="theme_lightshop_product_tabs[<?php echo $lightshop_product_tabs_row; ?>][sort]" value="<?php echo $theme_lightshop_product_tabs[$lightshop_product_tabs_row]['sort']; ?>" placeholder="Сортировка" class="form-control"></td>
					<td class="text-right"><button type="button" onclick="$('#lightshop_product_tabs-row<?php echo $lightshop_product_tabs_row; ?>').remove();" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="Удалить"><i class="fa fa-minus-circle"></i></button></td>
					</tr>
				<?php $lightshop_product_tabs_row++; ?>	
				<?php } ?>
				</tbody>
				  <tfoot>
					<tr>
					  <td colspan="5"></td>
					  <td class="text-right">
					  <button type="button" onclick="addLinks();" data-toggle="tooltip" title="" class="btn addlinks btn-primary" data-original-title="Добавить ссылку"><i class="fa fa-plus-circle"></i></button>
					</td>
					</tr>
				  </tfoot>
				</table>
			  </div>
        </form>
      </div>
    </div>
  </div>
<script type="text/javascript"><!--
var lightshop_product_tabs_row = <?php echo $lightshop_product_tabs_row; ?>;

function addLinks() {

    html  = '<tr id="lightshop_product_tabs-row' + lightshop_product_tabs_row + '">';
	html += '  <td class="text-left">';
        	<?php foreach ($languages as $language) { ?>
	html += '  <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="Russian"></span>';
	html += '  <input type="text" name="theme_lightshop_product_tabs[' + lightshop_product_tabs_row + '][description][<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($theme_lightshop_product_tabs[$lightshop_product_tabs_row]['description'][$language['language_id']]) ? $theme_lightshop_product_tabs[$lightshop_product_tabs_row]['description'][$language['language_id']]['name'] : ''; ?>" placeholder="Название" class="form-control">';
	html += '  </div>';
                <?php } ?>
	html += '  </td>';
	html += '  <td class="text-left">';
	html += '  <select id="target-' + lightshop_product_tabs_row + '-0" name="theme_lightshop_product_tabs[' + lightshop_product_tabs_row + '][target]" class="form-control master-select-target" for="' + lightshop_product_tabs_row + '">';
		<?php foreach ($theme_lightshop_product_tabs_targets as $key => $target) { ?>
	html += '  <option value="<?php echo $key; ?>"><?php echo $target; ?></option>';
		<?php } ?>
	html += '  </select>';
	html += '  <div id="select-target-' + lightshop_product_tabs_row + '-1" style="display:none;" class="well-table select-target-' + lightshop_product_tabs_row + '">';
	html += '  <input type="text" name="product_name" value="" placeholder="<?php echo $entry_product; ?>" for="' + lightshop_product_tabs_row + '" id="input-product" class="form-control" />';
	html += '  <div id="featured-product-' + lightshop_product_tabs_row + '-1" class="well well-sm">';
	html += '  </div>';
	html += '  </div>';
	html += '  </div>';
	html += '  <div id="select-target-' + lightshop_product_tabs_row + '-2" style="display:none;" class="well-table select-target-' + lightshop_product_tabs_row + '">';
	html += '  <input type="text" name="category_name" value="" placeholder="<?php echo $entry_category; ?>" for="' + lightshop_product_tabs_row + '" id="input-category" class="form-control" />';
	html += '  <div id="featured-category-' + lightshop_product_tabs_row + '-2" class="well well-sm">';
	html += '  </div>';
	html += '  </div>';
	html += '  </div>';
	html += '  </td>';
	html += '  <td class="text-left">';
	html += '  <select id="sortorder" name="theme_lightshop_product_tabs[' + lightshop_product_tabs_row + '][sortorder]" class="form-control">';
		<?php foreach ($sorts as $key => $sortOrder) { ?>
	html += '  <option value="<?php echo $key; ?>" ><?php echo $sortOrder; ?></option>';
		<?php } ?>
	html += '  </select>';
	html += '  </td>';
	html += '  <td class="text-left">';
	html += '  <input type="text" name="theme_lightshop_product_tabs[' + lightshop_product_tabs_row + '][limit]" value="6" placeholder="Лимит товаров" class="form-control">';
	html += '  </td>';
	html += '  <td class="text-left">';
	html += '  <input type="text" name="theme_lightshop_product_tabs[' + lightshop_product_tabs_row + '][sort]" value="0" placeholder="Сортировка" class="form-control">';
	html += '  </td>';
	html += '  <td class="text-right"><button type="button" onclick="$(\'#lightshop_product_tabs-row' + lightshop_product_tabs_row + '\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
    html += '</tr>';

	$('#lightshop_product_tabs tbody').append(html);
	
	lightshop_product_tabs_row++;
	addAutocomplete();
}

//--></script>



  <script type="text/javascript"><!--


function addAutocomplete() {
  $('input[name=\'product_name\']').autocomplete({

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
		var row = $(this).attr('for');
		$('input[name=\'product_name\']').val('');
		
		$('#featured-product-' + row + '-' + item['value']).remove();
		
		$('#featured-product-' + row + '-1').append('<div id="featured-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="theme_lightshop_product_tabs['+ row +'][products][]" value="' + item['value'] + '" /></div>');	
	}
  });

  $('input[name=\'category_name\']').autocomplete({

	source: function(request, response) {

		$.ajax({
			url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['category_id']
					}
				}));
			}
		});
	},
	select: function(item) {
		var row = $(this).attr('for');

		$('input[name=\'category_name\']').val('');
		
		$('#featured-category-' + row + '-' + item['value']).remove();
		
		$('#featured-category-' + row + '-2').append('<div id="featured-category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="theme_lightshop_product_tabs['+ row +'][categories][]" value="' + item['value'] + '" /></div>');	
	}
  });
};

$(document).on('change', 'select[name=\'view\']', function() {
	var type = $('select[name=\'view\'] option:selected').val();
	if (type == 1) {
		$('.cell-lim').hide();
	}else{
		$('.cell-lim').show();
	}
});
	
$('.well-sm').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});

$('#lightshop_product_tabs').on('change','.master-select-target', function() {
	var row = $(this).attr('for');
console.log(row);
	$('.select-target-'+row).hide();
	var sel = $(this).val();
	$('#select-target-'+row+'-'+sel).show();
});

$(document).ready(function() {
	addAutocomplete();
	if ($('select[name=\'view\'] option:selected').val() != 1) {
		$('.cell-lim').show();
	}	
});
	
//--></script>


</div>
<?php echo $footer; ?>
