<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
      	<?php if ($store_total && !$store_id) { ?>
		<button type="text" data-toggle="modal" data-target="#copyalert" title="<?php echo $button_copy; ?>" class="btn btn-primary" style="background: #343434;border-color: #000000;"><i class="fa fa-save"></i></button>
      	<?php } ?>
        <button type="submit" form="form-theme-lightshop" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>  
  </div>
	<div class="modal fade" id="copyalert" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">Копировать настройки основного магазина на мультимагазины?</h4>
		  </div>
		  <div class="modal-body">
			<p>Копировать настройки основного магазина на мультимагазины?</p>
		  </div>
		  <div class="modal-footer">
			<button type="button" class="btn btn-default yes" data-dismiss="modal" id="storecopy">Да</button>
			<button type="button" class="btn btn-primary no" data-dismiss="modal">Отмена</button>
		  </div>
		</div>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-theme-lightshop" class="form-horizontal">

			<ul class="nav nav-tabs">
				<li class="active"><a href="#tab-general" data-toggle="tab">Общие</a></li>
				<li><a href="#tab-header" data-toggle="tab">Верх сайта</a></li>				
				<li><a href="#tab-home" data-toggle="tab">Контент</a></li>				
				<li><a href="#tab-footer" data-toggle="tab">Низ сайта</a></li>				
				<li><a href="#tab-widgets" data-toggle="tab">Виджеты</a></li>				
				<li><a href="#tab-info" data-toggle="tab" <?php if ($new_version) { ?>class="tab-new"<?php } ?>>О шаблоне</a></li>				
			</ul>

		<div class="tab-content">
            <div class="tab-pane active" id="tab-general">
			
				<div class="tabbable tabs-left">
					<ul id="vtab-option" class="nav nav-tabs">					
						<li class="active"><a href="#tab-left-config" data-toggle="tab">Настройка</a></li>
						<li><a href="#tab-left-image" data-toggle="tab">Размеры картинок</a></li>
						<li><a href="#tab-left-color" data-toggle="tab">Цветовая схема</a></li>
						<li><a href="#tab-left-css-js" data-toggle="tab">Для разработчиков</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-left-config">
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-directory"><span data-toggle="tooltip" title="<?php echo $help_directory; ?>"><?php echo $entry_directory; ?></span></label>
							  <div class="col-sm-10">
								<select name="theme_lightshop_directory" id="input-directory" class="form-control">
								  <?php foreach ($directories as $directory) { ?>
								  <?php if ($directory == $theme_lightshop_directory) { ?>
								  <option value="<?php echo $directory; ?>" selected="selected"><?php echo $directory; ?></option>
								  <?php } else { ?>
								  <option value="<?php echo $directory; ?>"><?php echo $directory; ?></option>
								  <?php } ?>
								  <?php } ?>
								</select>
							  </div>							  
							</div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
							  <div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo $theme_lightshop_status == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_status" id="theme_lightshop_status_1" autocomplete="off" <?php echo $theme_lightshop_status == '1' ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo $theme_lightshop_status == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_status" id="theme_lightshop_status_0" autocomplete="off" <?php echo $theme_lightshop_status == '0' ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							  </div>							  
							</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-theme_lightshop_phone_1">Номер телефона 1</label>
							<div class="col-sm-10">
								<?php foreach ($languages as $language) { ?>
									<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
									<input type="text" name="theme_lightshop_phone_1<?php echo $language['language_id']; ?>" value="<?php echo !empty(${'theme_lightshop_phone_1' . $language['language_id']}) ? ${'theme_lightshop_phone_1' . $language['language_id']} : ''; ?>" placeholder="Номер телефона 1" id="input-theme_lightshop_phone_1<?php echo $language['language_id']; ?>" class="form-control" />
									</div>
								<?php } ?>
							</div>		
						</div>
						<div class="form-group">	
							<label class="col-sm-2 control-label" for="input-theme_lightshop_phone_2">Номер телефона 2</label>
							<div class="col-sm-10">
								<?php foreach ($languages as $language) { ?>
									<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
									<input type="text" name="theme_lightshop_phone_2<?php echo $language['language_id']; ?>" value="<?php echo !empty(${'theme_lightshop_phone_2' . $language['language_id']}) ? ${'theme_lightshop_phone_2' . $language['language_id']} : ''; ?>" placeholder="Номер телефона 2" id="input-theme_lightshop_phone_2<?php echo $language['language_id']; ?>" class="form-control" />
									</div>
								<?php } ?>
							</div>	
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-theme_lightshop_schema"><span data-toggle="tooltip" title="" data-original-title="Schema.org — это стандарт семантической разметки данных в сети, объявленный поисковыми системами Google, Bing и Yahoo! летом 2011 года. Цель семантической разметки – сделать интернет более понятным, структурированным и облегчить поисковым системам и специальным программам извлечение и обработку информации для удобного её представления в результатах поиска.">Разметка Schema.org</span> </label>
							<div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo $theme_lightshop_schema == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_schema" id="theme_lightshop_schema-1" autocomplete="off" <?php echo $theme_lightshop_schema == '1' ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo $theme_lightshop_schema == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_schema" id="theme_lightshop_schema-0" autocomplete="off" <?php echo $theme_lightshop_schema == '0' ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							</div>	
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-theme_lightshop_og"><span data-toggle="tooltip" title="" data-original-title="Стандарт Open Graph разработан социальной сетью Facebook. Он позволяет контролировать превью, которое формируется при публикации ссылки на сайт в социальных сетях, и передавать информацию другим интернет-сервисам. Разметку Open Graph используют Facebook, Вконтакте, Google+, Twitter, LinkedIn, Pinterest и другие сервисы.">Разметка Open Graph</span></label>
							<div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo $theme_lightshop_og == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_og" id="theme_lightshop_og-1" autocomplete="off" <?php echo $theme_lightshop_og == '1' ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo $theme_lightshop_og == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_og" id="theme_lightshop_og-0" autocomplete="off" <?php echo $theme_lightshop_og == '0' ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							</div>	
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Индикатор загрузки контента сайта, рекомендуется использовать если вывод .css и .js кода в положении - Внизу сайта">Индикатор загрузки</span></label>
							<div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo $theme_lightshop_preloader == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_preloader" id="theme_lightshop_preloader-1" autocomplete="off" <?php echo $theme_lightshop_preloader == '1' ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo $theme_lightshop_preloader == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_preloader" id="theme_lightshop_preloader-0" autocomplete="off" <?php echo $theme_lightshop_preloader == '0' ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							</div>	
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Максимальная ширина сайта в ПК версии, фиксированное значение или автоматическое в процентнах.">Ширина сайта</span></label>
							<div class="col-sm-10">
								<select id="" name="theme_lightshop_container_width" class="form-control">
									<optgroup label="Фиксированная">
										<option value="0" <?php echo $theme_lightshop_container_width == 0 ? 'selected="selected"' : '' ?>>1200px (по умолчанию)</option>
										<option value="1600px" <?php echo $theme_lightshop_container_width == '1600px' ? 'selected="selected"' : '' ?>>1600px</option>
									</optgroup>
									<optgroup label="Автоматическая">
										<option value="80%" <?php echo $theme_lightshop_container_width == '80%' ? 'selected="selected"' : '' ?>>80%</option>
										<option value="85%" <?php echo $theme_lightshop_container_width == '85%' ? 'selected="selected"' : '' ?>>85%</option>
										<option value="90%" <?php echo $theme_lightshop_container_width == '90%' ? 'selected="selected"' : '' ?>>90%</option>
										<option value="95%" <?php echo $theme_lightshop_container_width == '95%' ? 'selected="selected"' : '' ?>>95%</option>
									</optgroup>
								</select>
							</div>
						</div>		
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-theme_lightshop_google_site_verification">Мета-тег google-site-verification</label>
							<div class="col-sm-10">
								<div class="input-group">
								  <div class="input-group-addon code">&lt;meta name='google-site-verification' content='</div>
									<input type="text" name="theme_lightshop_google_site_verification" value="<?php echo $theme_lightshop_google_site_verification; ?>" placeholder="XXXXXXXXXXXXXX" id="input-theme_lightshop_google_site_verification" class="form-control code" />
								  <div class="input-group-addon code">'&gt;</div>
								</div>	
							</div>
						</div>	
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-theme_lightshop_yandex_verification">Мета-тег yandex-verification</label>
							<div class="col-sm-10">								
								<div class="input-group">
								  <div class="input-group-addon code">&lt;meta name='yandex-verification' content='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
									<input type="text" name="theme_lightshop_yandex_verification" value="<?php echo $theme_lightshop_yandex_verification; ?>" placeholder="XXXXXXXXXXXXXX" id="input-theme_lightshop_yandex_verification" class="form-control code" />
								  <div class="input-group-addon code">'&gt;</div>
								</div>								
							</div>
						</div>						
						</div>
						<div class="tab-pane" id="tab-left-image">
						<div class="alert alert-info" role="alert"><i class="fa fa-info-circle"></i> Ресайз изображений можно изменить стандартный opencart или Лайтшоп. При выборе опции Лайтшоп ресайз, изображения обрезаются по высоте и автоматически в пропорции по ширине.</div> 
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-category-width"><?php echo $entry_image_category; ?></label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_category_width" value="<?php echo $theme_lightshop_image_category_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-category-width" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_category_height" value="<?php echo $theme_lightshop_image_category_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control"  />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_category_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_category_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_category) { ?>
								<div class="text-danger"><?php echo $error_image_category; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-thumb-width"><?php echo $entry_image_thumb; ?></label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_thumb_width" value="<?php echo $theme_lightshop_image_thumb_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-thumb-width" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_thumb_height" value="<?php echo $theme_lightshop_image_thumb_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_thumb_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_thumb_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_thumb) { ?>
								<div class="text-danger"><?php echo $error_image_thumb; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-popup-width"><?php echo $entry_image_popup; ?></label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_popup_width" value="<?php echo $theme_lightshop_image_popup_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-popup-width" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_popup_height" value="<?php echo $theme_lightshop_image_popup_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_popup_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_popup_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_popup) { ?>
								<div class="text-danger"><?php echo $error_image_popup; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-product-width"><?php echo $entry_image_product; ?></label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_product_width" value="<?php echo $theme_lightshop_image_product_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-product-width" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_product_height" value="<?php echo $theme_lightshop_image_product_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_product_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_product_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_product) { ?>
								<div class="text-danger"><?php echo $error_image_product; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-additional-width"><?php echo $entry_image_additional; ?></label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_additional_width" value="<?php echo $theme_lightshop_image_additional_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-additional-width" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_additional_height" value="<?php echo $theme_lightshop_image_additional_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_additional_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_additional_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_additional) { ?>
								<div class="text-danger"><?php echo $error_image_additional; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-related"><?php echo $entry_image_related; ?></label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_related_width" value="<?php echo $theme_lightshop_image_related_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-related" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_related_height" value="<?php echo $theme_lightshop_image_related_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_related_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_related_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_related) { ?>
								<div class="text-danger"><?php echo $error_image_related; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-compare"><?php echo $entry_image_compare; ?></label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_compare_width" value="<?php echo $theme_lightshop_image_compare_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-compare" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_compare_height" value="<?php echo $theme_lightshop_image_compare_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_compare_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_compare_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_compare) { ?>
								<div class="text-danger"><?php echo $error_image_compare; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-wishlist"><?php echo $entry_image_wishlist; ?></label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_wishlist_width" value="<?php echo $theme_lightshop_image_wishlist_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-wishlist" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_wishlist_height" value="<?php echo $theme_lightshop_image_wishlist_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_wishlist_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_wishlist_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_wishlist) { ?>
								<div class="text-danger"><?php echo $error_image_wishlist; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-cart"><?php echo $entry_image_cart; ?></label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_cart_width" value="<?php echo $theme_lightshop_image_cart_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_cart_height" value="<?php echo $theme_lightshop_image_cart_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_cart_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_cart_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_cart) { ?>
								<div class="text-danger"><?php echo $error_image_cart; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-cart">Подменю категории (Ш x В)</label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_main_rec_width" value="<?php echo $theme_lightshop_image_main_rec_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_main_rec_height" value="<?php echo $theme_lightshop_image_main_rec_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_main_rec_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_main_rec_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_main_rec) { ?>
								<div class="text-danger"><?php echo $error_image_main_rec; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-cart">Окно быстрого просмотра (Ш x В)</label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_product_detail_width" value="<?php echo $theme_lightshop_image_product_detail_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_product_detail_height" value="<?php echo $theme_lightshop_image_product_detail_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_product_detail_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_product_detail_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_product_detail) { ?>
								<div class="text-danger"><?php echo $error_image_product_detail; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-cart">Категория блога (Ш x В)</label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_blog_cat_width" value="<?php echo $theme_lightshop_image_blog_cat_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_blog_cat_height" value="<?php echo $theme_lightshop_image_blog_cat_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_blog_cat_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_blog_cat_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_blog_cat) { ?>
								<div class="text-danger"><?php echo $error_image_blog_cat; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-cart">Статья блога (Ш x В)</label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_blog_item_width" value="<?php echo $theme_lightshop_image_blog_item_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_blog_item_height" value="<?php echo $theme_lightshop_image_blog_item_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_blog_item_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_blog_item_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_blog_item) { ?>
								<div class="text-danger"><?php echo $error_image_blog_item; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-cart">Рекомендуемые статьи блога (Ш x В)</label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_blog_related_width" value="<?php echo $theme_lightshop_image_blog_related_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control"  />
								  </div>
								  <div class="col-sm-4">
									<input type="text" name="theme_lightshop_image_blog_related_height" value="<?php echo $theme_lightshop_image_blog_related_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
									<div class="col-sm-4">
										<div class="checkbox">
											<label><input name="theme_lightshop_image_blog_related_resize" type="checkbox" value="1" <?php echo $theme_lightshop_image_blog_related_resize ? 'checked="checked"' : '' ?>> Лайтшоп ресайз</label>
										</div>
									</div>
								</div>
								<?php if ($error_image_blog_related) { ?>
								<div class="text-danger"><?php echo $error_image_blog_related; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-3 control-label" for="input-image-location"><?php echo $entry_image_location; ?></label>
							  <div class="col-sm-9">
								<div class="row">
								  <div class="col-sm-6">
									<input type="text" name="theme_lightshop_image_location_width" value="<?php echo $theme_lightshop_image_location_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-location" class="form-control"  />
								  </div>
								  <div class="col-sm-6">
									<input type="text" name="theme_lightshop_image_location_height" value="<?php echo $theme_lightshop_image_location_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
								  </div>
								</div>
								<?php if ($error_image_location) { ?>
								<div class="text-danger"><?php echo $error_image_location; ?></div>
								<?php } ?>
							  </div>
							</div>
						</div>
						<div class="tab-pane" id="tab-left-color">
						<fieldset>
							<legend>Основные цвета</legend>
							<div class="form-group">
									<div class="col-sm-3">
										<label class="radio"><input type="radio" name="theme_lightshop_color" value="" <?php echo $theme_lightshop_color == '' ? 'checked="checked"' : '' ?> > 
										По умолчанию <br/>
											<div class="theme-color thumbnail color-0">
												<div class="main-color"></div>
												<div class="secondary-color"></div>
											</div>
										</label>
									</div>
									<div class="col-sm-3">
										<label class="radio"><input type="radio" name="theme_lightshop_color" value="1" <?php echo $theme_lightshop_color == '1' ? 'checked="checked"' : '' ?> > 
										Схема 1 <br/>
											<div class="theme-color thumbnail color-1">
												<div class="main-color"></div>
												<div class="secondary-color"></div>
											</div>
										</label>
									</div>
									<div class="col-sm-3">
										<label class="radio"><input type="radio" name="theme_lightshop_color" value="2" <?php echo $theme_lightshop_color == '2' ? 'checked="checked"' : '' ?> > 
										Схема 2 <br/>
											<div class="theme-color thumbnail color-2">
												<div class="main-color"></div>
												<div class="secondary-color"></div>
											</div>
										</label>
									</div>
									<div class="col-sm-3">
										<label class="radio"><input type="radio" name="theme_lightshop_color" value="3" <?php echo $theme_lightshop_color == '3' ? 'checked="checked"' : '' ?> > 
										Схема 3 <br/>
											<div class="theme-color thumbnail color-3">
												<div class="main-color"></div>
												<div class="secondary-color"></div>
											</div>
										</label>
									</div>
									<div class="col-sm-3">
										<label class="radio"><input type="radio" name="theme_lightshop_color" value="4" <?php echo $theme_lightshop_color == '4' ? 'checked="checked"' : '' ?> > 
										Схема 4 <br/>
											<div class="theme-color thumbnail color-4">
												<div class="main-color"></div>
												<div class="secondary-color"></div>
											</div>
										</label>
									</div>
									<div class="col-sm-3">
										<label class="radio"><input type="radio" name="theme_lightshop_color" value="5" <?php echo $theme_lightshop_color == '5' ? 'checked="checked"' : '' ?> > 
										Схема 5 <br/>
											<div class="theme-color thumbnail color-5">
												<div class="main-color"></div>
												<div class="secondary-color"></div>
											</div>
										</label>
									</div>
									<div class="col-sm-3">
										<label class="radio"><input type="radio" name="theme_lightshop_color" value="6" <?php echo $theme_lightshop_color == '6' ? 'checked="checked"' : '' ?> > 
										Произвольная схема<br/>
											<div class="theme-color thumbnail color-5">
												<div class=""><input name="theme_lightshop_custom_color_1" class="jscolor main-color" value="<?php echo $theme_lightshop_custom_color_1; ?>"></div>
												<div class=""><input name="theme_lightshop_custom_color_2" class="jscolor secondary-color" value="<?php echo $theme_lightshop_custom_color_2; ?>"></div>
											</div>
										</label>
									</div>
							</div>	
						</fieldset>	
						<fieldset>
							<legend>Верх и низ сайта</legend>
								<div class="form-group">
									<div class="col-sm-3">
										<label class="radio"><input type="radio" name="theme_lightshop_color_2" value="" <?php echo $theme_lightshop_color_2 == '' ? 'checked="checked"' : '' ?> > 
										По умолчанию <br/>
											<div class="theme-color thumbnail four-colors">
												<div class="main-color main-color--1"></div>
												<div class="main-color main-color--2"></div>
												<div class="secondary-color secondary-color--1"></div>
												<div class="secondary-color secondary-color--2"></div>
											</div>
										</label>
									</div>
									<div class="col-sm-3">
										<label class="radio"><input type="radio" name="theme_lightshop_color_2" value="1" <?php echo $theme_lightshop_color_2 == '1' ? 'checked="checked"' : '' ?> > 
										Произвольная схема<br/>
											<div class="theme-color thumbnail four-colors">
												<div class=""><input name="theme_lightshop_custom_fc_color_1" class="jscolor main-color" value="<?php echo $theme_lightshop_custom_fc_color_1; ?>"></div>
												<div class=""><input name="theme_lightshop_custom_fc_color_2" class="jscolor main-color" value="<?php echo $theme_lightshop_custom_fc_color_2; ?>"></div>
												<div class=""><input name="theme_lightshop_custom_fc_color_3" class="jscolor secondary-color" value="<?php echo $theme_lightshop_custom_fc_color_3; ?>"></div>
												<div class=""><input name="theme_lightshop_custom_fc_color_4" class="jscolor secondary-color" value="<?php echo $theme_lightshop_custom_fc_color_4; ?>"></div>
											</div>
										</label>
									</div>
								</div>
						</fieldset>	
						
						
						
						</div>
						<div class="tab-pane" id="tab-left-css-js">
						<fieldset>
							<legend>Пользовательские скрипты</legend>
							<div class="form-group">
							  <label class="col-sm-2 control-label">css</label>
							  <div class="col-sm-10">
								<textarea name="theme_lightshop_css" rows="25" placeholder="css" id="theme_lightshop_css" class="form-control code"><?php echo $theme_lightshop_css; ?></textarea>
							  </div>
							</div>	
							<div class="form-group">
							  <label class="col-sm-2 control-label">js</label>
							  <div class="col-sm-10">
								<textarea name="theme_lightshop_js" rows="25" placeholder="js" id="theme_lightshop_js" class="form-control code"><?php echo $theme_lightshop_js; ?></textarea>
							  </div>
							</div>	
						</fieldset>	
						<fieldset>
							<legend>Основные скрипты</legend>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Вывод css и js скриптов. Для совместимости со сторонними дополнениями, рекомендуется положение - Вверху сайта">Вывод css и js скриптов</span></label>
								<div class="col-sm-10">
									<label class="radio-inline"><input type="radio" name="theme_lightshop_js_footorhead" value="1" <?php echo $theme_lightshop_js_footorhead == '1' ? 'checked' : '' ?>> Вверху сайта</label>
									<label class="radio-inline"><input type="radio" name="theme_lightshop_js_footorhead" value="2" <?php echo $theme_lightshop_js_footorhead == '2' ? 'checked' : '' ?>> Внизу сайта</label>
								</div>	
							</div>	
						</fieldset>	
						<fieldset>
							<legend>Дополнительные компоненты</legend>
							<div class="form-group">
								<div class="col-sm-6">
									<label class="col-sm-8 control-label"><span class="tooltip-custom" title="Включите, если стороннее дополенение использует <a href='https://getbootstrap.com/docs/3.3/javascript/#modals' target='_blank'>bootstrap: modal</a>">bootstrap: modal</span></label>
									<div class="col-sm-4">
										<div class="btn-group on-off" data-toggle="buttons">
											<label class="btn btn-default btn-on <?php echo $theme_lightshop_bootstrap_modal == '1' ? 'active' : '' ?>">
												<input value="1" type="radio" name="theme_lightshop_bootstrap_modal" id="theme_lightshop_bootstrap_modal-1" autocomplete="off" <?php echo $theme_lightshop_bootstrap_modal == '1' ? 'checked' : '' ?>>Вкл.
											</label>
											<label class="btn btn-default btn-off <?php echo $theme_lightshop_bootstrap_modal == '0' ? 'active' : '' ?>">
												<input value="0" type="radio" name="theme_lightshop_bootstrap_modal" id="theme_lightshop_bootstrap_modal-0" autocomplete="off" <?php echo $theme_lightshop_bootstrap_modal == '0' ? 'checked' : '' ?>>Откл.
											</label>
										</div>
									</div>	
								</div>	
								<div class="col-sm-6">
									<label class="col-sm-8 control-label"><span class="tooltip-custom" title="Включите, если стороннее дополенение использует <a href='https://getbootstrap.com/docs/3.3/javascript/#tooltips' target='_blank'>bootstrap: tooltip</a> или <a href='https://getbootstrap.com/docs/3.3/javascript/#popovers' target='_blank'>bootstrap: popover</a>">bootstrap: tooltip, popover</span></label>
									<div class="col-sm-4">
										<div class="btn-group on-off" data-toggle="buttons">
											<label class="btn btn-default btn-on <?php echo $theme_lightshop_bootstrap_ttpo == '1' ? 'active' : '' ?>">
												<input value="1" type="radio" name="theme_lightshop_bootstrap_ttpo" id="theme_lightshop_bootstrap_ttpo-1" autocomplete="off" <?php echo $theme_lightshop_bootstrap_ttpo == '1' ? 'checked' : '' ?>>Вкл.
											</label>
											<label class="btn btn-default btn-off <?php echo $theme_lightshop_bootstrap_ttpo == '0' ? 'active' : '' ?>">
												<input value="0" type="radio" name="theme_lightshop_bootstrap_ttpo" id="theme_lightshop_bootstrap_ttpo-0" autocomplete="off" <?php echo $theme_lightshop_bootstrap_ttpo == '0' ? 'checked' : '' ?>>Откл.
											</label>
										</div>
									</div>	
								</div>	
							</div>	
							<div class="form-group">
								<div class="col-sm-6">
									<label class="col-sm-8 control-label"><span class="tooltip-custom" title="Включите, если стороннее дополенение использует <a href='https://getbootstrap.com/docs/3.3/javascript/#tabs' target='_blank'>bootstrap: tabs</a>">bootstrap: tabs</span></label>
									<div class="col-sm-4">
										<div class="btn-group on-off" data-toggle="buttons">
											<label class="btn btn-default btn-on <?php echo $theme_lightshop_bootstrap_tabs == '1' ? 'active' : '' ?>">
												<input value="1" type="radio" name="theme_lightshop_bootstrap_tabs" id="theme_lightshop_bootstrap_tabs-1" autocomplete="off" <?php echo $theme_lightshop_bootstrap_tabs == '1' ? 'checked' : '' ?>>Вкл.
											</label>
											<label class="btn btn-default btn-off <?php echo $theme_lightshop_bootstrap_tabs == '0' ? 'active' : '' ?>">
												<input value="0" type="radio" name="theme_lightshop_bootstrap_tabs" id="theme_lightshop_bootstrap_tabs-0" autocomplete="off" <?php echo $theme_lightshop_bootstrap_tabs == '0' ? 'checked' : '' ?>>Откл.
											</label>
										</div>
									</div>	
								</div>	
								<div class="col-sm-6">
									<label class="col-sm-8 control-label">bootstrap:  button, collapse, transition</label>
									<div class="col-sm-4">
										<div class="btn-group on-off" data-toggle="buttons" style="pointer-events: none;">
											<label class="btn btn-default btn-on active disabled">
												<input value="1" type="radio" name="" id="" autocomplete="off" checked>Вкл.
											</label>
											<label class="btn btn-default btn-off disabled">
												<input value="0" type="radio" name="" id="" autocomplete="off">Откл.
											</label>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-6">
									<label class="col-sm-8 control-label"><span class="tooltip-custom" title="Включите, если стороннее дополенение использует иконки <a href='https://fontawesome.com/icons?d=gallery&m=free' target='_blank'>fontawesome</a>">Иконки fontawesome</span></label>
									<div class="col-sm-4">
										<div class="btn-group on-off" data-toggle="buttons">
											<label class="btn btn-default btn-on <?php echo $theme_lightshop_fontawesome == '1' ? 'active' : '' ?>">
												<input value="1" type="radio" name="theme_lightshop_fontawesome" id="theme_lightshop_fontawesome-1" autocomplete="off" <?php echo $theme_lightshop_fontawesome == '1' ? 'checked' : '' ?>>Вкл.
											</label>
											<label class="btn btn-default btn-off <?php echo $theme_lightshop_fontawesome == '0' ? 'active' : '' ?>">
												<input value="0" type="radio" name="theme_lightshop_fontawesome" id="theme_lightshop_fontawesome-0" autocomplete="off" <?php echo $theme_lightshop_fontawesome == '0' ? 'checked' : '' ?>>Откл.
											</label>
										</div>
									</div>	
								</div>	
							</div>
						</fieldset>							
						</div>
					</div>
				</div>

            </div>
			<div class="tab-pane" id="tab-header">
				<div class="tabbable tabs-left">
					<ul id="vtab-option" class="nav nav-tabs">					
						<li class="active"><a href="#tab-left-header-all" data-toggle="tab">Основные настройки</a></li>
						<li><a href="#tab-left-header-nav" data-toggle="tab">Верхнее мега-меню</a></li>
						<li><a href="#tab-left-header-menu" data-toggle="tab">Главное мега-меню</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-left-header-all">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-lightshop-header-type">Тип шапки</label>
									<div class="col-sm-10">
										<label class="radio"><input type="radio" name="theme_lightshop_header_type" value="1" <?php echo $theme_lightshop_header_type == '1' ? 'checked="checked"' : '' ?> > 
										Только главное меню <br/><img class="thumbnail img-responsive" src="view/image/lightshop/header-type-1.png">
										</label>
										<label class="radio"><input type="radio" name="theme_lightshop_header_type" value="2" <?php echo $theme_lightshop_header_type == '2' ? 'checked="checked"' : '' ?> > 
										Верхнее и главное меню, стиль 1 <br/><img class="thumbnail img-responsive" src="view/image/lightshop/header-type-2.png"></label>
										<label class="radio"><input type="radio" name="theme_lightshop_header_type" value="3" <?php echo $theme_lightshop_header_type == '3' ? 'checked="checked"' : '' ?> > 
										Верхнее и главное меню, стиль 2 <br/><img class="thumbnail img-responsive" src="view/image/lightshop/header-type-3.png"></label>
									</div>
							</div>	
							
							<!-- пункты только для 3 шапки -->

							<div class="form-group top3" style="display:none;">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Положение логотипа">Положение логотипа</span></label>
								<div class="col-sm-10">
									<select name="theme_lightshop_header_type3_logo" class="form-control">
										<option value="0" <?php echo $theme_lightshop_header_type3_logo == 0 ? 'selected="selected"' : '' ?>>По центру</option>
										<option value="1" <?php echo $theme_lightshop_header_type3_logo == 1 ? 'selected="selected"' : '' ?>>Слева</option>
									</select>
								</div>
							</div>
							<div class="form-group top3" style="display:none;">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Пункты в главном меню">Пункты в главном меню</span></label>
								<div class="col-sm-10">
									<select name="theme_lightshop_header_type3_menu" class="form-control">
										<option value="1" <?php echo $theme_lightshop_header_type3_menu == 1 ? 'selected="selected"' : '' ?>>По центру</option>
										<option value="0" <?php echo $theme_lightshop_header_type3_menu == 0 ? 'selected="selected"' : '' ?>>Слева</option>
									</select>
								</div>
							</div>

							<!-- // пункты только для 3 шапки -->
							
							<div class="form-group">
								<label class="col-sm-2 control-label" for="theme_lightshop_fixed_header"><span data-toggle="tooltip" title="" data-original-title="Фиксировать меню вверху сайта при скролле">Фикс. меню</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_fixed_header == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_fixed_header" id="theme_lightshop_fixed_header-1" autocomplete="off" <?php echo $theme_lightshop_fixed_header == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_fixed_header == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_fixed_header" id="theme_lightshop_fixed_header-0" autocomplete="off" <?php echo $theme_lightshop_fixed_header == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>	

						  <div class="form-group">
							<label class="col-sm-2 control-label" for="input-lightshop-header-text-logo">Текстовый логотип или svg код</label>
							<div class="col-sm-10">
								<textarea name="theme_lightshop_header_text_logo" rows="5" placeholder="Текстовый логотип или svg код" id="input-theme_lightshop_header_text_logo" class="form-control code"><?php echo $theme_lightshop_header_text_logo; ?></textarea>
							</div>
						  </div>
						  
						  <div class="form-group">
							<label class="col-sm-2 control-label" for="input-logo">Логотип</label>
							<div class="col-sm-10">
							<a href="" id="thumb-logo" data-toggle="image" class="img-thumbnail"><img src="<?php echo $logo; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
							<input type="hidden" name="theme_lightshop_header_logo" value="<?php echo $theme_lightshop_header_logo; ?>" id="input-logo" />
							</div>
						  </div>
						  
						  <div class="form-group">
							<label class="col-sm-2 control-label">Favicon</label>
							<div class="col-sm-10">
							<div class="thumbnail">
								<a href="" id="thumb-fav_16" data-toggle="image" class="img-thumbnail"><img src="<?php echo $fav_16; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
								<input type="hidden" name="theme_lightshop_fav_16" value="<?php echo $theme_lightshop_fav_16; ?>" id="input-fav_16" />
								<div class="caption">
									<p>16x16 px</p>
								</div> 
							</div>
							<div class="thumbnail">
								<a href="" id="thumb-fav_32" data-toggle="image" class="img-thumbnail"><img src="<?php echo $fav_32; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
								<input type="hidden" name="theme_lightshop_fav_32" value="<?php echo $theme_lightshop_fav_32; ?>" id="input-fav_32" />
								<div class="caption">
									<p>32x32 px</p>
								</div> 
							</div>
							<div class="thumbnail">
								<a href="" id="thumb-fav_180" data-toggle="image" class="img-thumbnail"><img src="<?php echo $fav_180; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
								<input type="hidden" name="theme_lightshop_fav_180" value="<?php echo $theme_lightshop_fav_180; ?>" id="input-fav_180" />
								<div class="caption">
									<p>180x180 px</p>
								</div> 
							</div>
							</div>
						  </div>	
	


			  
						</div>
						<div class="tab-pane" id="tab-left-header-nav">
						
						
						
			<div class="table table-responsive">
                <table id="header_nav" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
						  <td class="text-left">Тип</td>
						  <td class="text-left">Пункт меню</td>
						  <td class="text-left">Порядок сортировки</td>
						  <td></td>
						</tr>
					</thead>				
					<tbody>
					<?php $header_nav_row = 0; ?>
					<?php foreach ($header_navs as $header_nav_row => $header_nav) { ?>
						<tr id="header-nav-row<?php echo $header_nav_row; ?>"><!-- Подменю - кастомный список -->
						<td class="text-left">
						<select id="" name="theme_lightshop_header_nav[<?php echo $header_nav_row; ?>][settype]" for="<?php echo $header_nav_row; ?>" class="form-control header_nav_select_type">
						   <?php foreach ($header_nav_types as $key => $header_nav_type) { ?>
							<?php if ($key == $header_nav['settype']) { ?>
							   <option value="<?php echo $key; ?>" selected="selected"><?php echo $header_nav_type; ?></option>
					  		<?php } else { ?>
							   <option value="<?php echo $key; ?>" ><?php echo $header_nav_type; ?></option>
							<?php } ?>
						   <?php } ?>
						</select>
						</td>
						<td class="text-left">
						   <div id="header_nav-<?php echo $header_nav_row; ?>-0" class="header_nav-<?php echo $header_nav_row; ?>" style="display:<?php if(!$header_nav['settype']){ ?>block<?php }else{ ?>none<?php } ?>">
						     <?php foreach ($languages as $language) { ?>
							<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
								<input type="text" name="theme_lightshop_header_nav[<?php echo $header_nav_row; ?>][type][0][language][<?php echo  $language['language_id'] ?>][name]" value="<?php echo isset($header_nav['type'][0]['language'][$language['language_id']]['name']) ? $header_nav['type'][0]['language'][$language['language_id']]['name'] : ''; ?>" placeholder="Название подменю" class="form-control">
							<input type="text" name="theme_lightshop_header_nav[<?php echo $header_nav_row; ?>][type][0][language][<?php echo  $language['language_id'] ?>][href]" value="<?php echo isset($header_nav['type'][0]['language'][$language['language_id']]['href']) ? $header_nav['type'][0]['language'][$language['language_id']]['href'] : ''; ?>" placeholder="Ссылка(http://)" class="form-control">
							</div>
                			   	    <?php } ?>						
				<div class="well-table" style="position: relative;">
                  <input type="text" name="header_nav[<?php echo $header_nav_row; ?>][type][0][linksmain]" for="<?php echo $header_nav_row; ?>-0" value="" placeholder="Ссылки" id="input-related" class="form-control header_nav_links" autocomplete="off">
				  <div id="header_nav-<?php echo $header_nav_row; ?>-0-links" class="well well-sm" style="overflow: auto;">
				<?php $linksrow = 0; ?>
			     <?php if(isset($header_nav['type'][0]['links'])){ ?>
				<?php foreach ($header_nav['type'][0]['links'] as $id => $link) { ?>
					<?php if(isset($top_links[$id])){ ?>
						<div id="header_nav-<?php echo $header_nav_row; ?>-links-<?php echo $id; ?>"><i class="fa fa-minus-circle"></i><?php echo key($top_links[$id]); ?><input type="hidden" name="theme_lightshop_header_nav[<?php echo $header_nav_row; ?>][type][0][links][<?php echo $id; ?>]" value="<?php echo $link; ?>"></div> 
					<?php } ?>
				<?php $linksrow++; ?>
		   	    	<?php } ?>
			     <?php } ?>
				  </div>
                </div>	
					           </div>
						   <div id="header_nav-<?php echo $header_nav_row; ?>-1" class="header_nav-<?php echo $header_nav_row; ?>" style="display:<?php if($header_nav['settype']){ ?>block<?php }else{ ?>none<?php } ?>">
				
				<div class="well-table" style="position: relative;">
                  <input type="text" name="header_nav[<?php echo $header_nav_row; ?>][type][1][linksmain]" for="<?php echo $header_nav_row; ?>-1" value="" placeholder="Ссылки" id="input-related" class="form-control header_nav_links" autocomplete="off">
				  <div id="header_nav-<?php echo $header_nav_row; ?>-1-links" class="well well-sm" style="overflow: auto;">
			     <?php if(isset($header_nav['type'][1]['links'])){ ?>
				<?php foreach ($header_nav['type'][1]['links'] as $id => $link) { ?>
					<?php if(isset($top_links[$id])){ ?>
						<div id="header_nav-<?php echo $header_nav_row; ?>-links-<?php echo $id; ?>"><i class="fa fa-minus-circle"></i><?php echo key($top_links[$id]); ?><input type="hidden" name="theme_lightshop_header_nav[<?php echo $header_nav_row; ?>][type][1][links][<?php echo $id; ?>]" value="<?php echo $link; ?>"></div> 
					<?php } ?>
				<?php $linksrow++; ?>
		   	    	<?php } ?>
			     <?php } ?>
				  </div>
                </div>	
					           </div>					  
						</td>
						<td class="text-left"><input type="text" name="theme_lightshop_header_nav[<?php echo $header_nav_row; ?>][sort]" value="<?php echo $header_nav['sort']; ?>" placeholder="Порядок сортировки" class="form-control"></td>
						<td class="text-right"><button type="button" onclick="$('#header-nav-row<?php echo $header_nav_row; ?>').remove();" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="Удалить"><i class="fa fa-minus-circle"></i></button></td>
						</tr>
						

					<?php $header_nav_row++; ?>
					<?php } ?>	
					</tbody>
					<tfoot>
						<tr>
							<td colspan="3"></td>
							<td class="text-right">
								<button type="button" onclick="addHeader_nav();" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="Добавить"><i class="fa fa-plus-circle"></i></button>
							</td>
						</tr>
					</tfoot>
                </table>
			</div>
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
						</div>
						<div class="tab-pane" id="tab-left-header-menu">
						

						  
						<fieldset>
						<legend>МЕНЮ</legend>
						
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-theme_lightshop_max_subcat"><span data-toggle="tooltip" title="" data-original-title="Ограничить категории 3го уровня">Ограничение категорий</span></label>
							<div class="col-sm-10">
								<input type="text" name="theme_lightshop_max_subcat" value="<?php echo $theme_lightshop_max_subcat; ?>" placeholder="Ограничение категорий" id="input-theme_lightshop_sub_menu_limit" class="form-control" />
							</div>
						</div>
						  
			<div class="table table-responsive">
                <table id="attribute" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
						  <td class="text-left">Тип</td>
						  <td class="text-left">Пункт меню</td>
						  <td class="text-left">Порядок сортировки</td>
						  <td style="width: 56px;"></td>
						</tr>
					</thead>				
					<tbody>
						<?php $main_nav_row = 0; ?>
						<?php foreach ($main_navs as $main_nav_row => $main_nav) { ?>
						<tr id="main-nav-row<?php echo $main_nav_row; ?>"><!-- Категории (Только категории первого уровня) -->
						<td class="text-left">
						<select id="" name="theme_lightshop_main_nav[<?php echo $main_nav_row; ?>][settype]" for="<?php echo $main_nav_row; ?>" class="form-control main_nav_select_type">
						   <?php foreach ($main_nav_types as $key => $main_nav_type) { ?>
							<?php if ($key == $main_nav['settype']) { ?>
							   <option value="<?php echo $key; ?>" selected="selected"><?php echo $main_nav_type; ?></option>
					  		<?php } else { ?>
							   <option value="<?php echo $key; ?>" ><?php echo $main_nav_type; ?></option>
							<?php } ?>
						   <?php } ?>
						</select>
						</td>
						<td>
				<div id="main_nav-<?php echo $main_nav_row; ?>-0" class="main_nav-<?php echo $main_nav_row; ?>" style="display:<?php if(!$main_nav['settype']){ ?>block<?php }else{ ?>none<?php } ?>">
				  <div class="well-table" style="position: relative;">
					  <input type="text" name="main_nav[<?php echo $main_nav_row; ?>][type][0][linksmain]" for="<?php echo $main_nav_row; ?>-0" value="" placeholder="Категории (по умолчанию все)" class="form-control main_nav_links" autocomplete="off">
					  <div id="main_nav-<?php echo $main_nav_row; ?>-0-links" class="well well-sm" style="overflow: auto;">
					 <?php if(isset($main_nav['type'][0]['links'])){ ?>
						<?php foreach ($main_nav['type'][0]['links'] as $id => $link) { ?>
							<?php if(isset($top_links[$id])){ ?>
								<div id="main_nav-<?php echo $main_nav_row; ?>-links-<?php echo $id; ?>"><i class="fa fa-minus-circle"></i><?php echo key($top_links[$id]); ?><input type="hidden" name="theme_lightshop_main_nav[<?php echo $main_nav_row; ?>][type][0][links][<?php echo $id; ?>]" value="<?php echo $link; ?>"></div> 
							<?php } ?>
						<?php } ?>
					 <?php } ?>
					  </div>
                  </div>
                </div>	
				<div id="main_nav-<?php echo $main_nav_row; ?>-1" class="main_nav-<?php echo $main_nav_row; ?>" style="display:<?php if($main_nav['settype'] == 1){ ?>block<?php }else{ ?>none<?php } ?>">
					<?php foreach ($languages as $language) { ?>
						<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
							<input type="text" name="theme_lightshop_main_nav[<?php echo $main_nav_row; ?>][type][1][language][<?php echo  $language['language_id'] ?>][name]" value="<?php echo isset($main_nav['type'][1]['language'][$language['language_id']]['name']) ? $main_nav['type'][1]['language'][$language['language_id']]['name'] : ''; ?>" placeholder="Название подменю" class="form-control">
							<input type="text" name="theme_lightshop_main_nav[<?php echo $main_nav_row; ?>][type][1][language][<?php echo  $language['language_id'] ?>][href]" value="<?php echo isset($main_nav['type'][1]['language'][$language['language_id']]['href']) ? $main_nav['type'][1]['language'][$language['language_id']]['href'] : ''; ?>" placeholder="Ссылка(http://)" class="form-control">
						</div>
                	<?php } ?>						
					<div class="well-table" style="position: relative;">
					  <input type="text" name="main_nav[<?php echo $main_nav_row; ?>][type][1][linksmain]" for="<?php echo $main_nav_row; ?>-1" value="" placeholder="Ссылки" id="input-related" class="form-control main_nav_links" autocomplete="off">
					  <div id="main_nav-<?php echo $main_nav_row; ?>-1-links" class="well well-sm" style="overflow: auto;">
					<?php $linksrow = 0; ?>
					 <?php if(isset($main_nav['type'][1]['links'])){ ?>
					<?php foreach ($main_nav['type'][1]['links'] as $id => $link) { ?>
						<?php if(isset($top_links[$id])){ ?>
							<div id="main_nav-<?php echo $main_nav_row; ?>-links-<?php echo $id; ?>"><i class="fa fa-minus-circle"></i><?php echo key($top_links[$id]); ?><input type="hidden" name="theme_lightshop_main_nav[<?php echo $main_nav_row; ?>][type][1][links][<?php echo $id; ?>]" value="<?php echo $link; ?>"></div> 
						<?php } ?>
					<?php $linksrow++; ?>
						<?php } ?>
					 <?php } ?>
					  </div>
					</div>	
				</div>	
				<div id="main_nav-<?php echo $main_nav_row; ?>-2" class="main_nav-<?php echo $main_nav_row; ?>" style="display:<?php if($main_nav['settype'] == 2){ ?>block<?php }else{ ?>none<?php } ?>">
				  <div class="well-table" style="position: relative;">
					  <input type="text" name="main_nav[<?php echo $main_nav_row; ?>][type][2][linksmain]" for="<?php echo $main_nav_row; ?>-2" value="" placeholder="Ссылки" class="form-control main_nav_links" autocomplete="off">
					  <div id="main_nav-<?php echo $main_nav_row; ?>-2-links" class="well well-sm" style="overflow: auto;">
					 <?php if(isset($main_nav['type'][2]['links'])){ ?>
						<?php foreach ($main_nav['type'][2]['links'] as $id => $link) { ?>
							<?php if(isset($top_links[$id])){ ?>
								<div id="main_nav-<?php echo $main_nav_row; ?>-links-<?php echo $id; ?>"><i class="fa fa-minus-circle"></i><?php echo key($top_links[$id]); ?><input type="hidden" name="theme_lightshop_main_nav[<?php echo $main_nav_row; ?>][type][2][links][<?php echo $id; ?>]" value="<?php echo $link; ?>"></div> 
							<?php } ?>
						<?php } ?> 
					 <?php } ?>
					  </div>
                  </div>
                </div>	  
						</td>
						<td class="text-left"><input type="text" name="theme_lightshop_main_nav[<?php echo $main_nav_row; ?>][sort]" value="<?php echo $main_nav['sort']; ?>" placeholder="Порядок сортировки" class="form-control"></td>
							<td class="text-right"><button type="button" onclick="$('#main-nav-row<?php echo $main_nav_row; ?>').remove();" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="Удалить"><i class="fa fa-minus-circle"></i></button></td>
						</tr>						
						

						
					<?php $main_nav_row++; ?>
					<?php } ?>						

					</tbody>
					<tfoot>
						<tr>
							<td colspan="3"></td>
							<td class="text-right">
								<button type="button" onclick="addMain_nav();" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="Добавить"><i class="fa fa-plus-circle"></i></button>
							</td>
						</tr>
					</tfoot>
                </table>
			</div>						
						</fieldset>
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						<fieldset>
						<legend>Дополнительный элемент подменю</legend>
							<div class="table table-responsive">
							<table id="main_rec" class="table table-bordered">
							<thead>
								<tr>
									<td class="text-left">Главная категория</td>
									<td class="text-left">Правый элемент подменю 1</td>
									<td style="width: 56px;"></td>
								</tr>
							</thead>
							<tbody>
								<?php $main_rec_row = 0; ?>
								<?php foreach ($main_recs as $main_rec_row => $main_rec) { ?>
								<tr id="main_rec-row<?php echo $main_rec_row; ?>"><!-- Товары -->
									<td class="text-left">
										<select  name="theme_lightshop_main_rec[<?php echo $main_rec_row; ?>][category_id]" class="form-control">
											<option value="0"> --- Не выбрано --- </option>
											<?php foreach ($toplinks as $key => $toplink) { ?>
												<?php if ($key == $main_rec['category_id']) { ?>
												   <option value="<?php echo $key; ?>" selected="selected"><?php echo key($toplink); ?></option>
												<?php } else { ?>
												   <option value="<?php echo $key; ?>" ><?php echo  key($toplink); ?></option>
												<?php } ?>
											<?php } ?>

										</select>									
									</td>
									<td class="text-left">
										<select name="theme_lightshop_main_rec[<?php echo $main_rec_row; ?>][settype]" for="<?php echo $main_rec_row; ?>" class="form-control main_rec_select_type">
											<option value="0"> --- Не выбрано --- </option>	
											<?php foreach ($main_rec_types as $key => $main_rec_type) { ?>
												<?php if ($key == $main_rec['settype']) { ?>
												   <option value="<?php echo $key; ?>" selected="selected"><?php echo $main_rec_type; ?></option>
												<?php } else { ?>
												   <option value="<?php echo $key; ?>" ><?php echo  $main_rec_type; ?></option>
												<?php } ?>
											<?php } ?>
										</select>
			   <div id="main_rec-<?php echo $main_rec_row; ?>-0" class="main_rec-<?php echo $main_rec_row; ?>" style="display:<?php if(!$main_rec['settype']){ ?>block<?php }else{ ?>none<?php } ?>">	
					<div style="position: relative;">
					  <input type="text" name="main_rec[<?php echo $main_rec_row; ?>][type][0][linksmain]" for="<?php echo $main_rec_row; ?>-0" value="" placeholder="Ссылки" class="form-control main_rec_prods" autocomplete="off">
					  <div id="main_rec-<?php echo $main_rec_row; ?>-0-links" class="well well-sm" style="overflow: auto;">
					 <?php if(isset($main_rec['type'][0]['links'])){ ?>
						<?php foreach ($main_rec['type'][0]['links'] as $id => $link) { ?>
							
								<div id="main_rec-<?php echo $main_rec_row; ?>-links-<?php echo $id; ?>"><i class="fa fa-minus-circle"></i><?php echo $link; ?>
									<input type="hidden" name="theme_lightshop_main_rec[<?php echo $main_rec_row; ?>][type][0][links][<?php echo $id; ?>]" value="<?php echo $link; ?>">
								</div> 
							
						<?php } ?>
					 <?php } ?>
					  </div>
					</div>
               </div>

			   <div id="main_rec-<?php echo $main_rec_row; ?>-2" class="main_rec-<?php echo $main_rec_row; ?>" style="display:<?php if($main_rec['settype'] == 2){ ?>block<?php }else{ ?>none<?php } ?>">	
					<div style="position: relative;">
					  <input type="text" name="main_rec[<?php echo $main_rec_row; ?>][type][0][linksmain]" for="<?php echo $main_rec_row; ?>-0" value="" placeholder="Производители" class="form-control main_rec_manf" autocomplete="off">
					  <div id="main_rec-<?php echo $main_rec_row; ?>-0-manufacturers" class="well well-sm" style="overflow: auto;">
					 <?php if(isset($main_rec['type'][0]['manf'])){ ?>
						<?php foreach ($main_rec['type'][0]['manf'] as $id => $link) { ?>
							
								<div id="main_rec-<?php echo $main_rec_row; ?>-manf-<?php echo $id; ?>"><i class="fa fa-minus-circle"></i><?php echo $link; ?>
									<input type="hidden" name="theme_lightshop_main_rec[<?php echo $main_rec_row; ?>][type][0][manf][<?php echo $id; ?>]" value="<?php echo $link; ?>">
								</div> 
							
						<?php } ?>
					 <?php } ?>
					  </div>
					</div>
               </div>

			   <div id="main_rec-<?php echo $main_rec_row; ?>-1" class="main_rec-<?php echo $main_rec_row; ?>" style="display:<?php if($main_rec['settype'] == 1){ ?>block<?php }else{ ?>none<?php } ?>">	
					<div class="input-group"><span class="input-group-addon"><i data-toggle="tooltip" data-original-title="Можно использовать html" class="fa fa-code"></i></span>
						<textarea name="theme_lightshop_main_rec[<?php echo $main_rec_row; ?>][type][1][html]" rows="5" placeholder="html контент"
						 class="form-control code"><?php echo $main_rec['type'][1]['html']; ?></textarea>
					</div>	
               </div>												
									</td>



									<td class="text-right"><button type="button" onclick="$('#main_rec-row<?php echo $main_rec_row; ?>').remove();" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="Удалить"><i class="fa fa-minus-circle"></i></button></td>
								</tr>
								<?php $main_rec_row++; ?>
								<?php } ?>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="3" class="text-right">
										<button type="button" onclick="addMain_rec();" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="Добавить элемент"><i class="fa fa-plus-circle"></i></button>
									</td>
								</tr>
							</tfoot>							
							</table>
							</div>						
						</fieldset>
						

	
						</div>
					</div>
				</div>


				






























	
			</div>
			<div class="tab-pane" id="tab-home">
				<div class="tabbable tabs-left">
					<ul id="vtab-option" class="nav nav-tabs">					
						<li class="active"><a href="#tab-left-catalog" data-toggle="tab">Каталог</a></li>
						<li><a href="#tab-left-product" data-toggle="tab">Карточка товара</a></li>
						<li><a href="#tab-left-news" data-toggle="tab">Страница новостей</a></li>
						<li><a href="#tab-left-contact" data-toggle="tab">Контакты</a></li>
						<li><a href="#tab-left-checkout-reg" data-toggle="tab">Заказ и регистрация</a></li>
						<li><a href="#tab-left-blog" data-toggle="tab">Блог</a></li>

					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-left-catalog">
							<div class="form-group required">
							  <label class="col-sm-2 control-label" for="input-catalog-limit"><span data-toggle="tooltip" title="<?php echo $help_product_limit; ?>"><?php echo $entry_product_limit; ?></span></label>
							  <div class="col-sm-10">
								<input type="text" name="theme_lightshop_product_limit" value="<?php echo $theme_lightshop_product_limit; ?>" placeholder="<?php echo $entry_product_limit; ?>" id="input-catalog-limit" class="form-control" />
								<?php if ($error_product_limit) { ?>
								<div class="text-danger"><?php echo $error_product_limit; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-2 control-label" for="input-description-limit"><span data-toggle="tooltip" title="<?php echo $help_product_description_length; ?>"><?php echo $entry_product_description_length; ?></span></label>
							  <div class="col-sm-10">
								<input type="text" name="theme_lightshop_product_description_length" value="<?php echo $theme_lightshop_product_description_length; ?>" placeholder="<?php echo $entry_product_description_length; ?>" id="input-description-limit" class="form-control" />
								<?php if ($error_product_description_length) { ?>
								<div class="text-danger"><?php echo $error_product_description_length; ?></div>
								<?php } ?>
							  </div>
							</div>	
							<div class="form-group">
								<label class="col-sm-2 control-label">Быстрый просмотр</label>
								<div class="col-sm-10">
									<label class="radio"><input type="radio" name="theme_lightshop_product_detail" value="0" <?php echo $theme_lightshop_product_detail == 0 ? 'checked' : '' ?>> Откл.</label>
									<label class="radio"><input type="radio" name="theme_lightshop_product_detail" value="1" <?php echo $theme_lightshop_product_detail == 1 ? 'checked' : '' ?>> Вкл. (при клике на название/изображение товара)</label>
									<label class="radio"><input type="radio" name="theme_lightshop_product_detail" value="2" <?php echo $theme_lightshop_product_detail == 2 ? 'checked' : '' ?>> Вкл. (при клике на кнопку быстрого просмотра)</label>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Действие после добавления товара в корзину">В корзину</span></label>
								<div class="col-sm-10">
									<label class="radio"><input type="radio" name="theme_lightshop_cart_call" value="" <?php echo $theme_lightshop_cart_call == 0 ? 'checked' : '' ?>> Показывать подсказку вверху сайта</label>
									<label class="radio"><input type="radio" name="theme_lightshop_cart_call" value="1" <?php echo $theme_lightshop_cart_call == 1 ? 'checked' : '' ?>> Открывать корзину</label>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Отображать фоновое изображение в каталоге товаров">Фон в каталоге</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_category_background == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_category_background" id="theme_lightshop_category_background-1" autocomplete="off" <?php echo $theme_lightshop_category_background == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_category_background == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_category_background" id="theme_lightshop_category_background-0" autocomplete="off" <?php echo $theme_lightshop_category_background == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Варианты отображения плиток категорий в каталоге">Категории в каталоге</span></label>
								<div class="col-sm-10">
									<select name="theme_lightshop_category_categories" class="form-control">
										<option value="0" <?php echo $theme_lightshop_category_categories == 0 ? 'selected="selected"' : '' ?>>Не отображать</option>
										<option value="4" <?php echo $theme_lightshop_category_categories == 4 ? 'selected="selected"' : '' ?>>По 3 в ряд</option>
										<option value="3" <?php echo $theme_lightshop_category_categories == 3 ? 'selected="selected"' : '' ?>>По 4 в ряд</option>
										<option value="2" <?php echo $theme_lightshop_category_categories == 2 ? 'selected="selected"' : '' ?>>По 6 в ряд</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Отображать варианты сортировки товаров">Сортировка</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_category_sorts == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_category_sorts" id="theme_lightshop_category_sorts-1" autocomplete="off" <?php echo $theme_lightshop_category_sorts == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_category_sorts == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_category_sorts" id="theme_lightshop_category_sorts-0" autocomplete="off" <?php echo $theme_lightshop_category_sorts == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Отображать лимиты вывода товаров в каталог">Лимиты</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_category_limits == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_category_limits" id="theme_lightshop_category_limits-1" autocomplete="off" <?php echo $theme_lightshop_category_limits == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_category_limits == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_category_limits" id="theme_lightshop_category_limits-0" autocomplete="off" <?php echo $theme_lightshop_category_limits == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Вид каталога товаров по умолчанию в ПК версии сайта">Вид каталога (ПК)</span></label>
								<div class="col-sm-10">
									<label class="radio"><input type="radio" name="theme_lightshop_pс_view" value="main" <?php echo $theme_lightshop_pс_view == '' || $theme_lightshop_pс_view == 'main' ? 'checked' : '' ?>> Плитка по 3 товара в ряд</label>
									<label class="radio"><input type="radio" name="theme_lightshop_pс_view" value="main-four" <?php echo $theme_lightshop_pс_view == 'main-four' ? 'checked' : '' ?>> Плитка по 4 товара в ряд</label>
									<label class="radio"><input type="radio" name="theme_lightshop_pс_view" value="main-five" <?php echo $theme_lightshop_pс_view == 'main-five' ? 'checked' : '' ?>> Плитка по 5 товаров в ряд</label>
									<label class="radio"><input type="radio" name="theme_lightshop_pс_view" value="list" <?php echo $theme_lightshop_pс_view == 'list' ? 'checked' : '' ?>> Лист</label>
									<label class="radio"><input type="radio" name="theme_lightshop_pс_view" value="table" <?php echo $theme_lightshop_pс_view == 'table' ? 'checked' : '' ?>> Таблица</label>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Вид каталога товаров по умолчанию в мобильной версии сайта">Вид каталога (моб.)</span></label>
								<div class="col-sm-10">
									<label class="radio"><input type="radio" name="theme_lightshop_mobile_view" value="main" <?php echo $theme_lightshop_mobile_view == '' || $theme_lightshop_mobile_view == 'main' ? 'checked' : '' ?>> Плитка</label>
									<label class="radio"><input type="radio" name="theme_lightshop_mobile_view" value="list" <?php echo $theme_lightshop_mobile_view == 'list' ? 'checked' : '' ?>> Лист</label>
									<label class="radio"><input type="radio" name="theme_lightshop_mobile_view" value="table" <?php echo $theme_lightshop_mobile_view == 'table' ? 'checked' : '' ?>> Таблица</label>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Вариант отображения плитки в каталоге товаров">Плитка</span></label>
									<div class="col-sm-2">
										<label class="radio"><input type="radio" name="theme_lightshop_catalog_type" value="0" <?php echo $theme_lightshop_catalog_type == '0' ? 'checked="checked"' : '' ?> > 
										Тип 1 <br/><br/> <img style="margin-left: -20px;" class="thumbnail img-responsive" src="view/image/lightshop/catalog-type1.png">
										</label>
									</div>
									<div class="col-sm-2">
										<label class="radio"><input type="radio" name="theme_lightshop_catalog_type" value="1" <?php echo $theme_lightshop_catalog_type == '1' ? 'checked="checked"' : '' ?> > 
										Тип 2 <br/><br/> <img style="margin-left: -20px;" class="thumbnail img-responsive" src="view/image/lightshop/catalog-type2.png"></label>
									</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Отключает обзательную регистрацию при добавлении товаров с список избранных">Избранные без регистрации</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_wishlist == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_wishlist" id="theme_lightshop_wishlist-1" autocomplete="off" <?php echo $theme_lightshop_wishlist == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_wishlist == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_wishlist" id="theme_lightshop_wishlist-0" autocomplete="off" <?php echo $theme_lightshop_wishlist == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Вывод в категории товаров из подкатегорий">Вывод в категории товаров из подкатегорий</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_subcategory == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_subcategory" id="theme_lightshop_subcategory-1" autocomplete="off" <?php echo $theme_lightshop_subcategory == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_subcategory == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_subcategory" id="theme_lightshop_subcategory-0" autocomplete="off" <?php echo $theme_lightshop_subcategory == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
						</div>

						<div class="tab-pane" id="tab-left-product">
						<fieldset>
						<legend>Основные настройки</legend>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Что-бы использовать краткое описание в карточках товаров, отделите текст описания Enter-ом в редактировании товара">Краткое описание</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_product_short_descr == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_product_short_descr" id="theme_lightshop_product_short_descr-1" autocomplete="off" <?php echo $theme_lightshop_product_short_descr == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_product_short_descr == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_product_short_descr" id="theme_lightshop_product_short_descr-0" autocomplete="off" <?php echo $theme_lightshop_product_short_descr == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>	
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Текст до данного разделителя будет перенесен в верхнюю часть картчки товара (под названием), остальной текст в останется в нижней части (в табе)">Разделитель краткого описания</span></label>
								<div class="col-sm-10">
									<input type="text" name="theme_lightshop_product_short_tag" value="<?php echo $theme_lightshop_product_short_tag; ?>" placeholder="&lt;/p&gt;" id="input-theme_lightshop_product_short_tag" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Вариант отображения опций">Опции</span></label>
								<div class="col-sm-10">
									<select id="" name="theme_lightshop_product_opt_select" class="form-control">
										<option value="0" <?php echo $theme_lightshop_product_opt_select == 0 ? 'selected="selected"' : '' ?>>в 2 столбца (по умолчанию)</option>
										<option value="1" <?php echo $theme_lightshop_product_opt_select == 1 ? 'selected="selected"' : '' ?>>в 1 столбец</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Вариант отображения атрибутов (характеристик)">Атрибуты</span></label>
								<div class="col-sm-10">
									<select id="" name="theme_lightshop_product_att_select" class="form-control">
										<option value="0" <?php echo $theme_lightshop_product_att_select == 0 ? 'selected="selected"' : '' ?>>в 2 столбца (по умолчанию)</option>
										<option value="1" <?php echo $theme_lightshop_product_att_select == 1 ? 'selected="selected"' : '' ?>>в 1 столбец</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Эффект увеличения изображения товара">Увеличение изображения</span></label>
								<div class="col-sm-10">
									<select id="" name="theme_lightshop_product_zoom" class="form-control">
										<option value="0" <?php echo $theme_lightshop_product_zoom == 0 ? 'selected="selected"' : '' ?>>Fancy box (по умолчанию)</option>
										<option value="1" <?php echo $theme_lightshop_product_zoom == 1 ? 'selected="selected"' : '' ?>>Cloud zoom</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Поле, в карточках товара, отображаемое на витрине магазина">Код товара</span></label>
								<div class="col-sm-10">
									<select id="" name="theme_lightshop_product_cod" class="form-control">
										<option value="" <?php echo $theme_lightshop_product_cod == '' ? 'selected="selected"' : '' ?>>model (по умолчанию)</option>
										<option value="sku" <?php echo $theme_lightshop_product_cod == 'sku' ? 'selected="selected"' : '' ?>>sku</option>
										<option value="upc" <?php echo $theme_lightshop_product_cod == 'upc' ? 'selected="selected"' : '' ?>>upc</option>
										<option value="ean" <?php echo $theme_lightshop_product_cod == 'ean' ? 'selected="selected"' : '' ?>>ean</option>
										<option value="jan" <?php echo $theme_lightshop_product_cod == 'jan' ? 'selected="selected"' : '' ?>>jan</option>
										<option value="isbn" <?php echo $theme_lightshop_product_cod == 'isbn' ? 'selected="selected"' : '' ?>>isbn</option>
										<option value="mpn" <?php echo $theme_lightshop_product_cod == 'mpn' ? 'selected="selected"' : '' ?>>mpn</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Шаблон вывода рекомендуемых товаров">Рекомендуемые товары</span></label>
								<div class="col-sm-10">
									<select id="" name="theme_lightshop_p_related_view" class="form-control">
										<option value="0" <?php echo $theme_lightshop_p_related_view == 0 ? 'selected="selected"' : '' ?>>Слайдер (по умолчанию)</option>
										<option value="3" <?php echo $theme_lightshop_p_related_view == 3 ? 'selected="selected"' : '' ?>>Сетка по 3 товара в строке</option>
										<option value="4" <?php echo $theme_lightshop_p_related_view == 4 ? 'selected="selected"' : '' ?>>Сетка по 4 товара в строке</option>
										<option value="5" <?php echo $theme_lightshop_p_related_view == 5 ? 'selected="selected"' : '' ?>>Сетка по 5 товаров в строке</option>
									</select>
								</div>
							</div>
						</fieldset>
						
						<fieldset>
						<legend>Дополнительные вкладки</legend>
						<div class="row">
							<div class="col-sm-2">
								<ul class="nav nav-pills nav-stacked" id="cust_tabs_tab">
								<?php foreach ($cust_tabs as $key => $cust_tab) { ?> 
									<li ><a href="#tab-ctabs<?php echo $key; ?>" data-toggle="tab" aria-expanded="true"><i class="fa fa-minus-circle" onclick="$('a[href=\'#tab-ctabs<?php echo $key; ?>\']').parent().remove(); $('#tab-ctabs<?php echo $key; ?>').remove(); $('#cust_tabs_tab a:first').tab('show');"></i> Вкладка #<?php echo $key; ?></a></li>
								<?php } ?>
								<li id="ctabs_add"><a  onclick="addCust_tab();" class="btn nav-pills-btn"><i class="fa fa-plus-circle"></i> Добавить</a></li>
								</ul>
							</div>
							<div class="col-sm-10">
								<div class="tab-content" id="cust_tabs_data">
								<?php  $cust_tab_key = 0; ?>
								<?php foreach ($cust_tabs as $cust_tab_key => $cust_tab) { ?> 
									<div  id="tab-ctabs<?php echo $cust_tab_key; ?>" class="tab-pane fade">
									
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-description1"><span data-toggle="tooltip" title="" data-original-title="<?php echo $help_product_tabs_main; ?>"><?php echo $text_tabs_shablon; ?></span></label>
											<div class="col-sm-10">
												<select name="cust_tabs[<?php echo $cust_tab_key; ?>][view]" class="form-control">
														<option value="tab" <?php echo  $cust_tab['view'] == "tab" ? 'selected="selected"' : '' ; ?>><?php echo $text_tabs_tab; ?></option>
														<option value="popup" <?php echo  $cust_tab['view'] == "popup" ? 'selected="selected"' : '' ; ?>><?php echo $text_tabs_popup; ?></option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-description1"><?php echo $text_tabs_links; ?></label>
											<div class="col-sm-10">
												<select name="cust_tabs[<?php echo $cust_tab_key; ?>][mode]" data-for="<?php echo $cust_tab_key; ?>" class="form-control cust_tabs_mode">
														<option value="products" <?php echo  $cust_tab['mode'] == "products" ? 'selected="selected"' : '' ; ?>><?php echo $text_tabs_to_products; ?></option>
														<option value="categories" <?php echo  $cust_tab['mode'] == "categories" ? 'selected="selected"' : '' ; ?>><?php echo $text_tabs_tab_to_categories; ?></option>
												</select>
											</div>
										</div>
										
										<div class="form-group tabsmode-<?php echo $cust_tab_key; ?>" id="customtab-<?php echo $cust_tab_key; ?>-products" style="display: <?php echo  $cust_tab['mode'] == "products" ? 'block' : 'none' ; ?>;">
											<label class="col-sm-2 control-label" for="input-product"><span data-toggle="tooltip" title="" data-original-title="<?php echo $help_product_tabs_select; ?>"><?php echo $text_products; ?></span></label>
											<div class="col-sm-10">
											  <input type="text" name="cust_tabs[<?php echo $cust_tab_key; ?>][product]" data-for="<?php echo $cust_tab_key; ?>" value="" placeholder="<?php echo $text_products; ?>"  class="form-control tab-products">
											  <div class="well well-sm" id="cust_tabs-<?php echo $cust_tab_key; ?>-products" style="height: 150px; overflow: auto;">
											  	<?php if($cust_tab['mode'] == "products"){  ?>
												  	<?php foreach ($cust_tab['instanses'] as  $instanse) { ?>
													  <div id="product<?php echo $instanse['id']; ?>"><i class="fa fa-minus-circle"></i><?php echo $instanse['name']; ?><input type="hidden" name="cust_tabs[<?php echo $cust_tab_key; ?>][instanses][products][]" value="<?php echo $instanse['id']; ?>">
													  </div>
												  	<?php } ?>
											  	<?php } ?>
											  </div>
											</div>
										</div>
										<div class="form-group tabsmode-<?php echo $cust_tab_key; ?>" id="customtab-<?php echo $cust_tab_key; ?>-categories" style="display: <?php echo  $cust_tab['mode'] == "categories" ? 'block' : 'none' ; ?>;">
											<label class="col-sm-2 control-label" for="input-categories"><span data-toggle="tooltip" title="" data-original-title="<?php echo $help_product_tabs_cat_select; ?>"><?php echo $text_categories; ?></span></label>
											<div class="col-sm-10">
											  <input type="text" name="cust_tabs[<?php echo $cust_tab_key; ?>][category]" data-for="<?php echo $cust_tab_key; ?>" value="" placeholder="<?php echo $text_categories; ?>"  class="form-control tab-categories">
											  <div class="well well-sm" id="cust_tabs-<?php echo $cust_tab_key; ?>-categories" style="height: 150px; overflow: auto;">
											  	<?php if($cust_tab['mode'] == "categories"){ ?>
												  	<?php foreach ($cust_tab['instanses'] as  $instanse) { ?>
													  <div id="category<?php echo $instanse['id']; ?>"><i class="fa fa-minus-circle"></i><?php echo $instanse['name']; ?><input type="hidden" name="cust_tabs[<?php echo $cust_tab_key; ?>][instanses][categories][]" value="<?php echo $instanse['id']; ?>">
													  </div>
												  	<?php } ?>											  	
												<?php } ?>
											  </div>
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label" for=""><?php echo $text_sort_order; ?></label>
											<div class="col-sm-10">
												<input type="text" name="cust_tabs[<?php echo $cust_tab_key; ?>][sort_order]" value="<?php echo $cust_tab['sort_order']; ?>" placeholder="<?php echo $text_sort_order; ?>" class="form-control">
											</div>
										</div>
										
										
										<ul class="nav nav-tabs" id="language_tab<?php echo $cust_tab_key; ?>">
										<?php foreach ($languages as $language) { ?> 
											<li ><a href="#language_tab-<?php echo $cust_tab_key; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab" aria-expanded="true"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"> <?php echo $language['name']; ?></a></li>
										<?php } ?>
										</ul>

										<div class="tab-content">
										<?php foreach ($languages as $language) { ?> 
											<div class="tab-pane " id="language_tab-<?php echo $cust_tab_key; ?>-<?php echo $language['language_id']; ?>">
												<div class="form-group required">
													<label class="col-sm-2 control-label" for="input-name1"><?php echo $text_name; ?></label>
													<div class="col-sm-10">
													<input type="text" name="cust_tabs[<?php echo $cust_tab_key; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_tab['title'][$language['language_id']]) ? $cust_tab['title'][$language['language_id']] : ''; ?>" placeholder="<?php echo $text_name; ?>"  class="form-control" />
													  </div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label" for="input-description1"><?php echo $text_description; ?></label>
													<div class="col-sm-10">
													<textarea name="cust_tabs[<?php echo $cust_tab_key; ?>][description][<?php echo $language['language_id']; ?>]" placeholder="<?php echo $text_description; ?>"  data-lang="<?php echo $language['code']; ?>" class="form-control summernote"><?php echo isset($cust_tab['description'][$language['language_id']]) ? $cust_tab['description'][$language['language_id']] : ''; ?></textarea>
													</div>
												</div>
											</div>
										<?php } ?>
										</div>
									</div>
								<?php } ?>
								<?php $cust_tab_key++; ?>
								</div>
							</div>
						</div>
						
						</fieldset>
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
						</div>
						
						<div class="tab-pane" id="tab-left-news">
							<div class="form-group">
								<label class="col-sm-2 control-label">HTML-тег Title</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="theme_lightshop_news_meta_title<?php echo $language['language_id']; ?>" value="<?php echo !empty(${'theme_lightshop_news_meta_title' . $language['language_id']}) ? ${'theme_lightshop_news_meta_title' . $language['language_id']} : ''; ?>" placeholder="HTML-тег Title" id="input-theme_lightshop_news_meta_title<?php echo $language['language_id']; ?>" class="form-control" />
										</div>
									<?php } ?>
								</div>	
							</div>	
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_news_meta_description">Мета-тег Description</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<textarea name="theme_lightshop_news_meta_description<?php echo $language['language_id']; ?>" rows="5" placeholder="Мета-тег Description" class="form-control" id="input-theme_lightshop_news_meta_description<?php echo $language['language_id']; ?>"><?php echo !empty(${'theme_lightshop_news_meta_description' . $language['language_id']}) ? ${'theme_lightshop_news_meta_description' . $language['language_id']} : ''; ?></textarea>
										</div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_news_meta_keyword">Мета-тег Keywords</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<textarea name="theme_lightshop_news_meta_keyword<?php echo $language['language_id']; ?>" rows="5" placeholder="Мета-тег Keywords" class="form-control" id="input-theme_lightshop_news_meta_keyword<?php echo $language['language_id']; ?>"><?php echo !empty(${'theme_lightshop_news_meta_keyword' . $language['language_id']}) ? ${'theme_lightshop_news_meta_keyword' . $language['language_id']} : ''; ?></textarea>
										</div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-2 control-label" for="input-theme_lightshop_news_limit"><span data-toggle="tooltip" title="Сколько новостей показывать на одной странице"><?php echo $entry_product_limit; ?></span></label>
							  <div class="col-sm-10">
								<input type="text" name="theme_lightshop_news_limit" value="<?php echo $theme_lightshop_news_limit; ?>" placeholder="<?php echo $entry_product_limit; ?>" id="input-theme_lightshop_news_limit" class="form-control" />
								<?php if ($error_news_limit) { ?>
								<div class="text-danger"><?php echo $error_news_limit; ?></div>
								<?php } ?>
							  </div>
							</div>
						</div>
						
						<div class="tab-pane" id="tab-left-contact">
							
							<div class="form-group">
								<label class="col-sm-2 control-label">HTML-тег Title</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="theme_lightshop_contact_meta_title<?php echo $language['language_id']; ?>" value="<?php echo !empty(${'theme_lightshop_contact_meta_title' . $language['language_id']}) ? ${'theme_lightshop_contact_meta_title' . $language['language_id']} : ''; ?>" placeholder="HTML-тег Title" id="input-theme_lightshop_contact_meta_title<?php echo $language['language_id']; ?>" class="form-control" />
										</div>
									<?php } ?>
								</div>	
							</div>	
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_contact_meta_description">Мета-тег Description</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<textarea name="theme_lightshop_contact_meta_description<?php echo $language['language_id']; ?>" rows="5" placeholder="Мета-тег Description" class="form-control" id="input-theme_lightshop_contact_meta_description<?php echo $language['language_id']; ?>"><?php echo !empty(${'theme_lightshop_contact_meta_description' . $language['language_id']}) ? ${'theme_lightshop_contact_meta_description' . $language['language_id']} : ''; ?></textarea>
										</div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_contact_meta_keyword">Мета-тег Keywords</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<textarea name="theme_lightshop_contact_meta_keyword<?php echo $language['language_id']; ?>" rows="5" placeholder="Мета-тег Keywords" class="form-control" id="input-theme_lightshop_contact_meta_keyword<?php echo $language['language_id']; ?>"><?php echo !empty(${'theme_lightshop_contact_meta_keyword' . $language['language_id']}) ? ${'theme_lightshop_contact_meta_keyword' . $language['language_id']} : ''; ?></textarea>
										</div>
									<?php } ?>
								</div>
							</div>
							
						
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Используемая карта">Используемая карта</span></label>
								<div class="col-sm-10">
									<select name="theme_lightshop_contact_map" class="form-control">
										<option value="" <?php echo $theme_lightshop_contact_map == '' ? 'selected="selected"' : '' ?>>Без карты</option>
										<option value="google_map" <?php echo $theme_lightshop_contact_map == 'google_map' ? 'selected="selected"' : '' ?>>Google карты</option>
										<option value="yandex_map" <?php echo $theme_lightshop_contact_map == 'yandex_map' ? 'selected="selected"' : '' ?>>Яндекс карты</option>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">Масштаб карты</label>
								<div class="col-sm-10">
									<select id="" name="theme_lightshop_contact_zoom" class="form-control">
										<?php for ($i = 13; $i <= 20; $i++) { ?>
											<option value="<?php echo $i; ?>" <?php echo $theme_lightshop_contact_zoom == $i ? 'selected="selected"' : '' ?> ><?php echo $i; ?></option>
										<?php } ?>	
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Показывать в углу карты кнопки +/- для увеличения/уменьшения масштаба карты">Кнопки увеличения</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_contact_zoom_control == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_contact_zoom_control" id="theme_lightshop_contact_zoom_control-1" autocomplete="off" <?php echo $theme_lightshop_contact_zoom_control == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_contact_zoom_control == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_contact_zoom_control" id="theme_lightshop_contact_zoom_control-0" autocomplete="off" <?php echo $theme_lightshop_contact_zoom_control == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
							<div class="form-group gmaps" style="display:none">
								<label class="col-sm-2 control-label">API ключ</label>
								<div class="col-sm-10">
									<div class="alert alert-info" role="alert"><i class="fa fa-info-circle"></i> Для получения ключа API Google Maps перейдите по ссылке <a href="https://developers.google.com/maps/documentation/geocoding/get-api-key?hl=ru" target="_blank">https://developers.google.com/maps/documentation/geocoding/get-api-key?hl=ru</a></div>
									<input type="text" name="theme_lightshop_contact_api_key" value="<?php echo $theme_lightshop_contact_api_key; ?>" placeholder="API ключ" id="input-theme_lightshop_contact_api_key" class="form-control" />
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-left-checkout-reg">


							<div class="tab-content">
							
								<fieldset>
									<legend>ОСНОВНЫЕ НАСТРОЙКИ</legend>
									<div class="form-group">
										<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Показывать заголовки способов оплаты и достаки">Заголовки</span></label>
										<div class="col-sm-2">
											<div class="btn-group on-off" data-toggle="buttons">
												<label class="btn btn-default btn-on <?php echo $theme_lightshop_checkout_st4_title == '1' ? 'active' : '' ?>">
												<input value="1" type="radio" name="theme_lightshop_checkout_st4_title" id="theme_lightshop_checkout_st4_title-1" autocomplete="off" <?php echo $theme_lightshop_checkout_st4_title == '1' ? 'checked' : '' ?>>Вкл.
												</label>
												<label class="btn btn-default btn-off <?php echo $theme_lightshop_checkout_st4_title == '0' ? 'active' : '' ?>">
												<input value="0" type="radio" name="theme_lightshop_checkout_st4_title" id="theme_lightshop_checkout_st4_title-0" autocomplete="off" <?php echo $theme_lightshop_checkout_st4_title == '0' ? 'checked' : '' ?>>Откл.
												</label>
											</div>	
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Вид отображения способов оплаты и достаки">Вид отображения</span></label>
										<div class="col-sm-10">
											<label class="radio"><input type="radio" name="theme_lightshop_checkout_st4_col" value="0" <?php echo $theme_lightshop_checkout_st4_col == 0 ? 'checked' : '' ?>> В 1 колонку</label>
											<label class="radio"><input type="radio" name="theme_lightshop_checkout_st4_col" value="1" <?php echo $theme_lightshop_checkout_st4_col == 1 ? 'checked' : '' ?>> В 2 колонки</label>
										</div>	
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Выбор адреса доставки, отличного от платежного адреса">Адрес доставки</span></label>
										<div class="col-sm-2">
											<div class="btn-group on-off" data-toggle="buttons">
												<label class="btn btn-default btn-on <?php echo $theme_lightshop_checkout_st3_sa == 0 ? 'active' : '' ?>">
												<input value="0" type="radio" name="theme_lightshop_checkout_st3_sa" id="theme_lightshop_checkout_st3_sa-1" autocomplete="off" <?php echo $theme_lightshop_checkout_st3_sa == 0 ? 'checked' : '' ?>>Вкл.
												</label>
												<label class="btn btn-default btn-off <?php echo $theme_lightshop_checkout_st3_sa == 1 ? 'active' : '' ?>">
												<input value="1" type="radio" name="theme_lightshop_checkout_st3_sa" id="theme_lightshop_checkout_st3_sa-0" autocomplete="off" <?php echo $theme_lightshop_checkout_st3_sa == 1 ? 'checked' : '' ?>>Откл.
												</label>
											</div>	
										</div>
									</div>
								</fieldset>
									

									<fieldset>
									<legend>Поле firstname</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Имя">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[firstname][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['firstname']['description'][$language['language_id']]) ? $cust_fields['firstname']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[firstname][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['firstname']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['firstname']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

																	</div>
									  </div>
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[firstname][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['firstname']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['firstname']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[firstname][sort_order]" value="<?php echo isset($cust_fields['firstname']['sort_order']) ? $cust_fields['firstname']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>
		 
									</fieldset>
									
									<fieldset>
										<legend>Поле lastname</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Фамилия">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[lastname][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['lastname']['description'][$language['language_id']]) ? $cust_fields['lastname']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[lastname][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['lastname']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['lastname']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[lastname][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['lastname']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['lastname']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[lastname][sort_order]" value="<?php echo isset($cust_fields['lastname']['sort_order']) ? $cust_fields['lastname']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>
									</fieldset>
									
									<fieldset>								
										<legend>Поле email</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - E-mail">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[email][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['email']['description'][$language['language_id']]) ? $cust_fields['email']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[email][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['email']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['email']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[email][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['email']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['email']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[email][sort_order]" value="<?php echo isset($cust_fields['email']['sort_order']) ? $cust_fields['email']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>
									</fieldset>
									
									<fieldset>
										<legend>Поле telephone</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Телефон">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[telephone][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['telephone']['description'][$language['language_id']]) ? $cust_fields['telephone']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[telephone][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['telephone']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['telephone']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[telephone][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['telephone']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['telephone']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[telephone][sort_order]" value="<?php echo isset($cust_fields['telephone']['sort_order']) ? $cust_fields['telephone']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>
									</fieldset>
									
									<fieldset>
										<legend>Поле fax</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Факс">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[fax][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['fax']['description'][$language['language_id']]) ? $cust_fields['fax']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[fax][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['fax']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['fax']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[fax][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['fax']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['fax']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[fax][sort_order]" value="<?php echo isset($cust_fields['fax']['sort_order']) ? $cust_fields['fax']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>
									</fieldset>
									
									<fieldset>
										<legend>Поле company</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Компания">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[company][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['company']['description'][$language['language_id']]) ? $cust_fields['company']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[company][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['company']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['company']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[company][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['company']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['company']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[company][sort_order]" value="<?php echo isset($cust_fields['company']['sort_order']) ? $cust_fields['company']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>
									</fieldset>
									
									<fieldset>
										<legend>Поле address_1</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Адрес">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[address_1][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['address_1']['description'][$language['language_id']]) ? $cust_fields['address_1']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[address_1][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['address_1']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['address_1']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[address_1][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['address_1']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['address_1']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[address_1][sort_order]" value="<?php echo isset($cust_fields['address_1']['sort_order']) ? $cust_fields['address_1']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>	
									</fieldset>
									
									<fieldset>
										<legend>Поле address_2</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Адрес (дополнительно)">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[address_2][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['address_2']['description'][$language['language_id']]) ? $cust_fields['address_2']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[address_2][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['address_2']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['address_2']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[address_2][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['address_2']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['address_2']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[address_2][sort_order]" value="<?php echo isset($cust_fields['address_2']['sort_order']) ? $cust_fields['address_2']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>	
									</fieldset>
									
									<fieldset>
										<legend>Поле city</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Город">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[city][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['city']['description'][$language['language_id']]) ? $cust_fields['city']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[city][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['city']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['city']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[city][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['city']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['city']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[city][sort_order]" value="<?php echo isset($cust_fields['city']['sort_order']) ? $cust_fields['city']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>	
									</fieldset>
									
									<fieldset>
										<legend>Поле postcode</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Индекс">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[postcode][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['postcode']['description'][$language['language_id']]) ? $cust_fields['postcode']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[postcode][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['postcode']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['postcode']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[postcode][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['postcode']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['postcode']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[postcode][sort_order]" value="<?php echo isset($cust_fields['postcode']['sort_order']) ? $cust_fields['postcode']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>	
									</fieldset>
									
									<fieldset>
										<legend>Поле country_id</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Страна">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[country][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['country']['description'][$language['language_id']]) ? $cust_fields['country']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[country][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['country']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['country']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[country][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['country']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['country']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[country][sort_order]" value="<?php echo isset($cust_fields['country']['sort_order']) ? $cust_fields['country']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>	
									</fieldset>
									
									<fieldset>
										<legend>Поле zone_id</legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title"><span data-toggle="tooltip" title="" data-original-title="Если значение не задано, используется по умолчанию - Регион / Область">Название</span></label>
											<div class="col-sm-10">
												<?php foreach ($languages as $language) { ?>
													<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cust_fields[zone][description][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cust_fields['zone']['description'][$language['language_id']]) ? $cust_fields['zone']['description'][$language['language_id']] : ''; ?>" placeholder="Название"  class="form-control" />
													</div>
												<?php } ?>
											</div>	
										</div>
									  <div class="form-group">
										<label class="col-sm-2 control-label">Группа покупателей</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[zone][customer_group][<?php echo $customer_group['customer_group_id']; ?>][show]" value="1" <?php echo isset($cust_fields['zone']['customer_group'][$customer_group['customer_group_id']]['show']) && $cust_fields['zone']['customer_group'][$customer_group['customer_group_id']]['show'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>

										 </div>
									  </div>
		  
									  <div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<?php foreach ($customer_groups as $customer_group) { ?>
																	  <div class="checkbox">
											<label>
																<input type="checkbox" name="cust_fields[zone][customer_group][<?php echo $customer_group['customer_group_id']; ?>][required]" value="1" <?php echo isset($cust_fields['zone']['customer_group'][$customer_group['customer_group_id']]['required']) && $cust_fields['zone']['customer_group'][$customer_group['customer_group_id']]['required'] ? 'checked="checked"' : '' ?>>
											  <?php echo $customer_group['name']; ?>                                 </label>
										  </div>
										  <?php } ?>
											
																	</div>
									  </div>
									  
									  
									  <div class="form-group">
										<label class="col-sm-2 control-label" for="input-sort-order">Порядок сортировки</label>
										<div class="col-sm-10">
										  <input type="text" name="cust_fields[zone][sort_order]" value="<?php echo isset($cust_fields['zone']['sort_order']) ? $cust_fields['zone']['sort_order'] : 0 ; ?>" placeholder="Порядок сортировки" id="input-sort-order" class="form-control">
										</div>
									  </div>	
									</fieldset>
									
									<div class="alert alert-info" role="alert"><i class="fa fa-info-circle"></i> Для добавления дополнительного поля откройте раздел <a href="<?php echo $custom_field; ?>" target="_blank">Покупатели > Произвольные поля</a></div>
								
							</div>
						</div>
						
						<div class="tab-pane" id="tab-left-blog">
						<fieldset>
						<legend>Общая страница блога</legend>
							<div class="form-group">
								<label class="col-sm-2 control-label">HTML-тег Title</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="theme_lightshop_blog_meta_title<?php echo $language['language_id']; ?>" value="<?php echo !empty(${'theme_lightshop_blog_meta_title' . $language['language_id']}) ? ${'theme_lightshop_blog_meta_title' . $language['language_id']} : ''; ?>" placeholder="HTML-тег Title" id="input-theme_lightshop_blog_meta_title<?php echo $language['language_id']; ?>" class="form-control" />
										</div>
									<?php } ?>
								</div>	
							</div>	
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_blog_meta_description">Мета-тег Description</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<textarea name="theme_lightshop_blog_meta_description<?php echo $language['language_id']; ?>" rows="5" placeholder="Мета-тег Description" class="form-control" id="input-theme_lightshop_blog_meta_description<?php echo $language['language_id']; ?>"><?php echo !empty(${'theme_lightshop_blog_meta_description' . $language['language_id']}) ? ${'theme_lightshop_blog_meta_description' . $language['language_id']} : ''; ?></textarea>
										</div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_blog_meta_keyword">Мета-тег Keywords</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<textarea name="theme_lightshop_blog_meta_keyword<?php echo $language['language_id']; ?>" rows="5" placeholder="Мета-тег Keywords" class="form-control" id="input-theme_lightshop_blog_meta_keyword<?php echo $language['language_id']; ?>"><?php echo !empty(${'theme_lightshop_blog_meta_keyword' . $language['language_id']}) ? ${'theme_lightshop_blog_meta_keyword' . $language['language_id']} : ''; ?></textarea>
										</div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group required">
							  <label class="col-sm-2 control-label" for="input-theme_lightshop_blog_limit"><span data-toggle="tooltip" title="Сколько записей блога показывать на одной странице"><?php echo $entry_product_limit; ?></span></label>
							  <div class="col-sm-10">
								<input type="text" name="theme_lightshop_blog_limit" value="<?php echo $theme_lightshop_blog_limit; ?>" placeholder="<?php echo $entry_product_limit; ?>" id="input-theme_lightshop_blog_limit" class="form-control" />
								<?php if ($error_blog_limit) { ?>
								<div class="text-danger"><?php echo $error_blog_limit; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="URL блога с категорией">URL блога с категорией</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_blog_path == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_blog_path" id="theme_lightshop_blog_path-1" autocomplete="off" <?php echo $theme_lightshop_blog_path == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_blog_path == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_blog_path" id="theme_lightshop_blog_path-0" autocomplete="off" <?php echo $theme_lightshop_blog_path == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
						</fieldset>
						<fieldset>
						<legend>Запись блога</legend>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Отображать фоновое изображение в записи блога">Фон в записи</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_blog_background == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_blog_background" id="theme_lightshop_blog_background-1" autocomplete="off" <?php echo $theme_lightshop_blog_background == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_blog_background == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_blog_background" id="theme_lightshop_blog_background-0" autocomplete="off" <?php echo $theme_lightshop_blog_background == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">Разрешить отзывы</label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_blog_rev_st == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_blog_rev_st" id="theme_lightshop_blog_rev_st-1" autocomplete="off" <?php echo $theme_lightshop_blog_rev_st == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_blog_rev_st == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_blog_rev_st" id="theme_lightshop_blog_rev_st-0" autocomplete="off" <?php echo $theme_lightshop_blog_rev_st == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Разрешить гостям оставлять отзывы. В противном случае, оставлять отзывы смогут только зарегистрированные покупатели!">Отзывы от гостей</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_blog_rev_guest == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_blog_rev_guest" id="theme_lightshop_blog_rev_guest-1" autocomplete="off" <?php echo $theme_lightshop_blog_rev_guest == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_blog_rev_guest == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_blog_rev_guest" id="theme_lightshop_blog_rev_guest-0" autocomplete="off" <?php echo $theme_lightshop_blog_rev_guest == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Публиковать отзывы без модерации.">Отзывы без модерации</span></label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_blog_rev_moder == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_blog_rev_moder" id="theme_lightshop_blog_rev_moder-1" autocomplete="off" <?php echo $theme_lightshop_blog_rev_moder == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_blog_rev_moder == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_blog_rev_moder" id="theme_lightshop_blog_rev_moder-0" autocomplete="off" <?php echo $theme_lightshop_blog_rev_moder == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>
						</fieldset>
						</div>
						
					</div>
				</div>			
			
			
			
			
			
			
			
		
			</div>
			<div class="tab-pane" id="tab-footer">
				<div class="tabbable tabs-left">
					<ul id="vtab-option" class="nav nav-tabs">					
						<li class="active"><a href="#tab-left-footer-all" data-toggle="tab">Основные настройки</a></li>
						<li><a href="#tab-left-footer-logo-text" data-toggle="tab">Логотип и тексты</a></li>
						<li><a href="#tab-left-footer-menu" data-toggle="tab">Нижнее мега-меню</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-left-footer-all">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-lightshop-footer-type">Тип футера</label>
								<div class="col-sm-10">
									<label class="radio"><input type="radio" name="theme_lightshop_footer_type" value="1" <?php echo $theme_lightshop_footer_type == '1' ? 'checked="checked"' : '' ?> > <img class="thumbnail img-responsive" src="view/image/lightshop/footer-type-1.png"></label>
									<label class="radio"><input type="radio" name="theme_lightshop_footer_type" value="2" <?php echo $theme_lightshop_footer_type == '2' ? 'checked="checked"' : '' ?> > <img class="thumbnail img-responsive" src="view/image/lightshop/footer-type-2.png"></label>
								</div>
							</div>	
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-lightshop-footer-type">Соц. сети</label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_footer_soc_stat == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_footer_soc_stat" id="theme_lightshop_footer_soc_stat-1" autocomplete="off" <?php echo $theme_lightshop_footer_soc_stat == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_footer_soc_stat == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_footer_soc_stat" id="theme_lightshop_footer_soc_stat-0" autocomplete="off" <?php echo $theme_lightshop_footer_soc_stat == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>	
								</div>
							</div>	
							
						</div>
					
						<div class="tab-pane" id="tab-left-footer-logo-text">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-lightshop-footer-text-logo">Текстовый логотип или svg код</label>
								<div class="col-sm-6">
									<textarea name="theme_lightshop_footer_text_logo" rows="5" placeholder="Текстовый логотип или svg код" id="input-theme_lightshop_footer_text_logo" class="form-control code"><?php echo $theme_lightshop_footer_text_logo; ?></textarea>
								</div>
								<label class="col-sm-2 control-label" for="input-lightshop-header-text-logo">Статус</label>
								<div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $theme_lightshop_footer_t_logo == '1' ? 'active' : '' ?>">
											<input value="1" type="radio" name="theme_lightshop_footer_t_logo" autocomplete="off" <?php echo $theme_lightshop_footer_t_logo == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $theme_lightshop_footer_t_logo == '0' ? 'active' : '' ?>">
											<input value="0" type="radio" name="theme_lightshop_footer_t_logo" autocomplete="off" <?php echo $theme_lightshop_footer_t_logo == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>
								</div>								
							</div>
							  
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-footer_logo">Логотип внизу сайта</label>
								<div class="col-sm-10">
								<a href="" id="thumb-footer_logo" data-toggle="image" class="img-thumbnail"><img src="<?php echo $footer_logo; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
								<input type="hidden" name="theme_lightshop_footer_logo" value="<?php echo $theme_lightshop_footer_logo; ?>" id="input-footer_logo" />
								</div>
							</div>	
							
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_footer_text">Тектовый блок</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<textarea name="theme_lightshop_footer_text<?php echo $language['language_id']; ?>" rows="5" placeholder="Тектовый блок" class="form-control" id="input-theme_lightshop_footer_text<?php echo $language['language_id']; ?>"><?php echo !empty(${'theme_lightshop_footer_text' . $language['language_id']}) ? ${'theme_lightshop_footer_text' . $language['language_id']} : ''; ?></textarea>
										</div>
									<?php } ?>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_footer_copyright">Копирайт</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="theme_lightshop_footer_copyright<?php echo $language['language_id']; ?>" value="<?php echo !empty(${'theme_lightshop_footer_copyright' . $language['language_id']}) ? ${'theme_lightshop_footer_copyright' . $language['language_id']} : ''; ?>" placeholder="Копирайт" id="input-theme_lightshop_footer_copyright<?php echo $language['language_id']; ?>" class="form-control" />
										</div>
									<?php } ?>
								</div>	
							</div>
							
						</div>
						<div class="tab-pane" id="tab-left-footer-menu">
						
							<div class="table table-responsive">
								<table id="footer_nav" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
										  <td class="text-left">Название колонки</td>
										  <td class="text-left">Контент</td>
										  <td class="text-left">Порядок сортировки</td>
										  <td></td>
										</tr>
									</thead>				
									<tbody>
										<?php $footer_nav_row = 0; ?>
										<?php foreach ($footer_navs as $footer_nav_row => $footer_nav) { ?>
										<tr id="footer-nav-row<?php echo $footer_nav_row; ?>"><!-- Ссылки -->
										<td class="text-left">
						     <?php foreach ($languages as $language) { ?>
							<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
								<input type="text" name="theme_lightshop_footer_nav[<?php echo $footer_nav_row; ?>][language][<?php echo  $language['language_id'] ?>][name]" value="<?php echo isset($footer_nav['language'][$language['language_id']]['name']) ? $footer_nav['language'][$language['language_id']]['name'] : ''; ?>" placeholder="Название подменю" class="form-control">
							</div>
                			   	    <?php } ?>	
										</td>
										<td class="text-left">
										<select  name="theme_lightshop_footer_nav[<?php echo $footer_nav_row; ?>][settype]" for="<?php echo $footer_nav_row; ?>" class="form-control footer_nav_select_type">
										   <?php foreach ($footer_nav_types as $key => $footer_nav_type) { ?>
											<?php if ($key == $footer_nav['settype']) { ?>
											   <option value="<?php echo $key; ?>" selected="selected"><?php echo $footer_nav_type; ?></option>
											<?php } else { ?>
											   <option value="<?php echo $key; ?>" ><?php echo $footer_nav_type; ?></option>
											<?php } ?>
										   <?php } ?>	
										</select>
							  <div id="footer_nav-<?php echo $footer_nav_row; ?>-0" class="footer_nav-<?php echo $footer_nav_row; ?>" style="display:<?php if(!$footer_nav['settype']){ ?>block<?php }else{ ?>none<?php } ?>">
								<div style="position: relative;">
								  <input type="text" name="footer_nav[<?php echo $footer_nav_row; ?>][type][0][linksmain]" for="<?php echo $footer_nav_row; ?>-0" value="" placeholder="Ссылки" id="input-related" class="form-control footer_nav_links" autocomplete="off">
									  <div id="footer_nav-<?php echo $footer_nav_row; ?>-0-links" class="well well-sm" style="overflow: auto;">
									<?php $linksrow = 0; ?>
									 <?php if(isset($footer_nav['type'][0]['links'])){ ?>
									<?php foreach ($footer_nav['type'][0]['links'] as $id => $link) { ?>
										<?php if(isset($top_links[$id])){ ?>
									  <div id="footer_nav-<?php echo $footer_nav_row; ?>-links-<?php echo $id; ?>"><i class="fa fa-minus-circle"></i><?php echo key($top_links[$id]); ?><input type="hidden" name="theme_lightshop_footer_nav[<?php echo $footer_nav_row; ?>][type][0][links][<?php echo $id; ?>]" value="<?php echo $link; ?>"></div> 
									    <?php } ?>
									<?php $linksrow++; ?>
										<?php } ?>
									 <?php } ?>
									  </div>
								</div>
							  </div>
							  <div id="footer_nav-<?php echo $footer_nav_row; ?>-1" class="footer_nav-<?php echo $footer_nav_row; ?>" style="display:<?php if($footer_nav['settype']){ ?>block<?php }else{ ?>none<?php } ?>">
								<div style="position: relative;">
									  <div id="footer_nav-<?php echo $footer_nav_row; ?>-1-links" class="well well-sm" style="overflow: auto;">
										<div class="input-group"><span class="input-group-addon"><i data-toggle="tooltip" data-original-title="Можно использовать html" class="fa fa-code"></i></span>
											<textarea name="theme_lightshop_footer_nav[<?php echo $footer_nav_row; ?>][type][1][links][html]" rows="5" placeholder="html контент" class="form-control code" ><?php echo $footer_nav['type'][1]['links']['html']; ?></textarea>
										</div>
								</div>		
							  </div>
									  </div>								
										</td>
										<td class="text-left"><input type="text" name="theme_lightshop_footer_nav[<?php echo $footer_nav_row; ?>][sort]" value="<?php echo $footer_nav['sort']; ?>" placeholder="Порядок сортировки" class="form-control"></td>
											<td class="text-right"><button type="button" onclick="$('#footer-nav-row<?php echo $footer_nav_row; ?>').remove();" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="Удалить"><i class="fa fa-minus-circle"></i></button></td>
										</tr>

					<?php $footer_nav_row++; ?>
					<?php } ?>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="3"></td>
											<td class="text-right">
												<button type="button" onclick="addFooter_nav();" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="Добавить"><i class="fa fa-plus-circle"></i></button>
											</td>
										</tr>
									</tfoot>
								</table>
							</div>



			
						</div>
					</div>
				</div>

			</div>
			<div class="tab-pane" id="tab-widgets">
				<div class="tabbable tabs-left">
					<ul id="vtab-option" class="nav nav-tabs">					
						<li class="active"><a href="#tab-left-callback" data-toggle="tab">Заказ звонка</a></li>
						<li><a href="#tab-left-newsletter" data-toggle="tab">Подписка на новости</a></li>
						<li><a href="#tab-left-links" data-toggle="tab">Дополнительные ссылки</a></li>
						<li><a href="#tab-left-soc" data-toggle="tab">Соц. сети</a></li>
						<li><a href="#tab-left-soc-share" data-toggle="tab">Кнопки соц. сетей (share)</a></li>
						<li><a href="#tab-left-stiker" data-toggle="tab">Стикеры</a></li>
						<li><a href="#tab-left-buy-click" data-toggle="tab">Быстрый заказ</a></li>
						<li><a href="#tab-left-scrolltotop" data-toggle="tab">Кнопка наверх</a></li>
						<li><a href="#tab-left-pdata" data-toggle="tab">Персональные данные</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-left-callback">
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
							  <div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo $theme_lightshop_callback_status == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_callback_status" id="theme_lightshop_callback_status-1" autocomplete="off" <?php echo $theme_lightshop_callback_status == '1' ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo $theme_lightshop_callback_status == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_callback_status" id="theme_lightshop_callback_status-0" autocomplete="off" <?php echo $theme_lightshop_callback_status == '0' ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							  </div>					  
							</div>	
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Использовать выбранную Captcha-службу в форме заказа звонка.">Captcha</span></label>
								<div class="col-sm-10">
									<select name="theme_lightshop_config_captcha_cb" id="input-captcha" class="form-control">
				                      <option value=""><?php echo $text_none; ?></option>
				                      <?php foreach ($captchas as $captcha) { ?>
				                      <?php if ($captcha['value'] == $theme_lightshop_config_captcha_cb) { ?>
				                      <option value="<?php echo $captcha['value']; ?>" selected="selected"><?php echo $captcha['text']; ?></option>
				                      <?php } else { ?>
				                      <option value="<?php echo $captcha['value']; ?>"><?php echo $captcha['text']; ?></option>
				                      <?php } ?>
				                      <?php } ?>
									</select>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-left-newsletter">
						
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
							  <div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo $theme_lightshop_subscribe_status == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_subscribe_status" id="theme_lightshop_subscribe_status-1" autocomplete="off" <?php echo $theme_lightshop_subscribe_status == '1' ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo $theme_lightshop_subscribe_status == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_subscribe_status" id="theme_lightshop_subscribe_status-0" autocomplete="off" <?php echo $theme_lightshop_subscribe_status == '0' ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							  </div>							  
							</div>	
							
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-status">Оповещение e-mail администратору</label>
							  <div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo $theme_lightshop_subscribe_email_alert == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_subscribe_email_alert" id="theme_lightshop_subscribe_email_alert-1" autocomplete="off" <?php echo $theme_lightshop_subscribe_email_alert == '1' ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo $theme_lightshop_subscribe_email_alert == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_subscribe_email_alert" id="theme_lightshop_subscribe_email_alert-0" autocomplete="off" <?php echo $theme_lightshop_subscribe_email_alert == '0' ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							  </div>							  
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Текст заголовка внизу сайта">Заголовок</span></label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="theme_lightshop_subscribe_title<?php echo $language['language_id']; ?>" value="<?php echo !empty(${'theme_lightshop_subscribe_title' . $language['language_id']}) ? ${'theme_lightshop_subscribe_title' . $language['language_id']} : ''; ?>" placeholder="Заголовок" id="input-theme_lightshop_subscribe_title<?php echo $language['language_id']; ?>" class="form-control" />
										</div>
									<?php } ?>
								</div>	
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Текст подзаголовка внизу сайта">Подзаголовок</span></label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="theme_lightshop_subscribe_subtitle<?php echo $language['language_id']; ?>" value="<?php echo !empty(${'theme_lightshop_subscribe_subtitle' . $language['language_id']}) ? ${'theme_lightshop_subscribe_subtitle' . $language['language_id']} : ''; ?>" placeholder="Подзаголовок" id="input-theme_lightshop_subscribe_subtitle<?php echo $language['language_id']; ?>" class="form-control" />
										</div>
									<?php } ?>
								</div>	
							</div>	
						</div>
						<div class="tab-pane" id="tab-left-links">
							<div class="alert alert-info" role="alert"><i class="fa fa-info-circle"></i> Дополнительные ссылки могут быть добавлены: Верх сайта > Верхнее мега-меню, Верх сайта > Главное мега-меню, Низ сайта > Нижнее мега-меню.</div>
						
							<div class="table table-responsive">
							<table id="links" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
								  <td class="text-left">Название</td>
								  <td class="text-left">Ссылка</td>
								  <td class="text-left">Атрибут</td>
								  <td class="text-left">Сортировка</td>
								  <td></td>
								</tr>
							</thead>
							<tbody>
							<?php $links_row = 0; ?>
							    <?php foreach ($theme_lightshop_vidg_extlinks as $extlink) { ?>
								<tr id="links-row<?php echo $links_row; ?>">
								<td class="text-left">
                						<?php foreach ($languages as $language) { ?>
									<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
										<input type="text" name="theme_lightshop_vidg_extlinks[<?php echo $links_row; ?>][description][<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($theme_lightshop_vidg_extlinks[$links_row]['description'][$language['language_id']]) ? $theme_lightshop_vidg_extlinks[$links_row]['description'][$language['language_id']]['name'] : ''; ?>" placeholder="Название" class="form-control">
									</div>
                						<?php } ?>
								</td>
								<td class="text-left">
								<?php foreach ($languages as $language) { ?>
									<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
									<input type="text" name="theme_lightshop_vidg_extlinks[<?php echo $links_row; ?>][link][<?php echo $language['language_id']; ?>]" value="<?php echo isset($extlink['link'][$language['language_id']]) ? $extlink['link'][$language['language_id']] : ''; ?>" placeholder="Ссылка" class="form-control">
									</div>
								<?php } ?>
								</td>
								<td class="text-left">
									<select id="target" name="theme_lightshop_vidg_extlinks[<?php echo $links_row; ?>][attr]" class="form-control">
                    							<?php foreach ($theme_lightshop_vidg_extlinks_targets as $key => $target) { ?>
                  								  <?php if ($target == $theme_lightshop_vidg_extlinks[$links_row]['attr']) { ?>
                								    <option value="<?php echo $key; ?>" selected="selected"><?php echo $target; ?></option>
              									  <?php } else { ?>
                 								    <option value="<?php echo $key; ?>"><?php echo $target; ?></option>
                 								   <?php } ?>

                    							<?php } ?>
									</select>
								</td>
								<td class="text-left"><input type="text" name="theme_lightshop_vidg_extlinks[<?php echo $links_row; ?>][sort]" value="<?php echo $theme_lightshop_vidg_extlinks[$links_row]['sort']; ?>" placeholder="Сортировка" class="form-control"></td>
								<td class="text-right"><button type="button" onclick="$('#links-row<?php echo $links_row; ?>').remove();" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="Удалить"><i class="fa fa-minus-circle"></i></button></td>
								</tr>
								<?php $links_row++; ?>	
                    					     <?php } ?>

							</tbody>
							  <tfoot>
								<tr>
								  <td colspan="4"></td>
								  <td class="text-right">
								  <button type="button" onclick="addLinks();" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="Добавить ссылку"><i class="fa fa-plus-circle"></i></button>
								</td>
								</tr>
							  </tfoot>
							</table>
						  </div>
						</div>
						<div class="tab-pane" id="tab-left-soc">

						
							<div class="table table-responsive">
							<table id="social_nav" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
								  <td class="text-left">Соц. сеть</td>
								  <td class="text-left">Название</td>
								  <td class="text-left">Ссылка</td>
								  <td class="text-left">Атрибут</td>
								  <td></td>
								</tr>
							</thead>
							<tbody>
							<?php $social_nav_row = 0; ?>
							<?php foreach ($social_navs as $social_nav_row => $social_nav) { ?>
								<tr id="social-nav-row<?php echo $social_nav_row; ?>">
								<td class="text-left">
										<select  name="theme_lightshop_social_nav[<?php echo $social_nav_row; ?>][settype]" for="<?php echo $social_nav_row; ?>" class="form-control social_nav_select_type">
										   <?php foreach ($social_nav_types as $key => $social_nav_type) { ?>
											<?php if ($key == $social_nav['settype']) { ?>
											   <option value="<?php echo $key; ?>" selected="selected"><?php echo $social_nav_type; ?></option>
											<?php } else { ?>
											   <option value="<?php echo $key; ?>" ><?php echo $social_nav_type; ?></option>
											<?php } ?>
										   <?php } ?>	
										</select>
								</td>
								<td class="text-left">
									 <?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
											<input type="text" name="theme_lightshop_social_nav[<?php echo $social_nav_row; ?>][language][<?php echo  $language['language_id'] ?>][name]" value="<?php echo isset($social_nav['language'][$language['language_id']]['name']) ? $social_nav['language'][$language['language_id']]['name'] : '' ;?>" placeholder="Название подменю" class="form-control">
										</div>
									 <?php } ?>	
								</td>
								<td class="text-left"><input type="text" name="theme_lightshop_social_nav[<?php echo $social_nav_row; ?>][link]" value="<?php echo $social_nav['link']; ?>" placeholder="Ссылка" class="form-control"></td>
								<td class="text-left">
									<select id="target_soc" name="theme_lightshop_social_nav[<?php echo $social_nav_row; ?>][attr]" class="form-control">
                    							<?php foreach ($theme_lightshop_vidg_extlinks_targets as $key => $target) { ?>
                  								  <?php if ($target == $social_nav['attr']) { ?>
                								    <option value="<?php echo $key; ?>" selected="selected"><?php echo $target; ?></option>
              									  <?php } else { ?>
                 								    <option value="<?php echo $key; ?>"><?php echo $target; ?></option>
                 								   <?php } ?>

                    							<?php } ?>
									</select>
								</td>
								<td class="text-right"><button type="button" data-toggle="tooltip" onclick="$('#social-nav-row<?php echo $social_nav_row; ?>').remove();" title="" class="btn btn-danger" data-original-title="Удалить"><i class="fa fa-minus-circle"></i></button></td>
								</tr>
							<?php $social_nav_row++; ?>
							<?php } ?>
							</tbody>
							  <tfoot>
								<tr>
								  <td colspan="4"></td>
								  <td class="text-right">
								  <button type="button" onclick="addSocial_nav();" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="Добавить соц. сеть"><i class="fa fa-plus-circle"></i></button>
								</td>
								</tr>
							  </tfoot>
							</table>
						  </div>
						</div>
						
						<div class="tab-pane" id="tab-left-soc-share">
						
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-theme_lightshop_soc_share_prod">Показывать на страницах товаров</label>
							  <div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo $theme_lightshop_soc_share_prod == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_soc_share_prod" id="theme_lightshop_soc_share_prod-1" autocomplete="off" <?php echo $theme_lightshop_soc_share_prod == '1' ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo $theme_lightshop_soc_share_prod == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_soc_share_prod" id="theme_lightshop_soc_share_prod-0" autocomplete="off" <?php echo $theme_lightshop_soc_share_prod == '0' ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							  </div>							  
							</div>
							
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-theme_lightshop_soc_share_blog">Показывать на страницах блога</label>
							  <div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo $theme_lightshop_soc_share_blog == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_soc_share_blog" id="theme_lightshop_soc_share_blog-1" autocomplete="off" <?php echo $theme_lightshop_soc_share_blog == '1' ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo $theme_lightshop_soc_share_blog == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_soc_share_blog" id="theme_lightshop_soc_share_blog-0" autocomplete="off" <?php echo $theme_lightshop_soc_share_blog == '0' ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							  </div>							  
							</div>
							
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-theme_lightshop_soc_share_code"><span data-toggle="tooltip" title="" data-original-title="Если поле пустое, используется код кнопок www.addthis.com">Код share кнопок</span></label>
							  <div class="col-sm-10">
								<textarea name="theme_lightshop_soc_share_code" rows="10" placeholder="Код share кнопок" id="input-theme_lightshop_soc_share_code" class="form-control code"><?php echo $theme_lightshop_soc_share_code; ?></textarea>
							  </div>
							</div>						
						</div>	
						
						<div class="tab-pane" id="tab-left-stiker">
						<fieldset>
							<legend>СТИКЕР НОВИНКА</legend>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
								  <div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $labels['new']['status'] == '1' ? 'active' : '' ?>">
											<input value="1" type="radio" name="theme_lightshop_label[new][status]" autocomplete="off" <?php echo $labels['new']['status'] == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $labels['new']['status'] == '0' ? 'active' : '' ?>">
											<input value="0" type="radio" name="theme_lightshop_label[new][status]" autocomplete="off" <?php echo $labels['new']['status'] == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>
								  </div>	
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_label_new">Название</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="theme_lightshop_label[new][name][<?php echo $language['language_id']; ?>]" value="<?php echo !empty($labels['new']['name'][$language['language_id']]) ? $labels['new']['name'][$language['language_id']] : ''; ?>" placeholder="Название" id="input-theme_lightshop_label[new][name]<?php echo $language['language_id']; ?>" class="form-control" />
										</div>
									<?php } ?>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="Период активности после добавления товара">Активен</span></label>
								<div class="col-sm-10">
									<select name="theme_lightshop_label[new][period]" class="form-control">
                   							<?php foreach ($theme_lightshop_label_new_periods as $key => $period) { ?>
                  								  <?php if ($key == $labels['new']['period']) { ?>
                								    <option value="<?php echo $key; ?>" selected="selected"><?php echo $period; ?></option>
              									  <?php } else { ?>
                 								    <option value="<?php echo $key; ?>"><?php echo $period; ?></option>
                 								   <?php } ?>
                    							<?php } ?>
									</select>
								</div>	
							</div>	
						</fieldset>	
						<fieldset>
							<legend>СТИКЕР СКИДКА</legend>
							<div class="alert alert-info" role="alert"><i class="fa fa-info-circle"></i> Отображается у товаров где добавлена цена по акции (есть перечеркнутая цена).</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
								  <div class="col-sm-2">
									<div class="btn-group on-off" data-toggle="buttons">
										<label class="btn btn-default btn-on <?php echo $labels['sale']['status'] == '1' ? 'active' : '' ?>">
											<input value="1" type="radio" name="theme_lightshop_label[sale][status]" autocomplete="off" <?php echo $labels['sale']['status'] == '1' ? 'checked' : '' ?>>Вкл.
										</label>
										<label class="btn btn-default btn-off <?php echo $labels['sale']['status'] == '0' ? 'active' : '' ?>">
											<input value="0" type="radio" name="theme_lightshop_label[sale][status]" autocomplete="off" <?php echo $labels['sale']['status'] == '0' ? 'checked' : '' ?>>Откл.
										</label>
									</div>
								  </div>	
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_label_sale">Название</label>
								<div class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="theme_lightshop_label[sale][name][<?php echo $language['language_id']; ?>]" value="<?php echo !empty($labels['sale']['name'][$language['language_id']]) ? $labels['sale']['name'][$language['language_id']] : ''; ?>" placeholder="Название" id="input-theme_lightshop_label_sale<?php echo $language['language_id']; ?>" class="form-control" />
										</div>
									<?php } ?>
								</div>	
							</div>	
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-theme_lightshop_label_sale_d">Дополнительный элемент</label>
								<div class="col-sm-10">
									 <?php foreach ($theme_lightshop_label_sale_extras as $key => $extra) { ?>
                  								  <?php if ($key == $labels['sale']['extra']) { ?>
                								    <label class="radio"><input type="radio" name="theme_lightshop_label[sale][extra]" value="<?php echo $key; ?>" checked="checked" ><?php echo $extra; ?></label>
              									  <?php } else { ?>
                 								    <label class="radio"><input type="radio" name="theme_lightshop_label[sale][extra]" value="<?php echo $key; ?>" ><?php echo $extra; ?></label>
                 								   <?php } ?>

									<?php } ?>
								</div>	
							</div>	
						</fieldset>								
						</div>

						<div class="tab-pane" id="tab-left-buy-click">
							<div class="alert alert-info" role="alert"><i class="fa fa-info-circle"></i> Настройки для функционала "Купить в один клик" (в карточке товара, каталоге и быстром просмотре) и "Быстрый заказ" (в стандартной и всплывающей корзине)</div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
							  <div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo (!isset($buy_click['status']) || $buy_click['status']) ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_buy_click[status]" id="theme_lightshop_buy_click_status-1" autocomplete="off" <?php echo (!isset($buy_click['status']) || $buy_click['status']) ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo (isset($buy_click['status']) && !$buy_click['status']) ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_buy_click[status]" id="theme_lightshop_buy_click_status-0" autocomplete="off" <?php echo (isset($buy_click['status']) && !$buy_click['status']) ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							  </div>							  
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="Использовать выбранную Captcha-службу в форме быстрого заказа.">Captcha</span></label>
								<div class="col-sm-10">
									<select name="theme_lightshop_config_captcha_fo" id="input-captcha" class="form-control">
				                      <option value=""><?php echo $text_none; ?></option>
				                      <?php foreach ($captchas as $captcha) { ?>
				                      <?php if ($captcha['value'] == $theme_lightshop_config_captcha_fo) { ?>
				                      <option value="<?php echo $captcha['value']; ?>" selected="selected"><?php echo $captcha['text']; ?></option>
				                      <?php } else { ?>
				                      <option value="<?php echo $captcha['value']; ?>"><?php echo $captcha['text']; ?></option>
				                      <?php } ?>
				                      <?php } ?>
									</select>
								</div>
							</div>
							<fieldset>
								<legend>Поле firstname</legend>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title">Название</label>
										<div class="col-sm-10">
											<?php foreach ($languages as $language) { ?>
												<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
												<input type="text" name="theme_lightshop_buy_click[firstname][name][<?php echo $language['language_id']  ?>]" value="<?php echo isset( $buy_click['firstname']['name'][$language['language_id']]) ? $buy_click['firstname']['name'][$language['language_id']]  : '' ; ?>" placeholder="Название"  class="form-control" />
												</div>
											<?php } ?>
										</div>	
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<label class="radio-inline"><input type="radio" name="theme_lightshop_buy_click[firstname][required]" value="1" <?php echo (!isset($buy_click['firstname']['required']) || $buy_click['firstname']['required']) ? 'checked' : '' ?>> Да</label>
											<label class="radio-inline"><input type="radio" name="theme_lightshop_buy_click[firstname][required]" value="0" <?php echo (isset($buy_click['firstname']['required']) && !$buy_click['firstname']['required']) ? 'checked' : '' ?>> Нет</label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
										<div class="col-sm-2">
											<div class="btn-group on-off" data-toggle="buttons">
												<label class="btn btn-default btn-on <?php echo (!isset($buy_click['firstname']['status']) || $buy_click['firstname']['status']) ? 'active' : '' ?>">
													<input value="1" type="radio" name="theme_lightshop_buy_click[firstname][status]" id="theme_lightshop_buy_click_firstname_status-1" autocomplete="off" <?php echo (!isset($buy_click['firstname']['status']) || $buy_click['firstname']['status']) ? 'checked' : '' ?>>Вкл.
												</label>
												<label class="btn btn-default btn-off <?php echo (isset($buy_click['firstname']['status']) && !$buy_click['firstname']['status']) ? 'active' : '' ?>">
													<input value="0" type="radio" name="theme_lightshop_buy_click[firstname][status]" id="theme_lightshop_buy_click_firstname_status-0" autocomplete="off" <?php echo (isset($buy_click['firstname']['status']) && !$buy_click['firstname']['status']) ? 'checked' : '' ?>>Откл.
												</label>
											</div>
										</div>							  
									</div>
							</fieldset>
							<fieldset>
								<legend>Поле email</legend>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title">Название</label>
										<div class="col-sm-10">
											<?php foreach ($languages as $language) { ?>
												<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
												<input type="text" name="theme_lightshop_buy_click[email][name][<?php echo $language['language_id']  ?>]" value="<?php echo isset( $buy_click['email']['name'][$language['language_id']]) ? $buy_click['email']['name'][$language['language_id']]  : '' ; ?>" placeholder="Название"  class="form-control" />
												</div>
											<?php } ?>
										</div>	
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<label class="radio-inline"><input type="radio" name="theme_lightshop_buy_click[email][required]" value="1" <?php echo (isset($buy_click['email']['required']) && $buy_click['email']['required']) ? 'checked' : '' ?>> Да</label>
											<label class="radio-inline"><input type="radio" name="theme_lightshop_buy_click[email][required]" value="0" <?php echo (!isset($buy_click['email']['required']) || !$buy_click['email']['required']) ? 'checked' : '' ?>> Нет</label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
										<div class="col-sm-2">
											<div class="btn-group on-off" data-toggle="buttons">
												<label class="btn btn-default btn-on <?php echo (isset($buy_click['email']['status']) && $buy_click['email']['status']) ? 'active' : '' ?>">
													<input value="1" type="radio" name="theme_lightshop_buy_click[email][status]" id="theme_lightshop_buy_click_email_status-1" autocomplete="off" <?php echo (isset($buy_click['email']['status']) && $buy_click['email']['status']) ? 'checked' : '' ?>>Вкл.
												</label>
												<label class="btn btn-default btn-off <?php echo (!isset($buy_click['email']['status']) || !$buy_click['email']['status']) ? 'active' : '' ?>">
													<input value="0" type="radio" name="theme_lightshop_buy_click[email][status]" id="theme_lightshop_buy_click_email_status-0" autocomplete="off" <?php echo (!isset($buy_click['email']['status']) || !$buy_click['email']['status']) ? 'checked' : '' ?>>Откл.
												</label>
											</div>
										</div>							  
									</div>
							</fieldset>
							<fieldset>
								<legend>Поле telephone</legend>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title">Название</label>
										<div class="col-sm-10">
											<?php foreach ($languages as $language) { ?>
												<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
												<input type="text" name="theme_lightshop_buy_click[telephone][name][<?php echo $language['language_id']  ?>]" value="<?php echo isset( $buy_click['telephone']['name'][$language['language_id']]) ? $buy_click['telephone']['name'][$language['language_id']]  : '' ; ?>" placeholder="Название"  class="form-control" />
												</div>
											<?php } ?>
										</div>	
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<label class="radio-inline"><input type="radio" name="theme_lightshop_buy_click[telephone][required]" value="1" <?php echo (!isset($buy_click['telephone']['required']) || $buy_click['telephone']['required']) ? 'checked' : '' ?>> Да</label>
											<label class="radio-inline"><input type="radio" name="theme_lightshop_buy_click[telephone][required]" value="0" <?php echo (isset($buy_click['telephone']['required']) && !$buy_click['telephone']['required']) ? 'checked' : '' ?>> Нет</label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
										<div class="col-sm-2">
											<div class="btn-group on-off" data-toggle="buttons">
												<label class="btn btn-default btn-on <?php echo (!isset($buy_click['telephone']['status']) || $buy_click['telephone']['status']) ? 'active' : '' ?>">
													<input value="1" type="radio" name="theme_lightshop_buy_click[telephone][status]" id="theme_lightshop_buy_click_telephone_status-1" autocomplete="off" <?php echo (!isset($buy_click['telephone']['status']) || $buy_click['telephone']['status']) ? 'checked' : '' ?>>Вкл.
												</label>
												<label class="btn btn-default btn-off <?php echo (isset($buy_click['telephone']['status']) && !$buy_click['telephone']['status']) ? 'active' : '' ?>">
													<input value="0" type="radio" name="theme_lightshop_buy_click[telephone][status]" id="theme_lightshop_buy_click_telephone_status-0" autocomplete="off" <?php echo (isset($buy_click['telephone']['status']) && !$buy_click['telephone']['status']) ? 'checked' : '' ?>>Откл.
												</label>
											</div>
										</div>							  
									</div>
							</fieldset>
							<fieldset>
								<legend>Поле comment</legend>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-theme_lightshop_che_st2_title">Название</label>
										<div class="col-sm-10">
											<?php foreach ($languages as $language) { ?>
												<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
												<input type="text" name="theme_lightshop_buy_click[comment][name][<?php echo $language['language_id']  ?>]" value="<?php echo isset( $buy_click['comment']['name'][$language['language_id']]) ? $buy_click['comment']['name'][$language['language_id']]  : '' ; ?>" placeholder="Название"  class="form-control" />
												</div>
											<?php } ?>
										</div>	
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">Обязательно</label>
										<div class="col-sm-10">
											<label class="radio-inline"><input type="radio" name="theme_lightshop_buy_click[comment][required]" value="1" <?php echo (isset($buy_click['comment']['required']) && $buy_click['comment']['required']) ? 'checked' : '' ?>> Да</label>
											<label class="radio-inline"><input type="radio" name="theme_lightshop_buy_click[comment][required]" value="0" <?php echo (!isset($buy_click['comment']['required']) || !$buy_click['comment']['required']) ? 'checked' : '' ?>> Нет</label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
										<div class="col-sm-2">
											<div class="btn-group on-off" data-toggle="buttons">
												<label class="btn btn-default btn-on <?php echo (!isset($buy_click['comment']['status']) || $buy_click['comment']['status']) ? 'active' : '' ?>">
													<input value="1" type="radio" name="theme_lightshop_buy_click[comment][status]" id="theme_lightshop_buy_click_comment_status-1" autocomplete="off" <?php echo (!isset($buy_click['comment']['status']) || $buy_click['comment']['status']) ? 'checked' : '' ?>>Вкл.
												</label>
												<label class="btn btn-default btn-off <?php echo (isset($buy_click['comment']['status']) && !$buy_click['comment']['status']) ? 'active' : '' ?>">
													<input value="0" type="radio" name="theme_lightshop_buy_click[comment][status]" id="theme_lightshop_buy_click_comment_status-0" autocomplete="off" <?php echo (isset($buy_click['comment']['status']) && !$buy_click['comment']['status']) ? 'checked' : '' ?>>Откл.
												</label>
											</div>
										</div>							  
									</div>
							</fieldset>
						</div>	
						
						<div class="tab-pane" id="tab-left-scrolltotop">
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
							  <div class="col-sm-2">
								<div class="btn-group on-off" data-toggle="buttons">
									<label class="btn btn-default btn-on <?php echo $theme_lightshop_scrolltt_status == '1' ? 'active' : '' ?>">
										<input value="1" type="radio" name="theme_lightshop_scrolltt_status" id="theme_lightshop_scrolltt_status-1" autocomplete="off" <?php echo $theme_lightshop_scrolltt_status == '1' ? 'checked' : '' ?>>Вкл.
									</label>
									<label class="btn btn-default btn-off <?php echo $theme_lightshop_scrolltt_status == '0' ? 'active' : '' ?>">
										<input value="0" type="radio" name="theme_lightshop_scrolltt_status" id="theme_lightshop_scrolltt_status-0" autocomplete="off" <?php echo $theme_lightshop_scrolltt_status == '0' ? 'checked' : '' ?>>Откл.
									</label>
								</div>
							  </div>							  
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">Позиция</label>
								<div class="col-sm-10">
									<label class="radio-inline"><input type="radio" name="theme_lightshop_scrolltt_pos" value="left" <?php echo $theme_lightshop_scrolltt_pos == 'left' ? 'checked' : '' ?>> Слева</label>
									<label class="radio-inline"><input type="radio" name="theme_lightshop_scrolltt_pos" value="right" <?php echo $theme_lightshop_scrolltt_pos == 'right' ? 'checked' : '' ?>> Справа</label>
								</div>	
							</div>							
						</div>	
						
						<div class="tab-pane" id="tab-left-pdata">
							<div class="alert alert-info" role="alert"><i class="fa fa-info-circle"></i> Перед выбором текст нужно добавить в раздел <a href="<?php echo $custom_information; ?>" target="_blank">Каталог > Статьи</a></div>
							
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="Текст согласия на обработку персональных данных в окне заказть звонок">Заказ звонка</span></label>
							  <div class="col-sm-10">
								<select name="theme_lightshop_callback_pdata" id="input-account" class="form-control">
								  <option value="0"> --- Не выбрано --- </option>
								  <?php foreach ($informations as $information) { ?>
								  <?php if ($information['information_id'] == $theme_lightshop_callback_pdata) { ?>
								  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
								  <?php } else { ?>
								  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
								  <?php } ?>
								  <?php } ?>
								</select>
							  </div>
							</div>	
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="Текст согласия на обработку персональных данных в форме подписки внизу сайта">Форма подписки</span></label>
							  <div class="col-sm-10">
								<select name="theme_lightshop_subscribe_pdata" id="input-account" class="form-control">
								  <option value="0"> --- Не выбрано --- </option>
								  <?php foreach ($informations as $information) { ?>
								  <?php if ($information['information_id'] == $theme_lightshop_subscribe_pdata) { ?>
								  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
								  <?php } else { ?>
								  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
								  <?php } ?>
								  <?php } ?>
								</select>
							  </div>
							</div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="Текст согласия на обработку персональных данных в форме быстрого заказа">Быстрый заказ</span></label>
							  <div class="col-sm-10">
								<select name="theme_lightshop_buy_click_pdata" id="input-account" class="form-control">
								  <option value="0"> --- Не выбрано --- </option>
								  <?php foreach ($informations as $information) { ?>
								  <?php if ($information['information_id'] == $theme_lightshop_buy_click_pdata) { ?>
								  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
								  <?php } else { ?>
								  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
								  <?php } ?>
								  <?php } ?>
								</select>
							  </div>
							</div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="Текст согласия на обработку персональных данных на странице контактов">Контакты</span></label>
							  <div class="col-sm-10">
								<select name="theme_lightshop_contact_pdata" id="input-account" class="form-control">
								  <option value="0"> --- Не выбрано --- </option>
								  <?php foreach ($informations as $information) { ?>
								  <?php if ($information['information_id'] == $theme_lightshop_contact_pdata) { ?>
								  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
								  <?php } else { ?>
								  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
								  <?php } ?>
								  <?php } ?>
								</select>
							  </div>
							</div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="Текст согласия на обработку персональных данных на странице подарочных сертификатов">Сертификат</span></label>
							  <div class="col-sm-10">
								<select name="theme_lightshop_voucher_pdata" id="input-account" class="form-control">
								  <option value="0"> --- Не выбрано --- </option>
								  <?php foreach ($informations as $information) { ?>
								  <?php if ($information['information_id'] == $theme_lightshop_voucher_pdata) { ?>
								  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
								  <?php } else { ?>
								  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
								  <?php } ?>
								  <?php } ?>
								</select>
							  </div>
							</div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="Текст согласия на обработку персональных данных в форме отзыва на товар">Отзывы о товарах</span></label>
							  <div class="col-sm-10">
								<select name="theme_lightshop_review_pdata" id="input-account" class="form-control">
								  <option value="0"> --- Не выбрано --- </option>
								  <?php foreach ($informations as $information) { ?>
								  <?php if ($information['information_id'] == $theme_lightshop_review_pdata) { ?>
								  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
								  <?php } else { ?>
								  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
								  <?php } ?>
								  <?php } ?>
								</select>
							  </div>
							</div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="Текст согласия на обработку персональных данных на странице статей блога">Статьи блога</span></label>
							  <div class="col-sm-10">
								<select name="theme_lightshop_blog_pdata" id="input-account" class="form-control">
								  <option value="0"> --- Не выбрано --- </option>
								  <?php foreach ($informations as $information) { ?>
								  <?php if ($information['information_id'] == $theme_lightshop_blog_pdata) { ?>
								  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
								  <?php } else { ?>
								  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
								  <?php } ?>
								  <?php } ?>
								</select>
							  </div>
							</div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="Текст согласия на обработку персональных данных для файлов cookies, отображается подсказка внизу сайта для неавторизованных клиентов, время жизни cookie 1 год.">Файлы cookies</span></label>
							  <div class="col-sm-10">
								<select name="theme_lightshop_cookies_pdata" id="input-account" class="form-control">
								  <option value="0"> --- Не выбрано --- </option>
								  <?php foreach ($informations as $information) { ?>
								  <?php if ($information['information_id'] == $theme_lightshop_cookies_pdata) { ?>
								  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
								  <?php } else { ?>
								  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
								  <?php } ?>
								  <?php } ?>
								</select>
							  </div>
							</div>
						</div>	
						
					</div>
				</div>
			</div>
			<div class="tab-pane" id="tab-info">
				<div class="col-sm-8 col-sm-offset-2">
					<div class="about-info thumbnail">
						<h2>Лайтшоп</h2>
						<div class="form-group">
							<label class="col-sm-4 control-label" for="input-theme_lightshop_label_sale_d">Версия</label>
							<div class="col-sm-8 inline-text">
								<?php echo $theme_lightshop_version; ?>
								<?php if ($new_version) { ?>
									<span class="label label-success">Доступна новая версия <?php echo $new_version; ?></span>
								<?php } ?>
								<input type="hidden" name="theme_lightshop_version" value="<?php echo $theme_lightshop_version; ?>" >
							</div>	
						</div>	
						<div class="form-group">
							<label class="col-sm-4 control-label" for="input-theme_lightshop_label_sale_d">Лицензия</label>
							<div class="col-sm-8 inline-text">
								Активна
							</div>	
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label" for="input-theme_lightshop_label_sale_d">Техническая поддержка</label>
							<div class="col-sm-8 inline-text">
								<?php if ($date_valid) { echo 'Активна до '.$date_valid  ; }?><br/>Отправить запрос в службу поддержки <a href="mailto:support@899themes.ru">(support@899themes.ru)</a>
							</div>	
						</div>	
						<div class="form-group">
							<label class="col-sm-4 control-label" for="input-theme_lightshop_label_sale_d">Разработчик</label>
							<div class="col-sm-8 inline-text">
								<a href="http://899themes.ru/" target="_blank">899themes.ru</a>
							</div>	
						</div>	
<!--
						<div class="form-group">
							<label class="col-sm-4 control-label" for="input-theme_lightshop_label_sale_d">Лицензионное соглашение</label>
							<div class="col-sm-8 inline-text">
								<div class="license-agreement">license-agreement</div>
							</div>	
						</div>
-->						
					</div>	
				</div>	
			</div>
		</div>
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript"><!--

$('.tooltip-custom').tooltip({trigger: 'click',html: true});

var header_nav_row = <?php echo $header_nav_row; ?>;

function addHeader_nav() {
    html  = '<tr id="header-nav-row' + header_nav_row + '">';
	html += '  <td class="text-left">';
	html += '  <select id="" name="theme_lightshop_header_nav[' + header_nav_row + '][settype]" for="' + header_nav_row + '" class="form-control header_nav_select_type">';
<?php foreach ($header_nav_types as $key => $header_nav_type) { ?>
	html += '  <option value="<?php echo $key; ?>" ><?php echo $header_nav_type; ?></option>';
<?php } ?>
	html += '  </select></td>';
	html += '  <td class="text-left">';
	html += '  <div id="header_nav-' + header_nav_row + '-0" class="header_nav-' + header_nav_row + '" style="display:block">';
<?php foreach ($languages as $language) { ?>
	html += '  <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="Russian"></span>';
	html += '  <input type="text" name="theme_lightshop_header_nav[' + header_nav_row + '][type][0][language][<?php echo  $language['language_id'] ?>][name]" value="" placeholder="Название подменю" class="form-control">';
	html += '  <input type="text" name="theme_lightshop_header_nav[' + header_nav_row + '][type][0][language][<?php echo  $language['language_id'] ?>][href]" value="" placeholder="Ссылка(http://)" class="form-control"></div>';
<?php } ?>	
	html += '  <div class="well-table" style="position: relative;">';
	html += '  <input type="text" name="header_nav[' + header_nav_row + '][type][0][linksmain]" for="' + header_nav_row + '-0" value="" placeholder="Ссылки" id="input-related" class="form-control header_nav_links" autocomplete="off">';
	html += '  <div id="header_nav-' + header_nav_row + '-0-links" class="well well-sm" style="overflow: auto;">';
	html += '  </div></div></div>';
	html += '  <div id="header_nav-' + header_nav_row + '-1" class="header_nav-' + header_nav_row + '" style="display:none">';
	html += '  <div class="well-table" style="position: relative;">';
	html += '  <input type="text" name="header_nav[' + header_nav_row + '][type][1][linksmain]" for="' + header_nav_row + '-1" value="" placeholder="Ссылки" id="input-related" class="form-control header_nav_links" autocomplete="off">';
	html += '  <div id="header_nav-' + header_nav_row + '-1-links" class="well well-sm" style="overflow: auto;">';
	html += '  </div></div></div></td>';
	html += '  <td class="text-left"><input type="text" name="theme_lightshop_header_nav[' + header_nav_row + '][sort]" value="0" placeholder="Порядок сортировки" class="form-control"></td>';

	html += '  <td class="text-right"><button type="button" onclick="$(\'#header-nav-row' + header_nav_row + '\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
    html += '</tr>';

	$('#header_nav tbody').append(html);
	
	header_nav_row++;
	addAutocomplete();
}
var footer_nav_row = <?php echo $footer_nav_row; ?>;

function addFooter_nav() {
    html  = '<tr id="footer-nav-row' + footer_nav_row + '">';
	html += '  <td class="text-left">';
<?php foreach ($languages as $language) { ?>
	html += '  <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>';
	html += '  <input type="text" name="theme_lightshop_footer_nav[' + footer_nav_row + '][language][<?php echo  $language['language_id'] ?>][name]" value="" placeholder="Название подменю" class="form-control"></div>';
<?php } ?>	
	html += '  </td>';
	html += '  <td class="text-left">';
	html += '  <select name="theme_lightshop_footer_nav[' + footer_nav_row + '][settype]" for="' + footer_nav_row + '" class="form-control footer_nav_select_type">';
<?php foreach ($footer_nav_types as $key => $footer_nav_type) { ?>
	html += '  <option value="<?php echo $key; ?>" ><?php echo $footer_nav_type; ?></option>';
<?php } ?>
	html += '  </select>';
	html += '  <div id="footer_nav-' + footer_nav_row + '-0" class="footer_nav-' + footer_nav_row + '" style="display:block">';
	html += '  <div class="well-table" style="position: relative;">';
	html += '  <input type="text" name="footer_nav[' + footer_nav_row + '][type][0][linksmain]" for="' + footer_nav_row + '-0" value="" placeholder="Ссылки" id="input-related" class="form-control footer_nav_links" autocomplete="off">';
	html += '  <div id="footer_nav-' + footer_nav_row + '-0-links" class="well well-sm" style="overflow: auto;">';
	html += '  </div></div></div>';
	html += '  <div id="footer_nav-' + footer_nav_row + '-1" class="footer_nav-' + footer_nav_row + '" style="display:none">';
	html += '  <div class="well-table" style="position: relative;">';	
	html += '  <div id="footer_nav-' + footer_nav_row + '-1-links" class="well well-sm" style="overflow: auto;">';
	html += '  <div class="input-group"><span class="input-group-addon"><i data-toggle="tooltip" data-original-title="Можно использовать html" class="fa fa-code"></i></span>';
	html += '  <textarea name="theme_lightshop_footer_nav[' + footer_nav_row + '][type][1][links][html]" rows="5" class="form-control code" placeholder="html контент"  ></textarea>';
	html += '  </div></div></div></div></td>';
	html += '  <td class="text-left"><input type="text" name="theme_lightshop_footer_nav[' + footer_nav_row + '][sort]" value="0" placeholder="Порядок сортировки" class="form-control"></td>';

	html += '  <td class="text-right"><button type="button" onclick="$(\'#footer-nav-row' + footer_nav_row + '\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
    html += '</tr>'; 

	$('#footer_nav tbody').append(html);
	
	footer_nav_row++;
	addAutocomplete();
}

var main_nav_row = <?php echo $main_nav_row; ?>;

function addMain_nav() {
    html  = '<tr id="main-nav-row' + main_nav_row + '">';
	html += '  <td class="text-left">';
	html += '  <select id="" name="theme_lightshop_main_nav[' + main_nav_row + '][settype]" for="' + main_nav_row + '" class="form-control main_nav_select_type">';
<?php foreach ($main_nav_types as $key => $main_nav_type) { ?>
	html += '  <option value="<?php echo $key; ?>" ><?php echo $main_nav_type; ?></option>';
<?php } ?>
	html += '  </select></td>';
	html += '  <td class="text-left">';
	html += '  <div id="main_nav-' + main_nav_row + '-0" class="main_nav-' + main_nav_row + '" style="display:block">';
	html += '  <div class="well-table" style="position: relative;">';
	html += '  <input type="text" name="main_nav[' + main_nav_row + '][type][0][linksmain]" for="' + main_nav_row + '-0" value="" placeholder="Ссылки" id="input-related" class="form-control main_nav_links" autocomplete="off">';
	html += '  <div id="main_nav-' + main_nav_row + '-0-links" class="well well-sm" style="overflow: auto;">';
	html += '  </div></div></div>';
	html += '  <div id="main_nav-' + main_nav_row + '-1" class="main_nav-' + main_nav_row + '" style="display:none">';
<?php foreach ($languages as $language) { ?>
	html += '  <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>';
	html += '  <input type="text" name="theme_lightshop_main_nav[' + main_nav_row + '][type][1][language][<?php echo  $language['language_id'] ?>][name]" value="" placeholder="Название подменю" class="form-control">'
	html += '  <input type="text" name="theme_lightshop_main_nav[' + main_nav_row + '][type][1][language][<?php echo  $language['language_id'] ?>][href]" value="" placeholder="Ссылка(http://)" class="form-control"></div>';
<?php } ?>	
	html += '  <div class="well-table" style="position: relative;">';
	html += '  <input type="text" name="main_nav[' + main_nav_row + '][type][1][linksmain]" for="' + main_nav_row + '-1" value="" placeholder="Ссылки" id="input-related" class="form-control main_nav_links" autocomplete="off">';
	html += '  <div id="main_nav-' + main_nav_row + '-1-links" class="well well-sm" style="overflow: auto;">';
	html += '  </div></div></div>';
	html += '  <div id="main_nav-' + main_nav_row + '-2" class="main_nav-' + main_nav_row + '" style="display:none">';
	html += '  <div class="well-table" style="position: relative;">';
	html += '  <input type="text" name="main_nav[' + main_nav_row + '][type][2][linksmain]" for="' + main_nav_row + '-2" value="" placeholder="Ссылки" id="input-related" class="form-control main_nav_links" autocomplete="off">';
	html += '  <div id="main_nav-' + main_nav_row + '-2-links" class="well well-sm" style="overflow: auto;">';
	html += '  </div></div></div>';
	html += '  </td>';
	html += '  <td class="text-left"><input type="text" name="theme_lightshop_main_nav[' + main_nav_row + '][sort]" value="0" placeholder="Порядок сортировки" class="form-control"></td>';

	html += '  <td class="text-right"><button type="button" onclick="$(\'#main-nav-row' + main_nav_row + '\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
    html += '</tr>';

	$('#attribute').append(html);
	
	main_nav_row++;
	addAutocomplete();
}

var main_rec_row = <?php echo $main_rec_row; ?>;

function addMain_rec() {
    html  = '<tr id="main_rec-row' + main_rec_row + '">';
	html += '  <td class="text-left">';
	html += '  <select  name="theme_lightshop_main_rec[' + main_rec_row + '][category_id]" class="form-control">';
	html += '<option value="0"  selected="selected" > --- Не выбрано --- </option>';
<?php foreach ($toplinks as $key => $toplink) { ?>
	html += '  <option value="<?php echo $key; ?>" ><?php echo addslashes ( key($toplink)); ?></option>';
<?php } ?>
	html += '  </select></td>';
	html += '  <td class="text-left">';
	html += '  <select name="theme_lightshop_main_rec[' + main_rec_row + '][settype]" for="' + main_rec_row + '" class="form-control main_rec_select_type">';
	html += '<option value="0"  selected="selected" > --- Не выбрано --- </option>';
<?php foreach ($main_rec_types as $key => $main_rec_type) { ?>
	html += '  <option value="<?php echo $key; ?>" ><?php echo  $main_rec_type; ?></option>';
<?php } ?>
	html += '  </select>';	
	
	html += '  <div id="main_rec-' + main_rec_row + '-0" class="main_rec-' + main_rec_row + '" style="display:block">';
	html += '  <div class="well-table" style="position: relative;">';
	html += '  <input type="text" name="main_rec[' + main_rec_row + '][type][0][linksmain]" for="' + main_rec_row + '-0" value="" placeholder="Ссылки" id="input-related" class="form-control main_rec_prods" autocomplete="off">';
	html += '  <div id="main_rec-' + main_rec_row + '-0-links" class="well well-sm" style="overflow: auto;">';
	html += '  </div></div></div>';
	html += '  <div id="main_rec-' + main_rec_row + '-1" class="main_rec-' + main_rec_row + '" style="display:none">';	
	html += '  <div class="well-table" style="position: relative;">';	
	html += '  <div class="input-group"><span class="input-group-addon"><i data-toggle="tooltip" data-original-title="Можно использовать html" class="fa fa-code"></i></span>';
	html += '  <textarea name="theme_lightshop_main_rec[' + main_rec_row + '][type][1][html]" rows="5" placeholder="html контент" class="form-control code"></textarea>';
	html += '  </div></div></div>';
	html += '  <div id="main_rec-' + main_rec_row + '-2" class="main_rec-' + main_rec_row + '" style="display:none">';
	html += '  <div class="well-table" style="position: relative;">';
	html += '  <input type="text" name="main_rec[' + main_rec_row + '][type][0][linksmain]" for="' + main_rec_row + '-0" value="" placeholder="Производители" id="input-related" class="form-control main_rec_manf" autocomplete="off">';
	html += '  <div id="main_rec-' + main_rec_row + '-0-manufacturers" class="well well-sm" style="overflow: auto;">';
	html += '  </div></div></div>';

	html += '  </td>';
//	html += '  <td class="text-left"><input type="text" name="theme_lightshop_main_rec[' + main_rec_row + '][sort]" value="0" placeholder="Порядок сортировки" class="form-control"></td>';

	html += '  <td class="text-right"><button type="button" onclick="$(\'#main_rec-row' + main_rec_row + '\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
    html += '</tr>';

	$('#main_rec').append(html);
	
	main_rec_row++;
	addAutocomplete();
}

//--></script>
<script type="text/javascript"><!--
var links_row = <?php echo $links_row; ?>;

function addLinks() {
    html  = '<tr id="links-row' + links_row + '">';
	html += '  <td class="text-left">';
            <?php foreach ($languages as $language) { ?>
		html += '<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>';
		html += '<input type="text" name="theme_lightshop_vidg_extlinks[' + links_row + '][description][<?php echo $language['language_id']; ?>][name]" value="" placeholder="Название" class="form-control">';
		html += '</div>';
             <?php } ?>
	html += '  </td>';
	html += '  <td class="text-left">';
			<?php foreach ($languages as $language) { ?>
	html += '  <input type="text" name="theme_lightshop_vidg_extlinks[' + links_row + '][link][<?php echo $language['language_id']; ?>]" value="" placeholder="Ссылка" class="form-control">';
			<?php } ?>
	html += '  </td>';
	html += '  <td class="text-left"><select id="target" name="theme_lightshop_vidg_extlinks[' + links_row + '][attr]" class="form-control">';
	<?php foreach ($theme_lightshop_vidg_extlinks_targets as $key => $target) { ?>
		html += '<option value="<?php echo $key; ?>"><?php echo $target; ?></option>';
        <?php } ?>
	html += '  </td>';
	html += '  <td class="text-left"><input type="text" name="theme_lightshop_vidg_extlinks[<?php echo $links_row; ?>][sort]" value="" placeholder="Сортировка" class="form-control"></td>';
	html += '  <td class="text-right"><button type="button" onclick="$(\'#links-row' + links_row + '\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
    html += '</tr>';

	$('#links tbody').append(html);
	
	links_row++;
}

var social_nav_row = <?php echo $social_nav_row; ?>;

function addSocial_nav() {
    html  = '<tr id="social_nav-row' + social_nav_row + '">';
	html += '  <td class="text-left">';
	html += '  <select  name="theme_lightshop_social_nav[' + social_nav_row + '][settype]" class="form-control">';
	html += '<option value="0"  selected="selected" > --- Не выбрано --- </option>';
<?php foreach ($social_nav_types as $key => $social_nav_type) { ?>
	html += '  <option value="<?php echo $key; ?>" ><?php echo $social_nav_type; ?></option>';
<?php } ?>
	html += '  </select></td>';
	html += '  <td class="text-left">';
            <?php foreach ($languages as $language) { ?>
		html += '<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>';
		html += '<input type="text" name="theme_lightshop_social_nav[' + social_nav_row + '][language][<?php echo $language['language_id']; ?>][name]" value="" placeholder="Название" class="form-control">';
		html += '</div>';
             <?php } ?>
	html += '  </td>';
	html += '  <td class="text-left"><input type="text" name="theme_lightshop_social_nav[' + social_nav_row + '][link]" value="" placeholder="Ссылка" class="form-control"></td>';
	html += '  <td class="text-left"><select id="target" name="theme_lightshop_social_nav[' + social_nav_row + '][attr]" class="form-control">';
	<?php foreach ($theme_lightshop_vidg_extlinks_targets as $key => $target) { ?>
		html += '<option value="<?php echo $key; ?>"><?php echo $target; ?></option>';
        <?php } ?>
	html += '  </td>';
	html += '  <td class="text-right"><button type="button" onclick="$(\'#social_nav-row' + social_nav_row + '\').remove();" data-toggle="tooltip" title="Удалить" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
    html += '</tr>';

	$('#social_nav tbody').append(html);
	
	social_nav_row++;

}

var cust_tab_row = <?php echo $cust_tab_key; ?>;

function addCust_tab() {
    html  = '<div class="tab-pane" id="tab-ctabs' + cust_tab_row + '">';
	html += '  <div class="form-group">';
	html += '  <label class="col-sm-2 control-label" for="input-description1"><span data-toggle="tooltip" title="" data-original-title="<?php echo $help_product_tabs_main; ?>"><?php echo $text_tabs_shablon; ?></span></label>';
	html += '<div class="col-sm-10">';
	html += '  <select name="cust_tabs[' + cust_tab_row + '][view]" class="form-control">';
	html += '  <option value="tab" selected="selected" ?><?php echo $text_tabs_tab; ?></option>';
	html += '  <option value="popup"  ?><?php echo $text_tabs_popup; ?></option>';
	html += '  </select></div></div>';
	html += '<div class="form-group">';
	html += '<label class="col-sm-2 control-label" for="input-description1"><?php echo $text_tabs_links; ?></label>';
	html += '<div class="col-sm-10">';
	html += '  <select name="cust_tabs[' + cust_tab_row + '][mode]" data-for="' + cust_tab_row + '" class="form-control cust_tabs_mode">';
	html += '  <option value="products" ><?php echo $text_tabs_to_products; ?></option>';
	html += '  <option value="categories" selected="selected"><?php echo $text_tabs_tab_to_categories; ?></option>';
	html += '  </select></div></div>';
	
	html += '<div class="form-group tabsmode-' + cust_tab_row + '" id="customtab-' + cust_tab_row + '-products" style="display: none;">';
	html += '  <label class="col-sm-2 control-label" for="input-product"><span data-toggle="tooltip" title="" data-original-title="<?php echo $help_product_tabs_select; ?>"><?php echo $text_products; ?></span></label>';
	html += '  <div class="col-sm-10">';
	html += '  <input type="text" name="cust_tabs[' + cust_tab_row + '][product]" data-for="' + cust_tab_row + '" value="" placeholder="<?php echo $text_products; ?>"  class="form-control tab-products">';	
	html += '  <div class="well well-sm" id="cust_tabs-' + cust_tab_row + '-products" style="height: 150px; overflow: auto;">';	
	html += '  </div></div></div>';

	html += '<div class="form-group tabsmode-' + cust_tab_row + '" id="customtab-' + cust_tab_row + '-categories" style="display: block;">';
	html += '  <label class="col-sm-2 control-label" for="input-category"><span data-toggle="tooltip" title="" data-original-title="<?php echo $help_product_tabs_cat_select; ?>"><?php echo $text_categories; ?></span></label>';
	html += '  <div class="col-sm-10">';
	html += '  <input type="text" name="cust_tabs[' + cust_tab_row + '][category]" data-for="' + cust_tab_row + '" value="" placeholder="<?php echo $text_categories; ?>"  class="form-control tab-categories">';	
	html += '  <div class="well well-sm" id="cust_tabs-' + cust_tab_row + '-categories" style="height: 150px; overflow: auto;">';	
	html += '  </div></div></div>';

	html += '  <div class="form-group">';	
	html += '  <label class="col-sm-2 control-label" for=""><?php echo $text_sort_order; ?></label>';
	html += '  <div class="col-sm-10">';
	html += '  <input type="text" name="cust_tabs[' + cust_tab_row + '][sort_order]" value="0" placeholder="<?php echo $text_sort_order; ?>" class="form-control">';
	html += '  </div></div>';

	html += '  <ul class="nav nav-tabs" id="language_tab' + cust_tab_row + '">';
	<?php foreach ($languages as $language) { ?>
	html += '  <li ><a href="#language_tab-' + cust_tab_row + '-<?php echo $language["language_id"]; ?>" data-toggle="tab" aria-expanded="true"><img src="language/<?php echo $language["code"]; ?>/<?php echo $language["code"]; ?>.png" title="<?php echo $language['name']; ?>"> <?php echo $language["name"]; ?></a></li>';
	<?php } ?>
	html += '  </ul>';

	html += ' <div class="tab-content">';
	<?php foreach ($languages as $language) { ?>
	html += '  <div class="tab-pane" id="language_tab-' + cust_tab_row + '-<?php echo $language["language_id"]; ?>">';
	html += '  <div class="form-group required"><label class="col-sm-2 control-label" for="input-name1"><?php echo $text_name; ?></label><div class="col-sm-10"><input type="text" name="cust_tabs[' + cust_tab_row + '][title][<?php echo $language["language_id"]; ?>]" value="" placeholder="<?php echo $text_name; ?>"  class="form-control" /></div></div>';
	html += '  <div class="form-group"><label class="col-sm-2 control-label" for="input-description1"><?php echo $text_description; ?></label><div class="col-sm-10"><textarea name="cust_tabs[' + cust_tab_row + '][description][<?php echo $language["language_id"]; ?>]" placeholder="<?php echo $text_description; ?>"  data-lang="<?php echo $language["code"]; ?>" class="form-control summernote"></textarea></div></div></div>';
	<?php } ?>
	html += '  </div></div>';

	$('#cust_tabs_data').append(html);

	html  = '<li ><a href="#tab-ctabs' + cust_tab_row + '" data-toggle="tab" aria-expanded="true"><i class="fa fa-minus-circle" onclick="$(\'a[href=\\\'#tab-ctabs' + cust_tab_row + '\\\']\').parent().remove(); $(\'#tab-ctabs' + cust_tab_row + '\').remove(); $(\'#cust_tabs_tab a:first\').tab(\'show\');"></i> Вкладка \#' + cust_tab_row + '</a></li>';
	
	$('#ctabs_add').before(html);

	$('a[href="#tab-ctabs' + cust_tab_row + '"]').tab('show');

	$('#tab-ctabs' + cust_tab_row + '').each(function(indx, element){
		$(this).find('li:first').tab('show');
	})
	$('#tab-ctabs' + cust_tab_row + '').each(function(indx, element){
		$(this).find('.tab-pane:first').addClass('active');
	})

	cust_tab_row++;
	addAutocomplete();
	$('#cust_tabs_data').tab();
	 $('.summernote').summernote( {height: 150});
}

//--></script>

  <script type="text/javascript"><!--
function addAutocomplete() {
$('.header_nav_links').autocomplete({

	source: function(request, response) {

		$.ajax({
			url: 'index.php?route=extension/theme/theme_lightshop/autocompletecustomlinks&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						link: item['link'],
						value: item['id'],
						category: item['category']
					}
				}));
			}
		});
	},
	select: function(item) {
		var row = $(this).attr('for');
		var rowtype = row.split('-');		
		$(this).val('');
		
		
		$('#header_nav-'+row+'-links').append('<div id="header_nav-'+row+'-links-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="theme_lightshop_header_nav['+rowtype[0]+'][type]['+rowtype[1]+'][links][' + item['value'] + ']" value="' + item['link'] + '" /></div>');	
	}
});
$('.footer_nav_links').autocomplete({

	source: function(request, response) {

		$.ajax({
			url: 'index.php?route=extension/theme/theme_lightshop/autocompletecustomlinks&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						link: item['link'],
						value: item['id'],
						category: item['category']
					}
				}));
			}
		});
	},
	select: function(item) {
		var row = $(this).attr('for');
		var rowtype = row.split('-');		
		$(this).val('');
		
//		$('#customlinks' + item['value']).remove();
		
		$('#footer_nav-'+row+'-links').append('<div id="footer_nav-'+row+'-links-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="theme_lightshop_footer_nav['+rowtype[0]+'][type]['+rowtype[1]+'][links][' + item['value'] + ']" value="' + item['link'] + '" /></div>');	
	}
});
$('.main_nav_links').autocomplete({

	source: function(request, response) {
		var row = $(this).attr('for');
		var rowtype = row.split('-');
		var type = $('#main-nav-row'+rowtype[0]).find('.main_nav_select_type :selected').val();
		$.ajax({
			url: 'index.php?route=extension/theme/theme_lightshop/autocompletecustomlinks&token=<?php echo $token; ?>&mainav=1&type='+type+'&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						link: item['link'],
						value: item['id'],
						category: item['category']
					}
				}));
			}
		});
	},
	select: function(item) {
		var row = $(this).attr('for');
		var rowtype = row.split('-');		
		$(this).val('');
		$('#main_nav-'+row+'-links').append('<div id="main_nav-'+row+'-links-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="theme_lightshop_main_nav['+rowtype[0]+'][type]['+rowtype[1]+'][links][' + item['value'] + ']" value="' + item['link'] + '" /></div>');	
	}
});
$('.main_rec_links').autocomplete({

	source: function(request, response) {

		$.ajax({
			url: 'index.php?route=extension/theme/theme_lightshop/autocompletecustomlinks&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						link: item['link'],
						value: item['id'],
						category: item['category']
					}
				}));
			}
		});
	},
	select: function(item) {
		var row = $(this).attr('for');
		var rowtype = row.split('-');		
		$(this).val('');
		
		$('#main_rec-'+row+'-links').append('<div id="main_rec-'+row+'-links-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="theme_lightshop_main_rec['+rowtype[0]+'][type]['+rowtype[1]+'][links][' + item['value'] + ']" value="' + item['link'] + '" /></div>');	
	}
});
$('.main_rec_prods').autocomplete({

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
		var rowtype = row.split('-');		
		$(this).val('');
		
		$('#main_rec-'+row+'-links').append('<div id="main_rec-'+row+'-links-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="theme_lightshop_main_rec['+rowtype[0]+'][type]['+rowtype[1]+'][links][' + item['value'] + ']" value="' + item['label'] + '" /></div>');	
	}
});

$('.main_rec_manf').autocomplete({

	source: function(request, response) {

		$.ajax({
			url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['manufacturer_id']
					}
				}));
			}
		});
	},
	select: function(item) {
		var row = $(this).attr('for');
		var rowtype = row.split('-');		
		$(this).val('');
		
		$('#main_rec-'+row+'-manufacturers').append('<div id="main_rec-'+row+'-manf-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="theme_lightshop_main_rec['+rowtype[0]+'][type]['+rowtype[1]+'][manf][' + item['value'] + ']" value="' + item['label'] + '" /></div>');	
	}
});

$('.tab-products').autocomplete({
	'source': function(request, response) {
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
	'select': function(item) {
		var row = $(this).attr('data-for');
		$('.tab-products').val('');

		$('#cust_tabs-'+row+'-product-' + item['value']).remove();

		$('#cust_tabs-'+row+'-products').append('<div id="cust_tabs-'+row+'-product-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="cust_tabs['+row+'][instanses][products][]" value="' + item['value'] + '" /></div>');
	}
});

$('.tab-categories').autocomplete({
	'source': function(request, response) {
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
	'select': function(item) {
		var row = $(this).attr('data-for');
		$('.tab-categories').val('');

		$('#cust_tabs-'+row+'-categories-' + item['value']).remove();

		$('#cust_tabs-'+row+'-categories').append('<div id="cust_tabs-'+row+'-category-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="cust_tabs['+row+'][instanses][categories][]" value="' + item['value'] + '" /></div>');
	}
});

}

$('input[name=\'customlinks1\']').autocomplete({

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
		
		$('#featured-category' + item['value']).remove();
		
		$('#featured-category').append('<div id="featured-category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="theme_lightshop_product_tabs['+ row +'][categories][]" value="' + item['value'] + '" /></div>');	
	}



});	

$('#header_nav').on('change','.header_nav_select_type', function() {
	var row = $(this).attr('for');
	$('.header_nav-'+row).hide();
	var sel = $(this).val();
	$('#header_nav-'+row+'-'+sel).show();
});

$('#tab-left-product').on('change','.cust_tabs_mode', function() {
	var row = $(this).attr('data-for');
	$('.tabsmode-'+row).hide();
	var sel = $(this).val();
	$('#customtab-'+row+'-'+sel).show();
});

$(document).on('click', '.well-sm .fa-minus-circle', function() {
	$(this).parent().remove();
});

$('#footer_nav').on('change','.footer_nav_select_type', function() {
	var row = $(this).attr('for');
	$('.footer_nav-'+row).hide();
	var sel = $(this).val();
	$('#footer_nav-'+row+'-'+sel).show();
});

$('#attribute').on('change','.main_nav_select_type', function() {
	var row = $(this).attr('for');
	$('.main_nav-'+row).hide();
	var sel = $(this).val();
	$('#main_nav-'+row+'-'+sel).show();
});
$('#main_rec').on('change','.main_rec_select_type', function() {
	var row = $(this).attr('for');
	$('.main_rec-'+row).hide();
	var sel = $(this).val();
	$('#main_rec-'+row+'-'+sel).show();
});

$('.well-sm').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});

$(document).on('click', 'input[name=\'theme_lightshop_header_type\']', function() {
	if ($(this).val() == 3) {
		$('.top3').show();
	}else{
		$('.top3').hide();
	}
});
$(document).on('change', 'select[name=\'theme_lightshop_contact_map\']', function() {
	var typemap = $('select[name=\'theme_lightshop_contact_map\'] option:selected').val();
	if (typemap == 'google_map') {
		$('.gmaps').show();
	}else{
		$('.gmaps').hide();
	}
});

$(document).ready(function() {
	addAutocomplete();
	$('#cust_tabs_data .nav-tabs').each(function(indx, element){
		$(this).find('li:first').tab('show');
	})
	$('#cust_tabs_data .tab-content').each(function(indx, element){
		$(this).find('.tab-pane:first').addClass('active');
	})
	$('#cust_tabs_tab a:first').tab('show');

	if ($('input[name=\'theme_lightshop_header_type\']:checked').val() == 3) {
		$('.top3').show();
	}
	if ($('select[name=\'theme_lightshop_contact_map\'] option:selected').val() == 'google_map') {
		$('.gmaps').show();
	}

});

$('#copyalert').modal({ show: false });

$('#storecopy').on('click', function() {
	$.ajax({
	  type: "POST",
	  url: 'index.php?route=extension/theme/theme_lightshop/copystore&token=<?php echo $token; ?>',
	  dataType: 'json',
	  success: function(msg){
	    alert( msg['success'] );
	  }
	});
});

var editor_css = CodeMirror.fromTextArea(document.getElementById('theme_lightshop_css'), {
	mode: 'css',
	lineNumbers: true,
	autofocus: true,
	theme: 'monokai'
});

var editor_js = CodeMirror.fromTextArea(document.getElementById('theme_lightshop_js'), {
	mode: 'javascript',
	lineNumbers: true,
	autofocus: true,
	theme: 'monokai'
});

$('a[href="#tab-left-css-js"]').on('shown.bs.tab', function () {
	$('.CodeMirror').each(function(i, el){
		el.CodeMirror.refresh(),
		el.CodeMirror.setSize(null, 600)
	});
})

//--></script>
<?php echo $footer; ?>
