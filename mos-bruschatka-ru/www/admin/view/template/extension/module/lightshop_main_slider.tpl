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
							  <label class="col-sm-2 control-label" for="input-image-related">Размер слайда (Ш x В)</label>
							  <div class="col-sm-10">
								<div class="row">
								<div class="col-sm-12">
								  <div class="alert alert-info" role="alert"><i class="fa fa-info-circle"></i> Ресайз изображений можно изменить стандартный opencart или Лайтшоп. При выборе опции Лайтшоп ресайз, изображения обрезаются по высоте и автоматически в пропорции по ширине.</div>
								</div>
								  <div class="col-sm-4">
									<input type="text" name="width" value="<?php echo $width; ?>" placeholder="Ширина" id="input-image-related" class="form-control"  />
			  <?php if ($error_width) { ?>
              <div class="text-danger"><?php echo $error_width; ?></div>
              <?php } ?>
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="height" value="<?php echo $height; ?>" placeholder="Высота" class="form-control" />
              <?php if ($error_height) { ?>
              <div class="text-danger"><?php echo $error_height; ?></div>
              <?php } ?>
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="resize" type="checkbox" value="1" <?php echo $resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
							  </div>
							</div>
							
			<div class="form-group">
				<label class="col-sm-2 control-label" for="input-img_link"><span data-toggle="tooltip" title="" data-original-title="Автоматически масштабировать изображение в пропорции (Ш x В), рекоментудется отключить лайтшоп ресайз. Отображение текста и кнопки на слайде будет скрыто.">Размер в пропорции</span></label>
				<div class="col-sm-10">
					<div class="row">
						<div class="col-sm-10">
							<label class="radio-inline"><input type="radio" name="resizable" value="1" <?php echo $resizable == 1 ? 'checked' : '' ?>> Да</label>
							<label class="radio-inline"><input type="radio" name="resizable" value="0" <?php echo $resizable == 0 ? 'checked' : '' ?>> Нет</label>
						</div>						
					</div>					
				</div>					
			</div>	
			
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-height">Автопролистывание</label>
            <div class="col-sm-10">
				<select name="autoplay" class="form-control">
					<option value="0" <?php echo $autoplay == '0' ? 'selected="selected"' : '' ?> >Отключено</option>
					<?php for ($i = 2; $i <= 10; $i++) { ?>
					<option value="<?php echo $i; ?>" <?php echo $autoplay == $i ? 'selected="selected"' : '' ?> >Включено, задержка <?php echo $i; ?> сек.</option>
					<?php } ?>     
				</select>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-height">Скорость листания</label>
            <div class="col-sm-10">
				<select name="speed" class="form-control">
					<?php for ($i = 1; $i <= 10; $i++) { ?>
					<option value="<?php echo $i; ?>" <?php echo $speed == $i ? 'selected="selected"' : '' ?> ><?php echo $i*100; ?> мс.</option>
					<?php } ?>     
				</select>
            </div>
          </div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="input-img_link">Клик по изображению</label>
				<div class="col-sm-2">
					<div class="btn-group on-off" data-toggle="buttons">
						<label class="btn btn-default btn-on <?php echo $img_link == 1 ? 'active' : '' ?>">
							<input value="1" type="radio" name="img_link" id="img_link-1" autocomplete="off" <?php echo $img_link == 1 ? 'checked' : '' ?>>Вкл.
						</label>
						<label class="btn btn-default btn-off <?php echo $img_link == 0 ? 'active' : '' ?>">
							<input value="0" type="radio" name="img_link" id="img_link-0" autocomplete="off" <?php echo $img_link == 0 ? 'checked' : '' ?>>Откл.
						</label>
					</div>
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
            <?php foreach ($languages as $language) { ?>
            <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
              <table id="images<?php echo $language['language_id']; ?>" class="table table-striped table-bordered table-hover">
                <thead>
                  <tr>
                    <td class="text-center">Изображение</td>
                    <td class="text-left">Заголовок</td>
                    <td class="text-left">Текст на слайде</td>
                    <td class="text-left">Текст на кнопке</td>
                    <td class="text-left">Ссылка</td>
                    <td class="text-left">Сортировка</td>
                    <td></td>
                  </tr>
                </thead>
                <tbody>
		<?php $lightshop_main_slider_row = 0; ?>
                  <?php if (isset($slider_images)) { ?>
                  <?php foreach ($slider_images as $lightshop_main_slider_row => $slider_image) {  ?> 
                  <tr id="image-row<?php echo $lightshop_main_slider_row; ?>">
                     <td class="text-center"><a href="" id="thumb-image-<?php echo $lightshop_main_slider_row; ?>-<?php echo $language['language_id']; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $slider_image['language'][$language['language_id']]['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="slider_image[<?php echo $lightshop_main_slider_row; ?>][language][<?php echo $language['language_id']; ?>][image]" value="<?php echo $slider_image['language'][$language['language_id']]['image']; ?>" id="input-image<?php echo $lightshop_main_slider_row; ?>-<?php echo $language['language_id']; ?>" /></td>
					<td class="text-left"><input type="text" name="slider_image[<?php echo $lightshop_main_slider_row; ?>][language][<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($slider_image['language'][$language['language_id']]) ? $slider_image['language'][$language['language_id']]['title'] : ''; ?>" placeholder="Заголовок" class="form-control" />
                      <?php if (isset($error_slider_image[$lightshop_main_slider_row][$language['language_id']])) { ?>
                      <div class="text-danger"><?php echo $error_slider_image[$lightshop_main_slider_row][$language['language_id']]; ?></div>
                      <?php } ?></td>
					  
					<td class="text-left"><input type="text" name="slider_image[<?php echo $lightshop_main_slider_row; ?>][language][<?php echo $language['language_id']; ?>][slider_text]" value="<?php echo isset($slider_image['language'][$language['language_id']]['slider_text']) ? $slider_image['language'][$language['language_id']]['slider_text'] : ''; ?>" placeholder="Текст на слайде" class="form-control" />
                      <?php if (isset($error_slider_image[$lightshop_main_slider_row][$language['language_id']])) { ?>
                      <div class="text-danger"><?php echo $error_slider_image[$lightshop_main_slider_row][$language['language_id']]; ?></div>
                      <?php } ?></td>
					<td class="text-left"><input type="text" name="slider_image[<?php echo $lightshop_main_slider_row; ?>][language][<?php echo $language['language_id']; ?>][btn_text]" value="<?php echo isset($slider_image['language'][$language['language_id']]['btn_text']) ? $slider_image['language'][$language['language_id']]['btn_text'] : ''; ?>" placeholder="Текст на кнопке" class="form-control" />
                      <?php if (isset($error_slider_image[$lightshop_main_slider_row][$language['language_id']])) { ?>
                      <div class="text-danger"><?php echo $error_slider_image[$lightshop_main_slider_row][$language['language_id']]; ?></div>
                      <?php } ?></td>
                    <td class="text-left"><input type="text" name="slider_image[<?php echo $lightshop_main_slider_row; ?>][language][<?php echo $language['language_id']; ?>][link]" value="<?php echo isset($slider_image['language'][$language['language_id']]['link']) ? $slider_image['language'][$language['language_id']]['link'] : '' ; ?>" placeholder="Ссылка" class="form-control" /></td>
                    <td class="text-right" style="width: 10%;"><input type="text" name="slider_image[<?php echo $lightshop_main_slider_row; ?>][language][<?php echo $language['language_id']; ?>][sort_order]" value="<?php echo isset($slider_image['language'][$language['language_id']]['sort_order']) ? $slider_image['language'][$language['language_id']]['sort_order'] : ''; ?>" placeholder="Сортировка" class="form-control" /></td>
                    <td class="text-left"><button type="button" onclick="$('#image-row<?php echo $lightshop_main_slider_row; ?>, .tooltip').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                  </tr>

                  <?php } ?>
                  <?php } ?>
                </tbody>
                <tfoot>
                  <tr>
                    <td colspan="6"></td>
                    <td class="text-left"><button type="button" onclick="addImage('<?php echo $language['language_id']; ?>');" data-toggle="tooltip" title="Добавить слайд" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
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
  
var lightshop_main_slider_row = <?php echo ++$lightshop_main_slider_row; ?>;

function addImage(language_id) {
	<?php foreach ($languages as $language) { ?>
	language_id = <?php echo $language['language_id']; ?>;
	html  = '<tr id="image-row' + lightshop_main_slider_row + '">';
	html += '  <td class="text-center"><a href="" id="thumb-image' + lightshop_main_slider_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="slider_image[' + lightshop_main_slider_row + '][language][' + language_id + '][image]" value="" id="input-image' + lightshop_main_slider_row + '" /></td>';	
    html += '  <td class="text-left"><input type="text" name="slider_image[' + lightshop_main_slider_row + '][language][' + language_id + '][title]" value="" placeholder="Заголовок" class="form-control" /></td>';	
    html += '  <td class="text-left"><input type="text" name="slider_image[' + lightshop_main_slider_row + '][language][' + language_id + '][slider_text]" value="" placeholder="Текст на слайде" class="form-control" /></td>';	
    html += '  <td class="text-left"><input type="text" name="slider_image[' + lightshop_main_slider_row + '][language][' + language_id + '][btn_text]" value="" placeholder="Текст на кнопке" class="form-control" /></td>';	
	html += '  <td class="text-left"><input type="text" name="slider_image[' + lightshop_main_slider_row + '][language][' + language_id + '][link]" value="" placeholder="Ссылка" class="form-control" /></td>';	
	html += '  <td class="text-right" style="width: 10%;"><input type="text" name="slider_image[' + lightshop_main_slider_row + '][language][' + language_id + '][sort_order]" value="" placeholder="Сортировка" class="form-control" /></td>';
	html += '  <td class="text-left"><button type="button" onclick="$(\'#image-row' + lightshop_main_slider_row  + ', .tooltip\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';
	
	$('#images' + language_id + ' tbody').append(html);
	<?php } ?>
	lightshop_main_slider_row++;
}
//--></script> 	
<?php echo $footer; ?>
