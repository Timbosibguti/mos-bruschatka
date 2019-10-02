<section class="section hits <?php echo $module_css_class; ?>" id="hits">
	<div class="container container--constraint">
		<div class="hits__container">
			<div class="mb-20 h2 icon-flame"><?php echo $heading_title; ?></div>
			<div class="hits__forms tabs">
				<div class="tabs__nav">
					<ul class="tabs__list">
						<?php foreach ($forms as $key => $form) { ?>
						<li class="tabs__list-item"><a href="#bsForm<?php echo $key; ?>" class="tabs__link hits__icon <?php echo $form['css_class']; ?> js-tab-btn <?php echo ($key === 0) ? 'default' : ''; ?>"><?php echo $form['name']; ?></a></li>
						<?php } ?>
					</ul>
				</div>
				<?php foreach ($forms as $key => $form) { ?>
				<div class="tab" id="bsForm<?php echo $key; ?>">
					<?php $products = $form['products']; ?>
					<div class="row">
						<?php foreach($products as $product) { ?>
						<div class="col-6 col-md-4">
							<?php require( DIR_TEMPLATE . 'theme_lightshop/template/product/products.tpl' ); ?>
						</div>
						<?php } ?>
					</div>
				</div>
				<?php } ?>
			</div>
			<?php if($show_button) { ?>
			<div class="inline-info">
				<a href="#modalDownloadCatalog" class="btn btn--spacing btn--yellow icon-download js-modal">
					скачать прайс-лист <i class="fa fa-file-excel-o" style="margin-left: 6px;font-size: 16px;"></i>
				</a>
				<span class="inline-info__description">Скачать полную версию каталога со всемя ценнами</span>
			</div>
			<?php } ?>
		</div>
	</div>
</section>
