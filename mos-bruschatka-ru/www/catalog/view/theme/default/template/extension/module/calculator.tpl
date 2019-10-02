<?php 
$colors = array(
	'Серый' => '7b7370',
	'Песочный' => 'cebbaa',
	'Красно-коричневый' => '725452',
	'Черный' => '4e4e50',
	'Красный' => '835d5c',
	'Коричневый' => '62504e',
	'Бежевый' => 'a28c81',
	'Зеленый' => '7e8772',
	'Синий' => '6f8087',
	'Персиковый' => 'a16c4c',
	'Желтый' => 'a59559',
);

$dimensions = array(
	'dimension1' => 'до 10 м2',
	'dimension2' => '10-20 м2',
	'dimension3' => '20-30 м2',
	'dimension4' => '30-50 м2',
	'dimension5' => '50-100 м2',
	'dimension6' => 'более 100 м2'
);
?>
<section class="section section--highlight calculator" id="calculator">
	<div class="container container--constraint">
		<div class="h2 calculator__h2">Рассчитайте стоимость плитки</div>
		<h3 class="calculator__h3">И закрепите за собой скидку 5%</h3>
	</div>

	<div class="calculator__table">
		<form class="calculator__form js-calc-form" action="javascript:void(0);" id="calculatorForm" data-form-title="Калькулятор">
			<div class="calculator__step js-calc-step" data-calc-step="1">
				<div class="calculator__products js-calc-products">
				<?php foreach ($products as $product) { ?>
					<div class="calculator__product js-calc-product" data-product="<?php echo $product['model']; ?>">
						<input type="radio" name="product" value="<?php echo $product['name']; ?>" class="js-calc-input" id="pd-<?php echo $product['model']; ?>">
						<label for="pd-<?php echo $product['model']; ?>" class="calculator__label">
							<img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $product['thumb']; ?>" height="<?php echo $product['thumb_height']; ?>" width="<?php echo $product['thumb_width']; ?>" alt="<?php echo $product['name']; ?>" class="calculator__product-img">
							<h5 class="calculator__product-name"><?php echo $product['name']; ?></h5>
						</label>
					</div>
				<?php } ?>
				</div>
				<div class="calculator__controls js-calc-controls">
					<div class="text-sm calculator__error js-calc-error">Вы не выбрали какой-либо вариант.</div>
					<div class="calculator__indicator"><span class="calculator__step-indicator">Шаг <span class="js-calc-step-index">1</span> из <span class="js-calc-total-step">5</span> - </span><span class="js-calc-step-title">Выбор узора плитки</span></div>
					<div class="calculator__btns">
						<button type="button" class="btn btn--inline btn--gray calculator__btn-prev js-calc-btn-prev">назад - шаг <span class="js-calc-step-prev-index">1</span></button>
						<button type="button" class="btn btn--inline btn--yellow calculator__btn-next js-calc-btn-next">к следующему шагу <i class="icon icon--arrow-next"></i></button>
					</div>
				</div>
			</div>

			<div class="calculator__step js-calc-step" data-calc-step="2">
				<div class="calculator__patterns js-calc-patterns">
				<?php foreach($products as $product) { ?>
					<?php if($product['patterns']) { ?>
						<?php foreach($product['patterns'] as $pattern) { ?>
						<div class="calculator__pattern js-calc-pattern" data-product-patterns="pd-<?php echo $product['model']; ?>">
							<input type="radio" name="pattern" value="<?php echo $pattern; ?><?php echo $index; ?>" class="js-calc-input" id="pt-<?php echo $pattern; ?>">
							<label for="pt-<?php echo $pattern; ?>" class="calculator__label">
								<svg height="160" width="160" class="calculator__pattern-svg"><use xlink:href="#<?php echo $pattern; ?>"></use></svg>
							</label>
						</div>
						<?php } ?>
					<?php } ?>
				<?php } ?>
				</div>
				<div class="calculator__showcase js-calc-showcase">
					<div class="calculator__virtual-card js-calc">
						<img src="<?php echo $placeholder_img; ?>" data-src="../image/catalog/calc-showcase-bg.png" alt="" width="570" height="380">
						<div class="calculator__virtual-img js-calc-virtual-img"></div>
					</div>
					<div class="calculator__result-showcase js-calc-result-showcase">
						<div class="calculator__reception">
							<div class="calculator__user-form">
								<h3 class="calculator__reception-title">Получите полный расчет-смету!</h3>
								<span class="text-sm calculator__change-option js-calc-change-option"><svg class="icon-arrow-left" height="8" width="12"><use xlink:href="#iconArrowRight"></use></svg></span>
								<div class="calculator__reception-option-title js-calc-reception-option-title">По WhatsApp</div>

								<div class="calculator__reception-option js-calc-reception-option">
									<a href="javascript:void(0);" class="calculator__whatsapp-btn js-calc-whatsapp-btn">
										<svg height="70" width="70" class="icon-calc-whatsapp"><use xlink:href="#iconWhatsapp"></use></svg>
										<p>По WhatsApp</p>
									</a>
									<a href="javascript:void(0);" class="calculator__email-btn js-calc-mail-btn">
										<svg height="70" width="70" class="icon-calc-email"><use xlink:href="#iconEmail"></use></svg>
										<p>На почту</p>
									</a>
								</div>
								<div class="calculator__user-data js-calc-user-data">
									<input type="text" name="name" placeholder="<?php echo $placeholder_name; ?>" class="input calculator__input js-calc-input-name" required />
									<input type="tel" name="phone" placeholder="<?php echo $placeholder_phone; ?>" class="input calculator__input js-calc-input-phone" required />
									<input type="email" name="email" placeholder="<?php echo $placeholder_email; ?>" class="input calculator__input js-calc-input-email" required />
									<button type="submit" class="btn btn btn--inline btn--yellow flashed calculator__btn-submit">получить смету!</button>
									<div class="privacy-info">Отправляя форму Вы  соглашаетесь с политикой  конфиденциальности</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="calculator__step js-calc-step" data-calc-step="3">
				<div class="calculator__coloration js-calc-coloration">
				<?php for($coloration = 1; $coloration <= $product['coloration']; $coloration++) { ?>
					<div class="calculator__colors js-calc-colors">
						<h3 class="calculator__coloration-h3">Цвет №<?php echo $coloration; ?> </h3>
						<?php foreach ($colors as $color['name'] => $color['value']) { ?>
						<div class="calculator__color js-calc-color<?php echo $coloration; ?>">
							<input type="radio" name="color<?php echo $coloration; ?>" value="<?php echo $color['name']; ?>" class="js-calc-input" id="<?php echo $color['value'].'-'.$coloration; ?>">
							<label for="<?php echo $color['value'].'-'.$coloration; ?>" class="calculator__label">
								<div class="calculator__color-img" style="background-color: #<?php echo $color['value']; ?>"></div>
								<div class="calculator__color-name"><?php echo $color['name']; ?></div>
							</label>
						</div>
						<?php } ?>
					</div>
				<?php } ?>
				</div>
			</div>

			<div class="calculator__step js-calc-step" data-calc-step="4">
				<div class="calculator__dimensions js-calc-surface">
					<h3>Площадь укладки</h3>
					<?php foreach($dimensions as $dimension['id'] => $dimension['value']) { ?>
					<div class="calculator__dimension js-calc-dimension">
						<input type="radio" name="dimension" value="<?php echo $dimension['value']; ?>" class="js-calc-input" id="<?php echo $dimension['id']; ?>">
						<label for="<?php echo $dimension['id']; ?>" class="calculator__label"><?php echo $dimension['value']; ?></label>
					</div>
					<?php } ?>
				</div>
			</div>

			<div class="calculator__step js-calc-step" data-calc-step="5" style="max-width: 1070px;">
				<div class="calculator__result js-calc-result">
					<table class="calculator__table">
						<thead class="calculator__table-header">
							<tr>
								<td>Завод</td>
								<td>Количество шт/м2</td>
								<td>Количество шт/поддон</td>
								<td>Цена, руб/шт</td>
							</tr>
						</thead>
						<tbody class="calculator__table-body">
							<?php foreach ($manufacturers as $manufacturer) { ?>
							<tr>
								<td><img data-src="<?php echo $manufacturer['image']; ?>" alt=""></td>
								<td class="js-calc-price">50</td>
								<td class="js-calc-price">100</td>
								<td class="js-calc-price">450</td>
							</tr>
							<?php } ?>
						</tbody>
					</table>
				</div>
			</div>
		</form>
	</div>
</section>
