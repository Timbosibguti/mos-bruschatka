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
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-width"><?php echo $entry_width; ?></label>
            <div class="col-sm-10">
              <input type="text" name="width" value="<?php echo $width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control" />
              <?php if ($error_width) { ?>
              <div class="text-danger"><?php echo $error_width; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
            <div class="col-sm-10">
              <input type="text" name="height" value="<?php echo $height; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control" />
              <?php if ($error_height) { ?>
              <div class="text-danger"><?php echo $error_height; ?></div>
              <?php } ?>
            </div>
          </div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="input-title">Заголовок модуля</label>
					<div class="col-sm-10">
						<?php foreach ($languages as $language) { ?>
						<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
						<input type="text" name="title<?php echo $language['language_id']; ?>" value="<?php echo !empty(${'title' . $language['language_id']}) ? ${'title' . $language['language_id']} : ''; ?>" placeholder="Заголовок модуля" id="input-title<?php echo $language['language_id']; ?>" class="form-control" />
						</div>
						<?php } ?>
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
	      <?php $lightshop_brands_row = 0; ?>
            <?php foreach ($languages as $language) { ?>
            <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
              <table id="images<?php echo $language['language_id']; ?>" class="table table-striped table-bordered table-hover">
                <thead>
                  <tr>
                    <td class="text-center">Изображение</td>
                    <td class="text-left">Заголовок (title, alt)</td>

                    <td class="text-left">Ссылка</td>

                    <td class="text-left">Сортировка</td>
                    <td></td>
                  </tr>
                </thead>
               <tbody>
				<?php $lightshop_brands_row = 0; ?>
                  <?php if (isset($brands_images)) { ?>
                  <?php foreach ($brands_images as $lightshop_brands_row => $brands_image) {  ?> 
                  <tr id="image-row<?php echo $lightshop_brands_row; ?>">
                     <td class="text-center"><a href="" id="thumb-image-<?php echo $lightshop_brands_row; ?>-<?php echo $language['language_id']; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $brands_image['language'][$language['language_id']]['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="brands_image[<?php echo $lightshop_brands_row; ?>][language][<?php echo $language['language_id']; ?>][image]" value="<?php echo $brands_image['language'][$language['language_id']]['image']; ?>" id="input-image<?php echo $lightshop_brands_row; ?>-<?php echo $language['language_id']; ?>" /></td>
					 
					<td class="text-left"><input type="text" name="brands_image[<?php echo $lightshop_brands_row; ?>][language][<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($brands_image['language'][$language['language_id']]) ? $brands_image['language'][$language['language_id']]['title'] : ''; ?>" placeholder="Заголовок" class="form-control" />
                     </td>

				   <td class="text-left"><input type="text" name="brands_image[<?php echo $lightshop_brands_row; ?>][language][<?php echo $language['language_id']; ?>][link]" value="<?php echo isset($brands_image['language'][$language['language_id']]['link']) ? $brands_image['language'][$language['language_id']]['link'] : '' ; ?>" placeholder="Ссылка" class="form-control" /></td>
				   
				   <td class="text-right" style="width: 10%;"><input type="text" name="brands_image[<?php echo $lightshop_brands_row; ?>][language][<?php echo $language['language_id']; ?>][sort_order]" value="<?php echo isset($brands_image['language'][$language['language_id']]['sort_order']) ? $brands_image['language'][$language['language_id']]['sort_order'] : ''; ?>" placeholder="Сортировка" class="form-control" /></td>
					
                    <td class="text-left"><button type="button" onclick="$('#image-row<?php echo $lightshop_brands_row; ?>, .tooltip').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                  </tr>

                  <?php } ?>
                  <?php } ?>
                </tbody>

                <tfoot>
                  <tr>
                    <td colspan="4"></td>
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

var lightshop_brands_row = <?php echo ++$lightshop_brands_row; ?>;

function addImage(language_id) {
	<?php foreach ($languages as $language) { ?>
	language_id = <?php echo $language['language_id']; ?>;
	html  = '<tr id="image-row' + lightshop_brands_row + '">';
	html += '  <td class="text-center"><a href="" id="thumb-image' + lightshop_brands_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="brands_image[' + lightshop_brands_row + '][language][' + language_id + '][image]" value="" id="input-image' + lightshop_brands_row + '" /></td>';	
    html += '  <td class="text-left"><input type="text" name="brands_image[' + lightshop_brands_row + '][language][' + language_id + '][title]" value="" placeholder="Заголовок" class="form-control" /></td>';	
	
	html += '  <td class="text-left"><input type="text" name="brands_image[' + lightshop_brands_row + '][language][' + language_id + '][link]" value="" placeholder="Ссылка" class="form-control" /></td>';	

	
	html += '  <td class="text-right" style="width: 10%;"><input type="text" name="brands_image[' + lightshop_brands_row + '][language][' + language_id + '][sort_order]" value="" placeholder="Сортировка" class="form-control" /></td>';

	html += '  <td class="text-left"><button type="button" onclick="$(\'#image-row' + lightshop_brands_row  + ', .tooltip\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';
	
	$('#images' + language_id + ' tbody').append(html);
	<?php } ?>	
	lightshop_brands_row++;
}
//--></script> 	
<?php echo $footer; ?>