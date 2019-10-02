<?php echo $header; ?>
<main class="section" id="wrapper">
	<?php if ($content_top) { ?>
		<?php echo $content_top; ?>
	<?php } ?>
	<div class="container">
		<div class="grid">
			<?php if($content_left) { ?><aside class="aside aside-left"><?php content_left; ?></aside><?php } ?>
			<section class="main-section">
				<div class="cart" id="cart">
					<div class="row">
						<div class="<?php echo ($step < 4) ? 'col-md-9' : 'col-md-8'; ?>">
							<form action="javascript:void(0)" method="post" enctype="multipart/form-data" id="formCart">
								<h1 class="mb-35"><?php echo $heading_title; if ($weight) { echo ' (' . $weight . ')'; };  ?></h1>
								<div class="cart-step">
									<ul class="cart-step__list">
									<?php foreach ($cart_nav_list as $item) { ?>
										<li class="cart-step__list-item <?php echo ($item['step'] === $step) ? 'active' : ''; echo ($item['step'] < $step) ? 'confirmed' : ''; ?>"><h5 class="cart-step__list-item-title"><?php echo $item['title']; ?></h5></li>
									<?php } ?>
									</ul>
									<?php if($step > 1) {?>
									<button type="submit" class="cart-btn cart-btn--stepper js-cart-control-btn js-cart-control-btn" value="<?php echo ($step - 1); ?>">Назад - Шаг <?php echo ($step - 1); ?></button>
									<?php } else { ?>
									<button type="button" class="icon-garbage-16 cart-btn cart-btn--clear js-cart-clear">Очистить корзину</button>
									<?php } ?>
								</div>

								<?php if($step === 1) { ?>
								<div class="cart-step1 cart-products">
									<ul class="cart-products__list">
										<?php foreach($products as $key => $product) { ?>
										<li class="cart-products__list-item">
											<a href="<?php echo $product['big_thumb']; ?>" data-fancybox data-caption="<?php echo $product['name']; ?>" class="cart-products__img">
												<img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $product['thumb']; ?>" alt="">
											</a>
											
											<div class="cart-products__details">
												<div class="row align-items-center">
													<a href="<?php echo $product['href']; ?>" class="col-7">
														<h4 class="cart-products__name"><?php echo $product['name']; ?></h4>
													</a>
													<div class="col-2">
														<input name="quantity[<?php echo $product['cart_id']; ?>]" type="number" min="1" class="cart-products__quantity js-cart-spinner" value="<?php echo $product['quantity']; ?>" placeholder="<?php echo $product['quantity']; ?>" />
													</div>
													<div class="cart-products__price col-2"><span class="text-sm"><?php echo $product['price']; ?> за м<sup>2</sup> </span> <br /> <strong><?php echo preg_replace('/[^0-9]/', '', $product['price']) * $product['quantity'] . ' ₽'; ?></strong></div>
													<div class="col-1 text-right text-media-1"><button title="Удалить товар" value="<?php echo $product['cart_id']; ?>" class="icon-garbage-16 <?php echo (count($products) > 1) ? 'js-cart-remove' : 'js-cart-clear'; ?>"></button></div>
												</div>
												<div class="cart-products__row">
													<span class="cart-products__manufacturer"><img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $product['manufacturer_logo']; ?>" alt="<?php echo $product['manufacturer_name']; ?>" /> <?php echo $product['manufacturer_name']; ?></span> /
													<span class="cart-products__model text-sm text--color-2"><?php echo $text_model . ' ' . $product['model']; ?></span>
												</div>
												<div class="col-1 text-right text-media-2"><button title="Удалить товар" value="<?php echo $product['cart_id']; ?>" class="icon-garbage-16 <?php echo (count($products) > 1) ? 'js-cart-remove' : 'js-cart-clear'; ?>">удалить товар</button></div>
												<?php if($product['option']) { ?>
												<div class="cart-products__row">
													<ul class="cart-products__options">
														<?php foreach($product['option'] as $option) { ?>
														<li class="cart-products__option"><?php echo $option['name']; ?> <br /> <?php echo ($option['name'] == 'Цвет') ? '<a href="javascript:voi(0);" title="' . $option['value'] . '" class="label--color"></a>' : ''; ?> <strong><?php echo $option['value']; ?></strong></li>
														<?php } ?>
													</ul>
												</div>
												<?php } ?>
											</div>
										</li>
										<?php } ?>
									</ul>
									<div class="cart-user">
										<p class="cart-user__title">Заполните Контактные данные, чтобы сформировать заказ</p>
										<div class="cart-user__info">
											<input type="text" name="name" <?php echo $user['name'] ? 'value="' . $user['name'] . '"' : 'placeholder="' . $placeholder_name . '"'; ?> class="input input--inline input--highlight js-name">
											<input type="text" name="phone" <?php echo $user['phone'] ? 'value="' . $user['phone'] . '"' : 'placeholder="' . $placeholder_phone . '"'; ?> class="input input--inline input--highlight js-phone">
											<input type="text" name="email" <?php echo $user['email'] ? 'value="' . $user['email'] . '"' : 'placeholder="' . $placeholder_email . '"'; ?>  class="input input--inline input--highlight js-email">
											<div class="privacy-info privacy-info--inline"><?php echo $privacy_info; ?></div>
										</div>
									</div>
								</div>
								<?php } else if($step === 2) { ?>
								<div class="cart-step2">
									<div class="row no-gutters align-items-stretch">
										<div class="size2of9">
											<input type="hidden" name="laying[name]" value="Укладка">
											<input type="checkbox" name="laying[status]" value="Нужнен" id="layingInput" class="cart-step__input" <?php echo ($user['laying']['status']) ? 'checked="checked"' : ''; ?> />
											<label for="layingInput" class="cart-step__label">
												<p>Укладка</p>
												<svg class="icon-laying" width="170" height="170"><use xlink:href="#iconLaying"></use></svg>
												<p class="btn btn--fluid btn--outline-black cart-step__label-status"></p>
											</label>
										</div>
										<div class="size7of9">
											<h3 class="cart-step2__title">Добавьте услугу по укладке плитки</h3>
											<p>Услуга включает в себя:</p>
											<ul class="cart-step2__list">
												<li class="cart-step2__list-item">
													<div class="svg-border svg-border--40 icon-computer"></div>
													<p>Создание дизайн-макета</p>
												</li>
												<li class="cart-step2__list-item">
													<div class="svg-border svg-border--40 icon-calculator"></div>
													<p>Расчет стоимости</p>
												</li>
												<li class="cart-step2__list-item">
													<div class="svg-border svg-border--40"><svg class="icon icon-worker" width="20" height="20"><use xlink:href="#iconWorker"></use></svg></div>
													<p>Выезд мастера на обьект</p>
												</li>
											</ul>
										</div>
									</div>
									<div class="cart-separator"><span class="cart-separator__text">также Вам понадобится</span></div>
									<?php echo $additional; ?>
								</div>
								<?php } else if($step === 3) { ?>
								<div class="cart-step3 cart-delivery">
									<div class="row no-gutters">
										<div class="size2of9">
											<input type="hidden" name="delivery[name]" value="Доставка">
											<input type="checkbox" name="delivery[status]" value="Нужен" id="deliveryInput" class="cart-step__input js-cart-del-check-status" <?php echo ($user['delivery']['status']) ? 'checked="checked"' : ''; ?> />
											<label for="deliveryInput" class="cart-step__label text-center">
												<p class="text--color-2">Доставка</p>
												<svg class="icon-shipped" height="100" width="100"><use xlink:href="#iconShipped"></use></svg>
												<p class="btn btn--fluid btn--outline-black cart-step__label-status"></p>
											</label>
										</div>
										<div class="size7of9">
											<div class="cart-delivery__form <?php echo $user['delivery']['status'] ? '' : 'disabled'; ?>" id="jsCartDelForm">
												<h5 class="cart-delivery__form-title">Адрес доставки</h5>
												<div class="row no-gutters align-items-stretch">
													<?php if($user['delivery']['status']) { ?>
													<div class="size2of7">
														<input type="text" name="delivery[oblast]" placeholder="Область" class="input input--fluid input--highlight" value="<?php echo $user['delivery']['oblast']; ?>" />
														<input type="text" name="delivery[city]" placeholder="населенный пункт" class="input input--fluid input--highlight" value="<?php echo $user['delivery']['city']; ?>" />
														<input type="text" name="delivery[street]" placeholder="улица" class="input input--fluid input--highlight" value="<?php echo $user['delivery']['street']; ?>" />
														<input type="text" name="delivery[street2]" placeholder="улица" class="input input--fluid input--highlight" style="margin-bottom: 0;" value="<?php echo $user['delivery']['street2']; ?>" />
														</div>
													<div class="size5of7">
														<!--
														<textarea name="delivery[comment]" placeholder="Примечание" id="" class="input input--fluid input--highlight cart-delivery__form-comment"><?php echo $user['delivery']['comment']; ?></textarea>
														-->
													</div>
													<?php } else { ?>
													<div class="size2of7">
														<input type="text" name="delivery[oblast]" placeholder="Область" class="input input--fluid input--highlight" disabled="disabled" />
														<input type="text" name="delivery[city]" placeholder="населенный пункт" class="input input--fluid input--highlight" disabled="disabled" />
														<input type="text" name="delivery[street]" placeholder="улица" class="input input--fluid input--highlight" disabled="disabled" />
														<input type="text" name="delivery[street2]" placeholder="улица" class="input input--fluid input--highlight" disabled="disabled" style="margin-bottom: 0;" />
													</div>
													<div class="size5of7">
														<!--
														<textarea name="delivery[comment]" placeholder="Примечание" id="" class="input input--fluid input--highlight cart-delivery__form-comment" disabled="disabled"></textarea>
														-->
													</div>
													<?php } ?>
												</div>
											</div>
										</div>
									</div>
								</div>
								<?php } else if($step === 4) { ?>
								<div class="cart-step4 cart-checkout">
									<div class="cart-step4__col">
										<p class="text--bold text--black"><span class="size3of4">Персональные данные</span></p>
										<hr class="hr-left" />
										<p class="text-sm text--light-gray">Имя</p>
										<p class="mb-20"><?php echo $user['name']; ?></p>
										<p class="text-sm text--light-gray">Телефон</p>
										<p class="mb-20"><?php echo $user['phone']; ?></p>
										<p class="text-sm text--light-gray">Email</p>
										<p class="mb-20"><?php echo $user['email']; ?></p>
										<?php if($user['delivery']['status']) { ?>
										<p class="text-sm text--light-gray">Адрес доставки</p>
										<p class="mb-20"><?php echo $user['delivery']['oblast']; ?> обл., г. <?php echo $user['delivery']['city']; ?>, <?php echo $user['delivery']['street']; ?> просп. <?php echo $user['delivery']['street2']; ?></p>
										<?php if($user['delivery']['comment']) { ?>
										<p class="text-sm text--light-gray">Комментарии</p>
										<p class=""><?php echo $user['delivery']['comment']; ?></p>
										<?php } ?>
										<?php } ?>
									</div>
									<div class="cart-step4__col">
										<p class="text--bold text--black"><span class="size3of4">Информация о заказе</span></p>
										<hr class="hr-left" />
										<p class="text--black"><span class="size3of4"><strong class="text-normal text--black"><?php echo $total_products; ?></strong> товара на сумму</span><span class="size1of4"><strong class="text-normal text--black"><?php echo $total_price; ?></strong></span></p>
										<p class="mb-20"><span class="size3of4">Ваша скидка</span><span class="size1of4"><?php echo $total_reduction; ?></span></p>
										<p class="text--bold text--black"><span class="size3of4">Укладка</span><span class="size1of4"><span class="text-normal text--black">Да</span></span></p>
										<ul class="mb-20">
											<?php foreach($user['needs'] as $need) { ?>
											<li><span class="size3of4"><?php echo $need; ?></span><span class="size1of4">+</span></li>
											<?php } ?>
										</ul>
										<?php if($user['delivery']['status']) { ?>
										<p class="text--bold text--black"><span class="size3of4 mb-20">Доставка</span><span class="size1of4"><span class="text-normal text--black">Да</span></span></p>
										<?php } ?>
									</div>
								</div>
								<?php } ?>
								<?php if($step < 4) { ?>
								<button type="submit" class="btn btn--fluid btn--yellow js-cart-control-btn" value="<?php echo ($step + 1); ?>">К следующую шагу</button>
								<p class="text-center text--light-gray text-sm">Переход к следующему шагу будет доступен после заполнения Контактных данных</p>
								<?php } ?>
							</form>
						</div><!-- col-9 -->
						<div class="<?php echo ($step < 4) ? 'col-md-3' : 'col-md-4'; ?>">
							<div class="cart-result <?php echo ($step < 4) ? 'cart-result--shadowed' : ''; ?>" id="cartResult">
								<?php if($step < 4) { ?>
									<div class="cart-result__top">
										<p class="text--bold"><span class="size2of3">Вы экономите</span><span class="size1of3"><?php echo $total_reduction; ?></span></p>
										<ul class="cart-result__top-list">
											<li class="cart-result__top-list-item">
												<p><span class="size2of3"><strong class="text-normal text--black"><?php echo $total_products; ?></strong> товара на сумму</span><span class="size1of3"><strong class="text-normal text--black"><?php echo $total_price; ?></strong></span></p>
												<p><span class="size2of3">Ваша скидка</span><span class="size1of3"><strong class="text-normal text--black">5%</strong></span></p>
											</li>
											<?php if($step > 2) { ?>
											<li class="cart-result__top-list-item">
												<p class="text--bold text--black text--normal"><span class="size2of3">Укладка</span><span class="size1of3"><span><?php echo ($user['laying']['status']) ? 'Да' : 'Нет'; ?></span></span></p>
												<ul class="cart-result__top-list-plus">
													<?php foreach($user['needs'] as $need) { ?>
													<li class="cart-result__top-plus"><span class="size2of3"><?php echo $need; ?></span><span class="size1of3">+</span></li>
													<?php } ?>
												</ul>
											</li>
											<?php } ?>
											<?php if($step > 3) { ?>
											<li class="cart-result__top-list-item">
												<p><span class="size2of3">Доставка</span><span class="size1of3"><strong class="text-normal text--black"><?php echo ($user['delivery']['status']) ? 'Да' : 'Нет'; ?></strong></span></p>
												<?php if($user['delivery']['status']) { ?>
												<p><svg height="12" width="8" class="icon-location"><use xlink:href="#iconLocation"></use></svg>Санкт-Петербург, Кутузовский просп. 45</p>
												<?php } ?>
											</li>
											<?php } ?>
										</ul>
									</div>
									<div class="cart-result__bottom text--yellow text--bold">
										<span class="size2of3">Итого: </span><span class="size1of3 text-right"><?php echo $total_price_with_reduction; ?></span>
									</div>
								<?php } else { ?>
								<div class="cart-result__overlay">
									<div class="mb-15 h3 text--black text--medium-bold">Счет сформирован</div>
									<p class="text--black">Способ оплаты: <strong>Безналичный</strong></p>
									<p class="text-sm">Безналичная оплата дает Скидку 2%</p>
									<ul class="cart-result__list">
										<li class="cart-result__list-item"><span>Итоговая цена</span><span><?php echo $total_price; ?></span></li>
										<li class="cart-result__list-item"><span>Скидка 5%</span><span><?php echo $total_reduction; ?></span></li>
										<li class="cart-result__list-item"><span>Скидка <?php echo $online_payment_reduction_percent; ?>%</span><span><?php echo $online_payment_reduction_price; ?></span></li>
									</ul>
									<p class="h4 text--black text--bold mb-25"><span class="size2of3">Цена со скидками</span><span class="size1of3 text-right"><?php echo $total_price_with_reduction; ?></span></p>
									<button type="button" id="cartSubmitOrderBtn" class="mb-25 btn btn--fluid btn--yellow">выставить счет</button>
									<p class="text-center">Можно оплатить наличными в офисе</p>
								</div>
								<?php } ?>
							</div><!-- cart-result -->
						</div><!-- col-3 -->
					</div><!-- row -->
				</div><!-- cart -->
			</section>
			
			<?php if($content_right) { ?><aside class="aside aside-right"><?php content_right; ?></aside><?php } ?>
		</div>
	</div><!-- container -->
	<?php if ($content_bottom) { ?>
		<?php echo $content_bottom; ?>
	<?php } ?>
</main>
<div class="section section--highlight cart-advantages">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<div class="h2 cart-advantages__title">Преимущества МосБрусчатки</div>
				<div class="row">
					<div class="col-4">
						<div class="svg-border svg-border--50 icon-shipped-32"></div>
						<p>Экспресс доставка за один день</p>
					</div>
					<div class="col-4">
						<div class="svg-border svg-border--50 icon-award-32"></div>
						<p>Экспресс доставка за один день</p>
					</div>
					<div class="col-4">
						<div class="svg-border svg-border--50 icon-ruler-32"></div>
						<p>Экспресс доставка за один день</p>
					</div>
				</div>
			</div>
			<div class="col-md-6 text-center">
				<a href="javascript:void(0);"><img src="<?php echo $placeholder_img; ?>" data-src="../image/catalog/cart-red-1.png" alt="" height="190" width="570"></a>
			</div>
		</div>
	</div>
</div>
<?php echo $footer; ?>
</body></html>
