<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-slideshow" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-slideshow" class="form-horizontal">
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="input-status">Тип сетки</label>
				<div class="col-sm-2">
					<select name="column" class="form-control">
						<option value="4" <?php echo $column == '4' ? 'selected="selected"' : '' ?>>3 блока в ряд</option>
						<option value="3" <?php echo $column == '3' ? 'selected="selected"' : '' ?>>4 блока в ряд</option>       
					</select>
				</div>					
			</div>	
			<div class="form-group">
				<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
				<div class="col-sm-2">
					<div class="btn-group on-off" data-toggle="buttons">
						<label class="btn btn-default btn-on <?php echo $status == '1' ? 'active' : '' ?>">
							<input value="1" type="radio" name="status" id="status-1" autocomplete="off" <?php echo $status == '1' ? 'checked' : '' ?>>Вкл.
						</label>
						<label class="btn btn-default btn-off <?php echo $status == '0' ? 'active' : '' ?>">
							<input value="0" type="radio" name="status" id="status-0" autocomplete="off" <?php echo $status == '' ? 'checked' : '' ?>>Откл.
						</label>
					</div>
				</div>					
			</div>	
		<div class="form-group">
		<div class="col-sm-12">
          <ul class="nav nav-tabs" id="language">
            <?php foreach ($languages as $language) { ?>
            <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
            <?php } ?>
          </ul>		
		<div class="tab-content">
	      <?php $lightshop_categories_min_row = 0; ?>
            <?php foreach ($languages as $language) { ?>
            <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
              <table id="images<?php echo $language['language_id']; ?>" class="table table-striped table-bordered table-hover">
                <thead>
                  <tr>
                    <td class="text-center">Изображение</td>
                    <td class="text-left"><span data-toggle="tooltip" title="" data-original-title="Для широкого (ширина в 2 раза больше) блока задайте Ш изображения больше 400, а для высокого (высота в 2 раза больше) блока задайте В изображения больше 300">Размер картинки (Ш х В)</span></td>
                    <td class="text-left">Заголовок</td>
                    <td class="text-left">Ссылка</td>
                    <td class="text-left">Сортировка</td>
                    <td></td>
                  </tr>
                </thead>
                <tbody>
				<?php $lightshop_categories_min_row = 0; ?>
                  <?php if (isset($categories_min_images)) { ?>
                  <?php foreach ($categories_min_images as $lightshop_categories_min_row => $categories_min_image) {  ?> 
                  <tr id="image-row<?php echo $lightshop_categories_min_row; ?>">
                     <td class="text-center"><a href="" id="thumb-image-<?php echo $lightshop_categories_min_row; ?>-<?php echo $language['language_id']; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $categories_min_image['language'][$language['language_id']]['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="categories_min_image[<?php echo $lightshop_categories_min_row; ?>][language][<?php echo $language['language_id']; ?>][image]" value="<?php echo $categories_min_image['language'][$language['language_id']]['image']; ?>" id="input-image<?php echo $lightshop_categories_min_row; ?>-<?php echo $language['language_id']; ?>" /></td>
					 
				   <td class="text-left" style="width: 20%;">
				   <div class="row">
				   <div class="col-xs-6">
					<input type="text" name="categories_min_image[<?php echo $lightshop_categories_min_row; ?>][language][<?php echo $language['language_id']; ?>][width]" value="<?php echo isset($categories_min_image['language'][$language['language_id']]['width']) ? $categories_min_image['language'][$language['language_id']]['width'] : ''; ?>" placeholder="Ширина" class="form-control" />
					</div>
				   <div class="col-xs-6">
					<input type="text" name="categories_min_image[<?php echo $lightshop_categories_min_row; ?>][language][<?php echo $language['language_id']; ?>][height]" value="<?php echo isset($categories_min_image['language'][$language['language_id']]['height']) ? $categories_min_image['language'][$language['language_id']]['height'] : ''; ?>" placeholder="Высота" class="form-control" />
					</div>
				   <div class="col-xs-12">
					  <div class="checkbox" style="padding-left: 0;">
						<label>
						  <input name="categories_min_image[<?php echo $lightshop_categories_min_row; ?>][language][<?php echo $language['language_id']; ?>][full]" value="<?php echo isset($categories_min_image['language'][$language['language_id']]['full']) ? 1 : ''; ?>" type="checkbox" <?php echo isset($categories_min_image['language'][$language['language_id']]['full']) ? 'checked' : ''; ?>> Полноразмерное изображение
						</label>
					  </div>
					</div>
					</div>
				   
				   
				   </td>
				   
					<td class="text-left"><input type="text" name="categories_min_image[<?php echo $lightshop_categories_min_row; ?>][language][<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($categories_min_image['language'][$language['language_id']]) ? $categories_min_image['language'][$language['language_id']]['title'] : ''; ?>" placeholder="Заголовок" class="form-control" />
                     </td>
                   
				   <td class="text-left"><input type="text" name="categories_min_image[<?php echo $lightshop_categories_min_row; ?>][language][<?php echo $language['language_id']; ?>][link]" value="<?php echo isset($categories_min_image['language'][$language['language_id']]['link']) ? $categories_min_image['language'][$language['language_id']]['link'] : '' ; ?>" placeholder="Ссылка" class="form-control" /></td>

				   <td class="text-right" style="width: 10%;"><input type="text" name="categories_min_image[<?php echo $lightshop_categories_min_row; ?>][language][<?php echo $language['language_id']; ?>][sort_order]" value="<?php echo isset($categories_min_image['language'][$language['language_id']]['sort_order']) ? $categories_min_image['language'][$language['language_id']]['sort_order'] : ''; ?>" placeholder="Сортировка" class="form-control" /></td>
					
                    <td class="text-left"><button type="button" onclick="$('#image-row<?php echo $lightshop_categories_min_row; ?>, .tooltip').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                  </tr>

                  <?php } ?>
                  <?php } ?>
                </tbody>
                <tfoot>
                  <tr>
                    <td colspan="5"></td>
                    <td class="text-left"><button type="button" onclick="addImage('<?php echo $language['language_id']; ?>');" data-toggle="tooltip" title="Добавить" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                  </tr>
                </tfoot>
              </table>
            </div>
            <?php } ?>
			</div>
		</div>	
		</div>	
        </form>
      </div>
    </div>
  </div>
</div>
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
  
var lightshop_categories_min_row = <?php echo ++$lightshop_categories_min_row; ?>;

function addImage(language_id) {
	<?php foreach ($languages as $language) { ?>
	language_id = <?php echo $language['language_id']; ?>;
	html  = '<tr id="image-row' + lightshop_categories_min_row + '">';
	html += '  <td class="text-center"><a href="" id="thumb-image' + lightshop_categories_min_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="categories_min_image[' + lightshop_categories_min_row + '][language][' + language_id + '][image]" value="" id="input-image' + lightshop_categories_min_row + '" /></td>';	
	
	html += '  <td class="text-left" style="width: 20%;"><div class="row"><div class="col-xs-6"><input type="text" name="categories_min_image[' + lightshop_categories_min_row + '][language][' + language_id + '][width]" value="400" placeholder="Ширина" class="form-control" /></div><div class="col-xs-6"><input type="text" name="categories_min_image[' + lightshop_categories_min_row + '][language][' + language_id + '][height]" value="300" placeholder="Высота" class="form-control" /></div><div class="col-xs-12"><div class="checkbox" style="padding-left: 0;"><label><input name="categories_min_image[' + lightshop_categories_min_row + '][language][' + language_id + '][full]" value="" type="checkbox"> Полноразмерное изображение</label></div></div></div></td>';	
	
    html += '  <td class="text-left"><input type="text" name="categories_min_image[' + lightshop_categories_min_row + '][language][' + language_id + '][title]" value="" placeholder="Заголовок" class="form-control" /></td>';	

	html += '  <td class="text-left"><input type="text" name="categories_min_image[' + lightshop_categories_min_row + '][language][' + language_id + '][link]" value="" placeholder="Ссылка" class="form-control" /></td>';	

	html += '  <td class="text-right" style="width: 10%;"><input type="text" name="categories_min_image[' + lightshop_categories_min_row + '][language][' + language_id + '][sort_order]" value="" placeholder="Сортировка" class="form-control" /></td>';

	html += '  <td class="text-left"><button type="button" onclick="$(\'#image-row' + lightshop_categories_min_row  + ', .tooltip\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	
	html += '</tr>';
	
	$('#images' + language_id + ' tbody').append(html);
	<?php } ?>
	lightshop_categories_min_row++;
}
//--></script> 	
<?php echo $footer; ?>